package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@GetMapping("/adminCategory")
	public String adminCategory() {
		System.out.println("AdminController adminCategory()");
		
		return "admin/adminCategory";
	}	
	
	@GetMapping("/adminClassAdd")
	public String adminClassAdd() {
		System.out.println("AdminController adminClassAdd()");
		
		return "admin/adminClassAdd";
	}	
	
	@PostMapping("/adminClassAddPro")
	public String adminClassAddPro(HttpServletRequest request) {
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
		
		adminService.LectureUpdate(lectureVO);
		
		return "admin/adminClassList";
	}	
	
	
	@GetMapping("/adminClassList")
	public String adminClassList() {
		System.out.println("AdminController adminClassList()");
		
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
