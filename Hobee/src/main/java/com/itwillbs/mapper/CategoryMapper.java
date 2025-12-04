package com.itwillbs.mapper;

import java.util.Map;

public interface CategoryMapper {

	void updateMainCategoryOrder(Map<String, Object> params);

	void updateSubCategoryOrder(Map<String, Object> params);

}
