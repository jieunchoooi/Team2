package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.Category_mainVO;
import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.NotApprovedVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UserVO;

public interface AdminMapper {

	public List<UserVO> listMember(PageVO pageVO);

	public int countMemberList(PageVO pageVO);

//	public void LectureUpdate(LectureVO lectureVO);

	public List<LectureVO> listLecture(PageVO pageVO);

	public int countlectureList(PageVO pageVO);

	public void deleteClass(String lecture_num);

	public UserVO insertMember(int user_num);

	public int adminUserUpdate(UserVO userVO);

	public LectureVO classEdit(int lecture_num);

	public void adminEditClass(LectureVO lectureVO);

	public List<UserVO> listTeacher(PageVO pageVO);

	public int teacharCount(PageVO pageVO);

	public int classCount(PageVO pageVO);

	public void deleteMember(int user_num);

	public List<UserVO> withDrawListMember(PageVO pageVO);

	public int countDrawMemberList();

	public int countTeacherList(PageVO pageVO);

	public void RevertMember(int user_num);

	public int inactiveTeacharCount(PageVO pageVO);

	public int deletecountMemberList(PageVO pageVO);

	public List<UserVO> activeTeacherList(PageVO pageVO);

	public List<UserVO> inactiveTeacherList(PageVO pageVO);

	public List<UserVO> activeMemberList(PageVO pageVO);

	public List<UserVO> inactiveMemberList(PageVO pageVO);

	public List<UserVO> MemberList(PageVO pageVO);

	public int memberCount(PageVO pageVO);

	public int inactiveMemberCount(PageVO pageVO);

	public List<UserVO> DrawinstructorListMember(PageVO pageVO);

	public int instructorDeletecountList(PageVO pageVO);

	public int deleteAllMemberCount(PageVO pageVO);

	public List<UserVO> withDeleteUserMember(PageVO pageVO);

//	public void insertChapter(ChapterVO chapterVO);

//	public void insertChapterDetail(ChapterDetailVO detailVO);

	public List<UserVO> getInstructorList();

	public String classSearch();

	public UserVO classSearch(int user_num);

	public List<LectureVO> teacherClassCheck(int user_num);

	public List<CategoryVO> categoryList();

	public void addCateMain(Category_mainVO category_mainVO);

	public void CateMainDelete(Category_mainVO category_mainVO);

	public void addCategoty(CategoryVO categoryVO);

	public void deleteCategory(int category_num);

	public Category_mainVO categoMainryList2(int category_num);

	public void updateCategory(CategoryVO categoryVO);

	public List<ChapterVO> getChaptersByLectureNum(int lecture_num);

	public void updateLecture(LectureVO lectureVO);

	public void deleteChaptersByLectureNum(int lecture_num);

	public String lectureCount(int user_num);

	public List<LectureVO> instructorLecture(int user_num);

	public UserVO teachercheck(int user_num);

	public List<LectureVO> okClass(PageVO pageVO);

	public List<LectureVO> askClass(PageVO pageVO);

	public List<LectureVO> compClass(PageVO pageVO);

	public int compClassCount(PageVO pageVO);

	public int askClassCount(PageVO pageVO);

	public int okClassCount(PageVO pageVO);

	public List<LectureVO> deleteClass1(PageVO pageVO);

	public int deleteClassCount(PageVO pageVO);

	public void classApprovalUpdate(int lecture_num);

	public void classNotApproval(NotApprovedVO notApprovedVO);

	public void classReject(int lecture_num);

	public void classApprovaldelete(int lecture_num);

	public void cancelDelete(int lecture_num);

	public List<Category_mainVO> categoMainryList();

	public List<Map<String, Object>> getCategoryDetailPaymentStats();

	public List<Map<String, Object>> bestClassTop10();

	public List<Map<String, Object>> monthlySales();

	public List<Map<String, Object>> getcategoryList();

	public int okClassCount1();

	public int countMemberList1();

	public int inactiveMemberCount1();

	public int countTeacherList1();

	public int monthsSales();

	public int averageSales();

	public int lectureSold();

	public int lectureRefunded();

	public int declaration();

	public int askClassCount1();

	public int newPerson();

	public UserVO insertMember1(String user_id);



	



}
