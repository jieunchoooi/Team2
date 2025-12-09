package com.itwillbs.controller;

import java.io.File;
import java.io.IOException;
import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // ✅ 추가

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.ChapterDetailVO;
import com.itwillbs.domain.ChapterVO;
import com.itwillbs.domain.EnrollmentVO;
import com.itwillbs.domain.EnrollmentViewVO;
import com.itwillbs.domain.LectureVO;
import com.itwillbs.domain.NotApprovedVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.PointHistoryVO;
import com.itwillbs.domain.ReviewVO;
import com.itwillbs.domain.ScrapVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.EnrollmentService;
import com.itwillbs.service.LectureService;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.PaymentService;
import com.itwillbs.service.PointHistoryService;
import com.itwillbs.service.ScrapService;
import com.mysql.cj.Session;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	private MemberService memberService;
	@Inject
	private AdminService adminService;
	@Inject
	private EnrollmentService enrollmentService;
	@Inject
    private PaymentService paymentService;
	@Inject
    private ScrapService scrapService;
	@Inject
    private PointHistoryService pointHistoryService;
	@Inject
	private LectureService lectureService;
	// 업로드 경로
	@Resource(name = "uploadPath")
	private String uploadPath;
	// 클래스 업로드 경로
	@Resource(name = "uploadPath1")
	private String uploadPath1;
	
	// ⭐ 모든 /member/* 요청에 대해 현재 페이지 식별값을 자동으로 Model에 주입
	@ModelAttribute("page")
	public String setPageIdentifier(HttpServletRequest req) {
	    String uri = req.getRequestURI();

	    if (uri.contains("mypage")) return "mypageHome";
	    if (uri.contains("my_classroom")) return "lecture";
	    if (uri.contains("scrap")) return "scrap";
	    if (uri.contains("review")) return "review";
	    if (uri.contains("paymentList")) return "paymentList";
	    if (uri.contains("payment")) return "paymentList"; // ⭐ 상세 페이지도 동일 그룹
	    if (uri.contains("editInfo")) return "edit";
	    if (uri.contains("updatePassWord")) return "edit";
	    if (uri.contains("pointHistory")) return "pointHistory";
	    if (uri.contains("teacherMyPage")) return "teacherMP";
	    return "";
	}

	
	
	// 마이페이지
	@GetMapping("/mypage") 
	public String mypage(Model model, HttpSession session) {
		System.out.println("MemberController mypage()");
		String user_id = (String) session.getAttribute("user_id");
		UserVO user = memberService.insertMember(user_id);
		   if (user == null) {
		        System.out.println("⚠ user is null (DB 조회 실패)");
		    } else {
		        System.out.println("✅ DB 조회 성공: " + user);
		    }

		model.addAttribute("user",user);
		return "member/mypage";  
	}
	
	// 회원수정
	@GetMapping("/editInfo")
	public String editInfo(Model model, HttpSession session) {
		System.out.println("MemberController editInfo()");
		String user_id = (String)session.getAttribute("user_id");
		UserVO user = memberService.insertMember(user_id);
		   if (user == null) {
		        System.out.println("⚠ user is null (DB 조회 실패)");
		    } else {
		        System.out.println("✅ DB 조회 성공: " + user);
		    }

		model.addAttribute("user",user);
		
		return "member/editInfo"; 
	}
	
	@PostMapping("/updatePro")
	public String updatePro(HttpSession session,HttpServletRequest request, 	// 파일 없으면 null값이 됨
			@RequestParam(value = "user_file", required = false) MultipartFile user_picture,
            RedirectAttributes rttr) throws Exception { //) throws Exception {
	    System.out.println("MemberController updatePro()");
	    
	    String user_id = (String) session.getAttribute("user_id");
	    // ✅ 1. 세션에서 user_id 가져오기 
	    UserVO user = memberService.insertMember(user_id);
	    // ✅ 2. request에서 파라미터 가져오기
	    String password = request.getParameter("user_password");
	    String phone = request.getParameter("user_phone");
	    String name = request.getParameter("user_name");
	    String email = request.getParameter("user_email");
	    String user_zipcode = request.getParameter("user_zipcode");
	    String address1 = request.getParameter("user_address1");
	    String address2 = request.getParameter("user_address2");
	    int user_num = Integer.parseInt(request.getParameter("user_num"));
	    
	    System.out.println("📝 받은 데이터: " + password + ", " + phone + ", " + name + ", " + email + ", " + user_zipcode + address1 + address2);
	    
	    // ✅ 3. UserVO 객체 생성 및 설정
	    UserVO userVO = new UserVO();
	    userVO.setUser_id(user_id); // WHERE 조건에 필수!
	    userVO.setUser_num(user_num);
	    
	    // 비밀번호가 입력된 경우만 설정 	// 양쪽 공백 제거. 문자열 길이가 0인지
	    if(password != null && !password.trim().isEmpty()) {
	        userVO.setUser_password(password);
	    }
	    
	    userVO.setUser_phone(phone);
	    userVO.setUser_name(name);
	    userVO.setUser_email(email);
	    userVO.setUser_zipcode(user_zipcode);
	    userVO.setUser_address1(address1);
	    userVO.setUser_address2(address2);
	    
	    if(user_picture == null || user_picture.isEmpty()) {
	    	userVO.setUser_file(request.getParameter("oldfile"));
		}else {
			UUID uuid = UUID.randomUUID();
	        String filename = uuid.toString() + "_" + user_picture.getOriginalFilename();
	        
	        System.out.println("📁 파일명: " + filename);
	        
	        FileCopyUtils.copy(user_picture.getBytes(), new File(uploadPath, filename));
	        
	        userVO.setUser_file(filename);
	        
			File oldfile = new File(uploadPath, request.getParameter("oldfile"));
			
			if(oldfile.exists()) {
				oldfile.delete();
			}
		}
		
	    System.out.println("✅ 저장할 데이터: " + userVO);
	    
	    memberService.updateProMember(userVO);
	    
	    rttr.addFlashAttribute("updateSuccess", "true");
	    
	    return "redirect:/member/mypage";   
	}

	// ✅ 로그인 세션의 user_num 기준으로 조회 → JSP에 enrollList로 전달
	 @GetMapping("/my_classroom")
	    public String my_classroom(HttpSession session, Model model) {
	        UserVO loginUser = (UserVO) session.getAttribute("userVO");
	        if (loginUser == null) {
	        	   return "redirect:/main/main";
	        }

	        List<EnrollmentViewVO> enrollList =
	                enrollmentService.getEnrollmentsByUser(loginUser.getUser_num());
	        model.addAttribute("enrollList", enrollList);
	        return "member/my_classroom";
	    }
	


	// 리뷰
	@GetMapping("/review")
	public String review(Model model, HttpSession session) {
		System.out.println("MemberController review()");
		
		String userId = (String) session.getAttribute("user_id");
		
		List<ReviewVO> personalReview = lectureService.getPersonalReview(userId);
		
		model.addAttribute("personalReview", personalReview);
		
		return "member/review";  
	}
	
	// 리뷰 수정
	@PostMapping("/updateReview")
	@ResponseBody
	public Map<String, Object> updateReview(
	        @RequestParam("review_num") int review_num,
	        @RequestParam("review_content") String review_content,
	        @RequestParam("review_score") String review_score // String으로 받기!
	) {

	    Map<String, Object> response = new HashMap<>();

	    try {
	        // "5.0" 같은 문자열 → double 변환
	        double score = Double.parseDouble(review_score);

	        int result = lectureService.updateReview(review_num, review_content, score);

	        response.put("success", result > 0);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	    }

	    return response;
	}



	
	// 리뷰 삭제
	@PostMapping("/deleteReview")
	@ResponseBody
	public Map<String, Object> deleteReview(int review_num) {
		System.out.println("MemberController deleteReview(review_num)");
		
		int result = lectureService.deleteReview(review_num);
		
		Map<String, Object> response = new HashMap<>();
		response.put("success", result > 0);
		
		return response;  
	}
	
	// 스크랩	
	@GetMapping("/scrap")
	public String scrapList(HttpSession session, Model model) {
	    UserVO userVO = (UserVO) session.getAttribute("userVO");

	    if (userVO == null) return "redirect:/main/main";

	    List<ScrapVO> scrapList = scrapService.getScrapList(userVO.getUser_num());
	    model.addAttribute("scrapList", scrapList);

	    return "member/scrap";
	}
	
	/** 스크랩 삭제 (단일) */
    @PostMapping("/scrap/delete")
    @ResponseBody
    public String deleteScrap(@RequestParam int lecture_num, HttpSession session) {

        UserVO userVO = (UserVO) session.getAttribute("userVO");
        if (userVO == null) return "LOGIN_REQUIRED";

        boolean result = scrapService.deleteScrap(userVO.getUser_num(), lecture_num);
        return result ? "OK" : "FAIL";
    }
	
	// 회원정보수정 들어가기전 비밀번호 확인
	@GetMapping("/updatePassWord") 
	public String updatePassWord(Model model, HttpSession session) {
		System.out.println("MemberController updatePassWord()");
		String user_id = (String) session.getAttribute("user_id");
		UserVO user = memberService.insertMember(user_id);
		
		model.addAttribute("user", user);
		return "member/updatePassWord";  
	}
	
	@PostMapping("/updatePasswordPro")
	public String updatePasswordPro(@RequestParam("user_id") String user_id,
								    @RequestParam("user_password") String user_password, Model model) {
		System.out.println("MemberController updatePasswordPro()");
		
		UserVO user = memberService.insertMember(user_id);
		
		if(user != null && user.getUser_password().equals(user_password)) {
			// 비번 일치
			return "redirect:/member/editInfo";
		}else {	
	        return "member/msg";
		}
		
	}
	
	// 회원탈퇴
	@GetMapping("/memberdeletePro") 
	public String memberdeletePro(@RequestParam("user_num") int user_num, HttpSession session) {
		System.out.println("MemberController memberdeletePro()");
		
		memberService.memberDelete(user_num);
		session.invalidate();
		
		return "redirect:/";  
	}

	// 로그아웃
	@GetMapping("/logout") 
	public String logout(HttpSession session) {
		System.out.println("MemberController logout()");
		session.invalidate();
		return "redirect:/";  
	}
	
	
	//결제내역
	  @GetMapping("/paymentList")
	    public String myPayment(HttpSession session, Model model) {
		  	 System.out.println("MemberController paymetList()");
		  	UserVO loginUser = (UserVO) session.getAttribute("userVO");
	        if (loginUser == null) {
	        	   return "redirect:/main/main";
	        }

	        List<PaymentVO> paymentList =
	                paymentService.getPaymentList(loginUser.getUser_num());
	        System.out.println(paymentList);
	        model.addAttribute("paymentList", paymentList);
	        

	        return "member/paymentList";    // JSP 경로
	    }
	
//	  // 결제내역상세상세
//	    @GetMapping("/payment")
//	    public String paymentDetail(int payment_id, HttpSession session, Model model) {
//	    	System.out.println("MemberController paymet()");
//	        UserVO user = (UserVO) session.getAttribute("userVO");
//	        PaymentVO payment = paymentService.getPayment(payment_id);
//
//	        payment.setRefundable(paymentService.isRefundable(payment.getCreated_at()));
//
//	        model.addAttribute("userVO", user);
//	        model.addAttribute("payment", payment);
//
//	        return "member/payment";
//	    }
	    
	    @GetMapping("/payment")
	    public String paymentDetailPage(
	            @RequestParam("payment_id") int paymentId,
	            HttpSession session,
	            Model model) {

	        UserVO user = (UserVO) session.getAttribute("userVO");
	        if (user == null) {
	            return "redirect:/member/login"; // 보호
	        }

	        // 결제 상세 정보
	        PaymentVO payment = paymentService.getPayment(paymentId);

	        // 환불 가능 여부 계산
	        payment.setRefundable(paymentService.isRefundable(payment.getCreated_at()));

	        // JSP에서 사용하도록 모델에 담기
	        model.addAttribute("payment", payment);
	        System.out.println("📌 PaymentVO JSON = " + payment);
	        // JSP 경로
	        return "member/payment";  // /WEB-INF/views/member/payment.jsp
	    }

	
	    /** 포인트 내역 페이지 */
	    @GetMapping("/member/pointHistory")
	    public String pointHistory(HttpSession session, Model model) {

	        // 세션 체크
	        UserVO user = (UserVO) session.getAttribute("userVO");
	        if (user == null) {
	            return "redirect:/member/login";
	        }

	        int userNum = user.getUser_num();

	        // 서비스 조회
	        List<PointHistoryVO> pointhistoryVOList = pointHistoryService.getHistoryByUser(userNum);

	        // JSP 로 전달
	        model.addAttribute("pointhistoryVOList", pointhistoryVOList);
	        model.addAttribute("userVO", user);

	        return "member/pointHistory";   // JSP 파일명
	    }
	
//	    강사 강의 관리 페이지
	    @GetMapping("/teacherMyPage")
	    public String teacherMyPage(HttpSession session, Model model, HttpServletRequest request,
	    						    @RequestParam(value = "filter", defaultValue = "all") String filter) {
			System.out.println("MemberController teacherMyPage()");
			
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
			String user_id = (String) session.getAttribute("user_id");
			String user_name = (String) session.getAttribute("user_name");
			UserVO user = memberService.insertMember(user_id);

			int count;
			List<LectureVO> manageMyCourses;
			// Map에 값 담기
		    Map<String, Object> params = new HashMap<>();
		    params.put("user_name", user_name);
		    params.put("pageVO", pageVO);
		    
			if("approval".equals(filter)) {
				manageMyCourses = memberService.approvalClass(params);
				count = memberService.teacherMyPageOk(params);
			}else if("waiting".equals(filter)) {
				manageMyCourses = memberService.waitingClass(params);
				count = memberService.teacherMyPageWaiting(params);
			}else if("reject".equals(filter)) {
				manageMyCourses = memberService.rejectClass(params);
				count = memberService.teacherMyPageReject(params); 
			}else if("delete".equals(filter)) {
				manageMyCourses = memberService.deleteClass(params);
				count = memberService.teacherMyPageDelete(params);
			}else {
				manageMyCourses = memberService.manageMyCourses(params);
				count = memberService.teacherMyPage(params);
			}
			
			int teacherMyPage = memberService.teacherMyPage(params); // 총 강의수
			int teacherMyPageOk = memberService.teacherMyPageOk(params); // 승인 완료
			int teacherMyPageWaiting = memberService.teacherMyPageWaiting(params); // 승인 대기
			int teacherMyPageReject = memberService.teacherMyPageReject(params); // 승인 반려
			int teacherMyPageDelete = memberService.teacherMyPageDelete(params); // 삭제 강의
			
		    
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
		    
		    model.addAttribute("filter",filter); 
		    model.addAttribute("user",user); 
			model.addAttribute("manageMyCourses", manageMyCourses);
			model.addAttribute("teacherMyPage", teacherMyPage);
			model.addAttribute("teacherMyPageOk", teacherMyPageOk);
			model.addAttribute("teacherMyPageWaiting", teacherMyPageWaiting);
			model.addAttribute("teacherMyPageReject", teacherMyPageReject);
			model.addAttribute("teacherMyPageDelete", teacherMyPageDelete);
		    model.addAttribute("pageVO", pageVO);
	    	
	    	return "member/teacherMyPage";   
	    }
	    
	    // 강의 추가
	    @GetMapping("/classAdd")
	    public String classAdd(Model model, HttpSession session) {
	    	System.out.println("MemberController classAdd()");
	    	
	    	String user_id = (String) session.getAttribute("user_id"); 
			UserVO user = memberService.insertMember(user_id);

	        List<CategoryVO> categoryList = adminService.categoryList();
	    	
	        model.addAttribute("user", user);
	        model.addAttribute("categoryList", categoryList);
	        return "member/classAdd";   
	    }
	    
	    @PostMapping("/classAddPro")
	    public String classAddPro(HttpServletRequest request, 
	    						  @RequestParam(value = "lecture_img", required = false)MultipartFile lecture_img) throws Exception {
	    	System.out.println("MemberController classAdd()");
	    	
		    LectureVO lectureVO = new LectureVO();
 
	    	String category_detail = request.getParameter("category_detail");
	    	String lecture_title = request.getParameter("lecture_title");
	    	String lecture_author = request.getParameter("lecture_author");
//	    	int user_num = Integer.parseInt(request.getParameter("user_num"));
		    String priceParam = request.getParameter("lecture_price");
	    	String lecture_detail = request.getParameter("lecture_detail");
	    	String lecture_tag = request.getParameter("lecture_tag");
	    	
		    String userNumParam = request.getParameter("user_num");
	    	int user_num = 0;
		    if (userNumParam != null && !userNumParam.isEmpty()) {
		        user_num = Integer.parseInt(userNumParam);
		    }
		    
		    int lecture_price = 0;
		    if (priceParam != null && !priceParam.isEmpty()) {
		        lecture_price = Integer.parseInt(priceParam);
		    }
		    
	    	lectureVO.setCategory_detail(category_detail);
	    	lectureVO.setLecture_title(lecture_title);
	    	lectureVO.setLecture_author(lecture_author);
	    	lectureVO.setUser_num(user_num);
	    	lectureVO.setLecture_price(lecture_price);
	    	lectureVO.setLecture_detail(lecture_detail);
	    	lectureVO.setLecture_tag(lecture_tag);
	    	
	    	if(!lecture_img.isEmpty()) {
	    		UUID uuid = UUID.randomUUID();
	    		String filename = uuid.toString() + "_" + lecture_img.getOriginalFilename();
	    		System.out.println("파일명 : " + filename);
	    		FileCopyUtils.copy(lecture_img.getBytes(), new File(uploadPath1, filename));
	    		lectureVO.setLecture_img(filename);
	    	}
	    	
	    	memberService.LectureUpdate(lectureVO);
	    	
	    	// 챕터 가져오기
	    	int lecture_num = lectureVO.getLecture_num();
	    	
	        System.out.println("생성된 lecture_num: " + lecture_num);
	        String[] chapter_title = request.getParameterValues("chapter_title[]");

	    	// ✅ 디버깅: 챕터 개수 확인
	    	System.out.println("=== 챕터 저장 시작 ===");
	    	System.out.println("총 챕터 개수: " + (chapter_title != null ? chapter_title.length : 0));
	    	
	    	if(chapter_title != null && chapter_title.length > 0) {
	    		for(int i = 0; i < chapter_title.length; i++) {
	    			System.out.println("\n--- 챕터 " + (i+1) + " 처리 중 ---");
	    			System.out.println("챕터 제목: " + chapter_title[i]);
	    			
	    			ChapterVO chapterVO = new ChapterVO();
	    			chapterVO.setLecture_num(lecture_num);
	    			chapterVO.setChapter_order(i + 1);
	    			chapterVO.setChapter_title(chapter_title[i]);
	    			
	    			memberService.insertChapter(chapterVO);
	    			
	    			int chapter_num = chapterVO.getChapter_num();
	                System.out.println("생성된 chapter_num: " + chapter_num);
	                
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
	                		 
	                         ChapterDetailVO chapterDetailVO = new ChapterDetailVO();
	                         chapterDetailVO.setChapter_num(chapter_num);
	                         chapterDetailVO.setDetail_order(j + 1);
	                         chapterDetailVO.setDetail_title(detailTitles[j]);
	                         chapterDetailVO.setDetail_time(detailTimes != null && j < detailTimes.length ? detailTimes[j] : "00:00");

	                         memberService.insertChapterDetail(chapterDetailVO);
	                	}
	                }else {
	                    System.out.println("  ⚠️ 강의를 찾을 수 없습니다!");
	                }
	    		}
	    	}
	    	
	        System.out.println("=== 챕터 저장 완료 ===\n");

	    	return "member/teacherMyPage"; 
	    }
	    
	    @GetMapping("/deleteLecture")
	    public String deleteLecture(@RequestParam("lecture_num") int lecture_num) {
	    	System.out.println("MemberController classAdd()");
	    	
	    	memberService.deleteRequest(lecture_num);
	    	return "redirect:/member/teacherMyPage";
	    }
	    
	    @PostMapping("/editLecture")
	    public String editLecture(@RequestParam("lecture_num") int lecture_num, Model model) {
	    	System.out.println("MemberController editLecture()");
	    	LectureVO lectureVO = adminService.classEdit(lecture_num);
	    	NotApprovedVO notApprovedVO= memberService.classReason(lecture_num);
		    List<UserVO> instructorList = adminService.getInstructorList();
		    List<CategoryVO> categoryList = adminService.categoryList();
		    List<ChapterVO> chapterList = adminService.getChaptersByLectureNum(lecture_num);
		    
		    String tags = lectureVO.getLecture_tag(); // "드로잉,일러스트,취미"

		    // 쉼표 기준으로 배열화
			String[] tagArr = tags.split(",");

			model.addAttribute("tagArr", tagArr);
			model.addAttribute("lectureVO", lectureVO);
			model.addAttribute("notApprovedVO", notApprovedVO);
			model.addAttribute("categoryList", categoryList);
			model.addAttribute("instructorList", instructorList);
		    model.addAttribute("chapterList", chapterList); // 챕터 리스트 추가

		    return "member/editLecture";
	    }
	    
	    // 강의 수정
	   	@PostMapping("/classUpdate")
	   	public String adminClassUpdate(HttpServletRequest request,
	   	                               @RequestParam(value = "lecture_img", required = false) MultipartFile lecture_img) throws Exception {
	   	    System.out.println("memberController classUpdate()");
	   	    
	   	    LectureVO lectureVO = new LectureVO();
	   	    
	   	    // ✅ 기본 정보 가져오기
	   	    int lecture_num = Integer.parseInt(request.getParameter("lecture_num"));
	   	    String lecture_title = request.getParameter("lecture_title");
	   	    String category_detail = request.getParameter("category_detail");
	   	    String lecture_author = request.getParameter("lecture_author");
	   	    String lecture_detail = request.getParameter("lecture_detail");
	   	    String priceParam = request.getParameter("lecture_price");
	   	    String lecture_tag = request.getParameter("lecture_tag");
	   	    String oldfile = request.getParameter("oldfile"); // 기존 이미지
	   	    
	   	    int lecture_price = 0;
	   	    if (priceParam != null && !priceParam.isEmpty()) {
	   	        lecture_price = Integer.parseInt(priceParam);
	   	    }
	   	    
	   	    // ✅ 강사 정보 분리 (user_num:user_name 형식)
//	   	    String lec[] = lecture_author.split(":");
	   	    
	   	    lectureVO.setLecture_num(lecture_num);
	   	    lectureVO.setLecture_title(lecture_title);
	   	    lectureVO.setCategory_detail(category_detail);
	   	    lectureVO.setLecture_detail(lecture_detail);
	   	    lectureVO.setLecture_author(lecture_author); // 강사명
	   	    lectureVO.setLecture_price(lecture_price);
	   	    lectureVO.setLecture_tag(lecture_tag);
//	   	    lectureVO.setUser_num(user_num); // 강사 번호
	   	    
	   	    // ✅ 이미지 처리
	   	    if (lecture_img != null && !lecture_img.isEmpty()) {
	   	        // 새 이미지 업로드
	   	        UUID uuid = UUID.randomUUID();
	   	        String filename = uuid.toString() + "_" + lecture_img.getOriginalFilename();
	   	        System.out.println("새 파일명: " + filename);
	   	        FileCopyUtils.copy(lecture_img.getBytes(), new File(uploadPath1, filename));
	   	        lectureVO.setLecture_img(filename);
	   	        
	   	        // 기존 이미지 삭제
	   	        if (oldfile != null && !oldfile.isEmpty()) {
	   	            File oldFile = new File(uploadPath1, oldfile);
	   	            if (oldFile.exists()) {
	   	                oldFile.delete();
	   	                System.out.println("기존 파일 삭제: " + oldfile);
	   	            }
	   	        }
	   	    } else {
	   	        // 이미지 변경 없으면 기존 이미지 유지
	   	        lectureVO.setLecture_img(oldfile);
	   	    }
	   	    
	   	    System.out.println("수정할 강의 정보: " + lectureVO);
	   	    
	   	    // ✅ 1. 강의 정보 업데이트
	   	    adminService.updateLecture(lectureVO);
	   	    
	   	    // ✅ 2. 기존 챕터 및 챕터 상세 삭제 (외래키 연쇄 삭제)
	   	    adminService.deleteChaptersByLectureNum(lecture_num);
	   	    
	   	    // ✅ 3. 새로운 챕터 및 챕터 상세 추가
	   	    String[] chapterTitles = request.getParameterValues("chapter_title[]");
	   	    
	   	    System.out.println("=== 챕터 업데이트 시작 ===");
	   	    System.out.println("총 챕터 개수: " + (chapterTitles != null ? chapterTitles.length : 0));
	   	    
	   	    if (chapterTitles != null && chapterTitles.length > 0) {
	   	        for (int i = 0; i < chapterTitles.length; i++) {
	   	            System.out.println("\n--- 챕터 " + (i+1) + " 처리 중 ---");
	   	            System.out.println("챕터 제목: " + chapterTitles[i]);
	   	            
	   	            ChapterVO chapterVO = new ChapterVO();
	   	            chapterVO.setLecture_num(lecture_num);
	   	            chapterVO.setChapter_order(i + 1);
	   	            chapterVO.setChapter_title(chapterTitles[i]);
	   	            
	   	            memberService.insertChapter(chapterVO);
	   	            int chapterNum = chapterVO.getChapter_num();
	   	            
	   	            System.out.println("생성된 chapter_num: " + chapterNum);
	   	            
	   	            String detailTitleParam = "detail_title_" + i + "[]";
	   	            String detailTimeParam = "detail_time_" + i + "[]";
	   	            
	   	            String[] detailTitles = request.getParameterValues(detailTitleParam);
	   	            String[] detailTimes = request.getParameterValues(detailTimeParam);
	   	            
	   	            System.out.println("강의 개수: " + (detailTitles != null ? detailTitles.length : 0));
	   	            
	   	            if (detailTitles != null && detailTitles.length > 0) {
	   	                for (int j = 0; j < detailTitles.length; j++) {
	   	                    System.out.println("  강의 " + (j+1) + ": " + detailTitles[j] + " (" + 
	   	                        (detailTimes != null && j < detailTimes.length ? detailTimes[j] : "00:00") + ")");
	   	                    
	   	                    ChapterDetailVO detailVO = new ChapterDetailVO();
	   	                    detailVO.setChapter_num(chapterNum);
	   	                    detailVO.setDetail_order(j + 1);
	   	                    detailVO.setDetail_title(detailTitles[j]);
	   	                    detailVO.setDetail_time(detailTimes != null && j < detailTimes.length ? detailTimes[j] : "00:00");
	   	                    
	   	                    memberService.insertChapterDetail(detailVO);
	   	                }
	   	            }
	   	        }
	   	    }
	   	    
	   	    System.out.println("=== 챕터 업데이트 완료 ===\n");
	   	    
	   	    return "redirect:/member/teacherMyPage";
	   	}
	    
	    @GetMapping("/cenceldeleteLecture")
	    public String cenceldeleteLecture(@RequestParam("lecture_num") int lecture_num) {
	 	   System.out.println("AdminController classRejectReason()");
	 	   memberService.deleteCencel(lecture_num);
	 	   
	 	   return "redirect:/member/teacherMyPage";
	    }
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	    
	
}
