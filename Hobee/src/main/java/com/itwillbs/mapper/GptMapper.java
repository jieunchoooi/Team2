package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GptMapper {

	Object insetInterest(Map<String, Object> params);

	String getUserInterest(String user_id);

	List<Integer> getPurchasedLectureIds(String user_id);

	List<String> getUserInterestList(String user_id);

	List<Map<String, Object>> getAllLecturesInfo();

}
