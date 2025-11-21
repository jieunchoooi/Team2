<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정 | Hobee Admin</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostEdit.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="page-title">게시글 수정</div>

    <div class="card-box">

        <form action="${pageContext.request.contextPath}/admin/adminPostEditPro" method="post">

            <input type="hidden" name="post_id" value="${post.post_id}">

            <div class="edit-row">
                <label>제목</label>
                <input type="text" name="title" value="${post.title}" required class="edit-input">
            </div>

            <div class="edit-row">
                <label>내용</label>
                <textarea name="content" required class="edit-textarea">${post.content}</textarea>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn-blue">수정 완료</button>

                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${post.post_id}'">
                    취소
                </button>
            </div>

        </form>

    </div>

</main>

</body>
</html>
