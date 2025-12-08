package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.AdminBoardVO;
import com.itwillbs.service.AdminBoardService;

@Controller
@RequestMapping("/admin/*")
public class AdminBoardController {
	
	@ModelAttribute("page")
	public String setPageIdentifier(HttpServletRequest req) {
	    String uri = req.getRequestURI();

	    if (uri.contains("adminBoardList")) return "boardList";
	    return "";
	}

    @Inject
    private AdminBoardService adminBoardService;

    // 📌 게시판 목록
    @GetMapping("/adminBoardList")
    public String adminBoardList(Model model) {
        model.addAttribute("boardList", adminBoardService.getBoardList());
        return "admin/community/adminBoard";
    }

    // 📌 게시판 추가
    @PostMapping("/adminBoardAdd")
    public String adminBoardAdd(AdminBoardVO vo) {
        adminBoardService.insertBoard(vo);
        return "redirect:/admin/adminBoardList";
    }

    // 📌 게시판 수정 화면
    @GetMapping("/adminBoardEdit")
    public String adminBoardEdit(@RequestParam("board_id") int boardId, Model model) {
        model.addAttribute("board", adminBoardService.getBoard(boardId));
        return "admin/community/adminBoardEdit";
    }

    // 📌 게시판 수정 처리
    @PostMapping("/adminBoardEditPro")
    public String adminBoardEditPro(AdminBoardVO vo) {

        // 금지 단어 공백 처리
        if (vo.getBanned_words() != null && vo.getBanned_words().trim().equals("")) {
            vo.setBanned_words(null);
        }

        adminBoardService.updateBoard(vo);
        return "redirect:/admin/adminBoardList";
    }

    // 📌 게시판 숨김
    @PostMapping("/adminBoardDisable")
    public String adminBoardDisable(@RequestParam("board_id") int boardId,
                                    RedirectAttributes rttr) {
        adminBoardService.disableBoard(boardId);
        rttr.addFlashAttribute("msg", "머리말을 숨김 처리했습니다.");

        // ❌ 기존: return "redirect:/admin/adminBoardList";

        // ✅ 수정:
        return "redirect:adminBoardList";
    }


    // 📌 게시판 표시
    @PostMapping("/adminBoardEnable")
    public String adminBoardEnable(@RequestParam("board_id") int boardId,
                                   RedirectAttributes rttr) {
        adminBoardService.enableBoard(boardId);
        rttr.addFlashAttribute("msg", "머리말을 표시했습니다.");

        // ❌ 기존: return "redirect:/admin/adminBoardList";
        // ✅ 수정:
        return "redirect:adminBoardList";
    }


    // 📌 게시판 순서 변경
    @PostMapping("/updateBoardOrder")
    @ResponseBody
    public String updateBoardOrder(@RequestParam("orderData") String orderData) {

        String[] items = orderData.split(",");

        for (String item : items) {
            String[] parts = item.split(":");

            AdminBoardVO vo = new AdminBoardVO();
            vo.setBoard_id(Integer.parseInt(parts[0]));
            vo.setBoard_order(Integer.parseInt(parts[1]));

            adminBoardService.updateBoardOrder(vo);
        }

        return "success";
    }

    // 📌 게시판 상세
    @GetMapping("/adminBoardDetail")
    public String adminBoardDetail(@RequestParam("board_id") int boardId, Model model) {

        model.addAttribute("board", adminBoardService.getBoardDetail(boardId));
        model.addAttribute("recentPosts", adminBoardService.getRecentPosts(boardId));

        model.addAttribute("weeklyStats", adminBoardService.getWeeklyPostStats(boardId));
        model.addAttribute("topViews", adminBoardService.getTopViewPosts(boardId));
        model.addAttribute("topReports", adminBoardService.getTopReportPosts(boardId));

        return "admin/community/adminBoardDetail";
    }

    // ============================
// 📌 게시판 옵션(허용/금지) 빠른 변경 (AJAX)
// ============================
    @PostMapping("/adminBoardOptionUpdate")
    @ResponseBody
    public String adminBoardOptionUpdate(@RequestParam("board_id") int boardId,
                                         @RequestParam("option") String option,
                                         @RequestParam("value") int value) {

        try {
            switch (option) {
                case "comment":
                    adminBoardService.updateAllowComment(boardId, value);
                    break;
                case "image":
                    adminBoardService.updateAllowImage(boardId, value);
                    break;
                case "file":
                    adminBoardService.updateAllowFile(boardId, value);
                    break;
                case "approval":
                    adminBoardService.updateRequireApproval(boardId, value);
                    break;
                default:
                    return "error";
            }

            return "success";

        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }


}
