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

    <div class="page-title">게시글 상세보기</div>

    <div class="detail-card">

        <div class="detail-info-box">

            <div class="detail-info-row">
                <span class="info-label">제목</span>
                <span class="info-value">${post.title}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">작성자</span>
                <span class="info-value">${post.author}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">게시판</span>
                <span class="info-value">${post.board_name}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">등록일</span>
                <span class="info-value">${post.created_at}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">조회수</span>
                <span class="info-value">${post.views}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">노출 여부</span>

                <div class="exposure-box">
                    <span class="state-badge ${post.is_visible == 1 ? 'on' : 'off'}">
                        ${post.is_visible == 1 ? '공개' : '숨김'}
                    </span>

                    <form action="${pageContext.request.contextPath}/admin/adminPostToggle" method="post">
                        <input type="hidden" name="post_id" value="${post.post_id}">
                        <button class="toggle-btn ${post.is_visible == 1 ? 'btn-red' : 'btn-green'}">
                            ${post.is_visible == 1 ? '숨기기' : '표시하기'}
                        </button>
                    </form>
                </div>
            </div>

        </div>

        <div class="detail-content-box">
            <h3>내용</h3>
            <div class="detail-content-area">
                ${post.content}
            </div>
        </div>

        <div class="detail-btn-area">

            <button class="btn-blue"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminPostEdit?post_id=${post.post_id}'">
                수정하기
            </button>

            <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
                목록으로
            </button>

            <form action="${pageContext.request.contextPath}/admin/adminPostDelete"
                method="post" onsubmit="return confirm('삭제하시겠습니까?');">
                <input type="hidden" name="post_id" value="${post.post_id}">
                <button class="btn-red">삭제</button>
            </form>

        </div>

    </div>

</main>

</body>
</html>
