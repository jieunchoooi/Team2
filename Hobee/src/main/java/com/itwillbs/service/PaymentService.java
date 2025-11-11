package com.itwillbs.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.EnrollmentVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.mapper.PaymentMapper;
import com.itwillbs.mapper.EnrollmentMapper;
import com.itwillbs.mapper.PointHistoryMapper;
import com.itwillbs.domain.PointHistoryVO;

@Service
public class PaymentService {

    @Autowired private PaymentMapper paymentMapper;
    @Autowired private EnrollmentMapper enrollmentMapper;
    @Autowired private PointHistoryMapper pointHistoryMapper;

    /**
     * ✅ 1회 결제 = Payment 1건 + 여러 수강 등록
     */
    public void processPayment(PaymentVO paymentVO, List<LectureVO> lectureList) {

        // 1️⃣ 결제 1건 저장
        paymentMapper.insertPayment(paymentVO);
        int paymentId = paymentVO.getPayment_id();
        int userNum = paymentVO.getUser_num();

        // 2️⃣ 포인트 사용 (있을 경우)
        if (paymentVO.getUsed_points() > 0) {
            PointHistoryVO usedVO = new PointHistoryVO();
            usedVO.setUser_num(userNum);
            usedVO.setPayment_id(paymentId);
            usedVO.setPoint_change(-paymentVO.getUsed_points());
            usedVO.setType("USE");
            usedVO.setDescription("클래스 결제 시 포인트 사용");
            pointHistoryMapper.insertPointHistory(usedVO);
            pointHistoryMapper.deductPoints(usedVO);
        }

        // 3️⃣ 포인트 적립 (결제금액의 5%)
        int savedPoints = (int) Math.floor(paymentVO.getAmount() * 0.05);
        paymentVO.setSaved_points(savedPoints);

        PointHistoryVO saveVO = new PointHistoryVO();
        saveVO.setUser_num(userNum);
        saveVO.setPayment_id(paymentId);
        saveVO.setPoint_change(savedPoints);
        saveVO.setType("SAVE");
        saveVO.setDescription("결제 적립 포인트");
        pointHistoryMapper.insertPointHistory(saveVO);
        pointHistoryMapper.addPoints(saveVO);

        // 4️⃣ 여러 강의 수강 등록
        for (LectureVO lecture : lectureList) {
            EnrollmentVO enrollVO = new EnrollmentVO();
            enrollVO.setUser_num(userNum);
            enrollVO.setLecture_num(lecture.getLecture_num());
            enrollVO.setPayment_id(paymentId);
            enrollmentMapper.insertEnrollment(enrollVO);
        }
    }
}
