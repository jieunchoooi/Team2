package com.itwillbs.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.List;

import javax.inject.Inject;

import com.itwillbs.domain.NoticeFileVO;
import com.itwillbs.domain.PageDTO;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.domain.AdminNoticeVO;
import com.itwillbs.service.AdminNoticeService;

@Controller
@RequestMapping("/admin/*")
public class AdminNoticeController {

    @Inject
    private AdminNoticeService adminNoticeService;

    /** ============================================
     *  공지 목록
     * ============================================ */
    @GetMapping("adminNoticeList")
    public String noticeList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int amount,
            @RequestParam(required=false) String type,
            @RequestParam(required=false) String keyword,
            @RequestParam(required=false) String sort,
            Model model) {

        int total = adminNoticeService.getNoticeCount(type, keyword);
        PageDTO pageDTO = new PageDTO(page, amount, total, sort);

        List<AdminNoticeVO> noticeList =
                adminNoticeService.getNoticeList(pageDTO, type, keyword);

        model.addAttribute("noticeList", noticeList);
        model.addAttribute("pageDTO", pageDTO);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);

        return "admin/community/adminNoticeList";
    }


    /** ============================================
     *  공지 작성 폼
     * ============================================ */
    @GetMapping("adminNoticeWrite")
    public String noticeWriteForm() {
        return "admin/community/adminNoticeWrite";
    }

    /** ============================================
     *  공지 등록 + 첨부파일 저장
     * ============================================ */
    @PostMapping("adminNoticeWritePro")
    public String noticeWritePro(AdminNoticeVO vo,
                                 @RequestParam("uploadFiles") MultipartFile[] uploadFiles)
            throws Exception {

        if(vo.getAdmin_id() == null) vo.setAdmin_id("admin");

        // 공지 등록
        adminNoticeService.insertNotice(vo);
        int noticeId = vo.getNotice_id();

        // 파일 저장 경로
        String uploadFolder = "C:/upload/notice";
        File dir = new File(uploadFolder);
        if(!dir.exists()) dir.mkdirs();

        // 첨부파일 저장
        for(MultipartFile file : uploadFiles){
            if(file.isEmpty()) continue;

            String fileName = file.getOriginalFilename();

            String savePath = uploadFolder + "/" + fileName;
            file.transferTo(new File(savePath));

            NoticeFileVO fvo = new NoticeFileVO();
            fvo.setNotice_id(noticeId);
            fvo.setFile_name(fileName);
            fvo.setFile_path(savePath);
            fvo.setFile_size(file.getSize());

            adminNoticeService.insertNoticeFile(fvo);
        }

        return "redirect:/admin/adminNoticeList";
    }


    /** ============================================
     *  공지 상세 + 조회수 증가
     * ============================================ */
    @GetMapping("adminNoticeDetail")
    public String noticeDetail(@RequestParam("notice_id") int notice_id, Model model) {

        adminNoticeService.updateViewCount(notice_id);

        AdminNoticeVO notice = adminNoticeService.getNoticeDetail(notice_id);
        List<NoticeFileVO> files = adminNoticeService.getNoticeFiles(notice_id);

        model.addAttribute("notice", notice);
        model.addAttribute("files", files);

        return "admin/community/adminNoticeDetail";
    }


    /** ============================================
     *  공지 수정 폼
     * ============================================ */
    @GetMapping("adminNoticeEdit")
    public String noticeEditForm(@RequestParam("notice_id") int notice_id, Model model) {

        AdminNoticeVO notice = adminNoticeService.getNoticeDetail(notice_id);
        List<NoticeFileVO> files = adminNoticeService.getNoticeFiles(notice_id);

        model.addAttribute("notice", notice);
        model.addAttribute("files", files);

        return "admin/community/adminNoticeEdit";
    }


    /** ============================================
     *  공지 수정 + 파일 삭제 + 새 파일 추가
     * ============================================ */
    @PostMapping("adminNoticeEditPro")
    public String noticeEditPro(AdminNoticeVO vo,
                                @RequestParam(value="deleteFiles", required=false) List<Integer> deleteFiles,
                                @RequestParam(value="uploadFiles", required=false) MultipartFile[] uploadFiles)
            throws Exception {

        adminNoticeService.updateNotice(vo);
        int noticeId = vo.getNotice_id();

        // 1) 기존 파일 삭제
        if(deleteFiles != null){
            for(Integer fileId : deleteFiles){

                NoticeFileVO fileVO = adminNoticeService.getNoticeFile(fileId);
                if(fileVO != null){
                    File realFile = new File(fileVO.getFile_path());
                    if(realFile.exists()) realFile.delete(); // 실제 파일 삭제
                }
                adminNoticeService.deleteNoticeFile(fileId); // DB 삭제
            }
        }

        // 2) 새 파일 추가
        if(uploadFiles != null){
            String uploadFolder = "C:/upload/notice";
            File dir = new File(uploadFolder);
            if(!dir.exists()) dir.mkdirs();

            for(MultipartFile file : uploadFiles){
                if(file.isEmpty()) continue;

                String fileName = file.getOriginalFilename();
                String savePath = uploadFolder + "/" + fileName;
                file.transferTo(new File(savePath));

                NoticeFileVO fvo = new NoticeFileVO();
                fvo.setNotice_id(noticeId);
                fvo.setFile_name(fileName);
                fvo.setFile_path(savePath);
                fvo.setFile_size(file.getSize());

                adminNoticeService.insertNoticeFile(fvo);
            }
        }

        return "redirect:/admin/adminNoticeDetail?notice_id=" + noticeId;
    }


    /** ============================================
     *  공지 삭제
     * ============================================ */
    @PostMapping("adminNoticeDelete")
    public String noticeDelete(@RequestParam("notice_id") int notice_id) {

        // 파일 먼저 삭제
        List<NoticeFileVO> files = adminNoticeService.getNoticeFiles(notice_id);
        for(NoticeFileVO f : files){
            File realFile = new File(f.getFile_path());
            if(realFile.exists()) realFile.delete();
        }

        adminNoticeService.deleteNoticeFiles(notice_id);
        adminNoticeService.deleteNotice(notice_id);

        return "redirect:/admin/adminNoticeList";
    }


    /** ============================================
     *  공개/숨김 토글
     * ============================================ */
    @PostMapping("adminNoticeVisible")
    public String noticeVisible(AdminNoticeVO vo) {
        adminNoticeService.updateVisible(vo);
        return "redirect:/admin/adminNoticeList";
    }


    /** ============================================
     *  PIN(상단 고정) 토글 - 목록
     * ============================================ */
    @PostMapping("adminNoticePinned")
    public String noticePinned(AdminNoticeVO vo) {
        adminNoticeService.updatePinned(vo);
        return "redirect:/admin/adminNoticeList";
    }

    /** ============================================
     *  PIN(상단 고정) 토글 - 상세
     * ============================================ */
    @PostMapping("adminNoticePinnedDetail")
    public String noticePinnedDetail(AdminNoticeVO vo) {
        adminNoticeService.updatePinned(vo);
        return "redirect:/admin/adminNoticeDetail?notice_id=" + vo.getNotice_id();
    }


    /** ============================================
     *  일괄 삭제
     * ============================================ */
    @PostMapping("adminNoticeDeleteSelect")
    public String noticeDeleteSelect(@RequestParam("noticeIds") List<Integer> noticeIds) {

        for(Integer id : noticeIds){
            List<NoticeFileVO> files = adminNoticeService.getNoticeFiles(id);
            for(NoticeFileVO f : files){
                File realFile = new File(f.getFile_path());
                if(realFile.exists()) realFile.delete();
            }
            adminNoticeService.deleteNoticeFiles(id);
        }

        adminNoticeService.deleteNoticeSelect(noticeIds);

        return "redirect:/admin/adminNoticeList";
    }


    /** ============================================
     *  파일 다운로드
     * ============================================ */
    @GetMapping("fileDownload")
    public ResponseEntity<byte[]> fileDownload(@RequestParam("file") String fileName) throws Exception {

        String uploadDir = "C:/upload/notice/";
        File file = new File(uploadDir + fileName);

        if(!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        byte[] fileData = Files.readAllBytes(file.toPath());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        // 한글 파일명 인코딩
        String encodedName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        headers.setContentDispositionFormData("attachment", encodedName);

        return new ResponseEntity<>(fileData, headers, HttpStatus.OK);
    }


}
