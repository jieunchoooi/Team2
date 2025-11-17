package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.LectureVO;
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


}
