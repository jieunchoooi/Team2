<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 상세 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqDetail.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header">
        <h1>FAQ 상세</h1>
    </div>

    <div class="detail-card">

        <div class="detail-row">
            <span class="detail-label">번호</span>
            <span class="detail-value">${faq.faq_id}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">카테고리</span>
            <span class="detail-value">${faq.category}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">질문</span>
            <span class="detail-value">${faq.question}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">공개 여부</span>
            <span class="detail-value">
                <span class="${faq.is_visible==1 ? 'visible-on':'visible-off'}">
                    ${faq.is_visible==1 ? '공개':'숨김'}
                </span>
            </span>
        </div>

        <div class="detail-row">
            <span class="detail-label">답변</span>
            <div class="detail-content-area">${faq.answer}</div>
        </div>

        <div class="btn-area">
            <button class="btn-blue"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqEdit?faq_id=${faq.faq_id}'">
                수정
            </button>

            <form action="${pageContext.request.contextPath}/admin/adminFaqDelete"
                  method="post"
                  style="display:inline-block"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="faq_id" value="${faq.faq_id}">
                <button class="btn-red">삭제</button>
            </form>

            <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                목록으로
            </button>
        </div>

    </div>

</main>

</body>
</html>
