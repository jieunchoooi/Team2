package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.NotApprovedVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UserVO;

public interface MemberMapper {

	public void updateProMember(UserVO userVO);

	public UserVO insertMember(String user_id);

	public void memberDelete(int user_num);

	public List<LectureVO> manageMyCourses(Map<String, Object> params);

	public int teacherMyPage(Map<String, Object> params);

	public int teacherMyPageWaiting(Map<String, Object> params);

	public int teacherMyPageReject(Map<String, Object> params);

	public List<LectureVO> approvalClass(Map<String, Object> params); 

	public List<LectureVO> waitingClass(Map<String, Object> params);

	public List<LectureVO> rejectClass(Map<String, Object> params);

	public List<LectureVO> deleteClass(Map<String, Object> params);
	
	public void LectureUpdate(LectureVO lectureVO);

	public void insertChapter(ChapterVO chapterVO);

	public void insertChapterDetail(ChapterDetailVO chapterDetailVO);

	public int teacherMyPageDelete(Map<String, Object> params);

	public void deleteRequest(int lecture_num);

	public NotApprovedVO classReason(int lecture_num);

	public void deleteCencel(int lecture_num);

	public int teacherMyPageOk(Map<String, Object> params);



	

}
