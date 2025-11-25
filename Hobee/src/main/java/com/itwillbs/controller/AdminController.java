package com.itwillbs.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.Category_mainVO;
import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.UserService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

   @Inject
   private AdminService adminService;

   @Resource(name = "uploadPath1")
   private String uploadPath1;

   @GetMapping("/adminCategory")
   public String adminCategory(Model model) {
      System.out.println("AdminController adminCategory()");
      
      List<Category_mainVO> categoMainryList = adminService.categoMainryList();
      List<CategoryVO> categoryList = adminService.categoryList();
      model.addAttribute("categoryList", categoryList);
      model.addAttribute("categoMainryList", categoMainryList);
      
      return "admin/adminCategory";
   }

//   카테고리 대분류 추가
   @PostMapping("/addCategoryMain")
   public String addCategoryMain(@RequestParam("category_main_name") String category_main_name) {
	   System.out.println("AdminController addCategoryMain()");
	   
   		Category_mainVO category_mainVO = new Category_mainVO();
   		category_mainVO.setCategory_main_name(category_main_name);
   		
   		adminService.addCateMain(category_mainVO);
   		
   		return "admin/adminCategory";
   }
   	
//  카테고리 대분류 삭제
   @PostMapping("/CategoryMainDelete")
   public String CategoryMainDelete(@RequestParam("category_main_name") String category_main_name) {
	   System.out.println("AdminController CategoryMainDelete()");
	   
   		Category_mainVO category_mainVO = new Category_mainVO();
   		category_mainVO.setCategory_main_name(category_main_name);
   		
   		adminService.CateMainDelete(category_mainVO);
   		
   		return "admin/adminCategory";
   }
   	
//  카테고리 추가
   @PostMapping("/addCategory")
   public String CategoryMainDelete(@RequestParam("category_main_name") String category_main_name,
   							  @RequestParam("category_detail") String category_detail) {
	   System.out.println("AdminController CategoryMainDelete()");
	   
   		CategoryVO categoryVO = new CategoryVO();
   		categoryVO.setCategory_main_name(category_main_name);
   		categoryVO.setCategory_detail(category_detail);
   		adminService.addCategoty(categoryVO);
   		
   		return "admin/adminCategory";
   }
   
   // 카테고리 삭제
   	@GetMapping("/deleteCategory")
   	public String deleteCategory(@RequestParam("category_num") int category_num) {
   		System.out.println("AdminController deleteCategory()");
   		
   		adminService.deleteCategory(category_num);
   		
   		return "admin/adminCategory";
   	}
   	
 // 모달에 카테고리 정보 보여주기
   	@GetMapping("/categoryEditInfoModal")
   	public String categoryEditInfoModal(@RequestParam("category_num") int category_num, Model model) {
   		System.out.println("AdminController categoryEditInfoModal()");

   	    // 1. 수정할 카테고리 정보 조회
   	    CategoryVO category = adminService.selectCategoryByNum(category_num);
   	    model.addAttribute("category", category);
   	    
   	    // 2. 대분류 목록도 함께 전달 (셀렉트박스에 옵션 표시용)
   	    List<Category_mainVO> categoMainryList = adminService.categoMainryList();
   	    model.addAttribute("categoMainryList", categoMainryList);
   	    return "admin/CategoryEditinfoModal";
   	}
    
   	// 2. 카테고리 수정 처리
   	@PostMapping("/updateCategory")
   	public String updateCategory(CategoryVO categoryVO) {
   	    adminService.updateCategory(categoryVO);
   	    return "redirect:/admin/adminCategory"; // 카테고리 관리 페이지로 리다이렉트
   	}
   	
   	
   // 클래스 등록
   @GetMapping("/adminClassAdd")
   public String adminClassAdd(Model model) {
      System.out.println("AdminController adminClassAdd()");
      
      // ✅ 강사 목록 조회
      List<UserVO> instructorList = adminService.getInstructorList();
      
      System.out.println("강사 수: " + (instructorList != null ? instructorList.size() : 0));
      if (instructorList != null) {
          for (UserVO user : instructorList) {
              System.out.println("강사: " + user.getUser_name() + " (" + user.getUser_id() + ")");
          }
      }
      
      model.addAttribute("instructorList", instructorList);
      
      return "admin/adminClassAdd";
   }

// 클래스 등록
   @PostMapping("/adminClassAddPro")
   public String adminClassAddPro(HttpServletRequest request,
                                 @RequestParam(value = "lecture_img", required = false) MultipartFile lecture_img) throws Exception {
	   System.out.println("AdminController adminClassAddPro()");

	    LectureVO lectureVO = new LectureVO();
	    String lecture_title = request.getParameter("lecture_title");
	    String category_detail = request.getParameter("category_detail");
	    String lecture_author = request.getParameter("lecture_author"); // 강사 이름
	    String lecture_detail = request.getParameter("lecture_detail");
	    String priceParam = request.getParameter("lecture_price");
	    String lecture_tag = request.getParameter("lecture_tag");
	    
	    // ✅ user_num 가져오기
	    String userNumParam = request.getParameter("user_num");
	    int user_num = 0;
	    if (userNumParam != null && !userNumParam.isEmpty()) {
	        user_num = Integer.parseInt(userNumParam);
	    }
	    
	    int lecture_price = 0;
	    if (priceParam != null && !priceParam.isEmpty()) {
	        lecture_price = Integer.parseInt(priceParam);
	    }
	    
	    System.out.println(lecture_author);
	    String lec[] = lecture_author.split(":");
	    System.out.println(lec.length);
	    System.out.println(lec[0]);
	    System.out.println(lec[1]);
	    
	    lectureVO.setLecture_title(lecture_title);
	    lectureVO.setCategory_detail(category_detail);
	    lectureVO.setLecture_detail(lecture_detail);
	    lectureVO.setLecture_author(lec[1]);
	    lectureVO.setLecture_price(lecture_price);
	    lectureVO.setLecture_tag(lecture_tag);
	    lectureVO.setUser_num(Integer.parseInt(lec[0])); // ✅ user_num 설정

	    if (lecture_img != null && !lecture_img.isEmpty()) {
	        UUID uuid = UUID.randomUUID();
	        String filename = uuid.toString() + "_" + lecture_img.getOriginalFilename();
	        System.out.println("파일명: " + filename);
	        FileCopyUtils.copy(lecture_img.getBytes(), new File(uploadPath1, filename));
	        lectureVO.setLecture_img(filename);
	    }
	    
	    System.out.println(lectureVO);
	    adminService.LectureUpdate(lectureVO);
	    
       
       int lectureNum = lectureVO.getLecture_num(); 
       System.out.println("생성된 lecture_num: " + lectureNum);

       // ✅ 챕터 제목 배열 가져오기
       String[] chapterTitles = request.getParameterValues("chapter_title[]");
       
       // ✅ 디버깅: 챕터 개수 확인
       System.out.println("=== 챕터 저장 시작 ===");
       System.out.println("총 챕터 개수: " + (chapterTitles != null ? chapterTitles.length : 0));
       
       if (chapterTitles != null && chapterTitles.length > 0) {
           for(int i = 0; i < chapterTitles.length; i++) {
               System.out.println("\n--- 챕터 " + (i+1) + " 처리 중 ---");
               System.out.println("챕터 제목: " + chapterTitles[i]);
               
               ChapterVO chapterVO = new ChapterVO();
               chapterVO.setLecture_num(lectureNum);
               chapterVO.setChapter_order(i + 1);
               chapterVO.setChapter_title(chapterTitles[i]);
               
               adminService.insertChapter(chapterVO);
               int chapterNum = chapterVO.getChapter_num();
               
               System.out.println("생성된 chapter_num: " + chapterNum);
               
               // ✅ 디버깅: 어떤 파라미터를 찾는지 출력
               String detailTitleParam = "detail_title_" + i + "[]";
               String detailTimeParam = "detail_time_" + i + "[]";
               System.out.println("찾는 파라미터: " + detailTitleParam);
               
               String[] detailTitles = request.getParameterValues(detailTitleParam);
               String[] detailTimes = request.getParameterValues(detailTimeParam);
               
               // ✅ 디버깅: 강의 개수 확인
               System.out.println("강의 개수: " + (detailTitles != null ? detailTitles.length : 0));
               
               if(detailTitles != null && detailTitles.length > 0) {
                   for(int j = 0; j < detailTitles.length; j++) {
                       System.out.println("  강의 " + (j+1) + ": " + detailTitles[j] + " (" + 
                           (detailTimes != null && j < detailTimes.length ? detailTimes[j] : "00:00") + ")");
                       
                       ChapterDetailVO detailVO = new ChapterDetailVO();
                       detailVO.setChapter_num(chapterNum);
                       detailVO.setDetail_order(j + 1);
                       detailVO.setDetail_title(detailTitles[j]);
                       detailVO.setDetail_time(detailTimes != null && j < detailTimes.length ? detailTimes[j] : "00:00");
                       
                       adminService.insertChapterDetail(detailVO);
                   }
               } else {
                   System.out.println("  ⚠️ 강의를 찾을 수 없습니다!");
               }
           }
       }
       
       System.out.println("=== 챕터 저장 완료 ===\n");
       
       return "redirect:/admin/adminClassList";
   }
   // 클래스 삭제
   @GetMapping("/deleteClass")
   public String deleteClass(@RequestParam("lecture_num") String lecture_num) {
      System.out.println("AdminController deleteClass()");

      adminService.deleteClass(lecture_num);

      return "redirect:/admin/adminClassList";
   }

   // 강의 목록
   @GetMapping("/adminClassList")
   public String adminClassList(Model model, HttpServletRequest request,
	   							@RequestParam(value = "search", required = false) String search,
	   						    @RequestParam(value = "searchList", required = false) String searchList) {
      System.out.println("AdminController adminClassList()");

      String pageNum = request.getParameter("pageNum");

      if (pageNum == null) {
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int pageSize = 10;

      PageVO pageVO = new PageVO();
      pageVO.setPageNum(pageNum);
      pageVO.setCurrentPage(currentPage);
      pageVO.setPageSize(pageSize);
      if(search == null) {
    	  search = "";
    	  pageVO.setSearch(search);
    	  pageVO.setSearchList(searchList);
      }else {
    	  pageVO.setSearch(search);
    	  pageVO.setSearchList(searchList);
      }
      
      int tCount = adminService.teacharCount(pageVO);
      int classCount = adminService.classCount();
      List<LectureVO> lectureList = adminService.listLecture(pageVO);

      int count = adminService.countlectureList();
      int pageBlock = 10;
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + (pageBlock - 1);
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      if (endPage > pageCount) {
         endPage = pageCount;
      }

      pageVO.setCount(count);
      pageVO.setPageBlock(pageBlock);
      pageVO.setStartPage(startPage);
      pageVO.setEndPage(endPage);
      pageVO.setPageCount(pageCount);
      pageVO.setCount(count);

      model.addAttribute("pageVO", pageVO);
      model.addAttribute("lectureList", lectureList);
      model.addAttribute("classCount", classCount);
      model.addAttribute("tCount", tCount);

      return "admin/adminClassList";
   }

   @GetMapping("/classSearch")
   public String classSearch(Model model) {
	   System.out.println("AdminController classSearch()");
	   
	   String classSearch = adminService.classSearch();
	   
	   return classSearch;
   }
   
   
   // 회원정보 조회
   @GetMapping("/adminMemberList")
   public String adminMemberList(Model model, HttpServletRequest request,
		   						 @RequestParam(value = "search", required = false) String search,
		   						 @RequestParam(value = "searchList", required = false) String searchList) {
      System.out.println("AdminController adminMemberList()");

      String filter = request.getParameter("filter");
      if(filter == null || filter.isEmpty()) {
    	  filter = "all";
      }
      
      String pageNum = request.getParameter("pageNum");
      if (pageNum == null) {
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int pageSize = 10;

      PageVO pageVO = new PageVO();
      pageVO.setPageNum(pageNum);
      pageVO.setCurrentPage(currentPage);
      pageVO.setPageSize(pageSize);
      pageVO.setSearch(search);
      pageVO.setSearchList(searchList);
      
      List<UserVO> memberList;
      int count;
      
      if("active".equals(filter)) {
    	  memberList = adminService.activeMemberList(pageVO);
    	  count = adminService.memberCount(pageVO);
      }else if("inactive".equals(filter)) {
    	  memberList = adminService.inactiveMemberList(pageVO);
    	  count = adminService.inactiveMemberCount(pageVO);
      }else{
    	  memberList = adminService.MemberList(pageVO);
    	  count = adminService.countMemberList(pageVO);
      }
      
      
      int dcount = adminService.inactiveMemberCount(pageVO);
      int acount = adminService.memberCount(pageVO);
      int totalcount = adminService.countMemberList(pageVO);
      int pageBlock = 10;
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + (pageBlock - 1);
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      if (endPage > pageCount) {
         endPage = pageCount;
      }

      // pageVO 담기
      pageVO.setCount(count);
      pageVO.setPageBlock(pageBlock);
      pageVO.setStartPage(startPage);
      pageVO.setEndPage(endPage);
      pageVO.setPageCount(pageCount);

      model.addAttribute("pageVO", pageVO);
      model.addAttribute("memberList", memberList);
      model.addAttribute("acount", acount);
      model.addAttribute("dcount", dcount);
      model.addAttribute("totalcount",totalcount);
      model.addAttribute("filter",filter);

      return "admin/adminMemberList";
   }

   @GetMapping("/MemberManagement")
   public String MemberManagement(Model model, @RequestParam("user_num") int user_num) {
      System.out.println("AdminController MemberManagement()");
      UserVO user = adminService.insertMember(user_num);

      model.addAttribute("user", user);
      return "admin/MemberManagement";
   }
   
   // 회원 강제 탈퇴
   @GetMapping("/MemberAdminDelete")
   public String MemberAdminDelete(@RequestParam("user_num") int user_num) {
      System.out.println("AdminController deleteClass()");

      adminService.deleteMember(user_num);

      return "redirect:/admin/adminMemberList";
   }
   
   // 탈퇴 회원 복구
   @GetMapping("/MemberRevert")
   public String MemberRevert(@RequestParam("user_num") int user_num) {
      System.out.println("AdminController deleteClass()");
      
      adminService.RevertMember(user_num);
      
      return "redirect:/admin/adminWithdrawList";
   }
   
   
   

   // 회원 권한 등록
   @PostMapping("/managementPro")
   public String managementPro(@RequestParam("user_role") String user_role, @RequestParam("user_num") int user_num) {
      System.out.println("AdminController managementPro()");
      UserVO userVO = new UserVO();

      if (user_role != "" && !user_role.isEmpty()) {
         userVO.setUser_role(user_role);
      }
      userVO.setUser_num(user_num);

      System.out.println(userVO);
      adminService.adminUserUpdate(userVO);
      return "redirect:/admin/adminMemberList";
   }

   // 강사정보 조회
   @GetMapping("/adminTeacherList")
   public String adminTeacherList(Model model, HttpServletRequest request,
		   						  @RequestParam(value = "search", required = false) String search,
		   						  @RequestParam(value = "searchList", required = false) String searchList) {
      System.out.println("AdminController adminTeacherList()");
      
      String filter = request.getParameter("filter");
      if (filter == null || filter.isEmpty()) {
          filter = "all"; // 기본값: 전체
      }
      
      String pageNum = request.getParameter("pageNum");
      if (pageNum == null) {
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int pageSize = 10;

      PageVO pageVO = new PageVO();
      pageVO.setPageNum(pageNum);
      pageVO.setCurrentPage(currentPage);
      pageVO.setPageSize(pageSize);
      pageVO.setSearch(search);
      pageVO.setSearchList(searchList);
      
      List<UserVO> teacherList;

      int count;
      
      if ("active".equals(filter)) {
          teacherList = adminService.activeTeacherList(pageVO);
          count = adminService.teacharCount(pageVO);
      } else if ("inactive".equals(filter)) {
          teacherList = adminService.inactiveTeacherList(pageVO);
          count = adminService.inactiveTeacharCount(pageVO);
      } else {
          teacherList = adminService.listTeacher(pageVO);
          count = adminService.countTeacherList(pageVO);
      }
      
      int totalCount = adminService.countTeacherList(pageVO);
      int tCount = adminService.teacharCount(pageVO);
      int intCount = adminService.inactiveTeacharCount(pageVO);
      
      int pageBlock = 10;
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + (pageBlock - 1);
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      if (endPage > pageCount) {
         endPage = pageCount;
      }

      // pageVO 담기
      pageVO.setCount(count);
      pageVO.setPageBlock(pageBlock);
      pageVO.setStartPage(startPage);
      pageVO.setEndPage(endPage);
      pageVO.setPageCount(pageCount);

      model.addAttribute("pageVO", pageVO);
      model.addAttribute("teacherList", teacherList);
      model.addAttribute("tCount", tCount);
      model.addAttribute("intCount", intCount);
      model.addAttribute("totalCount", totalCount);
      model.addAttribute("filter", filter);

      return "admin/adminTeacherList";
   }

   // 탈퇴 회원 조회
   @GetMapping("/adminWithdrawList")
   public String adminWithdrawList(Model model, HttpServletRequest request,
		   						   @RequestParam(value = "search", required = false) String search,
		   						   @RequestParam(value = "searchList", required = false) String searchList) {
      System.out.println("AdminController adminWithdrawList()");

      String filter = request.getParameter("filter");
      if (filter == null || filter.isEmpty()) {
          filter = "all"; // 기본값: 전체
      }
      
      String pageNum = request.getParameter("pageNum");
      if (pageNum == null) {
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int pageSize = 10;

      PageVO pageVO = new PageVO();
      pageVO.setPageNum(pageNum);
      pageVO.setCurrentPage(currentPage);
      pageVO.setPageSize(pageSize);
      pageVO.setSearch(search);
      pageVO.setSearchList(searchList);
      
      List<UserVO> memberList;
      
      int count;
      if("user".equals(filter)) {
    	  memberList = adminService.withDeleteUserMember(pageVO);
    	  count = adminService.deletecountMemberList(pageVO);
      }else if("instructor".equals(filter)) {
    	  memberList = adminService.DrawinstructorListMember(pageVO);
    	  count = adminService.instructorDeletecountList(pageVO);
      }else {
    	  memberList = adminService.withDrawListMember(pageVO);
    	  count = adminService.deleteAllMemberCount(pageVO);
      }
      
      int totalCount = adminService.deleteAllMemberCount(pageVO);
      int mdCount = adminService.deletecountMemberList(pageVO);
      int intCount = adminService.instructorDeletecountList(pageVO);
      
      int pageBlock = 10;
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + (pageBlock - 1);
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      if (endPage > pageCount) {
         endPage = pageCount;
      }

      // pageVO 담기
      pageVO.setCount(count);
      pageVO.setPageBlock(pageBlock);
      pageVO.setStartPage(startPage);
      pageVO.setEndPage(endPage);
      pageVO.setPageCount(pageCount);
      pageVO.setCount(count);

      model.addAttribute("pageVO", pageVO);
      model.addAttribute("memberList", memberList);
      model.addAttribute("totalCount", totalCount);
      model.addAttribute("mdCount", mdCount);
      model.addAttribute("intCount", intCount);
      model.addAttribute("filter", filter);

      return "admin/adminWithdrawList";
   }

   // 클래스 수정
   @PostMapping("/adminClassEditPro")
   public String adminClassEditPro(HttpServletRequest request, 
         @RequestParam(value = "lecture_img", required = false) MultipartFile lecture_img) throws Exception {
      System.out.println("AdminController adminClassEditPro()");
      LectureVO lectureVO = new LectureVO();
      String lecture_title = request.getParameter("lecture_title");
      String category_detail = request.getParameter("category_detail");
      String lecture_author = request.getParameter("lecture_author");
      String lecture_detail = request.getParameter("lecture_detail");
      int lecture_num = Integer.parseInt(request.getParameter("lecture_num"));

      String priceParam = request.getParameter("lecture_price");
      int lecture_price = 0; // 기본값 설정

      if (priceParam != null && !priceParam.isEmpty()) {
         lecture_price = Integer.parseInt(priceParam);
      }

      lectureVO.setLecture_num(lecture_num);
      lectureVO.setLecture_title(lecture_title);
      lectureVO.setCategory_detail(category_detail);
      lectureVO.setLecture_detail(lecture_detail);
      lectureVO.setLecture_author(lecture_author);
      lectureVO.setLecture_price(lecture_price);
      
      if(lecture_img.isEmpty()) {
         lectureVO.setLecture_img(request.getParameter("oldfile"));
      }else {
         UUID uuid = UUID.randomUUID();
         String filename = uuid.toString() + "_" + lecture_img.getOriginalFilename();
         System.out.println("파일명: " + filename);

         FileCopyUtils.copy(lecture_img.getBytes(), new File(uploadPath1, filename));

         lectureVO.setLecture_img(filename);
         
         File oldfile = new File(uploadPath1, request.getParameter("oldfile"));
         
         if(oldfile.exists()) {
            oldfile.delete();
         }
      
      }
      System.out.println(lectureVO);
      adminService.adminEditClass(lectureVO);

      return "redirect:/admin/adminClassList";
   }
   
//   강의 수정
   @GetMapping("/adminClassEditinfo")
   public String adminClassEditinfo(@RequestParam("lecture_num") int lecture_num, Model model) {
	    System.out.println("AdminController adminClassEditPro()");
	    
	    LectureVO lectureVO = adminService.classEdit(lecture_num);

	    model.addAttribute("lectureVO", lectureVO);
	    
	    return "admin/adminClassEditinfo";
   }
   
// 강사 상세보기
   @GetMapping("/adminTeacherDetail")
   public String adminTeacherDetail(@RequestParam("user_num") int user_num, Model model) {
	   System.out.println("AdminController adminTeacherDetail()");
	   
	   UserVO userVO = adminService.teachercheck(user_num);
//	   List<LectureVO> lectureVO = adminService.teacherClassCheck(user_num);
	   
	   model.addAttribute("userVO", userVO);
//	   model.addAttribute("lectureVO", lectureVO);
//	   for(LectureVO lecture : lectureList) {
//		    System.out.println(lecture.getLecture_title());
//		}
//
//		// 또는 단순히 첫 번째 강의만 필요하다면
//		LectureVO lecture = null;
//		if(!lectureList.isEmpty()) {
//		    lecture = lectureList.get(0);
//		}
	   return "admin/adminTeacherDetail";
   }
   
   

}
