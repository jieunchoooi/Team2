package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class MemberService {

	@Inject
	private MemberMapper memberMapper;
	
	
	public void updateProMember(UserVO userVO) {
		System.out.println("MemberService updateProMember()");
		memberMapper.updateProMember(userVO);
	}

	public UserVO insertMember(String user_id) {
		System.out.println("MemberService insertMember()");
		
		return memberMapper.insertMember(user_id);
	}

	public void memberDelete(int user_num) {
		System.out.println("MemberService insertMember()");
		
		memberMapper.memberDelete(user_num);
	}

	public List<LectureVO> manageMyCourses(String user_name) {
		System.out.println("MemberService manageMyCourses()");
		return memberMapper.manageMyCourses(user_name);
	}

	public int teacherMyPage(String user_name) {
		System.out.println("MemberService teacherMyPage()");
		return memberMapper.teacherMyPage(user_name);
	}

	public int teacherMyPageOk(String user_name) {
		System.out.println("MemberService teacherMyPageOk()");
		return memberMapper.teacherMyPageOk(user_name);
	}

	public int teacherMyPageWaiting(String user_name) {
		System.out.println("MemberService teacherMyPageWaiting()");
		return memberMapper.teacherMyPageWaiting(user_name);
	}

	public int teacherMyPageReject(String user_name) {
		System.out.println("MemberService teacherMyPageReject()");
		return memberMapper.teacherMyPageReject(user_name);
	}

	public List<LectureVO> approvalClass(String user_name) {
		System.out.println("MemberService approvalClass()");
		return memberMapper.approvalClass(user_name);
	}

	public List<LectureVO> waitingClass(String user_name) {
		System.out.println("MemberService waitingClass()");
		return memberMapper.waitingClass(user_name);
	}

	public List<LectureVO> rejectClass(String user_name) {
		System.out.println("MemberService rejectClass()");
		return memberMapper.rejectClass(user_name);
	}

	public List<LectureVO> deleteClass(String user_name) {
		System.out.println("MemberService deleteClass()");
		return memberMapper.deleteClass(user_name);
	}
	
	public void LectureUpdate(LectureVO lectureVO) {
		System.out.println("MemberService LectureUpdate()");
		memberMapper.LectureUpdate(lectureVO);
	}

	public void insertChapter(ChapterVO chapterVO) {
		System.out.println("MemberService insertChapter()");
		memberMapper.insertChapter(chapterVO);
	}

	public void insertChapterDetail(ChapterDetailVO chapterDetailVO) {
		System.out.println("MemberService insertChapter()");
		memberMapper.insertChapterDetail(chapterDetailVO);
	}

	public int teacherMyPageDelete(String user_name) {
		System.out.println("MemberService teacherMyPageDelete()");
		return memberMapper.teacherMyPageDelete(user_name);
	}

	public void deleteRequest(int lecture_num) {
		System.out.println("MemberService deleteRequest()");
		memberMapper.deleteRequest(lecture_num);
	}




}
