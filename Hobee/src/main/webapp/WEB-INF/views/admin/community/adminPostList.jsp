<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 관리 | Hobee Admin</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostList.css">
</head>

<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 콘텐츠 -->
<main class="main-content">

    <div class="main-header">
        <h1>게시글 관리</h1>
    </div>

    <div class="admin-card">
        <div class="table-container">

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>태그</th>
                        <th>등록일</th>
                        <th>조회수</th>
                        <th>노출</th>
                        <th>상세</th>
                        <th>삭제</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="post" items="${postList}">
                        <tr>
                            <!-- 번호 -->
                            <td>${post.post_id}</td>

                            <!-- 제목 링크 -->
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${post.post_id}"
                                   class="post-link">
                                    ${post.title}
                                </a>
                            </td>

                            <!-- 작성자 -->
                            <td>${post.author}</td>

                            <!-- 태그 -->
                            <td>${post.tag}</td>

                            <!-- 등록일 -->
                            <td>${post.created_at}</td>

                            <!-- 조회수 -->
                            <td>${post.views}</td>

                            <!-- 공개/숨김 버튼 -->
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/adminPostToggle"
                                      method="post">
                                    <input type="hidden" name="post_id" value="${post.post_id}">
                                    <button class="${post.is_visible == 1 ? 'btn-blue' : 'btn-gray'}">
                                        ${post.is_visible == 1 ? '공개' : '숨김'}
                                    </button>
                                </form>
                            </td>

                            <!-- 상세 버튼 -->
                            <td>
                                <button class="btn-blue"
                                        onclick="location.href='${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${post.post_id}'">
                                    상세
                                </button>
                            </td>

                            <!-- 삭제 버튼 -->
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/adminPostDelete"
                                      method="post"
                                      onsubmit="return confirm('삭제하시겠습니까?');">
                                    <input type="hidden" name="post_id" value="${post.post_id}">
                                    <button class="btn-red">삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</main>

</body>
</html>
