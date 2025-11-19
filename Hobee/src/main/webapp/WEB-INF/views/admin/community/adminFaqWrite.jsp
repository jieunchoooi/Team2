<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 작성 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqWrite.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header">
        <h1>FAQ 작성</h1>
    </div>

    <div class="form-card">

        <form action="${pageContext.request.contextPath}/admin/adminFaqWritePro"
              method="post">

            <div class="form-group">
                <label>카테고리</label>
                <select name="category" required>
                    <option value="">선택</option>
                    <option value="계정">계정</option>
                    <option value="결제">결제</option>
                    <option value="커뮤니티">커뮤니티</option>
                    <option value="수업">수업</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <div class="form-group">
                <label>질문</label>
                <input type="text" name="question" required>
            </div>

            <div class="form-group">
                <label>공개 여부</label>
                <select name="is_visible">
                    <option value="1">공개</option>
                    <option value="0">숨김</option>
                </select>
            </div>

            <div class="form-group">
                <label>답변</label>
                <textarea name="answer" required></textarea>
            </div>

            <div class="btn-area">
                <button class="btn-blue" type="submit">등록하기</button>

                <button class="btn-gray" type="button"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                    목록
                </button>
            </div>

        </form>
    </div>

</main>

</body>
</html>
