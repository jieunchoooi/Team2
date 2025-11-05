package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class MemberService {

	@Inject
	private MemberMapper memberMapper;

	public MemberVO udateMember(String id) {

		return memberMapper.udateMember(id);
	}
	
	
	
	
	
	
	
}
