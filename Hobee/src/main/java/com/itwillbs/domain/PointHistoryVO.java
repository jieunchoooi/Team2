package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PointHistoryVO {
    private int point_id;
    private int user_num;
    private int payment_id;
    private int point_change;      // +적립 / -사용
    private String type;           // USE / SAVE
    private String description;
    private String created_at;
}