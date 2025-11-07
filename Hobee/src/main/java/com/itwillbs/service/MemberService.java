package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class MemberService {

	@Inject
	private MemberMapper memberMapper;
	
	public void updateProMember(UserVO userVO) {
		System.out.println("MemberService updateProMember()");
		memberMapper.updateProMember(userVO);
	}

	public UserVO updateMember(String user_id) {
		System.out.println("MemberService updateMember()");
		
		return memberMapper.updateMember(user_id);
	}

}
