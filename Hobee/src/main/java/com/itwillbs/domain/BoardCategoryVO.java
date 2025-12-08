package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardCategoryVO {

    private int category_id;
    private String category_key;
    private String category_name;
    private String category_desc;
    private int is_active;
    private int sort_order;
}


