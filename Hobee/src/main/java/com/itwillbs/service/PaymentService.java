package com.itwillbs.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.EnrollmentVO;
import com.itwillbs.domain.GradeVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.PaymentDetailVO;
import com.itwillbs.domain.PaymentResultVO;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.PointHistoryVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.EnrollmentMapper;
import com.itwillbs.mapper.GradeMapper;
import com.itwillbs.mapper.LectureMapper;
import com.itwillbs.mapper.PaymentDetailMapper;
import com.itwillbs.mapper.PaymentMapper;
import com.itwillbs.mapper.PointHistoryMapper;
import com.itwillbs.mapper.ScrapMapper;
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
    @Autowired
    private ScrapMapper scrapMapper;
    @Autowired
    private LectureMapper lectureMapper;
    @Autowired
    private PaymentDetailMapper paymentDetailMapper;
  
   
    /**
     * 결제 완료 처리 (포인트 차감, 적립, 수강 등록 포함)
     */
    @Transactional
    public PaymentResultVO processPayment(PaymentVO paymentVO, List<Integer> lectureNums, GradeVO gradeVO) {

        PaymentResultVO resultVO = new PaymentResultVO();

        int userNum = paymentVO.getUser_num();
        resultVO.setUserNum(userNum);

        System.out.println("🟢 [PaymentService] 결제 처리 시작");

        // 0) 결제 중복 체크
        if (paymentMapper.checkDuplicateImpUid(paymentVO.getImp_uid()) > 0) {
            throw new IllegalStateException("이미 처리된 결제입니다.");
        }

        // 1) 기존 유저 정보 조회
        UserVO oldUser = userMapper.getUserByNum(userNum);
        resultVO.setOldGradeId(oldUser.getGrade_id());
        resultVO.setBeforePoints(oldUser.getPoints());

        int currentPoints = oldUser.getPoints();

        // 2) 결제 저장
        paymentVO.setStatus("PAID");
        paymentMapper.insertPayment(paymentVO);

        int paymentId = paymentVO.getPayment_id();
        resultVO.setPaymentId(paymentId);

        // 3) 포인트 사용 처리
        if (paymentVO.getUsed_points() > 0) {

            int minus = paymentVO.getUsed_points();
            currentPoints -= minus;

            // ⭐ 수정: VO로 묶어서 전달
            UserVO p1 = new UserVO();
            p1.setUser_num(userNum);
            p1.setPoints(currentPoints);
            userMapper.updateUserPoints(p1);

            PointHistoryVO usedPH = new PointHistoryVO();
            usedPH.setUser_num(userNum);
            usedPH.setPayment_id(paymentId);
            usedPH.setPoint_change(-minus);
            usedPH.setType("USE");
            usedPH.setDescription("클래스 결제 시 포인트 사용");
            pointHistoryMapper.insertPointHistory(usedPH);

            resultVO.setUsedPoints(minus);
        }

        // 4) 포인트 적립
        int savedPoints = (int) Math.floor(paymentVO.getAmount() * (gradeVO.getReward_rate() / 100.0));
        currentPoints += savedPoints;

        // ⭐ 수정: VO로 묶어서 전달
        UserVO p2 = new UserVO();
        p2.setUser_num(userNum);
        p2.setPoints(currentPoints);
        userMapper.updateUserPoints(p2);

        PointHistoryVO savedPH = new PointHistoryVO();
        savedPH.setUser_num(userNum);
        savedPH.setPayment_id(paymentId);
        savedPH.setPoint_change(savedPoints);
        savedPH.setType("SAVE");
        savedPH.setDescription("결제 적립 포인트");
        pointHistoryMapper.insertPointHistory(savedPH);

        resultVO.setSavedPoints(savedPoints);

        // 5) 강의별 디테일 저장
        double discountRate = gradeVO.getDiscount_rate() / 100.0;
        double rewardRate = gradeVO.getReward_rate() / 100.0;

        int totalSaleAmount = 0;
        for (int lec : lectureNums) {
            LectureVO l = lectureMapper.getLectureById(lec);
            totalSaleAmount += (int) Math.round(l.getLecture_price() * (1 - discountRate));
        }

        int usedSum = 0;

        for (int i = 0; i < lectureNums.size(); i++) {
            int lecNum = lectureNums.get(i);
            LectureVO l = lectureMapper.getLectureById(lecNum);

            PaymentDetailVO detail = new PaymentDetailVO();
            detail.setPayment_id(paymentId);
            detail.setLecture_num(lecNum);

            int original = l.getLecture_price();
            int sale = (int) Math.round(original * (1 - discountRate));

            detail.setOriginal_price(original);
            detail.setSale_price(sale);

            int dividedUsed = 0;
            if (paymentVO.getUsed_points() > 0) {
                double ratio = (double) sale / totalSaleAmount;
                dividedUsed = (int) Math.round(paymentVO.getUsed_points() * ratio);

                if (i == lectureNums.size() - 1) {
                    dividedUsed += paymentVO.getUsed_points() - (usedSum + dividedUsed);
                }

                usedSum += dividedUsed;
            }

            detail.setUsed_points(dividedUsed);

            int dividedSaved = (int) Math.round(sale * rewardRate);
            detail.setSaved_points(dividedSaved);

            detail.setStatus("PAID");

            paymentDetailMapper.insert(detail);
        }

        // 6) 수강등록
        for (int lec : lectureNums) {
            EnrollmentVO e = new EnrollmentVO();
            e.setUser_num(userNum);
            e.setLecture_num(lec);
            e.setPayment_id(paymentId);

            if (enrollmentMapper.checkEnrollmentExists(e) == 0) {
                enrollmentMapper.insertEnrollment(e);
            }
        }

        // 7) 스크랩 삭제
        scrapMapper.deleteScrapAfterPayment(userNum, lectureNums);

        // 8) 등급 재조정
        int totalPayments = paymentMapper.getUserTotalPayment(userNum);
        GradeVO newGrade = gradeMapper.getGradeByTotalPayment(totalPayments);

        resultVO.setNewGradeId(newGrade.getGrade_id());
        resultVO.setNewGradeName(newGrade.getGrade_name());

        if (newGrade.getGrade_id() != oldUser.getGrade_id()) {
            resultVO.setGradeChanged(true);
            resultVO.setGradeUp(newGrade.getGrade_id() > oldUser.getGrade_id());

            // ⭐ 수정: VO로 묶어서 전달
            UserVO g = new UserVO();
            g.setUser_num(userNum);
            g.setGrade_id(newGrade.getGrade_id());
            userMapper.updateUserGrade(g);
        }

        resultVO.setAfterPoints(currentPoints);

        // 최신 유저 정보
        resultVO.setUpdatedUserVO(userMapper.getUserByNum(userNum));

        resultVO.setSuccess(true);
        resultVO.setMessage("결제가 정상 처리되었습니다.");

        System.out.println("✅ [PaymentService] 결제 프로세스 정상 종료");

        return resultVO;
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
     // 1) 수강등록 삭제
        enrollmentMapper.deleteEnrollmentByPaymentId(paymentId);
        System.out.println("🗑 수강등록 삭제 완료");

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
        	UserVO userVO = new UserVO();
        	userVO.setUser_num(userNum);
        	userVO.setGrade_id(newGrade.getGrade_id());

        	userMapper.updateUserGrade(userVO);

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
