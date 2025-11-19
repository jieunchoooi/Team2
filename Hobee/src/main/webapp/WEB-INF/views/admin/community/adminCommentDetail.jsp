<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>댓글 상세보기 | Hobee Admin</title>

    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCommentDetail.css">
</head>

<body>

<!-- 공통 상단 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 콘텐츠 -->
<main class="main-content">

    <div class="main-header">
        <h1>댓글 상세보기</h1>
    </div>

    <div class="detail-card">

        <div class="detail-row">
            <span class="label">댓글 ID</span>
            <span class="value">${comment.comment_id}</span>
        </div>

        <div class="detail-row">
            <span class="label">게시글 제목</span>
            <span class="value">
                <a class="title-link" 
                   href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${comment.post_id}">
                    ${comment.post_title}
                </a>
            </span>
        </div>

        <div class="detail-row">
            <span class="label">작성자</span>
            <span class="value">${comment.user_id}</span>
        </div>

        <div class="detail-row">
            <span class="label">등록일</span>
            <span class="value">${comment.created_at}</span>
        </div>

        <div class="detail-row">
            <span class="label">신고 횟수</span>
            <span class="value">
                <span class="badge-red">${comment.report_count}</span>
            </span>
        </div>

        <!-- 내용 -->
        <div class="detail-content">
            <h3>내용</h3>
            <div class="content-box">
                ${comment.content}
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="btn-area">

            <button class="btn-back"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList'">
                목록으로
            </button>

            <form action="${pageContext.request.contextPath}/admin/adminCommentDelete"
                  method="post"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="comment_id" value="${comment.comment_id}">
                <button class="btn-delete">삭제</button>
            </form>

        </div>

    </div>

</main>

</body>
</html>
