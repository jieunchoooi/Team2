package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.CommunityVO;

@Mapper
public interface CommunityMapper {

	public void writeCommunity(CommunityVO communityVO);

	public List<CommunityVO> comunityList();

}
