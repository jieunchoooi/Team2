<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>댓글 상세</title>

    <!-- 공통 레이아웃 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- 댓글 상세 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCommentDetail.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="commentList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>💬 댓글 상세</h2>

    <!-- 게시글 정보 카드 -->
    <div class="post-info-card">
        <div class="post-info-title">📌 이 댓글이 달린 게시글</div>
        <div style="margin-top:8px;">
            <a href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${comment.post_id}">
                ${comment.post_title}
            </a>
        </div>
    </div>

    <table style="width:100%; border-collapse:collapse;">
        <tbody>

            <tr>
                <td class="info-label">댓글 번호</td>
                <td>${comment.comment_id}</td>
            </tr>

            <tr>
                <td class="info-label">작성자</td>
                <td>${comment.user_id}</td>
            </tr>

            <tr>
                <td class="info-label">등록일</td>
                <td>${comment.created_at}</td>
            </tr>

            <tr>
                <td class="info-label">신고 횟수</td>
                <td>
                    <span class="btn-red" style="padding:6px 14px;">${comment.report_count}</span>
                </td>
            </tr>

            <tr>
                <td class="info-label" style="vertical-align:top;">내용</td>
                <td>
                    <div class="comment-box">${comment.content}</div>
                </td>
            </tr>

        </tbody>
    </table>

    <!-- 버튼 -->
    <div style="text-align:right; margin-top:30px;">

        <!-- 삭제 -->
        <form method="post" action="${pageContext.request.contextPath}/admin/adminCommentDelete"
              style="display:inline-block;"
              onsubmit="return confirm('정말 삭제하시겠습니까?');">

            <input type="hidden" name="comment_id" value="${comment.comment_id}">
            <button class="btn-red">삭제</button>
        </form>

        <!-- 목록 -->
        <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList'">
            목록으로
        </button>
    </div>

</div>
</div>

</body>
</html>
