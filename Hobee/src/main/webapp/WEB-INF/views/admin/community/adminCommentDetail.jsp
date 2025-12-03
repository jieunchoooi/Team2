<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>댓글 상세보기 | Hobee Admin</title>

    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCommentDetail.css">

    
</head>

<body>

<!-- 공통 상단 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- 메인 콘텐츠 -->
<main class="main-content">

    <div class="main-header">
        <h1>댓글 상세보기</h1>
    </div>
<div class="detail-card">

    <!-- 기본 정보 -->
    <div class="detail-section">
        <div class="detail-row">
            <span class="label">댓글 ID</span>
            <span class="value">${comment.comment_id}</span>
        </div>

        <div class="detail-row">
            <span class="label">게시글 제목</span>
            <span class="value">
                <a class="title-link"
                   href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${comment.post_id}">
                    ${comment.post_title}
                </a>
            </span>
        </div>

        <div class="detail-row">
            <span class="label">작성자</span>
            <span class="value">${comment.user_id}</span>
        </div>

        <div class="detail-row">
            <span class="label">등록일</span>
            <span class="value">${comment.created_at}</span>
        </div>

        <div class="detail-row">
            <span class="label">신고 횟수</span>
            <span class="value">
                <c:choose>
                    <c:when test="${comment.report_count == 0}">
                        <span class="badge green">${comment.report_count}</span>
                    </c:when>
                    <c:when test="${comment.report_count <= 2}">
                        <span class="badge yellow">${comment.report_count}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge red">${comment.report_count}</span>
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>

    <!-- 내용 -->
    <div class="detail-section">
        <h3>내용</h3>
        <div class="content-box">
            ${fn:escapeXml(comment.content)}
        </div>
    </div>

    <!-- 신고 내역 -->
    <div class="detail-section">
        <h3>신고 내역</h3>

        <c:if test="${empty reportList}">
            <div class="content-box" style="background:#fff7f7; border:1px solid #ffd1d1;">
                신고 내역이 없습니다.
            </div>
        </c:if>

        <c:forEach var="r" items="${reportList}">
            <div class="content-box" style="margin-bottom:15px; background:#f7f9ff; border:1px solid #dce3ff;">
                <p><b>신고자:</b> ${r.reporter_id}</p>
                <p><b>사유:</b> ${r.reason}</p>
                <p><b>신고 일시:</b> ${r.created_at}</p>
            </div>
        </c:forEach>
    </div>

    <!-- 관리자 로그 -->
    <div class="detail-section">
        <h3>관리자 처리 로그</h3>

        <c:if test="${empty actionLogs}">
            <div class="content-box" style="background:#fff3cd; border:1px solid #ffeeba;">
                관리자 조치 이력이 없습니다.
            </div>
        </c:if>

        <c:forEach var="log" items="${actionLogs}">
            <div class="content-box" style="margin-bottom:12px;">
                <p><b>관리자:</b> ${log.admin_id}</p>
                <p><b>조치:</b> ${log.action}</p>
                <p><b>사유:</b> ${log.reason}</p>
                <p><b>일시:</b> ${log.created_at}</p>
            </div>
        </c:forEach>
    </div>

    <!-- 버튼 -->
    <div class="btn-area">
        <button class="btn-back"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList'">
            목록으로
        </button>

        <button class="btn-blue"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${comment.post_id}'">
            게시글 보기
        </button>

        <c:if test="${comment.is_deleted == 0}">
            <form action="${pageContext.request.contextPath}/admin/adminCommentDelete"
                  method="post"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="comment_id" value="${comment.comment_id}">
                <button class="btn-delete">댓글 삭제</button>
            </form>
        </c:if>

        <c:if test="${comment.is_deleted == 1}">
            <form action="${pageContext.request.contextPath}/admin/adminCommentRestore" method="post"
                  onsubmit="return confirm('댓글을 복구하시겠습니까?');">
                <input type="hidden" name="comment_id" value="${comment.comment_id}">
                <button class="btn-green">복구하기</button>
            </form>
        </c:if>
    </div>

</div>

</main>

</body>
</html>
