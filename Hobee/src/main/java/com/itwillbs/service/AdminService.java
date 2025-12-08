package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.Category_mainVO;
import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.NotApprovedVO;
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

	public int countMemberList(PageVO pageVO) {
		System.out.println("AdminService countMemberList()");
		return adminMapper.countMemberList(pageVO);
	}

//	public void LectureUpdate(LectureVO lectureVO) {
//		System.out.println("AdminService LectureUpdate()");
//		adminMapper.LectureUpdate(lectureVO);
//	}

	public List<LectureVO> listLecture(PageVO pageVO) {
		System.out.println("AdminService listLecture()");

		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();

		pageVO.setStartRow(startRow);

		return adminMapper.listLecture(pageVO);
	}

	public int countlectureList(PageVO pageVO) {
		System.out.println("AdminService countlectureList()");

		return adminMapper.countlectureList(pageVO);
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

	public int teacharCount(PageVO pageVO) {
		System.out.println("AdminService teacharCount()");
		return adminMapper.teacharCount(pageVO);
	}

	public int classCount(PageVO pageVO) {
		System.out.println("AdminService classCount()");
		return adminMapper.classCount(pageVO);
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

	public int countTeacherList(PageVO pageVO) {
		System.out.println("AdminService countTeacherList()");
		return adminMapper.countTeacherList(pageVO);
	}

	public void RevertMember(int user_num) {
		System.out.println("AdminService RevertMember()");
		adminMapper.RevertMember(user_num);
	}

	public int inactiveTeacharCount(PageVO pageVO) {
		System.out.println("AdminService inactiveTeacharCount()");
		return adminMapper.inactiveTeacharCount(pageVO);
	}

	public int deletecountMemberList(PageVO pageVO) {
		System.out.println("AdminService deletecountMemberList()");
		return adminMapper.deletecountMemberList(pageVO);
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

	public int memberCount(PageVO pageVO) {
		System.out.println("AdminService memberCount()");
		return adminMapper.memberCount(pageVO);
	}

	public int inactiveMemberCount(PageVO pageVO) {
		System.out.println("AdminService inactiveMemberCount()");
		return adminMapper.inactiveMemberCount(pageVO);
	}

	public List<UserVO> DrawinstructorListMember(PageVO pageVO) {
		System.out.println("AdminService DrawinstructorListMember()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.DrawinstructorListMember(pageVO);
	}

	public int instructorDeletecountList(PageVO pageVO) {
		System.out.println("AdminService instructorDeletecountList()");
		return adminMapper.instructorDeletecountList(pageVO);
	}

	public int deleteAllMemberCount(PageVO pageVO) {
		System.out.println("AdminService deleteAllMemberCount()");
		return adminMapper.deleteAllMemberCount(pageVO);
	}

	public List<UserVO> withDeleteUserMember(PageVO pageVO) {
		System.out.println("AdminService withDeleteUserMember()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.withDeleteUserMember(pageVO);
	}

//	public void insertChapter(ChapterVO chapterVO) {
//		System.out.println("AdminService insertChapter()");
//		adminMapper.insertChapter(chapterVO);
//	}

//	public void insertChapterDetail(ChapterDetailVO detailVO) {
//		System.out.println("AdminService insertChapterDetail()");
//		adminMapper.insertChapterDetail(detailVO);
//	}

	public List<UserVO> getInstructorList() {
		System.out.println("AdminService insertChapterDetail()");
		return adminMapper.getInstructorList();
	}

	public String classSearch() {
		System.out.println("AdminService classSearch()");
		return adminMapper.classSearch();
	}

	public List<LectureVO> teacherClassCheck(int user_num) {
		System.out.println("AdminService teacherClassCheck()");
		return adminMapper.teacherClassCheck(user_num);
	}

	public List<CategoryVO> categoryList() {
		System.out.println("AdminService categoryList()");
		return adminMapper.categoryList();
	}

	public void addCateMain(Category_mainVO category_mainVO) {
		System.out.println("AdminService addCateMain()");
		adminMapper.addCateMain(category_mainVO);
	}

	public void CateMainDelete(Category_mainVO category_mainVO) {
		System.out.println("AdminService CateMainDelete()");
		adminMapper.CateMainDelete(category_mainVO);
	}

	public void addCategoty(CategoryVO categoryVO) {
		System.out.println("AdminService addCategoty()");
		adminMapper.addCategoty(categoryVO);
	}

	public void deleteCategory(int category_num) {
		System.out.println("AdminService deleteCategory()");
		adminMapper.deleteCategory(category_num);
	}

	public void updateCategory(CategoryVO categoryVO) {
		System.out.println("AdminService updateCategory()");
		adminMapper.updateCategory(categoryVO);
	}

	public List<ChapterVO> getChaptersByLectureNum(int lecture_num) {
		System.out.println("AdminService getChaptersByLectureNum()");
		return adminMapper.getChaptersByLectureNum(lecture_num);
	}

	public void updateLecture(LectureVO lectureVO) {
		System.out.println("AdminService updateLecture()");
		adminMapper.updateLecture(lectureVO);
	}

	public void deleteChaptersByLectureNum(int lecture_num) {
		System.out.println("AdminService deleteChaptersByLectureNum()");
		adminMapper.deleteChaptersByLectureNum(lecture_num);
	}

	public String lectureCount(int user_num) {
		System.out.println("AdminService lectureCount()");
		return adminMapper.lectureCount(user_num);
	}

	public List<LectureVO> instructorLecture(int user_num) {
		System.out.println("AdminService instructorLecture()");
		return adminMapper.instructorLecture(user_num);
	}

	public UserVO teachercheck(int user_num) {
		System.out.println("AdminService teachercheck()");
		return adminMapper.teachercheck(user_num);
	}

	public List<LectureVO> okClass(PageVO pageVO) {
		System.out.println("AdminService okClass()");
		
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		
		return adminMapper.okClass(pageVO);
	}

	public List<LectureVO> askClass(PageVO pageVO) {
		System.out.println("AdminService askClass()");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		return adminMapper.askClass(pageVO);
	}

	public List<LectureVO> compClass(PageVO pageVO) {
		System.out.println("AdminService compClass()");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		return adminMapper.compClass(pageVO);
	}

	public int compClassCount(PageVO pageVO) {
		System.out.println("AdminService compClassCount()");
		return adminMapper.compClassCount(pageVO);
	}

	public int askClassCount(PageVO pageVO) {
		System.out.println("AdminService askClassCount()");
		return adminMapper.askClassCount(pageVO);
	}

	public int okClassCount(PageVO pageVO) {
		System.out.println("AdminService okClassCount()");
		return adminMapper.okClassCount(pageVO);
	}

	public List<LectureVO> deleteClass1(PageVO pageVO) {
		System.out.println("AdminService deleteClass()");
		int startRow = (pageVO.getCurrentPage() - 1) * pageVO.getPageSize();
		pageVO.setStartRow(startRow);
		return adminMapper.deleteClass1(pageVO);
	}

	public int deleteClassCount(PageVO pageVO) {
		System.out.println("AdminService deleteClassCount()");
		return adminMapper.deleteClassCount(pageVO);
	}

	public void classApprovalUpdate(int lecture_num) {
		System.out.println("AdminService classApprovalUpdate()");
		adminMapper.classApprovalUpdate(lecture_num);
	}

	public void classNotApproval(NotApprovedVO notApprovedVO) {
		System.out.println("AdminService classNotApproval()");
		adminMapper.classNotApproval(notApprovedVO);
	}

	public void classReject(int lecture_num) {
		System.out.println("AdminService classReject()");
		adminMapper.classReject(lecture_num);
	}

	public void classApprovaldelete(int lecture_num) {
		System.out.println("AdminService classApprovaldelete()");
		adminMapper.classApprovaldelete(lecture_num);
	}

	public void cancelDelete(int lecture_num) {
		System.out.println("AdminService cancelDelete()");
		adminMapper.cancelDelete(lecture_num);
	}

	public List<Category_mainVO> categoMainryList() {
	    System.out.println("AdminService categoMainryList()");
	    return adminMapper.categoMainryList();
	}

	public List<Map<String, Object>> getCategoryDetailPaymentStats() {
		System.out.println("AdminService getCategoryDetailPaymentStats()");
	    return adminMapper.getCategoryDetailPaymentStats();
	}

	public List<Map<String, Object>> bestClassTop10() {
		System.out.println("AdminService bestClassTop10()");
	    return adminMapper.bestClassTop10();
	}

	public List<Map<String, Object>> monthlySales() {
		System.out.println("AdminService monthlySales()");
	    return adminMapper.monthlySales();
	}

	public List<Map<String, Object>> getcategoryList() {
		System.out.println("AdminService getcategoryList()");
	    return adminMapper.getcategoryList();
	}

	public int okClassCount1() {
		System.out.println("AdminService okClassCount1()");
		return adminMapper.okClassCount1();
	}

	public int countMemberList1() {
		System.out.println("AdminService countMemberList1()");
		return adminMapper.countMemberList1();
	}

	public int inactiveMemberCount1() {
		System.out.println("AdminService inactiveMemberCount1()");
		return adminMapper.inactiveMemberCount1();
	}

	public int countTeacherList1() {
		System.out.println("AdminService countTeacherList1()");
		return adminMapper.countTeacherList1();
	}

	public int monthsSales() {
		System.out.println("AdminService monthsSales()");
		return adminMapper.monthsSales();
	}

	public int averageSales() {
		System.out.println("AdminService averageSales()");
		return adminMapper.averageSales();
	}

	public int lectureSold() {
		System.out.println("AdminService lectureSold()");
		return adminMapper.lectureSold();
	}

	public int lectureRefunded() {
		System.out.println("AdminService lectureRefunded()");
		return adminMapper.lectureRefunded();
	}

	public int declaration() {
		System.out.println("AdminService declaration()");
		return adminMapper.declaration();
	}
	
	
	
	









	

}
