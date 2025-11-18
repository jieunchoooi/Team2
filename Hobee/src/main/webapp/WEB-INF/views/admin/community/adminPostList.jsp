<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 관리</title>

<!-- 공통 관리자 레이아웃 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

</head>
<body>

<!-- 공통 관리자 사이드바 포함 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 카드 형태 메인 콘텐츠 시작 -->
<div class="admin-main">
    <div class="admin-card">

    <h2>📄 게시글 관리</h2>

    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>제목</th>
                <th>작성자</th>
                <th>태그</th>
                <th>등록일</th>
                <th>조회수</th>
                <th>노출</th>
                <th>삭제</th>
            </tr>
        </thead>

        <tbody>

        <!-- 게시글이 없을 때 -->
        <c:if test="${empty postList}">
            <tr>
                <td colspan="8" style="padding:20px; text-align:center;">
                    등록된 게시글이 없습니다.
                </td>
            </tr>
        </c:if>

        <!-- 게시글 목록 출력 -->
        <c:forEach var="post" items="${postList}">
            <tr>
                <td>${post.post_id}</td>

                <!-- 제목 클릭 → 상세 페이지 -->
                <td>
                    <a href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${post.post_id}"
                       style="color:#2f6bff; font-weight:600; text-decoration:none;">
                        ${post.title}
                    </a>
                </td>

                <td>${post.author}</td>
                <td>${post.tag}</td>
                <td>${post.created_at}</td>
                <td>${post.views}</td>

                <!-- 공개/숨김 -->
                <td>
                    <form action="${pageContext.request.contextPath}/admin/adminPostToggle" method="post">
                        <input type="hidden" name="post_id" value="${post.post_id}">
                        <button class="${post.is_visible == 1 ? 'btn-blue' : 'btn-gray'}">
                            ${post.is_visible == 1 ? '공개' : '숨김'}
                        </button>
                    </form>
                </td>

                <!-- 삭제 -->
                <td>
                    <form action="${pageContext.request.contextPath}/admin/adminPostDelete" method="post"
                          onsubmit="return confirm('정말 삭제하시겠습니까?');">
                        <input type="hidden" name="post_id" value="${post.post_id}">
                        <button class="btn-red">삭제</button>
                    </form>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
<!-- ⭐ 카드 형태 메인 콘텐츠 종료 -->

</body>
</html>
