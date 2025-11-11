package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class UserVO {
    private int user_num;
    private String user_id;
    private String user_password;
    private String user_name;
    private String user_phone;
    private String user_email;
    private String user_address;
    private String user_gender;
    private String user_role;      // user, instructor, admin
    private String user_status;    // active, inactive, withdraw
    private int grade_id;
    private int points;
    private String user_file;      // 프로필 이미지 파일명
    private String created_at;
    private String updated_at;
}
