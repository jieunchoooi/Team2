<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${notice.title} | Hobee</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/noticeDetail.css">
</head>

<body>

<div class="detail-wrap">

    <!-- 제목 + 중요도 -->
    <div class="detail-header">
        <h2 class="detail-title">${notice.title}</h2>

        <c:choose>
            <c:when test="${notice.priority == 4}">
                <span class="badge-priority priority-4">🔥 긴급</span>
            </c:when>
            <c:when test="${notice.priority == 3}">
                <span class="badge-priority priority-3">매우 중요</span>
            </c:when>
            <c:when test="${notice.priority == 2}">
                <span class="badge-priority priority-2">중요</span>
            </c:when>
            <c:otherwise>
                <span class="badge-priority priority-1">일반</span>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 날짜, 조회수 -->
    <div class="detail-info">
        <span>작성일 : ${fn:substring(notice.created_at, 0, 10)}</span>
        <span>조회수 : ${notice.view_count}</span>
    </div>

    <hr class="detail-line"/>

    <!-- 내용 -->
    <div class="detail-content">
        ${notice.content}
    </div>

    <!-- 목록 버튼 -->
    <div class="detail-bottom">
        <a href="${pageContext.request.contextPath}/notice/list" class="detail-back-btn">← 목록으로</a>
    </div>

</div>

</body>
</html>
