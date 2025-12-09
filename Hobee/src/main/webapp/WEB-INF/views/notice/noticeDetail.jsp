<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${notice.title} | Hobee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/noticeDetail.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="notice-detail-container">

    <h1 class="detail-title">${notice.title}</h1>

    <div class="detail-info">
        <span>작성일: ${notice.created_at}</span>
        <span>조회수: ${notice.view_count}</span>
        <span class="priority-badge p-${notice.priority}">
            <c:choose>
                <c:when test="${notice.priority == 4}">긴급</c:when>
                <c:when test="${notice.priority == 3}">매우 중요</c:when>
                <c:when test="${notice.priority == 2}">중요</c:when>
                <c:otherwise>일반</c:otherwise>
            </c:choose>
        </span>
    </div>

    <div class="detail-content">
        ${notice.content}
    </div>

    <c:if test="${!empty files}">
        <div class="file-area">
            <h3>첨부파일</h3>
            <c:forEach var="f" items="${files}">
                <a href="${pageContext.request.contextPath}/notice/fileDownload?file=${f.file_name}">
                    📎 ${f.file_name}
                </a><br>
            </c:forEach>
        </div>
    </c:if>

    <button onclick="location.href='${pageContext.request.contextPath}/notice/list'" class="btn-back">
        목록으로
    </button>

</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

</body>
</html>
