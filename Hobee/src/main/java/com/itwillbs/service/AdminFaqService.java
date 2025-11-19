package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.AdminFaqVO;
import com.itwillbs.mapper.AdminFaqMapper;

@Service
public class AdminFaqService {
	
	@Inject
	private AdminFaqMapper adminFaqMapper;
	
	// FAQ 목록
    public List<AdminFaqVO> getFaqList() {
    	System.out.println("AdminFaqService : getFaqList() 실행");
        return adminFaqMapper.getFaqList();
    }

    // FAQ 등록
    public void insertFaq(AdminFaqVO vo) {
    	System.out.println("AdminFaqService : insertFaq() 실행");
    	adminFaqMapper.insertFaq(vo);
    }

    // FAQ 상세
    public AdminFaqVO getFaqDetail(int faq_id) {
    	System.out.println("AdminFaqService : getFaqDetail() 실행");
        return adminFaqMapper.getFaqDetail(faq_id);
    }

    // FAQ 수정
    public void updateFaq(AdminFaqVO vo) {
    	System.out.println("AdminFaqService : updateFaq() 실행");
    	adminFaqMapper.updateFaq(vo);
    }

    // FAQ 삭제
    public void deleteFaq(int faq_id) {
    	System.out.println("AdminFaqService : deleteFaq() 실행");
    	adminFaqMapper.deleteFaq(faq_id);
    }

    // FAQ 공개/숨김 변경
    public void updateVisible(AdminFaqVO vo) {
    	System.out.println("AdminFaqService : updateVisible() 실행");
    	adminFaqMapper.updateVisible(vo);
    }
	
}
