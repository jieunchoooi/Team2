package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        System.out.println("AdminBoardController: adminBoardEdit() 실행");
        model.addAttribute("board", adminBoardService.getBoard(boardId));
        return "admin/community/adminBoardEdit";
    }

    // 📌 수정 처리
    @PostMapping("/adminBoardEditPro")
    public String adminBoardEditPro(AdminBoardVO vo) {
        System.out.println("AdminBoardController: adminBoardEditPro() 실행");
        adminBoardService.updateBoard(vo);
        return "redirect:/admin/adminBoardList";
    }

    // 📌 삭제 처리
    @GetMapping("/adminBoardDelete")
    public String adminBoardDelete(@RequestParam("board_id") int boardId) {
        System.out.println("AdminBoardController: adminBoardDelete() 실행");
        adminBoardService.deleteBoard(boardId);
        return "redirect:/admin/adminBoardList";
    }
}
