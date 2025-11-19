package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminNoticeVO;
import com.itwillbs.mapper.AdminNoticeMapper;

@Service
public class AdminNoticeService {
	
	@Inject
	private AdminNoticeMapper adminNoticeMapper;
	
	// 공지 목록
    public List<AdminNoticeVO> getNoticeList() {
    	System.out.println("AdminNoticeService : getNoticeList() 실행");
        return adminNoticeMapper.getNoticeList();
    }

    // 공지 등록
    public void insertNotice(AdminNoticeVO vo) {
    	System.out.println("AdminNoticeService : insertNotice() 실행");
    	adminNoticeMapper.insertNotice(vo);
    }

    // 공지 상세
    public AdminNoticeVO getNoticeDetail(int notice_id) {
    	System.out.println("AdminNoticeService : getNoticeDetail() 실행");
        return adminNoticeMapper.getNoticeDetail(notice_id);
    }

    // 조회수 증가
    public void updateViewCount(int notice_id) {
    	System.out.println("AdminNoticeService : updateViewCount() 실행");
    	adminNoticeMapper.updateViewCount(notice_id);
    }

    // 공지 수정
    public void updateNotice(AdminNoticeVO vo) {
    	System.out.println("AdminNoticeService : updateNotice() 실행");
    	adminNoticeMapper.updateNotice(vo);
    }

    // 공지 삭제
    public void deleteNotice(int notice_id) {
    	System.out.println("AdminNoticeService : deleteNotice() 실행");
    	adminNoticeMapper.deleteNotice(notice_id);
    }

    // 공개/숨김 업데이트
    public void updateVisible(AdminNoticeVO vo) {
    	System.out.println("AdminNoticeService : updateVisible() 실행");
    	adminNoticeMapper.updateVisible(vo);
    }

}
