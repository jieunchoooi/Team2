package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.LectureVO;

@Mapper
public interface LectureMapper {

	List<LectureVO> getAllLectures();

	List<LectureVO> getTop10();

	List<LectureVO> getLecturesByCategory(String category_detail);

	List<LectureVO> getTop10ByCategory(String category_detail);

}
