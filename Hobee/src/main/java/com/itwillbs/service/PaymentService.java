package com.itwillbs.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.EnrollmentVO;
import com.itwillbs.domain.GradeVO;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.PointHistoryVO;
import com.itwillbs.mapper.EnrollmentMapper;
import com.itwillbs.mapper.GradeMapper;
import com.itwillbs.mapper.PaymentMapper;
import com.itwillbs.mapper.PointHistoryMapper;
import com.itwillbs.mapper.UserMapper;

@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;
    @Autowired
    private PointHistoryMapper pointHistoryMapper;
    @Autowired
    private EnrollmentMapper enrollmentMapper;
    @Autowired
    private GradeMapper gradeMapper;
    @Autowired
    private UserMapper userMapper;
  
  
   
    /**
     * 결제 완료 처리 (포인트 차감, 적립, 수강 등록 포함)
     */
    @Transactional
    public void processPayment(PaymentVO paymentVO, List<Integer> lectureNums, GradeVO gradeVO) {

        int userNum = paymentVO.getUser_num();

        System.out.println("🟢 [PaymentService] 결제 처리 시작");

        // 1️⃣ imp_uid 중복 체크
        if (paymentMapper.checkDuplicateImpUid(paymentVO.getImp_uid()) > 0) {
            throw new IllegalStateException("이미 처리된 결제입니다.");
        }

        // 2️⃣ 결제 저장
        paymentMapper.insertPayment(paymentVO);
        int paymentId = paymentVO.getPayment_id();
        System.out.println("💾 결제 저장 완료 (payment_id=" + paymentId + ")");

        // 3️⃣ 포인트 사용
        if (paymentVO.getUsed_points() > 0) {
            PointHistoryVO usedVO = new PointHistoryVO();
            usedVO.setUser_num(userNum);
            usedVO.setPayment_id(paymentId);
            usedVO.setPoint_change(-paymentVO.getUsed_points());
            usedVO.setType("USE");
            usedVO.setDescription("클래스 결제 시 포인트 사용");

            pointHistoryMapper.insertPointHistory(usedVO);
            pointHistoryMapper.deductPoints(usedVO);
            System.out.println("💸 포인트 차감 완료");
        }

        // 4️⃣ 포인트 적립
        int savedPoints = (int) Math.floor(paymentVO.getAmount() * (gradeVO.getReward_rate() / 100.0));
        paymentVO.setSaved_points(savedPoints);

        PointHistoryVO saveVO = new PointHistoryVO();
        saveVO.setUser_num(userNum);
        saveVO.setPayment_id(paymentId);
        saveVO.setPoint_change(savedPoints);
        saveVO.setType("SAVE");
        saveVO.setDescription("결제 적립 포인트");

        pointHistoryMapper.insertPointHistory(saveVO);
        pointHistoryMapper.addPoints(saveVO);
        System.out.println("💰 포인트 적립 완료");

        // 5️⃣ 수강 등록
        for (Integer lectureNum : lectureNums) {
            EnrollmentVO enrollVO = new EnrollmentVO();
            enrollVO.setUser_num(userNum);
            enrollVO.setLecture_num(lectureNum);
            enrollVO.setPayment_id(paymentId);

            if (enrollmentMapper.checkEnrollmentExists(enrollVO) == 0) {
                enrollmentMapper.insertEnrollment(enrollVO);
                System.out.println("🎓 수강 등록 완료: " + lectureNum);
            }
        }

        // 6️⃣ 등급 자동 조정
        int totalPayments = paymentMapper.getUserTotalPayment(userNum);
        GradeVO newGrade = gradeMapper.getGradeByTotalPayment(totalPayments);

        if (newGrade != null) {
           	
            System.out.println("🏅 등급 업데이트 → " + newGrade.getGrade_name());
        }

        System.out.println("✅ [PaymentService] 결제 프로세스 정상 종료");
    }

    
    @Transactional
    public void testTransaction() {
        System.out.println("=== [1] 결제내역 저장 ===");
        paymentMapper.insertPaymentForTest(); // 기존 mapper insert 사용

        System.out.println("=== [2] 포인트 기록 저장 ===");
        pointHistoryMapper.insertPointHistoryForTest(); // 기존 mapper insert 사용

        System.out.println("=== [3] 강제 예외 발생 ===");
        int x = 10 / 0; // 💥 일부러 예외 (rollback 확인용)
    }
    
    

    // 결제 상세조회
    public PaymentVO getPayment(int payment_id) {
    	System.out.println("MemberSerivce paymet()");
        System.out.println(paymentMapper.getPayment(payment_id));
    	return paymentMapper.getPayment(payment_id);
    }

    // 결제목록조회
    public List<PaymentVO> getPaymentList(int user_num) {
    	System.out.println(user_num+"번호를 가진 유저의 결제내역을 조회합니다");
        List<PaymentVO> list = paymentMapper.getPaymentList(user_num);

        // 환불 가능 여부(Boolean) 계산
        for (PaymentVO vo : list) {
            vo.setRefundable(isRefundable(vo.getCreated_at()));
        }

        return list;
    }

    /** ============================================================
     *  🟣 환불 처리 (3일 제한 + 상태 변경 + 포인트 회수)
     * ============================================================ */
    @Transactional
    public void refundPayment(PaymentVO paymentVO) {

        System.out.println("🟠 [PaymentService] 환불 처리 시작");
        int paymentId = paymentVO.getPayment_id();

        // 1️⃣ 결제 정보 조회
        PaymentVO original = paymentMapper.getPaymentById(paymentId);

        if (original == null) {
            throw new RuntimeException("결제내역을 찾을 수 없음");
        }

        System.out.println("📦 환불 대상 payment_id=" + paymentId 
                           + " / user_num=" + original.getUser_num()
                           + " / amount=" + original.getAmount());

        // 2️⃣ 환불 가능 기간(3일) 체크
        if (!isRefundable(original.getCreated_at())) {
            throw new RuntimeException("환불 가능 기간이 지났습니다.");
        }

        // 3️⃣ Payment 상태 변경 → cancelled
        paymentMapper.updatePaymentStatusRefund(paymentId);
        System.out.println("🔄 Payment 상태 → CANCELLED");

        // 4️⃣ 수강 등록 취소 (enrollment status update)
        enrollmentMapper.cancelEnrollmentByPaymentId(paymentId);
        System.out.println("🎓 해당 결제의 수강 전체 취소 완료");

        int userNum = original.getUser_num();

        // 5️⃣ 적립 포인트 회수
        if (original.getSaved_points() > 0) {

            PointHistoryVO minusVO = new PointHistoryVO();
            minusVO.setUser_num(userNum);
            minusVO.setPayment_id(paymentId);
            minusVO.setPoint_change(-original.getSaved_points());
            minusVO.setType("USE");
            minusVO.setDescription("결제 환불로 적립 포인트 회수");

            pointHistoryMapper.insertPointHistory(minusVO);
            pointHistoryMapper.deductPoints(minusVO);

            System.out.println("💸 적립 포인트 회수: -" + original.getSaved_points());
        }

        // 6️⃣ 사용 포인트 복구
        if (original.getUsed_points() > 0) {

            PointHistoryVO addVO = new PointHistoryVO();
            addVO.setUser_num(userNum);
            addVO.setPayment_id(paymentId);
            addVO.setPoint_change(original.getUsed_points());
            addVO.setType("SAVE");
            addVO.setDescription("결제 환불로 사용 포인트 복구");

            pointHistoryMapper.insertPointHistory(addVO);
            pointHistoryMapper.addPoints(addVO);

            System.out.println("💰 사용 포인트 복구: +" + original.getUsed_points());
        }

        // 7️⃣ 등급 자동 재계산
        int totalPayment = paymentMapper.getUserTotalPayment(userNum);
        GradeVO newGrade = gradeMapper.getGradeByTotalPayment(totalPayment);

        if (newGrade != null) {
            userMapper.updateUserGrade(userNum, newGrade.getGrade_id());
            System.out.println("🏅 등급 자동 조정 완료 → " + newGrade.getGrade_name());
        }

        System.out.println("✅ [PaymentService] 환불 프로세스 정상 종료");
    }


    /** 결제일 3일 제한 체크 */
    public boolean isRefundable(Timestamp createdAt) {
        long now = System.currentTimeMillis();
        long created = createdAt.getTime();
        long diffDays = (now - created) / (1000 * 60 * 60 * 24);
        return diffDays <= 3;
    }
}
