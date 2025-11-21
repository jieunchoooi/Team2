package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.mapper.AdminMapper;
import com.itwillbs.mapper.MemberMapper;

@Service
public class AdminService {

	@Inject
	private AdminMapper adminMapper;

	public List<UserVO> listMember(PageVO pageVO) {
		System.out.println("AdminService listMember()");

		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();

		pageVO.setStartRow(startRow);

		return adminMapper.listMember(pageVO);
	}

	public int countMemberList() {
		System.out.println("AdminService countMemberList()");
		return adminMapper.countMemberList();
	}

	public void LectureUpdate(LectureVO lectureVO) {
		System.out.println("AdminService LectureUpdate()");
		adminMapper.LectureUpdate(lectureVO);
	}

	public List<LectureVO> listLecture(PageVO pageVO) {
		System.out.println("AdminService listLecture()");

		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();

		pageVO.setStartRow(startRow);

		return adminMapper.listLecture(pageVO);
	}

	public int countlectureList() {
		System.out.println("AdminService countlectureList()");

		return adminMapper.countlectureList();
	}

	public void deleteClass(String lecture_num) {
		System.out.println("AdminService deleteClass()");

		adminMapper.deleteClass(lecture_num);
	}

	public UserVO insertMember(int user_num) {
		System.out.println("AdminService insertMember()");
		return adminMapper.insertMember(user_num);
	}

	public void adminUserUpdate(UserVO userVO) {
		System.out.println("AdminService adminUserUpdate()");
		adminMapper.adminUserUpdate(userVO);
	}

	public LectureVO classEdit(int lecture_num) {
		System.out.println("AdminService adminUserUpdate()");
		return adminMapper.classEdit(lecture_num);
	}

	public void adminEditClass(LectureVO lectureVO) {
		System.out.println("AdminService adminEditClass()");
		adminMapper.adminEditClass(lectureVO);
	}

	public List<UserVO> listTeacher(PageVO pageVO) {
		System.out.println("AdminService listTeacher()");

		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();

		pageVO.setStartRow(startRow);

		return adminMapper.listTeacher(pageVO);
	}

	public int teacharCount() {
		System.out.println("AdminService teacharCount()");
		return adminMapper.teacharCount();
	}

	public int classCount() {
		System.out.println("AdminService classCount()");
		return adminMapper.classCount();
	}

	public void deleteMember(int user_num) {
		System.out.println("AdminService deleteMember()");
		adminMapper.deleteMember(user_num);
	}

	public List<UserVO> withDrawListMember(PageVO pageVO) {
		System.out.println("AdminService withDrawListMember()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.withDrawListMember(pageVO);
	}

	public int countDrawMemberList() {
		System.out.println("AdminService countDrawMemberList()");
		return adminMapper.countDrawMemberList();
	}

	public int countTeacherList() {
		System.out.println("AdminService countTeacherList()");
		return adminMapper.countTeacherList();
	}

	public void RevertMember(int user_num) {
		System.out.println("AdminService RevertMember()");
		adminMapper.RevertMember(user_num);
	}

	public int inactiveTeacharCount() {
		System.out.println("AdminService inactiveTeacharCount()");
		return adminMapper.inactiveTeacharCount();
	}

	public int activecountMemberList() {
		System.out.println("AdminService inactiveTeacharCount()");
		return adminMapper.activecountMemberList();
	}

	public int deletecountMemberList() {
		System.out.println("AdminService deletecountMemberList()");
		return adminMapper.deletecountMemberList();
	}

	public List<UserVO> activeTeacherList(PageVO pageVO) {
		System.out.println("AdminService activeTeacherList()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.activeTeacherList(pageVO);
	}

	public List<UserVO> inactiveTeacherList(PageVO pageVO) {
		System.out.println("AdminService inactiveTeacherList()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.inactiveTeacherList(pageVO);
	}

	public List<UserVO> activeMemberList(PageVO pageVO) {
		System.out.println("AdminService activeMemberList()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.activeMemberList(pageVO);
	}

	public List<UserVO> inactiveMemberList(PageVO pageVO) {
		System.out.println("AdminService inactiveMemberList()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.inactiveMemberList(pageVO);
		
	}

	public List<UserVO> MemberList(PageVO pageVO) {
		System.out.println("AdminService MemberList()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.MemberList(pageVO);
	}

	public int memberCount() {
		System.out.println("AdminService memberCount()");
		return adminMapper.memberCount();
	}

	public int inactiveMemberCount() {
		System.out.println("AdminService inactiveMemberCount()");
		return adminMapper.inactiveMemberCount();
	}

	public int countMemberCount() {
		System.out.println("AdminService countMemberCount()");
		return adminMapper.countMemberCount();
	}

	public List<UserVO> DrawinstructorListMember(PageVO pageVO) {
		System.out.println("AdminService DrawinstructorListMember()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.DrawinstructorListMember(pageVO);
	}

	public int instructorDeletecountList() {
		System.out.println("AdminService instructorDeletecountList()");
		return adminMapper.instructorDeletecountList();
	}

	public int deleteAllMemberCount() {
		System.out.println("AdminService deleteAllMemberCount()");
		return adminMapper.deleteAllMemberCount();
	}

	public List<UserVO> withDeleteUserMember(PageVO pageVO) {
		System.out.println("AdminService withDeleteUserMember()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.withDeleteUserMember(pageVO);
	}

	public void insertChapter(ChapterVO chapterVO) {
		System.out.println("AdminService insertChapter()");
		adminMapper.insertChapter(chapterVO);
	}

	public void insertChapterDetail(ChapterDetailVO detailVO) {
		System.out.println("AdminService insertChapterDetail()");
		adminMapper.insertChapterDetail(detailVO);
	}

	public List<UserVO> getInstructorList() {
		System.out.println("AdminService insertChapterDetail()");
		return adminMapper.getInstructorList();
	}




	

}
