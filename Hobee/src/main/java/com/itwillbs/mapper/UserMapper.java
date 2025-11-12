package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.domain.UserVO;

@Mapper
public interface UserMapper {

	// ✅ 회원가입
	public void insertUser(UserVO userVO);

	// ✅ 로그인
	public UserVO login(UserVO userVO);
	
	// ✅ 아이디로 회원 조회 (로그인, 중복확인 공용)
	public UserVO selectUserById(String user_id);

	
}
