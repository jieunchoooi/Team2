package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class NotApprovedVO {

	private int reason_num;
	private int lecture_num;
	private String status;
	private String reason; // 미승인 사유
	
	
}
