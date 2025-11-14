package com.itwillbs.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	public String adminCategory() {
		System.out.println("AdminController adminCategory()");
		
		return "admin/adminCategory";
	}	
	
	// 클래스 등록
	@GetMapping("/adminClassAdd")
	public String adminClassAdd() {
		System.out.println("AdminController adminClassAdd()");
		
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
		String lecture_author = request.getParameter("lecture_author");
		// int lecture_price = Integer.parseInt(request.getParameter("lecture_price"));
		String lecture_detail = request.getParameter("lecture_detail");
		
		String priceParam = request.getParameter("lecture_price");
		int lecture_price = 0; // 기본값 설정

		if (priceParam != null && !priceParam.isEmpty()) {
		    lecture_price = Integer.parseInt(priceParam);
		}
		
		lectureVO.setLecture_title(lecture_title);
		lectureVO.setCategory_detail(category_detail);
		lectureVO.setLecture_detail(lecture_detail);
		lectureVO.setLecture_author(lecture_author);
		lectureVO.setLecture_price(lecture_price);
		
		if(lecture_img != null && !lecture_img.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String filename = uuid.toString() + "_" + lecture_img.getOriginalFilename();
			System.out.println("파일명: " + filename);
			
			FileCopyUtils.copy(lecture_img.getBytes(), new File(uploadPath1, filename));
			
			lectureVO.setLecture_img(filename);
			
		}
	
		adminService.LectureUpdate(lectureVO);
		
		return "redirect:/admin/adminClassList";
	}	
	
	
	@GetMapping("/adminClassList")
	public String adminClassList(Model model, HttpServletRequest request) {
		System.out.println("AdminController adminClassList()");
		
		String pageNum = request.getParameter("pageNum");

		if(pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int pageSize = 10;
		
		PageVO pageVO = new PageVO();
		pageVO.setPageNum(pageNum);
		pageVO.setCurrentPage(currentPage);	
		pageVO.setPageSize(pageSize);
		
		List<LectureVO> lectureList = adminService.listLecture(pageVO);
		
		int count = adminService.countlectureList();
		int pageBlock = 10;
		int startPage = (currentPage -1)/pageBlock * pageBlock +1;
		int endPage = startPage + (pageBlock - 1);
		int pageCount = count / pageSize + (count % pageSize == 0? 0:1);
		if(endPage > pageCount) {
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
		
		return "admin/adminClassList";
	}	
	
	// 회원정보 조회
	@GetMapping("/adminMemberList")
	public String adminMemberList(Model model, HttpServletRequest request) {
		System.out.println("AdminController adminMemberList()");
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int pageSize = 10;
		
		PageVO pageVO = new PageVO();
		pageVO.setPageNum(pageNum);
		pageVO.setCurrentPage(currentPage);
		pageVO.setPageSize(pageSize);
		
		List<UserVO> memberList = adminService.listMember(pageVO);
		
		int count = adminService.countMemberList();
		int pageBlock = 10;
		int startPage = (currentPage -1)/pageBlock * pageBlock +1;
		int endPage = startPage + (pageBlock - 1);
		int pageCount = count / pageSize + (count % pageSize == 0? 0:1);
		if(endPage > pageCount) {
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
			
		return "admin/adminMemberList";
	}	
	
	@GetMapping("/adminTeacherList")
	public String adminTeacherList() {
		System.out.println("AdminController adminTeacherList()");
		
		return "admin/adminTeacherList";
	}	
	
	@GetMapping("/adminWithdrawList")
	public String adminWithdrawList() {
		System.out.println("AdminController adminWithdrawList()");
		
		return "admin/adminWithdrawList";
	}	
	
	
	
	
	
	
	
}
