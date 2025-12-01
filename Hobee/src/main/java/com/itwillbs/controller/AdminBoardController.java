package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

    @Inject
    private AdminBoardService adminBoardService;

    // 📌 게시판 목록 (정식 URL: /admin/adminBoardList)
    @GetMapping("/adminBoardList")
    public String adminBoardList(Model model) {
        System.out.println("AdminBoardController: adminBoardList() 실행");
        model.addAttribute("boardList", adminBoardService.getBoardList());
        return "admin/community/adminBoard";   // JSP 파일 이름은 동일하게 유지
    }

    // 📌 게시판 추가
    @PostMapping("/adminBoardAdd")
    public String adminBoardAdd(AdminBoardVO vo) {
        System.out.println("AdminBoardController: adminBoardAdd() 실행");
        adminBoardService.insertBoard(vo);
        return "redirect:/admin/adminBoardList";
    }

    // 📌 게시판 수정 화면
    @GetMapping("/adminBoardEdit")
    public String adminBoardEdit(@RequestParam("board_id") int boardId, Model model) {

        AdminBoardVO board = adminBoardService.getBoard(boardId);
        List<AdminBoardVO> parentList = adminBoardService.getParentCategories();

        model.addAttribute("board", board);
        model.addAttribute("parentList", parentList);

        return "admin/community/adminBoardEdit";
    }


    // 📌 수정 처리
    @PostMapping("/adminBoardEditPro")
    public String adminBoardEditPro(AdminBoardVO vo) {
        System.out.println("AdminBoardController: adminBoardEditPro() 실행");
        adminBoardService.updateBoard(vo);
        return "redirect:/admin/adminBoardList";
    }

    @PostMapping("/adminBoardDisable")
    public String adminBoardDisable(@RequestParam("board_id") int boardId, RedirectAttributes rttr) {
        System.out.println("AdminBoardController: adminBoardDisable() 실행");
        adminBoardService.disableBoard(boardId);
        rttr.addFlashAttribute("msg", "게시판을 숨김 처리했습니다.");
        return "redirect:/admin/adminBoardList";
    }
    
    @PostMapping("/adminBoardEnable")
    public String adminBoardEnable(@RequestParam("board_id") int boardId, RedirectAttributes rttr) {
    	System.out.println("AdminBoardController: adminBoardEnable() 실행");
        adminBoardService.enableBoard(boardId);
        rttr.addFlashAttribute("msg", "게시판을 표시했습니다.");
        return "redirect:/admin/adminBoardList";
    }
    
    @PostMapping("/updateBoardOrder")
    @ResponseBody
    public String updateBoardOrder(@RequestParam("orderData") String orderData) {

        // orderData 예: "3:1,5:2,2:3"
        String[] items = orderData.split(",");

        for (String item : items) {
            String[] parts = item.split(":");
            int board_id = Integer.parseInt(parts[0]);
            int order = Integer.parseInt(parts[1]);

            AdminBoardVO vo = new AdminBoardVO();
            vo.setBoard_id(board_id);
            vo.setBoard_order(order);

            adminBoardService.updateBoardOrder(vo);
        }

        return "success";
    }
    
    @GetMapping("/adminBoardDetail")
    public String adminBoardDetail(@RequestParam("board_id") int boardId, Model model) {

        model.addAttribute("board", adminBoardService.getBoardDetail(boardId));
        model.addAttribute("recentPosts", adminBoardService.getRecentPosts(boardId));

        model.addAttribute("weeklyStats", adminBoardService.getWeeklyPostStats(boardId));
        model.addAttribute("topViews", adminBoardService.getTopViewPosts(boardId));
        model.addAttribute("topReports", adminBoardService.getTopReportPosts(boardId));

        return "admin/community/adminBoardDetail";
    }


  }

