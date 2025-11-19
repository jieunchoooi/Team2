<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>댓글 관리 | Hobee Admin</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCommentList.css">
</head>

<body>

<!-- 공통 상단 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 콘텐츠 시작 -->
<main class="main-content">

    <div class="main-header">
        <h1>댓글 관리</h1>
    </div>

    <div class="table-card">

        <table class="admin-table">
            <thead>
                <tr>
                    <th>No</th>
                    <th>게시글 제목</th>
                    <th>작성자</th>
                    <th>내용</th>
                    <th>등록일</th>
                    <th>신고</th>
                    <th>상세</th>
                    <th>삭제</th>
                </tr>
            </thead>

            <tbody>

            <c:if test="${empty commentList}">
                <tr>
                    <td colspan="8" class="empty-text">
                        등록된 댓글이 없습니다.
                    </td>
                </tr>
            </c:if>

            <c:forEach var="c" items="${commentList}">
                <tr>
                    <td>${c.comment_id}</td>

                    <td>
                        <a class="title-link"
                           href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${c.post_id}">
                            ${c.post_title}
                        </a>
                    </td>

                    <td>${c.user_id}</td>

                    <td>
                        <c:choose>
                            <c:when test="${fn:length(c.content) > 40}">
                                ${fn:substring(c.content, 0, 40)}...
                            </c:when>
                            <c:otherwise>
                                ${c.content}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>${c.created_at}</td>

                    <td>
                        <span class="btn-red small">${c.report_count}</span>
                    </td>

                    <td>
                        <button class="btn-blue"
                            onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentDetail?comment_id=${c.comment_id}'">
                            상세
                        </button>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/admin/adminCommentDelete"
                              method="post"
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">

                            <input type="hidden" name="comment_id" value="${c.comment_id}">
                            <button class="btn-red">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>

    </div>
</main>

</body>
</html>
