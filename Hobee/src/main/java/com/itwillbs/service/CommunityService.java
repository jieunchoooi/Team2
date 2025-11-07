package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.CommunityVO;
import com.itwillbs.mapper.CommunityMapper;

@Service
public class CommunityService {
	@Inject
	private CommunityMapper communityMapper;

	public void writeCommunity(CommunityVO communityVO) {
		System.out.println("CommunityService writeBoard()");
		System.out.println(communityVO);
		
		communityMapper.writeCommunity(communityVO);
		
	}

	public List<CommunityVO> comunityList() {
		System.out.println("CommunityService comunityList()");
		return communityMapper.comunityList();
	}

}
