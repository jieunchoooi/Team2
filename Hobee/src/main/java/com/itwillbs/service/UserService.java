package com.itwillbs.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.UserMapper;

@Service
public class UserService {

    @Inject
    private UserMapper userMapper;

    // 회원가입
    public void insertUser(UserVO userVO) {
    	System.out.println("UesrService: insertUser() 실행");
        userMapper.insertUser(userVO);
    }

    public UserVO login(UserVO userVO) {
    	System.out.println("UesrService: login() 실행");
        return userMapper.login(userVO);
    }
    
	public UserVO selectUserById(String user_id) {
		System.out.println("UesrService: selectUserById() 실행");
		return userMapper.selectUserById(user_id);
	}

}