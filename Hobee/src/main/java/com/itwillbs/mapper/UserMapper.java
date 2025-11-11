package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.domain.UserVO;

@Mapper
public interface UserMapper {

	// ✅ 회원가입
	public void insertUser(UserVO userVO);

	// ✅ 로그인
	public UserVO login(UserVO userVO);

	public UserVO selectUserById(String user_id);


}
