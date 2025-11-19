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

<!-- 공통 header + sidebar -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 콘텐츠 -->
<main class="main-content">

    <div class="main-header">
        <h1>게시글 상세보기</h1>
    </div>

    <!-- ⭐ 상세 카드 -->
    <div class="detail-card">

        <div class="detail-row">
            <span class="label">제목</span>
            <span class="value">${post.title}</span>
        </div>

        <div class="detail-row">
            <span class="label">작성자</span>
            <span class="value">${post.author}</span>
        </div>

        <div class="detail-row">
            <span class="label">태그</span>
            <span class="value">${post.tag}</span>
        </div>

        <div class="detail-row">
            <span class="label">등록일</span>
            <span class="value">${post.created_at}</span>
        </div>

        <div class="detail-row">
            <span class="label">조회수</span>
            <span class="value">${post.views}</span>
        </div>

        <div class="detail-row">
            <span class="label">노출 여부</span>
            <span class="value">
                <span class="${post.is_visible == 1 ? 'badge-blue' : 'badge-gray'}">
                    ${post.is_visible == 1 ? "공개" : "숨김"}
                </span>
            </span>
        </div>

        <div class="detail-content">
            <h3>내용</h3>
            <div class="content-box">
                ${post.content}
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="btn-area">
            <button class="btn-back"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
                목록으로
            </button>

            <form action="${pageContext.request.contextPath}/admin/adminPostDelete"
                  method="post"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="post_id" value="${post.post_id}">
                <button class="btn-delete">삭제</button>
            </form>
        </div>

    </div>
</main>

</body>
</html>
