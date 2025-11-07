package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.CommunityVO;

@Mapper
public interface CommunityMapper {

	public void writeCommunity(CommunityVO communityVO);

}
