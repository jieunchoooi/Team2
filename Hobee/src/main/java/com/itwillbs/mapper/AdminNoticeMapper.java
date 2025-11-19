package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminNoticeVO;

@Mapper
public interface AdminNoticeMapper {
	
	// 공지사항 전체 목록
    public List<AdminNoticeVO> getNoticeList();

    // 공지사항 등록
    public void insertNotice(AdminNoticeVO vo);

    // 공지사항 상세 조회
    public AdminNoticeVO getNoticeDetail(int notice_id);

    // 조회수 증가
    public void updateViewCount(int notice_id);

    // 공지사항 수정
    public void updateNotice(AdminNoticeVO vo);

    // 공지사항 삭제
    public void deleteNotice(int notice_id);

    // 공개/숨김 토글
    public void updateVisible(AdminNoticeVO vo);

}
