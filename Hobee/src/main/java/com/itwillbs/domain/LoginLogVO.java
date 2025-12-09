package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginLogVO {
	
	private int log_id;
    private String user_id;
    private String login_time;
    private String ip;
    private String device;
    private String location;

}
