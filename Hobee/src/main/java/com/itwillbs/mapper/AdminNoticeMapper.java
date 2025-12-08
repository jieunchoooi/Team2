package com.itwillbs.mapper;

import java.util.List;

import com.itwillbs.domain.NoticeFileVO;
import com.itwillbs.domain.PageDTO;
import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminNoticeVO;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminNoticeMapper {
	
	// 공지사항 전체 목록
    List<AdminNoticeVO> getNoticeList(
            @Param("pageDTO") PageDTO pageDTO,
            @Param("type") String type,
            @Param("keyword") String keyword);

    int getNoticeCount(
            @Param("type") String type,
            @Param("keyword") String keyword);


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

    void updatePinned(AdminNoticeVO vo);


    void deleteNoticeSelect(@Param("noticeIds") List<Integer> noticeIds);

    void insertNoticeFile(NoticeFileVO vo);
    List<NoticeFileVO> getNoticeFiles(int notice_id);
    void deleteNoticeFiles(int notice_id);

    NoticeFileVO getNoticeFile(int fileId);

    void deleteNoticeFile(int fileId);
}


