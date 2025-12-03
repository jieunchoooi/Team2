package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.NotApprovedVO;
import com.itwillbs.domain.UserVO;

public interface MemberMapper {

	public void updateProMember(UserVO userVO);

	public UserVO insertMember(String user_id);

	public void memberDelete(int user_num);

	public List<LectureVO> manageMyCourses(String user_name);

	public int teacherMyPage(String user_name);

	public int teacherMyPageOk(String user_name);

	public int teacherMyPageWaiting(String user_name);

	public int teacherMyPageReject(String user_name);

	public List<LectureVO> approvalClass(String user_name); //

	public List<LectureVO> waitingClass(String user_name);

	public List<LectureVO> rejectClass(String user_name);

	public List<LectureVO> deleteClass(String user_name);
	
	public void LectureUpdate(LectureVO lectureVO);

	public void insertChapter(ChapterVO chapterVO);

	public void insertChapterDetail(ChapterDetailVO chapterDetailVO);

	public int teacherMyPageDelete(String user_name);

	public void deleteRequest(int lecture_num);

	public NotApprovedVO classReason(int lecture_num);

	public void deleteCencel(int lecture_num);



	

}
