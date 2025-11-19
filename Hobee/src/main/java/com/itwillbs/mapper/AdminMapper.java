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

	public List<UserVO> withDrawListMember(PageVO pageVO);

	public int countDrawMemberList();

	public int countTeacherList();

	public void RevertMember(int user_num);

	public int inactiveTeacharCount();

	public int activecountMemberList();

	public int deletecountMemberList();

	public List<UserVO> activeTeacherList(PageVO pageVO);

	public List<UserVO> inactiveTeacherList(PageVO pageVO);

	public List<UserVO> activeMemberList(PageVO pageVO);

	public List<UserVO> inactiveMemberList(PageVO pageVO);

	public List<UserVO> MemberList(PageVO pageVO);

	public int memberCount();

	public int inactiveMemberCount();

	public int countMemberCount();

}
