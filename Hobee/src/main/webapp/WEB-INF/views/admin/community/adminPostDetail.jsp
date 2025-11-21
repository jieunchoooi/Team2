<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 상세보기 | Hobee Admin</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostDetail.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 페이지 제목 -->
    <div class="page-title">게시글 상세보기</div>

    <!-- 카드박스 -->
    <div class="card-box">

        <div class="detail-row">
            <span class="label">제목</span>
            <span class="value">${post.title}</span>
        </div>

        <div class="detail-row">
            <span class="label">작성자</span>
            <span class="value">${post.author}</span>
        </div>

        <div class="detail-row">
            <span class="label">게시판</span>
            <span class="value">${post.board_name}</span>
        </div>

        <div class="detail-row">
            <span class="label">등록일</span>
            <span class="value">${post.created_at}</span>
        </div>

        <div class="detail-row">
            <span class="label">조회수</span>
            <span class="value">${post.views}</span>
        </div>

        <!-- ================================
             🔥 노출 여부 + 토글 버튼 (정렬 깔끔 버전)
        ================================= -->
       <div class="detail-row">
    <span class="label">노출 여부</span>

    <span class="value" style="display:flex; align-items:center; gap:12px;">

        <!-- 🔥 공개/숨김을 버튼으로 통일 -->
        <button class="btn-toggle ${post.is_visible == 1 ? 'btn-green' : 'btn-gray'}" disabled>
            ${post.is_visible == 1 ? '공개' : '숨김'}
        </button>

        <!-- 🔥 숨기기/표시하기 버튼 -->
        <form action="${pageContext.request.contextPath}/admin/adminPostToggle" method="post">
            <input type="hidden" name="post_id" value="${post.post_id}">
            <button class="btn-toggle ${post.is_visible == 1 ? 'btn-red' : 'btn-green'}">
                ${post.is_visible == 1 ? '숨기기' : '표시하기'}
            </button>
        </form>

    </span>
</div>

        <!-- 내용 -->
        <div class="content-box-wrapper">
            <h3>내용</h3>
            <div class="content-box">
                ${post.content}
            </div>
        </div>
        
      

        <!-- 버튼 영역 -->
        <div class="btn-area">
        
        
           <!-- 수정하기 -->
    <button class="btn-blue"
        onclick="location.href='${pageContext.request.contextPath}/admin/adminPostEdit?post_id=${post.post_id}'">
        수정하기
    </button>

    <!-- 목록으로 -->
    <button class="btn-blue"
        onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
        목록으로
    </button>

    <!-- 삭제 -->
    <form action="${pageContext.request.contextPath}/admin/adminPostDelete"
          method="post" onsubmit="return confirm('삭제하시겠습니까?');">
        <input type="hidden" name="post_id" value="${post.post_id}">
        <button class="btn-red">삭제</button>
    </form>

</div>

    </div><!-- card-box -->

</main>

</body>
</html>
