package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.CommunityContentVO;
import com.itwillbs.mapper.CommunityContentMapper;

@Service
public class CommunityService {
	@Inject
	private CommunityContentMapper communityContentMapper;

	public List<CommunityContentVO> getList(Integer categoryMainNum, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return communityContentMapper.getCommunityList(categoryMainNum, offset, pageSize);
    }

    public int getTotalCount(Integer categoryMainNum) {
        return communityContentMapper.getCommunityCount(categoryMainNum);
    }

}
