package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.domain.UserVO;

@Mapper
public interface LectureMapper {

	List<LectureVO> getAllLectures();

	List<LectureVO> getTop10();

	List<LectureVO> getLecturesByCategory(String category_detail);

	List<LectureVO> getTop10ByCategory(String category_detail);

	LectureVO contentLecture(int lecture_num);

	UserVO getUserImg(int lecture_num);

	List<LectureVO> authorLectures(LectureVO lectureVO);

	List<LectureVO> similarLectures(Map<String, Object> param);

	ChapterVO getChapter(int lecture_num);

	List<ChapterDetailVO> getDetail(int chapter_num);

	List<ChapterVO> getChapterList(int lecture_num);

	List<ReviewVO> getReviewList(int lecture_num);

	

	

}
