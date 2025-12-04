package com.itwillbs.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.AdminMapper;
import com.itwillbs.mapper.CategoryMapper;

@Service
public class CategoryService {

	@Inject
	private CategoryMapper categoryMapper;
	
	public void updateMainCategoryOrder(Map<String, Object> params) {
		System.out.println("CategoryService updateMainCategoryOrder()");
		
		categoryMapper.updateMainCategoryOrder(params);
	}

	public void updateSubCategoryOrder(Map<String, Object> params) {
		System.out.println("CategoryService updateMainCategoryOrder()");
		categoryMapper.updateSubCategoryOrder(params);
	}

}
