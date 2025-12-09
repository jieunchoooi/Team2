<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostDeletedList.css?v=5">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>

<!-- 공통 header / sidebar -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="card-box">

        <table class="styled-table">
            <thead>
                <tr>
                    <th class="col-no">No</th>
                    <th class="col-title">제목</th>
                    <th class="col-writer">작성자</th>
                    <th class="col-board">머리말</th>
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

                        <td class="col-title title-cell">
                            <a href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${post.post_id}">
                                ${post.title}
                            </a>
                        </td>

                        <td class="col-writer">${post.author}</td>
                        <td class="col-board">${post.board_name}</td>
                        <td class="col-date">${post.created_at}</td>
                        <td class="col-views">${post.views}</td>

                        <!-- ⭐ 버튼 가로 정렬 완성본 -->
                        <td class="col-manage">
                            <div class="btn-group">

                                <!-- 복구 -->
                                <form action="${pageContext.request.contextPath}/admin/adminPostRestoreFromTrash" method="post">
                                    <input type="hidden" name="post_id" value="${post.post_id}">
                                    <button class="btn-green">복구</button>
                                </form>

                                <!-- 영구 제거 -->
                                <form action="${pageContext.request.contextPath}/admin/adminPostDeletePermanent"
                                      method="post"
                                      onsubmit="return confirm('정말 영구 삭제하시겠습니까? 복구할 수 없습니다.');">
                                    <input type="hidden" name="post_id" value="${post.post_id}">
                                    <button class="btn-red">영구삭제</button>
                                </form>

                            </div>
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

<script>
<c:if test="${restored}">
    Toastify({
        text: "게시글이 복구되었습니다!",
        duration: 2500,
        gravity: "top",
        position: "right",
        backgroundColor: "#2ecf8f",
    }).showToast();
</c:if>
</script>

</body>
</html>
