package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminFaqVO;

@Mapper
public interface AdminFaqMapper {
	
	// FAQ 목록
    public List<AdminFaqVO> getFaqList();

    // FAQ 등록
    public void insertFaq(AdminFaqVO vo);

    // FAQ 상세
    public AdminFaqVO getFaqDetail(int faq_id);

    // FAQ 수정
    public void updateFaq(AdminFaqVO vo);

    // FAQ 삭제
    public void deleteFaq(int faq_id);

    // 공개/숨김 변경
    public void updateVisible(AdminFaqVO vo);

}
