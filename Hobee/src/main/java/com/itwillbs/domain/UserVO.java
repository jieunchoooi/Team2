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


    private String user_role;
    private String user_status;
    private int grade_id;        // 🔹 외래키: 현재 등급 ID
    private int points;          // 🔹 보유 포인트
    private String user_file;    // 사진 경로 마이페이지에서만 활용
    private String created_at;
    private String updated_at;
    private String updated_sat;
    
    // 결제 관련 보조 필드
    private int used_points;
    private int saved_points;
}
