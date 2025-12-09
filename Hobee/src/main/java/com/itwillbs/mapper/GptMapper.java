package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GptMapper {

	String insetInterest(@Param("prompt") String prompt, @Param("user_id") String user_id);

}
