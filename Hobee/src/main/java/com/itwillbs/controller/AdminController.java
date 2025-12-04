package com.itwillbs.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.Category_mainVO;
import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.NotApprovedVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.CategoryService;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.UserService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

   @Inject
   private AdminService adminService;
   
   @Inject
   private CategoryService categoryService;

   @Resource(name = "uploadPath1")
   private String uploadPath1;

	// ⭐ 모든 /admin/* 요청에 대해 현재 페이지 식별값을 자동으로 Model에 주입
	@ModelAttribute("page")
	public String setPageIdentifier(HttpServletRequest req) {
	    String uri = req.getRequestURI();

	    if (uri.contains("adminCategory")) return "category";
	    if (uri.contains("adminClassList")) return "classList";
	    if (uri.contains("adminMemberList")) return "memberList";
	    if (uri.contains("adminTeacherList")) return "teacherList";
	    if (uri.contains("adminWithdrawList")) return "withdrawList";
	    if (uri.contains("adminPaymentList")) return "paymentList"; 
	    if (uri.contains("adminPostList")) return "postList";
	    
	    return "";
	}
   
   
   
   
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
   
   // 클래스 삭제
   @GetMapping("/deleteClass")
   public String deleteClass(@RequestParam("lecture_num") String lecture_num) {
      System.out.println("AdminController deleteClass()");

      adminService.deleteClass(lecture_num);

      return "redirect:/admin/adminClassList";
   }

   @GetMapping("/adminClassList")
   public String adminClassList(Model model, HttpServletRequest request,
                               @RequestParam(value = "search", required = false) String search,
                               @RequestParam(value = "searchList", required = false) String searchList) {
      System.out.println("AdminController adminClassList()");
      String pageNum = request.getParameter("pageNum");
      String filter = request.getParameter("filter");
      
      if(filter == null || filter.isEmpty()) {
         filter = "all";
      }
      if (pageNum == null) {
         pageNum = "1";
      }
      
      int currentPage = Integer.parseInt(pageNum);
      int pageSize = 10;
      
      PageVO pageVO = new PageVO();
      pageVO.setPageNum(pageNum);
      pageVO.setCurrentPage(currentPage);
      pageVO.setPageSize(pageSize);
      
      if(search == null || search.trim().isEmpty()) {
         search = null;
      }
      
      if(searchList == null || searchList.isEmpty()) {
         searchList = "전체";
      }
      
      pageVO.setSearch(search);
      pageVO.setSearchList(searchList);
      
      // 필터에 따른 강의 목록과 카운트 조회
      List<LectureVO> lectureList;
      int count;
      
      if("ok".equals(filter)) {
         lectureList = adminService.okClass(pageVO);
         count = adminService.okClassCount(pageVO);
      } else if("ask".equals(filter)) {
         lectureList = adminService.askClass(pageVO);
         count = adminService.askClassCount(pageVO);
      } else if("comp".equals(filter)) {
         lectureList = adminService.compClass(pageVO);
         count = adminService.compClassCount(pageVO);
      } else if("delete".equals(filter)){
         lectureList = adminService.deleteClass1(pageVO);
         count = adminService.deleteClassCount(pageVO);
      } else {
         lectureList = adminService.listLecture(pageVO);
         count = adminService.countlectureList(pageVO);
      }
      
      // 전체 통계 (검색 없이)
      PageVO statPageVO = new PageVO();
      int classCount = adminService.classCount(statPageVO);
      int okClassCount = adminService.okClassCount(statPageVO);
      int askClassCount = adminService.askClassCount(statPageVO);
      int compClassCount = adminService.compClassCount(statPageVO);
      int deleteClassCount = adminService.deleteClassCount(statPageVO);
      
      // 페이징 처리
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
      model.addAttribute("lectureList", lectureList);
      model.addAttribute("classCount", classCount);
      model.addAttribute("filter", filter);
      model.addAttribute("compClassCount", compClassCount);
      model.addAttribute("askClassCount", askClassCount);
      model.addAttribute("okClassCount", okClassCount);
      model.addAttribute("deleteClassCount", deleteClassCount);
      
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

      if(search == null || search.trim().isEmpty()) {
          search = null;
       }
       
       if(searchList == null || searchList.isEmpty()) {
          searchList = "전체";
       }
       
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
      
      PageVO statPageVO = new PageVO();
      int dcount = adminService.inactiveMemberCount(statPageVO);
      int acount = adminService.memberCount(statPageVO);
      int totalcount = adminService.countMemberList(statPageVO);
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
   
   // 강사 강제 탈퇴
   @GetMapping("/AdminTeacherDelete")
   public String AdminTeacherDelete(@RequestParam("user_num") int user_num) {
	   System.out.println("AdminController AdminTeacherDelete()");
	   
	   adminService.deleteMember(user_num);
	   
	   return "redirect:/admin/adminTeacherList";
   }
   
   // 탈퇴 회원 복구
   @GetMapping("/MemberRevert")
   public String MemberRevert(@RequestParam("user_num") int user_num) {
      System.out.println("AdminController deleteClass()");
      
      adminService.RevertMember(user_num);
      
      return "redirect:/admin/adminWithdrawList";
   }
   
   // 탈퇴 강사 복구
   @GetMapping("/teacherRevert")
   public String teacherRevert(@RequestParam("user_num") int user_num) {
	   System.out.println("AdminController teacherRevert()");
	   
	   adminService.RevertMember(user_num);
	   
	   return "redirect:/admin/adminTeacherList";
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
      
      PageVO statPageVO = new PageVO();
      int totalCount = adminService.countTeacherList(statPageVO);
      int tCount = adminService.teacharCount(statPageVO);
      int intCount = adminService.inactiveTeacharCount(statPageVO);
      
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
      
      PageVO statPageVO = new PageVO();
      int totalCount = adminService.deleteAllMemberCount(statPageVO);
      int mdCount = adminService.deletecountMemberList(statPageVO);
      int intCount = adminService.instructorDeletecountList(statPageVO);
      
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
//      pageVO.setCount(count);

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
	    List<UserVO> instructorList = adminService.getInstructorList();
	    List<CategoryVO> categoryList = adminService.categoryList();
	    List<ChapterVO> chapterList = adminService.getChaptersByLectureNum(lecture_num);
	    
	    String tags = lectureVO.getLecture_tag(); // "드로잉,일러스트,취미"

	    System.out.println("강사 수: " + (instructorList != null ? instructorList.size() : 0));
	    if (instructorList != null) {
	        for (UserVO user : instructorList) {
	            System.out.println("강사: " + user.getUser_name() + " (" + user.getUser_id() + ")");
	        }
	    }
	    // 쉼표 기준으로 배열화
		String[] tagArr = tags.split(",");

		model.addAttribute("tagArr", tagArr);
		model.addAttribute("lectureVO", lectureVO);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("instructorList", instructorList);
	    model.addAttribute("chapterList", chapterList); // 챕터 리스트 추가

		return "admin/adminClassEditinfo";
   }
   
   @GetMapping("/adminTeacherDetail")
   public String adminTeacherDetail(@RequestParam("user_num") int user_num, Model model) {
       System.out.println("=== adminTeacherDetail 실행 ===");
       System.out.println("user_num: " + user_num);
       
       try {
           UserVO userVO = adminService.teachercheck(user_num);
           System.out.println("userVO: " + userVO);
           
           List<LectureVO> lectureList = adminService.teacherClassCheck(user_num);
           System.out.println("조회된 강의 수: " + (lectureList != null ? lectureList.size() : 0));
           
           // 각 강의 정보 출력
           if (lectureList != null) {
               for (LectureVO lecture : lectureList) {
                   System.out.println("강의: " + lecture.getLecture_title() 
                       + " (lecture_num: " + lecture.getLecture_num() + ")");
               }
           }
           
           model.addAttribute("userVO", userVO);
           model.addAttribute("lectureList", lectureList);
           model.addAttribute("lectureCount", lectureList != null ? lectureList.size() : 0);
           
           return "admin/adminTeacherDetail";
           
       } catch (Exception e) {
           System.out.println("⚠️ 에러 발생 ⚠️");
           e.printStackTrace();
           return "redirect:/admin/adminTeacherList";
       }
   }
   
   @GetMapping("/classApproval")
   public String classApproval(@RequestParam("lecture_num") int lecture_num) {
	   System.out.println("AdminController classApproval()");
	   adminService.classApprovalUpdate(lecture_num);
	   
	   return "redirect:/admin/adminClassList";
   }
   
   @GetMapping("/classNotApproval")
   public String classNotApproval(@RequestParam("lecture_num") int lecture_num,
		   						  @RequestParam("reason") String reason) {
	   System.out.println("AdminController classNotApproval()");
	   NotApprovedVO notApprovedVO = new NotApprovedVO();
	   notApprovedVO.setLecture_num(lecture_num);
	   notApprovedVO.setReason(reason);
	   
	   adminService.classNotApproval(notApprovedVO);
	   adminService.classReject(lecture_num);
	   
	   return "redirect:/admin/adminClassList";
   }
   
   @GetMapping("/deleteApproval")
   public String deleteApproval(@RequestParam("lecture_num") int lecture_num) {
	   System.out.println("AdminController classApproval()");
	   adminService.classApprovaldelete(lecture_num);
	   
	   return "redirect:/admin/adminClassList";
   }
   
   @GetMapping("/cancelDeleteApproval")
   public String cancelDeleteApproval(@RequestParam("lecture_num") int lecture_num) {
	   System.out.println("AdminController cancelDeleteApproval()");
	   adminService.cancelDelete(lecture_num);
	   
	   return "redirect:/admin/adminClassList";
   }
   
   @PostMapping("/updateCategoryOrder")
   @ResponseBody
   public Map<String, Object> updateCategoryOrder(@RequestBody Map<String, Object> orderData) {
       Map<String, Object> response = new HashMap<>();
       
       try {
           // 1. 대분류 순서 업데이트
           List<Map<String, Object>> mainCategories = 
               (List<Map<String, Object>>) orderData.get("mainCategories");
           
           if (mainCategories != null && !mainCategories.isEmpty()) {
               for (Map<String, Object> main : mainCategories) {
                   int num = (Integer) main.get("category_main_num");
                   int order = (Integer) main.get("category_main_order");
                   
                   System.out.println("대분류 번호: " + num + ", 순서: " + order);
                   
                   // 실제 DB 업데이트
                   Map<String, Object> params = new HashMap<>();
                   params.put("category_main_num", num);
                   params.put("category_main_order", order);
                   categoryService.updateMainCategoryOrder(params);
               }
           }
           
           // 2. 소분류 순서 업데이트
           List<Map<String, Object>> subCategories = 
               (List<Map<String, Object>>) orderData.get("subCategories");
           
           if (subCategories != null && !subCategories.isEmpty()) {
               for (Map<String, Object> sub : subCategories) {
                   int num = (Integer) sub.get("category_num");
                   int order = (Integer) sub.get("category_order");
                   
                   System.out.println("소분류 번호: " + num + ", 순서: " + order);
                   
                   // 실제 DB 업데이트
                   Map<String, Object> params = new HashMap<>();
                   params.put("category_num", num);
                   params.put("category_order", order);
                   categoryService.updateSubCategoryOrder(params);
               }
           }
           
           response.put("success", true);
           response.put("message", "저장 완료");
           
       } catch (Exception e) {
           e.printStackTrace();
           response.put("success", false);
           response.put("message", "저장 실패: " + e.getMessage());
       }
       
       return response;
   }
   
   
   
   

}