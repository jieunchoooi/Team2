package com.itwillbs.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeFileVO {

    private int file_id;
    private int notice_id;
    private String file_name;
    private String file_path;
    private long file_size;
    private String upload_date;
}
