package com.itwillbs.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.AdminBoardVO;
import com.itwillbs.domain.BoardCategoryVO;
import com.itwillbs.domain.CommunityCategoryVO;
import com.itwillbs.domain.CommunityCommentVO;
import com.itwillbs.domain.CommunityContentVO;
import com.itwillbs.domain.CommunityDetailDTO;
import com.itwillbs.domain.CommunityReportVO;
import com.itwillbs.domain.CommunitySearchCriteria;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReactionCountVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.service.AdminBoardService;
import com.itwillbs.service.CommunityService;
import com.itwillbs.service.ReportService;

/**
 * CommunityController
 * ------------------------------------
 * - /community/list  : 기본 목록 (카테고리/정렬/기간 + 페이징)
 * - /community/search: 검색 전용 (제목/제목+내용/댓글/사용자 + 페이징)
 * - /community/reaction: 좋아요/싫어요 토글
 */
@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;
    
    // 추가
 	@Autowired
 	private ReportService reportService;

 	// 🔥 추가된 부분 (기존 코드 영향 없음)
 	@Autowired
 	private AdminBoardService adminBoardService;


    	
    /* ============================================================
    📌 커뮤니티 목록 (검색 + 필터 + 정렬 + 기간 + 페이징)
    - CommunitySearchCriteria 로 통합
    - 파라미터 이름 절대 변경 안 함
    ============================================================ */
	 @GetMapping("/list")
	 public String communityList(CommunitySearchCriteria cri, Model model,HttpSession session) {
	
	     // <%-- 기본값 설정 (널 또는 빈값일 때) --%>
	     if (cri.getSort() == null || cri.getSort().equals("")) {
	         cri.setSort("latest");
	     }
	
	     if (cri.getPeriod() == null || cri.getPeriod().equals("")) {
	         cri.setPeriod("all");
	     }
	
	     if (cri.getPage() <= 0) {
	         cri.setPage(1);
	     }
	
	     if (cri.getAmount() <= 0) {
	         cri.setAmount(10);
	     }
	  // offset 계산
	     cri.setOffset((cri.getPage() - 1) * cri.getAmount());
	     
	    
	     //글작성용 카테고리
	     model.addAttribute("categoryList", communityService.getCategoryList());
	     model.addAttribute("mainList", communityService.getMainCategoryList());
	     
	     
	     // <%-- 게시글 목록 조회 --%>
	     List<CommunityContentVO> communityList = communityService.getCommunityList(cri);
	
	     // <%-- 총 게시글 수 조회 --%>
	     int totalCount = communityService.getTotalCount(cri);
	     PageDTO pageMaker = new PageDTO(cri.getPage(), cri.getAmount(), totalCount);
	
	     // <%-- 카테고리 메인 목록(Chip 버튼용) --%>
	     List<CommunityContentVO> categoryMainList = communityService.getCategoryMainList();
	     
	     
	     // <%-- 카테고리 말머리 목록(Chip 버튼용) --%>
	     //이름이 엉켰지만 일단 사용
	     List<AdminBoardVO> categoryList = adminBoardService.getActiveBoardList();
	     
	     // <%-- 인기글 목록 --%>
	     List<CommunityContentVO> popularList = communityService.getPopularPosts();
	
	     // 🔥 실시간 핫토픽
	     List<CommunityContentVO> hotTopicList = communityService.getHotTopicList();
	    

	     // ============================================================
	     //   🔥 cri 세션 저장 (상세 → 목록 복귀 시 필터 유지용)
	     // ============================================================
	     session.setAttribute("communityFilterVO", cri);

	     // <%-- 모델 등록 --%>
	     model.addAttribute("communityList", communityList);
	     model.addAttribute("categoryMainList", categoryMainList);
	     model.addAttribute("categoryList", categoryList);
	    
	     model.addAttribute("hotTopicList", hotTopicList);
	     model.addAttribute("popularList", popularList);
	     model.addAttribute("pageMaker", pageMaker);
	     System.out.println("핫토픽 리스트 "+hotTopicList);
	     // <%-- 검색/필터 상태유지 --%>
	     model.addAttribute("cri", cri);
	
	     return "community/communityList";
	 }

	 @GetMapping("/detail")
	 public String communityDetail(
	         @RequestParam("post_id") int postId,
	         Model model,
	         HttpSession session,
	         HttpServletResponse response
	 ) throws Exception {

	     // ------------------------------------------------------------
	     // 1️⃣ 로그인 유저 정보
	     // ------------------------------------------------------------
	     UserVO loginUserVO = (UserVO) session.getAttribute("userVO");
	     Integer loginUserNum = (loginUserVO != null)
	             ? loginUserVO.getUser_num()
	             : null;

	     // ------------------------------------------------------------
	     // 2️⃣ 리스트에서 저장한 필터(CRI) 복원
	     // ------------------------------------------------------------
	     CommunitySearchCriteria cri =
	             (CommunitySearchCriteria) session.getAttribute("communityFilterVO");

	     if (cri == null) {
	         cri = new CommunitySearchCriteria();
	     }

	     // ------------------------------------------------------------
	     // 3️⃣ 상세 DTO 조회
	     // ------------------------------------------------------------
	     CommunityDetailDTO communityDetailDTO =
	             communityService.getPostDetailBundle(postId, cri, loginUserNum);

	     // ------------------------------------------------------------
	     // 4️⃣ 존재하지 않거나 삭제된 게시물 접근 차단
	     // ------------------------------------------------------------
	     if (communityDetailDTO == null 
	             || communityDetailDTO.getPost().getIs_deleted() == 1) {

	         response.setContentType("text/html; charset=UTF-8");
	         response.getWriter().println("<script>");
	         response.getWriter().println("alert('존재하지 않거나 삭제된 게시글입니다.');");
	         response.getWriter().println("location.href='" 
	                 + session.getServletContext().getContextPath()
	                 + "/community/list';");
	         response.getWriter().println("</script>");
	         response.getWriter().flush();
	         return null; // JSP 이동 안 하고 바로 종료
	     }

	     // ------------------------------------------------------------
	     // 인기글 + 핫토픽
	     // ------------------------------------------------------------
	     List<CommunityContentVO> popularList = communityService.getPopularPosts();
	     List<CommunityContentVO> hotTopicList = communityService.getHotTopicList();

	     // ------------------------------------------------------------
	     // 5️⃣ 모델 등록
	     // ------------------------------------------------------------
	     model.addAttribute("dto", communityDetailDTO);
	     model.addAttribute("hotTopicList", hotTopicList);
	     model.addAttribute("popularList", popularList);

	     return "community/communityDetail";
	 }



 // ==========================================================
 // 📌 1) 게시글 좋아요 토글
 // ==========================================================
 @PostMapping("/post/like")
 @ResponseBody
 public Map<String, Object> togglePostLike(
         @RequestParam("postId") int postId,
         @RequestParam("currentLiked") boolean currentLiked,
         HttpSession session) {

     Map<String, Object> res = new HashMap<>();

     UserVO userVO = (UserVO) session.getAttribute("userVO");
     if (userVO == null) {
         res.put("success", false);
         res.put("needLogin", true);
         return res;
     }

     boolean liked =
             communityService.togglePostLike(postId, userVO.getUser_num(), currentLiked);

     res.put("success", true);
     res.put("liked", liked); // true = 좋아요 상태, false = 취소됨
     return res;
 }



 // ==========================================================
 // 📌 2) 댓글 좋아요 토글
 // ==========================================================
 @PostMapping("/comment/like")
 @ResponseBody
 public Map<String, Object> toggleCommentLike(
         @RequestParam("commentId") int commentId,
         @RequestParam("currentLiked") boolean currentLiked,
         HttpSession session) {

     Map<String, Object> res = new HashMap<>();

     UserVO userVO = (UserVO) session.getAttribute("userVO");
     if (userVO == null) {
         res.put("success", false);
         res.put("needLogin", true);
         return res;
     }

     boolean liked =
             communityService.toggleCommentLike(commentId, userVO.getUser_num(), currentLiked);

     res.put("success", true);
     res.put("liked", liked);
     return res;
 }
 
 

 @PostMapping("/writePro")
 public void writeSubmit(
         CommunityContentVO communityContentVO,
         HttpSession session,
         HttpServletResponse response
 ) throws Exception {

     UserVO loginUserVO = (UserVO) session.getAttribute("userVO");

     if (loginUserVO == null) {
         alertBack(response, "로그인이 필요합니다.");
         return;
     }

     // 🔥 말머리 필수
     if (communityContentVO.getBoard_id() == null ||
         communityContentVO.getBoard_id() == 0) {

         alertBack(response, "말머리를 선택해주세요.");
         return;
     }

     // 🔥 제목 필수
     if (communityContentVO.getTitle() == null ||
         communityContentVO.getTitle().trim().isEmpty()) {

         alertBack(response, "제목을 입력해주세요.");
         return;
     }

     // 🔥 내용 필수
     if (communityContentVO.getContent() == null ||
         communityContentVO.getContent().trim().isEmpty()) {

         alertBack(response, "내용을 입력해주세요.");
         return;
     }

     // 🔥 카테고리 선택값이 placeholder면 null 처리
     if (communityContentVO.getCategory_main_num() != null &&
             communityContentVO.getCategory_main_num() == 0) {
         communityContentVO.setCategory_main_num(null);
     }

     communityContentVO.setUser_num(loginUserVO.getUser_num());

     int postId = communityService.writePost(communityContentVO);

     // 성공 → detail 이동
     response.sendRedirect(
    		    response.encodeRedirectURL(
    		        "/hobee/community/detail?post_id=" + postId
    		    )
    		);


 }


 //수정 페이지 데이터 가져오기
 @GetMapping("/edit")
 @ResponseBody
 public Map<String, Object> getPostDetailForEdit(
         @RequestParam("post_id") int postId,
         HttpSession session) {

     Map<String, Object> result = new HashMap<>();

     UserVO userVO = (UserVO) session.getAttribute("userVO");
     if (userVO == null) {
         result.put("error", "NOT_LOGIN");
         return result;
     }

     CommunityContentVO post = communityService.getPostById(postId);

     if (post == null || post.getUser_num() != userVO.getUser_num()) {
         result.put("error", "UNAUTHORIZED");
         return result;
     }

     result.put("post", post);
     
     result.put("categoryList", communityService.getCategoryList());
     result.put("mainCategoryList", communityService.getMainCategoryList());
     System.out.println("수정화면 result : "+result);
     return result;
 }

 
 //수정실행
 @PostMapping("/editPro")
 public String editPro(CommunityContentVO communityContentVO,
                       HttpSession session) {

     UserVO userVO = (UserVO) session.getAttribute("userVO");
     if (userVO == null) {
         return "redirect:/member/login";
     }

     // 작성자 본인인지 체크
     CommunityContentVO origin = communityService.getPostById(communityContentVO.getPost_id());
     if (origin == null || origin.getUser_num() != userVO.getUser_num()) {
         return "redirect:/community/list";
     }

     communityService.updatePost(communityContentVO);

     return "redirect:/community/detail?post_id=" + communityContentVO.getPost_id();
 }
 
 //게시글 삭제
 @GetMapping("/delete")
 public String delete(@RequestParam("post_id") int postId,
                      HttpSession session) {

     UserVO userVO = (UserVO) session.getAttribute("userVO");
     if (userVO == null) {
         return "redirect:/member/login";
     }

     communityService.deletePost(postId, userVO.getUser_num());

     return "redirect:/community/list";
 }

 /* ============================================================
 💬 댓글 CRUD (CommunityController 내부)
 ============================================================ */

 /* ============================================
 💬 댓글 등록 (댓글 + 대댓글 공용)
 ============================================ */
@PostMapping("/comment/add")
@ResponseBody
public Map<String, Object> addComment(
      @RequestParam int post_id,
      @RequestParam(required = false) Integer parent_id,
      @RequestParam String content,
      HttpSession session) {

  Map<String, Object> result = new HashMap<>();
  UserVO userVO = (UserVO) session.getAttribute("userVO");

  if (userVO == null) {
      result.put("needLogin", true);
      return result;
  }

  CommunityCommentVO vo = new CommunityCommentVO();
  vo.setPost_id(post_id);
  vo.setUser_num(userVO.getUser_num());
  vo.setParent_id(parent_id);      // ← 댓글(null) / 대댓글(값 존재)
  vo.setContent(content);

  boolean ok = communityService.insertComment(vo);
  result.put("success", ok);

  return result;
}



/* ============================================
✏ 댓글 수정
============================================ */
@PostMapping("/comment/update")
@ResponseBody
public Map<String, Object> updateComment(
     @RequestParam int comment_id,
     @RequestParam String content,
     HttpSession session) {

 Map<String, Object> result = new HashMap<>();
 UserVO userVO = (UserVO) session.getAttribute("userVO");

 if (userVO == null) {
     result.put("needLogin", true);
     return result;
 }

 boolean ok = communityService.updateComment(comment_id, userVO.getUser_num(), content);
 result.put("success", ok);

 return result;
}

/* ============================================
❌ 댓글 삭제
============================================ */
@PostMapping("/comment/delete")
@ResponseBody
public Map<String, Object> deleteComment(
     @RequestParam int comment_id,
     HttpSession session) {

 Map<String, Object> result = new HashMap<>();
 UserVO userVO = (UserVO) session.getAttribute("userVO");

 if (userVO == null) {
     result.put("needLogin", true);
     return result;
 }

 boolean ok = communityService.deleteComment(comment_id, userVO.getUser_num());
 result.put("success", ok);

 return result;
}

private void alertBack(HttpServletResponse response, String msg) throws Exception {
    response.setContentType("text/html; charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<script>alert('" + msg + "'); history.back();</script>");
    out.flush();
}

// ==========================================================
//📌 신고 여부 체크 (게시글 / 댓글 공용)
//==========================================================
	@PostMapping("/report/check")
	@ResponseBody
	public Map<String, Object> checkReport(
			@RequestParam String targetType, // "post" 또는 "comment"
			@RequestParam int targetId,      // post_id 또는 comment_id
			HttpSession session) {

		Map<String, Object> res = new HashMap<>();

		// 🔹 로그인 여부 확인
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		if (userVO == null) {
			res.put("loggedIn", false);
			return res;
		}

		int userNum = userVO.getUser_num();
		boolean already;

		// 🔹 게시글 / 댓글 신고 여부 분기
		if ("post".equals(targetType)) {
			already = communityService.alreadyReportedPost(userNum, targetId);
		} else {
			already = communityService.alreadyReportedComment(userNum, targetId);
		}

		res.put("loggedIn", true);
		res.put("already", already);  // true면 이미 신고함

		return res;
	}

	// ==========================================================
//📌 신고 저장 API (게시글 / 댓글 공용)
//==========================================================
	@PostMapping("/report")
	@ResponseBody
	public Map<String, Object> saveReport(
			@RequestParam String targetType, // "post" 또는 "comment"
			@RequestParam int targetId,      // post_id 또는 comment_id
			@RequestParam String reason,     // 신고 사유
			HttpSession session) {

		Map<String, Object> res = new HashMap<>();

		// 🔹 로그인 여부 확인
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		if (userVO == null) {
			res.put("success", false);
			res.put("needLogin", true);
			return res;
		}

		int userNum = userVO.getUser_num();

		// 🔹 신고 VO 구성
		CommunityReportVO vo = new CommunityReportVO();
		vo.setUser_num(userNum);
		vo.setReason(reason);

		if ("post".equals(targetType)) {
			vo.setPost_id(targetId); // 게시글 신고
		} else {
			vo.setComment_id(targetId); // 댓글 신고
		}

		// 🔹 저장 실행
		boolean ok = reportService.insertReport(vo);

		res.put("success", ok);
		return res;
	}


}
