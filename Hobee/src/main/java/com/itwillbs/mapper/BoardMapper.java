package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.BoardVO;

@Mapper
public interface BoardMapper {

	public void writeBoard(BoardVO boardVO);

}
