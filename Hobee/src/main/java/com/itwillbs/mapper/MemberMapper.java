package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.MemberVO;

@Mapper
public interface MemberMapper {

	MemberVO udateMember(String id);

}
