package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserInterestVO {
	
	 private String userId;
	 private int interestId;
	 private InterestVO interest;

}
