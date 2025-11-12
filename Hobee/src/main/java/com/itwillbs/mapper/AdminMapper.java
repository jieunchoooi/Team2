package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UserVO;

public interface AdminMapper {

	public List<UserVO> listMember(PageVO pageVO);

	public int countMemberList();

	public void LectureUpdate(LectureVO lectureVO);

	public List<LectureVO> listLecture(PageVO pageVO);

	public int countlectureList();

}
