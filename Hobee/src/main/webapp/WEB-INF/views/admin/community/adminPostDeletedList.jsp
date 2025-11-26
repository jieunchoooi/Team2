<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>삭제된 게시글 (휴지통) | Hobee Admin</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostDeletedList.css">

</head>
<body>

<!-- 공통 header / sidebar -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

	<div class="page-title">삭제된 게시글 (휴지통)</div>

	<div class="card-box">

		<table class="styled-table">
    <thead>
        <tr>
            <th class="col-no">No</th>
            <th class="col-title">제목</th>
            <th class="col-writer">작성자</th>
            <th class="col-board">게시판</th>
            <th class="col-date">등록일</th>
            <th class="col-views">조회수</th>
            <th class="col-manage">관리</th>
        </tr>
    </thead>

    <tbody>

        <c:if test="${empty deletedList}">
            <tr>
                <td colspan="7" class="no-data">삭제된 게시글이 없습니다.</td>
            </tr>
        </c:if>

        <c:forEach var="post" items="${deletedList}">
            <tr>
                <td class="col-no">${post.post_id}</td>

                <td class="title-cell col-title">
                    <a href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${post.post_id}">
                        ${post.title}
                    </a>
                </td>

                <td class="col-writer">${post.author}</td>
                <td class="col-board">${post.board_name}</td>
                <td class="col-date">${post.created_at}</td>
                <td class="col-views">${post.views}</td>

                <td class="col-manage btn-group">
                    <!-- 복구 -->
                    <form action="${pageContext.request.contextPath}/admin/adminPostRestoreFromTrash" method="post">
                        <input type="hidden" name="post_id" value="${post.post_id}">
                        <button class="btn-green">복구</button>
                    </form>

                    <!-- 영구 삭제 -->
                    <form action="${pageContext.request.contextPath}/admin/adminPostDeletePermanent" 
                          method="post"
                          onsubmit="return confirm('정말 영구 삭제하시겠습니까? 복구할 수 없습니다.');">
                        <input type="hidden" name="post_id" value="${post.post_id}">
                        <button class="btn-red">영구삭제</button>
                    </form>
                </td>
            </tr>
        </c:forEach>

    </tbody>
</table>


		<div class="back-btn-area">
			<button class="btn-gray"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
				게시글 목록으로
			</button>
		</div>

	</div>

</main>

</body>
</html>
