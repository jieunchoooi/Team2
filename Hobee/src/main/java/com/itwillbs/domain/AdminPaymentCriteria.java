package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminPaymentCriteria {

    private String viewType;

    // 공통 필터
    private String merchantUid;
    private String period;
    private String startDate;
    private String endDate;
    private String status;
    private String detailStatus;
    private String keyword;
    private String searchType;
    private String sort;

    // 결제건별 필터
    private Integer minAmount;
    private Integer maxAmount;
    private String lectureCountOption; // single / multi
    private String refundType;         // none / partial / full

    // 강의별 필터
    private String lectureTitle;
    private String lectureAuthor;
    private String categoryDetail;
    private Integer minPrice;
    private Integer maxPrice;
}
