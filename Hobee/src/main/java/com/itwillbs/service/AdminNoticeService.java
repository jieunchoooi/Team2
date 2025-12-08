package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminNoticeVO;
import com.itwillbs.domain.NoticeFileVO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.mapper.AdminNoticeMapper;

@Service
public class AdminNoticeService {

    @Inject
    private AdminNoticeMapper adminNoticeMapper;

    // ===============================
    // 1) 공지 목록 + 검색 + 정렬 + 페이징
    // ===============================
    public List<AdminNoticeVO> getNoticeList(PageDTO pageDTO, String type, String keyword) {
        System.out.println("AdminNoticeService : getNoticeList() 실행");
        return adminNoticeMapper.getNoticeList(pageDTO, type, keyword);
    }

    // 전체 개수
    public int getNoticeCount(String type, String keyword) {
        return adminNoticeMapper.getNoticeCount(type, keyword);
    }


    // ===============================
    // 2) 공지 등록
    // ===============================
    public void insertNotice(AdminNoticeVO vo) {
        System.out.println("AdminNoticeService : insertNotice() 실행");
        adminNoticeMapper.insertNotice(vo);
    }


    // ===============================
    // 3) 공지 상세
    // ===============================
    public AdminNoticeVO getNoticeDetail(int notice_id) {
        System.out.println("AdminNoticeService : getNoticeDetail() 실행");
        return adminNoticeMapper.getNoticeDetail(notice_id);
    }

    // 조회수 증가
    public void updateViewCount(int notice_id) {
        System.out.println("AdminNoticeService : updateViewCount() 실행");
        adminNoticeMapper.updateViewCount(notice_id);
    }


    // ===============================
    // 4) 공지 수정
    // ===============================
    public void updateNotice(AdminNoticeVO vo) {
        System.out.println("AdminNoticeService : updateNotice() 실행");
        adminNoticeMapper.updateNotice(vo);
    }


    // ===============================
    // 5) 공지 삭제
    // ===============================
    public void deleteNotice(int notice_id) {
        System.out.println("AdminNoticeService : deleteNotice() 실행");
        adminNoticeMapper.deleteNotice(notice_id);
    }

    // 여러 개 삭제
    public void deleteNoticeSelect(List<Integer> noticeIds) {
        adminNoticeMapper.deleteNoticeSelect(noticeIds);
    }


    // ===============================
    // 6) 공개 / 숨김 토글
    // ===============================
    public void updateVisible(AdminNoticeVO vo) {
        System.out.println("AdminNoticeService : updateVisible() 실행");
        adminNoticeMapper.updateVisible(vo);
    }


    // ===============================
    // 7) 상단 고정 PIN
    // ===============================
    public void updatePinned(AdminNoticeVO vo) {
        System.out.println("AdminNoticeService : updatePinned() 실행");
        adminNoticeMapper.updatePinned(vo);
    }


    // ===============================
    // 8) 첨부파일 기능
    // ===============================

    // 첨부파일 등록
    public void insertNoticeFile(NoticeFileVO vo) {
        adminNoticeMapper.insertNoticeFile(vo);
    }

    // 첨부파일 목록 조회
    public List<NoticeFileVO> getNoticeFiles(int notice_id) {
        return adminNoticeMapper.getNoticeFiles(notice_id);
    }

    // 해당 공지의 모든 첨부파일 삭제
    public void deleteNoticeFiles(int notice_id) {
        adminNoticeMapper.deleteNoticeFiles(notice_id);
    }

    // 특정 파일 1개 조회
    public NoticeFileVO getNoticeFile(int file_id) {
        return adminNoticeMapper.getNoticeFile(file_id);
    }

    // 특정 파일 1개 삭제
    public void deleteNoticeFile(int file_id) {
        adminNoticeMapper.deleteNoticeFile(file_id);
    }

    public List<AdminNoticeVO> getNoticeListForUser() {
        return adminNoticeMapper.getNoticeListForUser();
    }



}