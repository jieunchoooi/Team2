package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.UserVO;

public interface MemberMapper {

	public void updateProMember(UserVO userVO);

	public UserVO insertMember(String user_id);

	public List<UserVO> listMember();
	

}
