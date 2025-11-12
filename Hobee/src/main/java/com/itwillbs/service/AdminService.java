package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.AdminMapper;

@Service
public class AdminService {

	@Inject
	private AdminMapper adminmapper;
	
	public List<UserVO> listMember() {
		System.out.println("AdminService listMember()");
		
		return adminmapper.listMember();
	}

}
