package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.UserVO;

@Mapper
public interface UserMapper {

	// ✅ 회원가입
	public void insertUser(UserVO userVO);

	// ✅ 로그인
	public UserVO loginUser(UserVO userVO);
	
	// ✅ 아이디로 회원 조회 (로그인, 중복확인 공용)
	public UserVO selectUserById(String user_id);

	// ✅ 이메일로 사용자 찾기
	public UserVO findUserByEmail(String user_email);

	// ✅ 임시 비밀번호 업데이트
	public void updateTempPassword(@Param("user_id") String user_id, @Param("tempPw") String tempPw);
	
	// ✅ 이메일 중복 체크
	public int checkEmail(String user_email);

	public UserVO findUserByIdAndEmail(@Param("user_id")String user_id,  @Param("user_email")String user_email);

	public UserVO findIdByNameAndEmail(@Param("user_name")String user_name, @Param("user_email")String user_email);
	
}
