package com.itwillbs.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GptMapper {

	Object insetInterest(Map<String, Object> params);

}
