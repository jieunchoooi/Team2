package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.UserVO;

@Mapper
public interface UserMapper {
	
	public void insertUser(UserVO userVO);
	
	public UserVO getUserById(String userId);
}
