<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 | Hobee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/noticeList.css">
</head>

<body>

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="notice-container">

    <h1 class="notice-title">공지사항</h1>

    <table class="notice-table">
        <thead>
        <tr>
            <th>No</th>
            <th>제목</th>
            <th>작성일</th>
            <th>중요도</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="n" items="${noticeList}">
            <tr onclick="location.href='${pageContext.request.contextPath}/notice/detail?notice_id=${n.notice_id}'">

                <td>${n.notice_id}</td>

                <td class="title">
                    <a class="title-link"
                       href="${pageContext.request.contextPath}/notice/detail?notice_id=${n.notice_id}">
                        <c:if test="${n.is_pinned == 1}">
                            📌
                        </c:if>
                        ${n.title}
                    </a>
                </td>

                <td>${n.created_at}</td>

                <td>
                    <span class="priority p-${n.priority}">
                        <c:choose>
                            <c:when test="${n.priority == 4}">긴급</c:when>
                            <c:when test="${n.priority == 3}">매우 중요</c:when>
                            <c:when test="${n.priority == 2}">중요</c:when>
                            <c:otherwise>일반</c:otherwise>
                        </c:choose>
                    </span>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

</body>
</html>
