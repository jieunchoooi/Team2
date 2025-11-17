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

	public void deleteClass(String lecture_num);

	public UserVO insertMember(int user_num);

	public void adminUserUpdate(UserVO userVO);

	public LectureVO classEdit(int lecture_num);

	public void adminEditClass(LectureVO lectureVO);

	public List<UserVO> listTeacher(PageVO pageVO);

	public int teacharCount();

	public int classCount();

	public void deleteMember(int user_num);

}
