<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>댓글 관리</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="commentList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>💬 댓글 관리</h2>

    <table>
        <thead>
            <tr>
                <th width="60">No</th>
                <th width="220">게시글 제목</th>
                <th width="120">작성자</th>
                <th>내용</th>
                <th width="150">등록일</th>
                <th width="80">신고</th>
                <th width="80">상세</th>
                <th width="80">삭제</th>
            </tr>
        </thead>

        <tbody>

        <c:if test="${empty commentList}">
            <tr>
                <td colspan="8" style="text-align:center; padding:20px;">
                    등록된 댓글이 없습니다.
                </td>
            </tr>
        </c:if>

        <c:forEach var="c" items="${commentList}">
            <tr>
                <td>${c.comment_id}</td>

                <!-- 게시글 제목 -->
                <td>
                    <a href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${c.post_id}"
                       style="color:#2f6bff; font-weight:600; text-decoration:none;">
                        ${c.post_title}
                    </a>
                </td>

                <td>${c.user_id}</td>

                <!-- 댓글 내용 축약 -->
                <td>
                    <c:choose>
                        <c:when test="${fn:length(c.content) > 45}">
                            ${fn:substring(c.content, 0, 45)}...
                        </c:when>
                        <c:otherwise>
                            ${c.content}
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>${c.created_at}</td>

                <!-- 신고 횟수 -->
                <td>
                    <span class="btn-red" style="padding:5px 12px;">
                        ${c.report_count}
                    </span>
                </td>

                <!-- 상세 페이지 이동 -->
                <td>
                    <button class="btn-blue"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentDetail?comment_id=${c.comment_id}'">
                        상세
                    </button>
                </td>

                <!-- 삭제 -->
                <td>
                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/adminCommentDelete"
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
</div>

</body>
</html>
