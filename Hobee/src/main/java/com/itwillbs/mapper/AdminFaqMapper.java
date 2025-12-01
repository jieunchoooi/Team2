package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.AdminFaqVO;
import org.apache.ibatis.annotations.Param;

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

    public List<AdminFaqVO> getFaqListFiltered(
            @Param("category") String category,
            @Param("keyword") String keyword);

    public List<AdminFaqVO> getFaqListPaged(
            @Param("startRow") int startRow,
            @Param("pageSize") int pageSize,
            @Param("category") String category,
            @Param("keyword") String keyword,
            @Param("sort") String sort);


    public int getFaqCount(
            @Param("category") String category,
            @Param("keyword") String keyword);

    public void updateVisibleBatch(@Param("ids") List<Integer> ids,
                                   @Param("is_visible") int is_visible);

    public void deleteBatch(@Param("ids") List<Integer> ids);


    void updateOrder(List<AdminFaqVO> list);

}
