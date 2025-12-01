package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginHistoryVO {

    private int id;                 // PK
    private String user_id;         // 로그인한 사용자 ID
    private String login_time;      // 로그인 시간
    private String device_info;     // 로그인 기기(OS/Browser)
    private String location;        // 로그인 지역

}
