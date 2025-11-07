package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class MemberService {

	@Inject
	private MemberMapper memberMapper;
	
	public void updateMember(UserVO userVO) {
		System.out.println("MemberService updatemember()");
		memberMapper.updateMember(userVO);
	}

}
