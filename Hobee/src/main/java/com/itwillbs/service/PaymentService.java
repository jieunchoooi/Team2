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
import com.itwillbs.mapper.PaymentMapper;
import com.itwillbs.mapper.PointHistoryMapper;

@Service
public class PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;
    @Autowired
    private PointHistoryMapper pointHistoryMapper;
    @Autowired
    private EnrollmentMapper enrollmentMapper;
  
   
    /**
     * 결제 완료 처리 (포인트 차감, 적립, 수강 등록 포함)
     */
    @Transactional
    public void processPayment(PaymentVO paymentVO, List<Integer> lectureNums, GradeVO gradeVO) {

        System.out.println("🟢 [PaymentService] 결제 처리 시작");
        System.out.println("📦 imp_uid=" + paymentVO.getImp_uid());
        System.out.println("📦 lectureNums=" + lectureNums);
        System.out.println("📦 할인율=" + gradeVO.getDiscount_rate() + "% / 적립율=" + gradeVO.getReward_rate() + "%");

        // 1️⃣ imp_uid 중복 결제 체크
        int duplicate = paymentMapper.checkDuplicateImpUid(paymentVO.getImp_uid());
        if (duplicate > 0) {
            System.out.println("⚠️ [PaymentService] 중복 결제 감지됨! imp_uid=" + paymentVO.getImp_uid());
            throw new IllegalStateException("이미 처리된 결제입니다.");
        }

        // 2️⃣ 결제 내역 저장
        paymentMapper.insertPayment(paymentVO);
        int paymentId = paymentVO.getPayment_id();
        int userNum = paymentVO.getUser_num();
        System.out.println("💾 결제 저장 완료 (payment_id=" + paymentId + ", user_num=" + userNum + ")");

        // 3️⃣ 포인트 사용 처리
        if (paymentVO.getUsed_points() > 0) {
            PointHistoryVO usedVO = new PointHistoryVO();
            usedVO.setUser_num(userNum);
            usedVO.setPayment_id(paymentId);
            usedVO.setPoint_change(-paymentVO.getUsed_points());
            usedVO.setType("USE");
            usedVO.setDescription("클래스 결제 시 포인트 사용");

            pointHistoryMapper.insertPointHistory(usedVO);
            pointHistoryMapper.deductPoints(usedVO);
            System.out.println("💸 포인트 차감 완료: -" + paymentVO.getUsed_points());
        }

        // 4️⃣ 포인트 적립 처리 (할인 전 금액 기준)
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
        System.out.println("💰 포인트 적립 완료: +" + savedPoints);

        // 5️⃣ 수강 등록 (강의별 등록)
        for (Integer lectureNum : lectureNums) {
            EnrollmentVO enrollVO = new EnrollmentVO();
            enrollVO.setUser_num(userNum);
            enrollVO.setLecture_num(lectureNum);
            enrollVO.setPayment_id(paymentId);

            // ✅ 중복 등록 방지
            int exists = enrollmentMapper.checkEnrollmentExists(enrollVO);
            if (exists > 0) {
                System.out.println("⚠️ [PaymentService] 이미 수강 중인 강의 → lecture_num=" + lectureNum);
                continue; // 중복이면 skip
            }

            enrollmentMapper.insertEnrollment(enrollVO);
            System.out.println("🎓 수강 등록 완료 (lecture_num=" + lectureNum + ")");
        }

        // 6️⃣ 등급 조정 (grade 테이블 미구현 → 주석 처리)
        /*
        int totalPayments = paymentMapper.getUserTotalPayment(userNum);
        GradeVO newGrade = gradeMapper.findGradeByPayment(totalPayments);
        if (newGrade != null) {
            userMapper.updateUserGrade(userNum, newGrade.getGrade_id());
            System.out.println("🏅 등급 자동 조정 완료 → " + newGrade.getGrade_name());
        }
        */

        System.out.println("✅ [PaymentService] 결제 프로세스 정상 완료");
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

        // 1️⃣ 결제정보 조회
        PaymentVO original = paymentMapper.getPaymentById(paymentVO.getPayment_id());

        if (original == null) 
            throw new RuntimeException("결제내역을 찾을 수 없음");

        // 2️⃣ 3일 제한 확인
        if (!isRefundable(original.getCreated_at())) 
            throw new RuntimeException("환불 가능 기간이 지났습니다.");

        // 3️⃣ Payment 상태 변경
        paymentMapper.updatePaymentStatusRefund(original.getPayment_id());

        // 4️⃣ Enrollment 상태 변경
        enrollmentMapper.cancelEnrollmentByPaymentId(original.getPayment_id());

        // 5️⃣ 적립 포인트 회수
        PointHistoryVO minusVO = new PointHistoryVO();
        minusVO.setUser_num(original.getUser_num());
        minusVO.setPayment_id(original.getPayment_id());
        minusVO.setType("USE");
        minusVO.setDescription("결제 환불로 적립 포인트 회수");
        minusVO.setPoint_change(-original.getSaved_points());

        pointHistoryMapper.insertPointHistory(minusVO);
        pointHistoryMapper.deductPoints(minusVO);

        // 6️⃣ 사용 포인트 복구
        if (original.getUsed_points() > 0) {
            PointHistoryVO addVO = new PointHistoryVO();
            addVO.setUser_num(original.getUser_num());
            addVO.setPayment_id(original.getPayment_id());
            addVO.setType("SAVE");
            addVO.setDescription("결제 환불로 사용 포인트 복구");
            addVO.setPoint_change(original.getUsed_points());

            pointHistoryMapper.insertPointHistory(addVO);
            pointHistoryMapper.addPoints(addVO);
        }
    }

    /** 결제일 3일 제한 체크 */
    public boolean isRefundable(Timestamp createdAt) {
        long now = System.currentTimeMillis();
        long created = createdAt.getTime();
        long diffDays = (now - created) / (1000 * 60 * 60 * 24);
        return diffDays <= 3;
    }
}
