package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 결제/환불 비즈니스 로직 수행 후
 * Controller에게 전달할 결과 전용 VO
 */
@Getter
@Setter
@ToString
public class PaymentResultVO {

    // 회원 코드
    private int userNum;

    // 등급 변화
    private int oldGradeId;
    private int newGradeId;
    private String newGradeName;
    private boolean gradeChanged;
    private boolean gradeUp;

    // 포인트 변화
    private int beforePoints;
    private int afterPoints;
    private int usedPoints;
    private int savedPoints;

    // 결제 정보
    private int paymentId;
    private boolean success;
    private String message;

    // 🔥 최신 유저 정보(세션 갱신용, Mapper를 Controller에서 쓰지 않기 위해)
    private UserVO updatedUserVO;
}

