package com.itwillbs.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.CategoryVO;
import com.itwillbs.domain.Category_mainVO;
import com.itwillbs.domain.CommunityCategoryVO;
import com.itwillbs.domain.CommunityCommentVO;
import com.itwillbs.domain.CommunityContentVO;
import com.itwillbs.domain.CommunityDetailDTO;
import com.itwillbs.domain.CommunityReportVO;
import com.itwillbs.domain.CommunitySearchCriteria;
import com.itwillbs.domain.ReactionCountVO;
import com.itwillbs.mapper.CommunityMapper;

/**
 * CommunityService
 * ------------------------------------
 * - Controller와 Mapper 사이의 비즈니스 레이어
 * - 커뮤니티 목록/검색/카테고리/인기글/리액션 처리
 */
@Service
public class CommunityService {

    @Autowired
    private CommunityMapper communityMapper;


    // ============================================
    // 📌 예전 전체 카운트 (단순 category_main_num 기준)
    //    - 기존 코드와의 호환을 위해 유지
    // ============================================
    public int getCommunityCount(Integer categoryMainNum) {
        return communityMapper.getCommunityCount(categoryMainNum);
    }
    // 🔥 실시간 HOT TOPIC */
    public List<CommunityContentVO> getHotTopicList() {
        return communityMapper.getHotTopicList();
    }

    // ============================================
    // 📌 인기글 Top N
    // ============================================
    public List<CommunityContentVO> getPopularPosts() {
        return communityMapper.getPopularPosts();
    }

    // ============================================
    // 📌 카테고리 메인 리스트 (Chip 버튼용)
    // ============================================
    public List<CommunityCategoryVO> getCategoryList() {
        return communityMapper.getCategoryList();
    }




    // ============================================
    // 📌 카테고리 메인 리스트 (Chip 버튼용)
    // ============================================
    public List<CommunityContentVO> getCategoryMainList() {
        return communityMapper.getCategoryMainList();
    }


    // ============================================
    // 📌 1) 통합 목록 조회 (검색 + 필터 + 정렬 + 기간 + 페이징)
    //     - CommunitySearchCriteria 기반으로 통합
    // ============================================
    public List<CommunityContentVO> getCommunityList(CommunitySearchCriteria cri) {
        return communityMapper.getCommunityList(cri);
    }

    public int getTotalCount(CommunitySearchCriteria cri) {
        return communityMapper.getTotalCount(cri);
    }


    
    //게시글 상세 조회
    public CommunityDetailDTO getPostDetailBundle(int postId, CommunitySearchCriteria criteria, Integer userNum) {

        System.out.println("\n===============================");
        System.out.println("📌 [CommunityService] 상세페이지 통합 조회 시작");
        System.out.println("👉 postId = " + postId);
        System.out.println("👉 userNum = " + userNum);
        System.out.println("👉 criteria = " + criteria);
        System.out.println("===============================\n");

        // ------------------------------------------------------------
        // 📌 0. DTO 생성 (풀네임)
        // ------------------------------------------------------------
        CommunityDetailDTO communityDetailDTO = new CommunityDetailDTO();

        // ------------------------------------------------------------
        // 📌 1. 게시글 상세 조회 + 좋아요 여부 포함
        // ------------------------------------------------------------
        CommunityContentVO currentPostVO =
                communityMapper.getPostDetailWithLike(postId, userNum);

        if (currentPostVO == null) {
            System.out.println("❌ 게시글을 찾을 수 없습니다 (postId=" + postId + ")");
            return null;
        }

        communityDetailDTO.setPost(currentPostVO);   // 기존 필드
        communityDetailDTO.setCurrent(currentPostVO); // 새로운 필드 (가운데 강조용)

        // ------------------------------------------------------------
        // 📌 2. 댓글 조회
        // ------------------------------------------------------------
        List<CommunityCommentVO> commentList =
                communityMapper.getCommentsByPostId(postId, userNum);

        communityDetailDTO.setComments(commentList);

        // ------------------------------------------------------------
        // 📌 3. 주변 글(7개: 이전3 + 현재 + 다음3) 전체 조회
        // ------------------------------------------------------------
        List<CommunityContentVO> aroundList =
                communityMapper.getPrevNextPosts(postId, criteria);

        // ------------------------------------------------------------
        // 📌 4. prev3 / next3 분류 로직
        // ------------------------------------------------------------
        List<CommunityContentVO> prev3 = new ArrayList<>();
        List<CommunityContentVO> next3 = new ArrayList<>();

        int currentRn = -1;

        // 🔍 먼저 현재 글의 rn 찾기
        for (CommunityContentVO item : aroundList) {
            if (item.getPost_id() == postId) {
                currentRn = item.getRn();
                break;
            }
        }

        // 🔥 안전장치: 혹시 rn 못 찾으면 그대로 return
        if (currentRn == -1) {
            System.out.println("❌ RN 값을 찾을 수 없습니다. 쿼리 확인 필요!");
            return null;
        }

        // 🔥 이전 3, 다음 3 분리
        for (CommunityContentVO item : aroundList) {

            // 현재 글이면 건너뛴다
            if (item.getPost_id() == postId) {
                continue;
            }

            if (item.getRn() < currentRn) {
                prev3.add(item);
            } else {
                next3.add(item);
            }
        }

        // 🔥 혹시 prev3, next3가 3개 이상이라면 정확히 3개만 사용
        if (prev3.size() > 3) prev3 = prev3.subList(prev3.size() - 3, prev3.size());
        if (next3.size() > 3) next3 = next3.subList(0, 3);

        communityDetailDTO.setPrev3(prev3);
        communityDetailDTO.setNext3(next3);

        // ------------------------------------------------------------
        // 📌 5. 조회수 증가 (본인 글은 제외)
        // ------------------------------------------------------------
        if (userNum == null || userNum != currentPostVO.getUser_num()) {
            System.out.println("▶ 조회수 증가 실행");
            communityMapper.updateViewCount(postId);
        } else {
            System.out.println("▶ 본인 글 → 조회수 증가 제외");
        }

        // ------------------------------------------------------------
        // 📌 완료 출력
        // ------------------------------------------------------------
        System.out.println("📌 상세페이지 DTO 구성 완료");
        System.out.println(communityDetailDTO);

        return communityDetailDTO;
    }

    
    

   

    // ==========================================================
    // 📌 2) 게시글 — 좋아요/싫어요 토글 (insert/update/delete)
    // ==========================================================
    @Transactional
    public boolean togglePostLike(int postId, int userNum, boolean currentLiked) {

        if (currentLiked) {
            // 좋아요 → 취소
            communityMapper.deletePostLike(postId, userNum);
            return false;
        }

        // 좋아요 추가
        communityMapper.upsertPostLike(postId, userNum);
        return true;
    }


   

    // ==========================================================
    // 📌 4) 댓글 — 좋아요/싫어요 토글
    // ==========================================================
    @Transactional
    public boolean toggleCommentLike(int commentId, int userNum, boolean currentLiked) {

        if (currentLiked) {
            communityMapper.deleteCommentLike(commentId, userNum);
            return false;
        }

        communityMapper.upsertCommentLike(commentId, userNum);
        return true;
    }
    
    
    
    //강의카테고리 가져오기
    public List<Category_mainVO> getMainCategoryList() {
        return communityMapper.getMainCategoryList();
    }

    
    //글작성
    public int writePost(CommunityContentVO communityContentVO) {
        communityMapper.insertPost(communityContentVO);
        return communityContentVO.getPost_id(); // 생성된 PK 반환
    }
    
    
    
    //글 가져오기
    public CommunityContentVO getPostById(int postId) {
        return communityMapper.getPostById(postId);
    }
    //글 수정
    public void updatePost(CommunityContentVO communityContentVO) {
        communityMapper.updatePost(communityContentVO);
    }
    
    //게시글 삭제
    public void deletePost(int postId, int userNum) {

        CommunityContentVO post = communityMapper.getPostById(postId);

        // 존재여부 검증
        if (post == null) {
            throw new IllegalArgumentException("존재하지 않는 게시글입니다.");
        }

        // 본인 글인지 검증
        if (post.getUser_num() != userNum) {
            throw new SecurityException("본인의 게시글만 삭제할 수 있습니다.");
        }

        communityMapper.deletePost(postId);
    }

    /* ============================================================
    💬 댓글 CRUD (CommunityService 내부)
    ============================================================ */
 // 댓글 등록
    public boolean insertComment(CommunityCommentVO vo) {
        return communityMapper.insertComment(vo) == 1;
    }

    // 댓글 수정
    public boolean updateComment(int commentId, int userNum, String content) {
        return communityMapper.updateComment(commentId, userNum, content) == 1;
    }

    // 댓글 삭제
    public boolean deleteComment(int commentId, int userNum) {
        return communityMapper.deleteComment(commentId, userNum) == 1;
    }
    
 // 📌 신고 여부 체크 (게시글)
 	public boolean alreadyReportedPost(int userNum, int postId) {
 		return communityMapper.checkAlreadyReported(userNum, postId) > 0;
 	}

 	// 📌 신고 여부 체크 (댓글)
 	public boolean alreadyReportedComment(int userNum, int commentId) {
 		return communityMapper.checkAlreadyReportedComment(userNum, commentId) > 0;
 	}

 	public boolean insertReport(CommunityReportVO vo) {
 		return communityMapper.insertReport(vo) == 1;
 	}



}
