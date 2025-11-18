<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>

<!-- 공통 레이아웃 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">
<!-- 상세 페이지용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostDetail.css">

</head>
<body>

<!-- 공통 사이드바 포함 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp" />

<div class="admin-container">

    <h2 class="admin-title">게시글 상세</h2>

   <div class="detail-card">

    <div class="detail-section">
        <div class="detail-row">
            <span class="detail-label">제목</span>
            <span class="detail-value">${post.title}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">작성자</span>
            <span class="detail-value">${post.author}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">태그</span>
            <span class="detail-value">${post.tag}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">등록일</span>
            <span class="detail-value">${post.created_at}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">조회수</span>
            <span class="detail-value">${post.views}</span>
        </div>
    </div>

    <div class="detail-row content-box">
        <span class="detail-label">내용</span>
        <div class="detail-content">${post.content}</div>
    </div>

    <div class="button-area">

    <!-- 공개/숨김 -->
    <form action="${pageContext.request.contextPath}/admin/adminPostToggle" method="post">
        <input type="hidden" name="post_id" value="${post.post_id}">
        <button class="btn ${post.is_visible == 1 ? 'btn-visible' : 'btn-hidden'}">
            ${post.is_visible == 1 ? '공개 중' : '숨김'}
        </button>
    </form>

    <!-- 삭제 -->
    <form action="${pageContext.request.contextPath}/admin/adminPostDelete" method="post"
          onsubmit="return confirm('정말 삭제하시겠습니까?');">
        <input type="hidden" name="post_id" value="${post.post_id}">
        <button class="btn btn-delete">삭제</button>
    </form>

    <!-- 목록으로 -->
    <button class="btn btn-back"
            onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
        목록으로
    </button>

</div>

</div>

</div>
</body>
</html>

