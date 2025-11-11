package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class MemberService {

	@Inject
	private MemberMapper memberMapper;
	@Autowired
	private UserVO userVO;
	
	public void updateProMember(UserVO userVO) {
		System.out.println("MemberService updateProMember()");
		memberMapper.updateProMember(userVO);
	}

	public UserVO insertMember(String user_id) {
		System.out.println("MemberService insertMember()");
		
		return memberMapper.insertMember(user_id);
	}

	public List<UserVO> listMember() {
		System.out.println("MemberService listMember()");
		
		if(userVO == null) {
			System.out.println("UserVO null");
		}
		return memberMapper.listMember();
	}

}
