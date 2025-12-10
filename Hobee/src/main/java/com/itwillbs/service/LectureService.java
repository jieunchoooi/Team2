package com.itwillbs.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.LectureMapper;

@Service
public class LectureService {
	
	@Inject
	private LectureMapper lectureMapper;

	public List<LectureVO> getAllLectures() {
		System.out.println("LectureService getAllLectures()");
		return lectureMapper.getAllLectures();
	}

	public List<LectureVO> getTop10() {
		System.out.println("LectureService getTop10()");
		return lectureMapper.getTop10();
	}

	public List<LectureVO> getLecturesByCategory(String category_detail) {
		System.out.println("LectureService getLecturesByCategory()");
		return lectureMapper.getLecturesByCategory(category_detail);
	}

	public List<LectureVO> getTop10ByCategory(String category_detail) {
		System.out.println("LectureService getTop10ByCategory()");
		return lectureMapper.getTop10ByCategory(category_detail);
	}

	public LectureVO contentLecture(int lecture_num) {
		System.out.println("LectureService contentLecture()");
		return lectureMapper.contentLecture(lecture_num);
	}

	public UserVO getUserImg(int lecture_num) {
		System.out.println("LectureService getUserImg()");
		return lectureMapper.getUserImg(lecture_num);
	}

	public List<LectureVO> authorLectures(LectureVO lectureVO) {
		System.out.println("LectureService authorLectures()");
		return lectureMapper.authorLectures(lectureVO);
	}

	public List<LectureVO> similarLectures(LectureVO lectureVO) {
		System.out.println("LectureService similarLectures()");
		
		String tags = lectureVO.getLecture_tag(); 

		List<String> tagList = Arrays.stream(tags.split(","))
		                             .map(String::trim)
		                             .collect(Collectors.toList());

		Map<String, Object> param = new HashMap<>();
		param.put("lecture_num", lectureVO.getLecture_num());
		param.put("tagList", tagList);
		
		return lectureMapper.similarLectures(param);
	}

	public ChapterVO getChapter(int lecture_num) {
		System.out.println("LectureService getChapter()");
		return lectureMapper.getChapter(lecture_num);
	}

	public List<ChapterDetailVO> getDetail(int chapter_num) {
		System.out.println("LectureService getDetail()");
		return lectureMapper.getDetail(chapter_num);
	}

	public List<ChapterVO> getChapterList(int lecture_num) {
		System.out.println("LectureService getChapterList()");
		return lectureMapper.getChapterList(lecture_num);
	}

	public List<ReviewVO> getReviewList(int lecture_num) {
		System.out.println("LectureService getChapterList()");
		return lectureMapper.getReviewList(lecture_num);
	}
	
	public int getUserNum(String user_id) {
		System.out.println("LectureService getUserNum()");
		return lectureMapper.getUserNum(user_id);
	}


	public int hasPurchased(int loginUserNum, int lecture_num) {
		System.out.println("LectureService hasPurchased()");
		return lectureMapper.hasPurchased(loginUserNum, lecture_num);
	}

	public void insertReview(ReviewVO reviewVO) {
		System.out.println("LectureService insertReview()");
		lectureMapper.insertReview(reviewVO);
	}

	public int hasWrittenReview(String user_id, int lecture_num) {
		System.out.println("LectureService hasWrittenReview()");
		return lectureMapper.hasWrittenReview(user_id, lecture_num);
	}

	public List<LectureVO> getAllLectures(String search) {
		System.out.println("LectureService getAllLectures(search)");
		return lectureMapper.getAllLectures(search);
	}

	public List<LectureVO> getRecoLectures(UserVO userVO) {
		System.out.println("LectureService getRecoLectures(userVO)");
		return lectureMapper.getRecoLectures(userVO);
	}

	public List<ReviewVO> getPersonalReview(String userId) {
		System.out.println("LectureService getPersonalReview(userId)");
		return lectureMapper.getPersonalReview(userId);
	}

	public int deleteReview(int review_num) {
		System.out.println("LectureService deleteReview(review_num)");
		return lectureMapper.deleteReview(review_num);
	}

	public int updateReview(int review_num, String review_content, double review_score) {
	    System.out.println("LectureService updateReview()");
	    return lectureMapper.updateReview(review_num, review_content, review_score);
	}

	public List<LectureVO> getLecturesByIds(List<Integer> recommendLectureIds) {
		System.out.println("LectureService getLecturesByIds()");
	    return lectureMapper.getLecturesByIds(recommendLectureIds);
	}






}
