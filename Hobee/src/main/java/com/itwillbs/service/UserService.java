package com.itwillbs.service;


import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.UserMapper;

@Service
public class UserService {

	@Inject
	private UserMapper userMapper;

	// 회원가입 처리
	public void registerUser(UserVO userVO) {
		userMapper.insertUser(userVO);
	}
	
	public UserVO getUserById(String userId) {
		return userMapper.getUserById(userId);
	}

}
