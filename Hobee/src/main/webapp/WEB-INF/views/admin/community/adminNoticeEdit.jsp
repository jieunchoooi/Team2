<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 수정 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeEdit.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header">
        <h1>공지사항 수정</h1>
    </div>

    <div class="form-card">

        <form action="${pageContext.request.contextPath}/admin/adminNoticeEditPro"
              method="post">

            <input type="hidden" name="notice_id" value="${notice.notice_id}">

            <!-- 제목 -->
            <div class="form-group">
                <label>제목</label>
                <input type="text" name="title" value="${notice.title}" required>
            </div>

            <!-- 작성자 -->
            <div class="form-group">
                <label>작성자</label>
                <input type="text" value="${notice.admin_id}" readonly>
            </div>

            <!-- 공개 여부 -->
            <div class="form-group">
                <label>공개 여부</label>
                <select name="is_visible">
                    <option value="1" ${notice.is_visible == 1 ? "selected" : ""}>공개</option>
                    <option value="0" ${notice.is_visible == 0 ? "selected" : ""}>숨김</option>
                </select>
            </div>

            <!-- 내용 -->
            <div class="form-group">
                <label>내용</label>
                <textarea name="content" required>${notice.content}</textarea>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn-blue">수정 완료</button>

                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeDetail?notice_id=${notice.notice_id}'">
                    상세로
                </button>
            </div>

        </form>

    </div>

</main>

</body>
</html>
