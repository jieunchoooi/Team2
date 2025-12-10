package com.itwillbs.service;

import java.sql.Timestamp;
import java.util.ArrayList;
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
	public PaymentResultVO processPayment(
	        PaymentVO paymentVO,
	        List<Integer> lectureNums,
	        List<PaymentDetailVO> detailList,   // ⭐ 프론트 계산된 detailList 받음
	        GradeVO gradeVO) {

	    PaymentResultVO paymentResultVO = new PaymentResultVO();

	    int userNum = paymentVO.getUser_num();
	    paymentResultVO.setUserNum(userNum);

	    System.out.println("🟢 [PaymentService] 결제 처리 시작");
	    System.out.println("   🔹 요청 paymentVO     : " + paymentVO);
	    System.out.println("   🔹 요청 lectureNums   : " + lectureNums);
	    System.out.println("   🔹 detailList(프론트 계산) : " + detailList);
	    System.out.println("   🔹 gradeVO(세션)       : " + gradeVO);

	    /* ===========================================================
	       0) imp_uid 중복 체크
	       =========================================================== */
	    if (paymentMapper.checkDuplicateImpUid(paymentVO.getImp_uid()) > 0) {
	        throw new IllegalStateException("이미 처리된 결제입니다.");
	    }

	    /* ===========================================================
	       1) 기존 유저 정보 조회
	       =========================================================== */
	    UserVO oldUserVO = userMapper.getUserByNum(userNum);
	    paymentResultVO.setOldGradeId(oldUserVO.getGrade_id());
	    paymentResultVO.setBeforePoints(oldUserVO.getPoints());
	    int currentPoints = oldUserVO.getPoints();

	    /* 실제 등급은 DB 기준 */
	    gradeVO = gradeMapper.getGradeById(oldUserVO.getGrade_id());

	    /* ===========================================================
	       2) payment INSERT
	       =========================================================== */
	    paymentVO.setStatus("paid");
	    paymentMapper.insertPayment(paymentVO);
	    int paymentId = paymentVO.getPayment_id();
	    paymentResultVO.setPaymentId(paymentId);

	    /* ===========================================================
	       ⭐ 3) 강의별 payment_detail INSERT (프론트 계산값 그대로 사용)
	       =========================================================== */

	    List<PaymentDetailVO> paymentDetailVOList = new ArrayList<>();
	    int totalUsedPoints = 0;
	    int totalSavedPoints = 0;

	    for (PaymentDetailVO detail : detailList) {

	        System.out.println("\n   ▶ detail 처리: " + detail);

	        detail.setPayment_id(paymentId); // FK 설정
	        detail.setStatus("paid");

	        paymentDetailMapper.insert(detail); // DB 저장(detail_id 생성됨)
	        paymentDetailVOList.add(detail);

	        // 누적값 계산
	        totalUsedPoints += detail.getUsed_points();
	        totalSavedPoints += detail.getSaved_points();
	    }

	    /* ===========================================================
	       ⭐ 4) point_history — 프론트 값 기반으로 그대로 기록
	       =========================================================== */
	    for (PaymentDetailVO detail : paymentDetailVOList) {

	        /* 사용 포인트 기록 */
	        if (detail.getUsed_points() > 0) {

	            currentPoints -= detail.getUsed_points();

	            PointHistoryVO historyUse = new PointHistoryVO();
	            historyUse.setUser_num(userNum);
	            historyUse.setDetail_id(detail.getDetail_id());
	            historyUse.setPoint_change(-detail.getUsed_points());
	            historyUse.setType("use");
	            historyUse.setDescription("클래스 결제 시 포인트 사용");

	            pointHistoryMapper.insertPointHistory(historyUse);
	        }

	        /* 적립 포인트 기록 */
	        if (detail.getSaved_points() > 0) {

	            currentPoints += detail.getSaved_points();

	            PointHistoryVO historySave = new PointHistoryVO();
	            historySave.setUser_num(userNum);
	            historySave.setDetail_id(detail.getDetail_id());
	            historySave.setPoint_change(detail.getSaved_points());
	            historySave.setType("save");
	            historySave.setDescription("결제 적립 포인트");

	            pointHistoryMapper.insertPointHistory(historySave);
	        }
	    }

	    /* ===========================================================
	       ⭐ 5) user 포인트 반영
	       =========================================================== */
	    UserVO updatePointsVO = new UserVO();
	    updatePointsVO.setUser_num(userNum);
	    updatePointsVO.setPoints(currentPoints);
	    userMapper.updateUserPoints(updatePointsVO);

	    paymentResultVO.setUsedPoints(totalUsedPoints);
	    paymentResultVO.setSavedPoints(totalSavedPoints);

	    /* ===========================================================
	       6) 수강 등록
	       =========================================================== */
	    for (int lectureNum : lectureNums) {

	        EnrollmentVO enroll = new EnrollmentVO();
	        enroll.setUser_num(userNum);
	        enroll.setLecture_num(lectureNum);
	        enroll.setPayment_id(paymentId);

	        if (enrollmentMapper.checkEnrollmentExists(enroll) == 0) {
	            enrollmentMapper.insertEnrollment(enroll);
	        }
	    }

	    /* ===========================================================
	       7) 스크랩 삭제
	       =========================================================== */
	    scrapMapper.deleteScrapAfterPayment(userNum, lectureNums);

	    /* ===========================================================
	       8) 등급 재산정
	       =========================================================== */
	    int totalPayments = paymentMapper.getUserTotalPayment(userNum);
	    GradeVO newGradeVO = gradeMapper.getGradeByTotalPayment(totalPayments);

	    paymentResultVO.setNewGradeId(newGradeVO.getGrade_id());
	    paymentResultVO.setNewGradeName(newGradeVO.getGrade_name());

	    if (oldUserVO.getGrade_id() != newGradeVO.getGrade_id()) {

	        paymentResultVO.setGradeChanged(true);
	        paymentResultVO.setGradeUp(newGradeVO.getGrade_id() > oldUserVO.getGrade_id());

	        UserVO gradeUpdateVO = new UserVO();
	        gradeUpdateVO.setUser_num(userNum);
	        gradeUpdateVO.setGrade_id(newGradeVO.getGrade_id());

	        userMapper.updateUserGrade(gradeUpdateVO);
	    }

	    /* ===========================================================
	       9) 응답 준비
	       =========================================================== */
	    paymentResultVO.setAfterPoints(currentPoints);
	    paymentResultVO.setUpdatedUserVO(userMapper.getUserByNum(userNum));
	    paymentResultVO.setSuccess(true);
	    paymentResultVO.setMessage("결제가 정상 처리되었습니다.");

	    return paymentResultVO;
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
		System.out.println(user_num + "번호를 가진 유저의 결제내역을 조회합니다");
		List<PaymentVO> list = paymentMapper.getPaymentList(user_num);

		// 환불 가능 여부(Boolean) 계산
		for (PaymentVO vo : list) {
			vo.setRefundable(isRefundable(vo.getCreated_at()));
		}

		return list;
	}

//	전체 환불 
	@Transactional
	public PaymentResultVO refundFull(int userNum, int paymentId) {

	    PaymentResultVO paymentResultVO = new PaymentResultVO();
	    paymentResultVO.setUserNum(userNum);
	    paymentResultVO.setPaymentId(paymentId);

	    System.out.println("\n🟡 [RefundService] 전체 환불 처리 시작");
	    System.out.println("   🔹 userNum   = " + userNum);
	    System.out.println("   🔹 paymentId = " + paymentId);

	    PaymentVO paymentVO = paymentMapper.getPaymentById(paymentId);
	    System.out.println("   [1] paymentVO 조회 결과 : " + paymentVO);

	    if (paymentVO == null) {
	        System.out.println("   ❌ paymentVO == null");
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("결제 정보를 확인할 수 없습니다.");
	        return paymentResultVO;
	    }

	    if (!"paid".equalsIgnoreCase(paymentVO.getStatus())) {
	        System.out.println("   ❌ status != paid");
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("환불할 수 없는 결제 상태입니다.");
	        return paymentResultVO;
	    }

	    UserVO oldUserVO = userMapper.getUserByNum(userNum);
	    if (oldUserVO == null) {
	        System.out.println("   ❌ oldUserVO == null");
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("유저 정보를 확인할 수 없습니다.");
	        return paymentResultVO;
	    }

	    int currentPoints = oldUserVO.getPoints();
	    System.out.println("   [2] oldUserVO : " + oldUserVO);
	    System.out.println("       현재 포인트 currentPoints = " + currentPoints);

	    List<PaymentDetailVO> paymentDetailList = paymentDetailMapper.getDetailsByPaymentId(paymentId);

	    if (paymentDetailList == null || paymentDetailList.isEmpty()) {
	        System.out.println("   ❌ paymentDetailList 비어있음");
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("결제 상세 정보를 찾을 수 없습니다.");
	        return paymentResultVO;
	    }

	    System.out.println("   [3] paymentDetailList size = " + paymentDetailList.size());
	    for (PaymentDetailVO detailVO : paymentDetailList) {
	        System.out.println("       - detailVO : " + detailVO);
	    }

	    int totalRestoreUsed = 0;
	    int totalRemoveSaved = 0;

	    System.out.println("   [4] 전체 환불 포인트 집계 시작");

	    for (PaymentDetailVO detailVO : paymentDetailList) {

	        if (detailVO == null) continue;

	        // 🔥 이미 부분 환불된 detail은 skip
	        if ("refunded".equalsIgnoreCase(detailVO.getStatus())) {
	            System.out.println("       ⚠ SKIP(이미 환불된 detail) detailId=" + detailVO.getDetail_id());
	            continue;
	        }

	        totalRestoreUsed += detailVO.getUsed_points();
	        totalRemoveSaved += detailVO.getSaved_points();
	    }

	    System.out.println("       totalRestoreUsed = " + totalRestoreUsed);
	    System.out.println("       totalRemoveSaved = " + totalRemoveSaved);

	    currentPoints += totalRestoreUsed;
	    currentPoints -= totalRemoveSaved;

	    System.out.println("       포인트 반영 후 currentPoints = " + currentPoints);

	    UserVO userUpdateVO = new UserVO();
	    userUpdateVO.setUser_num(userNum);
	    userUpdateVO.setPoints(currentPoints);
	    userMapper.updateUserPoints(userUpdateVO);

	    /* ===========================================================
	       point_history 기록 (refunded detail 제외)
	       =========================================================== */
	    System.out.println("   [5] point_history INSERT 시작(전체 환불)");

	    for (PaymentDetailVO detailVO : paymentDetailList) {

	        if (detailVO == null) continue;

	        if ("refunded".equalsIgnoreCase(detailVO.getStatus())) {
	            System.out.println("       ⚠ SKIP HISTORY (이미 환불됨) detailId=" + detailVO.getDetail_id());
	            continue;
	        }

	        int used = detailVO.getUsed_points();
	        int saved = detailVO.getSaved_points();
	        int detailId = detailVO.getDetail_id();

	        if (detailId == 0) {
	            System.out.println("       ⚠ detailId=0 → point_history insert 불가 → skip");
	            continue;
	        }

	        if (used > 0) {
	            PointHistoryVO phRestore = new PointHistoryVO();
	            phRestore.setUser_num(userNum);
	            phRestore.setDetail_id(detailId);
	            phRestore.setPoint_change(used);
	            phRestore.setType("restore");
	            phRestore.setDescription("전체 환불로 사용 포인트 복구");
	            System.out.println("       ▶ RESTORE INSERT : " + phRestore);
	            pointHistoryMapper.insertPointHistory(phRestore);
	        }

	        if (saved > 0) {
	            PointHistoryVO phRemove = new PointHistoryVO();
	            phRemove.setUser_num(userNum);
	            phRemove.setDetail_id(detailId);
	            phRemove.setPoint_change(-saved);
	            phRemove.setType("remove");
	            phRemove.setDescription("전체 환불로 적립 포인트 회수");
	            System.out.println("       ▶ REMOVE INSERT : " + phRemove);
	            pointHistoryMapper.insertPointHistory(phRemove);
	        }
	    }

	    /* ===========================================================
	       enrollment 삭제 & 상태 업데이트
	       =========================================================== */
	    System.out.println("   [6] 수강 등록 삭제 paymentId=" + paymentId);
	    enrollmentMapper.deleteEnrollmentByPaymentId(paymentId);

	    System.out.println("   [7] payment / payment_detail 상태 변경");
	    paymentMapper.updatePaymentStatusRefund(paymentId);
	    paymentDetailMapper.updateDetailStatusRefund(paymentId);

	    /* ===========================================================
	       등급 재조정
	       =========================================================== */
	    int totalPayments = paymentMapper.getUserTotalPayment(userNum);
	    GradeVO newGradeVO = gradeMapper.getGradeByTotalPayment(totalPayments);

	    if (newGradeVO != null &&
	        newGradeVO.getGrade_id() != oldUserVO.getGrade_id()) {

	        UserVO gradeUpdateVO = new UserVO();
	        gradeUpdateVO.setUser_num(userNum);
	        gradeUpdateVO.setGrade_id(newGradeVO.getGrade_id());
	        userMapper.updateUserGrade(gradeUpdateVO);
	    }

	    paymentResultVO.setAfterPoints(currentPoints);
	    paymentResultVO.setUpdatedUserVO(userMapper.getUserByNum(userNum));
	    paymentResultVO.setSuccess(true);
	    paymentResultVO.setMessage("전체 환불이 정상 처리되었습니다.");

	    System.out.println("✅ [RefundService] 전체 환불 처리 완료");
	    System.out.println("   ▶ paymentResultVO : " + paymentResultVO);

	    return paymentResultVO;
	}



	/* ===========================================================
	   🔥 부분 환불 (기존 그대로 — 이미 잘 되어있음)
	   + NPE 방지만 조금 더 강화
	=========================================================== */
	@Transactional
	public PaymentResultVO refundPartial(int userNum, int paymentId, int lectureNum) {

	    PaymentResultVO paymentResultVO = new PaymentResultVO();
	    paymentResultVO.setUserNum(userNum);
	    paymentResultVO.setPaymentId(paymentId);

	    System.out.println("\n🟡 [RefundService] 부분 환불 처리 시작");
	    System.out.println("   🔹 userNum    = " + userNum);
	    System.out.println("   🔹 paymentId  = " + paymentId);
	    System.out.println("   🔹 lectureNum = " + lectureNum);

	    PaymentVO paymentVO = paymentMapper.getPaymentById(paymentId);

	    if (paymentVO == null) {
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("결제 정보를 확인할 수 없습니다.");
	        return paymentResultVO;
	    }

	    if (!"paid".equalsIgnoreCase(paymentVO.getStatus())) {
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("환불할 수 없는 결제입니다.");
	        return paymentResultVO;
	    }

	    UserVO oldUserVO = userMapper.getUserByNum(userNum);
	    if (oldUserVO == null) {
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("유저 정보를 확인할 수 없습니다.");
	        return paymentResultVO;
	    }

	    int currentPoints = oldUserVO.getPoints();

	    PaymentDetailVO detailVO =
	            paymentDetailMapper.getDetailByPaymentAndLecture(paymentId, lectureNum);

	    if (detailVO == null) {
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("환불할 강의 정보를 찾을 수 없습니다.");
	        return paymentResultVO;
	    }

	    if ("refunded".equalsIgnoreCase(detailVO.getStatus())) {
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("이미 환불된 강의입니다.");
	        return paymentResultVO;
	    }

	    int used = detailVO.getUsed_points();
	    int saved = detailVO.getSaved_points();
	    int detailId = detailVO.getDetail_id();

	    if (detailId == 0) {
	        paymentResultVO.setSuccess(false);
	        paymentResultVO.setMessage("결제 상세 정보가 유효하지 않습니다.");
	        return paymentResultVO;
	    }

	    currentPoints += used;
	    currentPoints -= saved;

	    UserVO userUpdateVO = new UserVO();
	    userUpdateVO.setUser_num(userNum);
	    userUpdateVO.setPoints(currentPoints);
	    userMapper.updateUserPoints(userUpdateVO);

	    /* 포인트 히스토리 */
	    if (used > 0) {
	        PointHistoryVO phRestore = new PointHistoryVO();
	        phRestore.setUser_num(userNum);
	        phRestore.setDetail_id(detailId);
	        phRestore.setPoint_change(used);
	        phRestore.setType("restore");
	        phRestore.setDescription("부분 환불로 사용 포인트 복구");
	        pointHistoryMapper.insertPointHistory(phRestore);
	    }

	    if (saved > 0) {
	        PointHistoryVO phRemove = new PointHistoryVO();
	        phRemove.setUser_num(userNum);
	        phRemove.setDetail_id(detailId);
	        phRemove.setPoint_change(-saved);
	        phRemove.setType("remove");
	        phRemove.setDescription("부분 환불로 적립 포인트 회수");
	        pointHistoryMapper.insertPointHistory(phRemove);
	    }

	    enrollmentMapper.deleteByPaymentAndLecture(paymentId, lectureNum);

	    paymentDetailMapper.updateDetailStatusRefund(detailVO.getDetail_id());

	    
	    
	    int totalDetails = paymentDetailMapper.countTotalDetails(paymentId);  
	    int remain = paymentDetailMapper.countPaidDetails(paymentId);

	    // 전체 환불
	    if (remain == 0) {
	    	 paymentMapper.updatePaymentStatusRefund(paymentId);
	    }
	    // 부분 환불
	    else if (remain < totalDetails) {
	        paymentMapper.updatePaymentStatusPartial(paymentId);
	    }

	    int totalPayments = paymentMapper.getUserTotalPayment(userNum);
	    GradeVO newGradeVO = gradeMapper.getGradeByTotalPayment(totalPayments);

	    if (newGradeVO != null &&
	        newGradeVO.getGrade_id() != oldUserVO.getGrade_id()) {

	        UserVO gradeUpdateVO = new UserVO();
	        gradeUpdateVO.setUser_num(userNum);
	        gradeUpdateVO.setGrade_id(newGradeVO.getGrade_id());
	        userMapper.updateUserGrade(gradeUpdateVO);
	    }

	    paymentResultVO.setAfterPoints(currentPoints);
	    paymentResultVO.setUpdatedUserVO(userMapper.getUserByNum(userNum));
	    paymentResultVO.setSuccess(true);
	    paymentResultVO.setMessage("부분 환불이 정상 처리되었습니다.");

	    System.out.println("✅ [RefundService] 부분 환불 처리 완료");
	    System.out.println("   ▶ paymentResultVO : " + paymentResultVO);

	    return paymentResultVO;
	}





	/** 결제일 3일 제한 체크 */
	public boolean isRefundable(Timestamp createdAt) {
		long now = System.currentTimeMillis();
		long created = createdAt.getTime();
		long diffDays = (now - created) / (1000 * 60 * 60 * 24);
		return diffDays <= 3;
	}
	
	public PaymentDetailVO getPaymentDetail(int detailId) {
	    return paymentDetailMapper.getDetailById(detailId);
	}
	
	public PaymentDetailVO getPaymentDetailByPaymentAndLecture(int paymentId, int lectureNum) {
	    return paymentDetailMapper.getDetailByPaymentAndLecture(paymentId, lectureNum);
	}





	public List<Integer> getPurchasedLectures(int user_num) {
		return paymentMapper.getPurchasedLectures(user_num);
	}

}
