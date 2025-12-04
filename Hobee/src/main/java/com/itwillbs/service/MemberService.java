package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.NotApprovedVO;
import com.itwillbs.domain.PageVO;
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

	public List<LectureVO> manageMyCourses(Map<String, Object> params) {
		System.out.println("MemberService manageMyCourses()");
		
		PageVO pageVO = (PageVO) params.get("pageVO");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		params.put("pageVO", pageVO);
		
		return memberMapper.manageMyCourses(params);
	}

	public int teacherMyPage(Map<String, Object> params) {
		System.out.println("MemberService teacherMyPage()");
		return memberMapper.teacherMyPage(params);
	}

	public int teacherMyPageOk(Map<String, Object> params) {
		System.out.println("MemberService teacherMyPageOk()");
		return memberMapper.teacherMyPageOk(params);
	}

	public int teacherMyPageWaiting(Map<String, Object> params) {
		System.out.println("MemberService teacherMyPageWaiting()");
		return memberMapper.teacherMyPageWaiting(params);
	}

	public int teacherMyPageReject(Map<String, Object> params) {
		System.out.println("MemberService teacherMyPageReject()");
		return memberMapper.teacherMyPageReject(params);
	}

	public List<LectureVO> approvalClass(Map<String, Object> params) {
		System.out.println("MemberService approvalClass()");
		PageVO pageVO = (PageVO) params.get("pageVO");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		params.put("pageVO", pageVO);
		return memberMapper.approvalClass(params);
	}
	
	public List<LectureVO> waitingClass(Map<String, Object> params) {
		System.out.println("MemberService waitingClass()");
		PageVO pageVO = (PageVO) params.get("pageVO");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		params.put("pageVO", pageVO);
		return memberMapper.waitingClass(params);
	}

	public List<LectureVO> rejectClass(Map<String, Object> params) {
		System.out.println("MemberService rejectClass()");
		PageVO pageVO = (PageVO) params.get("pageVO");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		params.put("pageVO", pageVO);
		return memberMapper.rejectClass(params);
	}

	public List<LectureVO> deleteClass(Map<String, Object> params) {
		System.out.println("MemberService deleteClass()");
		PageVO pageVO = (PageVO) params.get("pageVO");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		params.put("pageVO", pageVO);
		return memberMapper.deleteClass(params);
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

	public int teacherMyPageDelete(Map<String, Object> params) {
		System.out.println("MemberService teacherMyPageDelete()");
		return memberMapper.teacherMyPageDelete(params);
	}

	public void deleteRequest(int lecture_num) {
		System.out.println("MemberService deleteRequest()");
		memberMapper.deleteRequest(lecture_num);
	}

	public NotApprovedVO classReason(int lecture_num) {
		System.out.println("MemberService classReason()");
		return memberMapper.classReason(lecture_num);
	}

	public void deleteCencel(int lecture_num) {
		System.out.println("MemberService deleteCencel()");
		memberMapper.deleteCencel(lecture_num);
	}



	




}
