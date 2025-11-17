package com.itwillbs.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.UserMapper;

@Service
public class UserService {

    @Inject
    private UserMapper userMapper;

    // ✅ 회원가입
    public void insertUser(UserVO userVO) {
    	System.out.println("UesrService: insertUser() 실행");
        userMapper.insertUser(userVO);
    }
    // ✅ 로그인
    public UserVO loginUser(UserVO userVO) {
    	System.out.println("UesrService: login() 실행");
        return userMapper.loginUser(userVO);
    }
    // ✅ 아이디로 회원 조회 (로그인, 중복확인 공용)
	public UserVO selectUserById(String user_id) {
		System.out.println("UesrService: selectUserById() 실행");
		return userMapper.selectUserById(user_id);
	}
	// ✅ 이메일로 사용자 찾기
	public UserVO findUserByEmail(String user_email) {
		System.out.println("UesrService: findUserByEmail() 실행");
		return userMapper.findUserByEmail(user_email);
	}
	// ✅ 임시 비밀번호 업데이트
	public void updateTempPassword(String user_id, String tempPw) {
		System.out.println("UesrService: updateTempPassword() 실행");
		userMapper.updateTempPassword(user_id, tempPw);
	}
	// ✅ 이메일 중복 체크
	public int checkEmail(String user_email) {
		System.out.println("UesrService: checkEmail() 실행");
		return userMapper.checkEmail(user_email); 
	}
	
	public UserVO findUserByIdAndEmail(String user_id, String user_email) {
		System.out.println("UesrService: findUserByIdAndEmail() 실행");
		return userMapper.findUserByIdAndEmail(user_id, user_email);
	}
	public UserVO findIdByNameAndEmail(String user_name, String user_email) {
		System.out.println("UesrService: findIdByNameAndEmail() 실행");
		return userMapper.findIdByNameAndEmail(user_name, user_email);
	}

}