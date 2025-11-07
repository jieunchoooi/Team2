package com.itwillbs.mapper;

import com.itwillbs.domain.UserVO;

public interface MemberMapper {

	public void updateProMember(UserVO userVO);

	public UserVO updateMember(String user_id);
	

}
