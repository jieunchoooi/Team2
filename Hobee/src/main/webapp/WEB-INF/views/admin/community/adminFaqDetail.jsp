<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 상세</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- FAQ 상세 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminFaqDetail.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="faqList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>❓ FAQ 상세</h2>

    <!-- 상단 정보 카드 -->
    <div class="post-info-card">
        <div class="post-info-title">📌 FAQ 정보</div>
        <div style="margin-top:8px; color:#556;">
            카테고리: <b>${faq.category}</b>
        </div>
    </div>

    <table class="faq-detail-table">
        <tbody>

            <tr>
                <td class="info-label">FAQ 번호</td>
                <td>${faq.faq_id}</td>
            </tr>

            <tr>
                <td class="info-label">카테고리</td>
                <td>${faq.category}</td>
            </tr>

            <tr>
                <td class="info-label">질문</td>
                <td>${faq.question}</td>
            </tr>

            <tr>
                <td class="info-label">공개 여부</td>
                <td>
                    <span class="${faq.is_visible == 1 ? 'visible-on' : 'visible-off'}">
                        ${faq.is_visible == 1 ? '공개' : '숨김'}
                    </span>
                </td>
            </tr>

            <tr>
                <td class="info-label">등록일</td>
                <td>${faq.created_at}</td>
            </tr>

            <tr>
                <td class="info-label" style="vertical-align:top;">답변</td>
                <td>
                    <div class="faq-answer-box">${faq.answer}</div>
                </td>
            </tr>

        </tbody>
    </table>

    <!-- 버튼 -->
    <div style="text-align:right; margin-top:30px;">

        <!-- 수정 -->
        <button class="btn-blue"
            onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqEdit?faq_id=${faq.faq_id}'">
            수정
        </button>

        <!-- 삭제 -->
        <form action="${pageContext.request.contextPath}/admin/adminFaqDelete"
              method="post"
              style="display:inline-block;"
              onsubmit="return confirm('정말 삭제하시겠습니까?');">
            <input type="hidden" name="faq_id" value="${faq.faq_id}">
            <button class="btn-red">삭제</button>
        </form>

        <!-- 목록 -->
        <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
            목록으로
        </button>

    </div>

</div>
</div>

</body>
</html>
