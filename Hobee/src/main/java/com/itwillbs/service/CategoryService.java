package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.mapper.CategoryMapper;

@Service
public class CategoryService {
	
	@Inject
	private CategoryMapper categoryMapper;

	public List<LectureVO> getAllLectures() {
		System.out.println("CategoryService getAllLectures()");
		return categoryMapper.getAllLectures();
	}

	public List<LectureVO> getTop10() {
		System.out.println("CategoryService getTop10()");
		return categoryMapper.getTop10();
	}

	public List<LectureVO> getLecturesByCategory(String category_detail) {
		System.out.println("CategoryService getLecturesByCategory()");
		return categoryMapper.getLecturesByCategory(category_detail);
	}

	public List<LectureVO> getTop10ByCategory(String category_detail) {
		System.out.println("CategoryService getTop10ByCategory()");
		return categoryMapper.getTop10ByCategory(category_detail);
	}


}
