<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 작성 | Hobee Admin</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 공지 작성 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeWrite.css">
</head>

<body>

<!-- 상단 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 -->
<main class="main-content">

    <div class="main-header">
        <h1>공지사항 작성</h1>
    </div>

    <div class="form-card">

        <form action="${pageContext.request.contextPath}/admin/adminNoticeWritePro"
              method="post">

            <!-- 제목 -->
            <div class="form-group">
                <label>제목</label>
                <input type="text" name="title" required>
            </div>

            <!-- 작성자 -->
            <div class="form-group">
                <label>작성자</label>
                <input type="text" name="admin_id" value="admin" readonly>
            </div>

            <!-- 공개 여부 -->
            <div class="form-group">
                <label>공개 여부</label>
                <select name="is_visible" required>
                    <option value="1">공개</option>
                    <option value="0">숨김</option>
                </select>
            </div>

            <!-- 내용 -->
            <div class="form-group">
                <label>내용</label>
                <textarea name="content" required></textarea>
            </div>

            <div class="btn-area">
                <button class="btn-blue" type="submit">등록하기</button>
                <button class="btn-gray" type="button"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeList'">
                    목록
                </button>
            </div>

        </form>

    </div>
</main>

</body>
</html>
