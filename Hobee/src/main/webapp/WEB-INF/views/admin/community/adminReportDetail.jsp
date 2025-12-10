<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <!-- 공통 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 신고 상세 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminReportDetail.css?v=23001">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<div class="detail-container">
<div class="detail-wrapper">

    <!-- 기본 정보 -->
    <div class="info-box">

        <div class="info-row"><strong>신고 번호</strong> ${report.report_id}</div>
        <div class="info-row"><strong>신고자</strong> ${report.user_id} (${report.user_name})</div>


        <div class="info-row">
            <strong>유형</strong>
            <c:choose>
                <c:when test="${report.post_id ne null}">게시글 신고</c:when>
                <c:when test="${report.comment_id ne null}">댓글 신고</c:when>
            </c:choose>
        </div>

        <div class="info-row"><strong>신고 사유</strong> ${report.reason}</div>
        <div class="info-row"><strong>신고 일시</strong> ${report.created_at}</div>

        <div class="info-row">
            <strong>처리 상태</strong>
            <c:choose>
                <c:when test="${report.is_done == 1}"><span class="status done">완료</span></c:when>
                <c:when test="${report.is_done == 2}"><span class="status reject">반려</span></c:when>
                <c:otherwise><span class="status wait">대기</span></c:otherwise>
            </c:choose>
        </div>

        <div class="info-row">
            <strong>처리 일시</strong>
            <c:choose>
                <c:when test="${empty report.done_at}">-</c:when>
                <c:otherwise>${report.done_at}</c:otherwise>
            </c:choose>
        </div>
    </div>


    <!-- 처리/반려 영역 -->
    <c:if test="${report.is_done == 0}">

        <!-- 처리 -->
        <!-- 처리 -->
<form class="process-card"
      action="${pageContext.request.contextPath}/admin/adminReportProcess"
      method="post">

    <input type="hidden" name="report_id" value="${report.report_id}">
    <input type="hidden" name="action" value="ACCEPT">

    <div class="info-row action-row">
        <strong>처리 사유</strong>
        <select name="admin_reason" required>
            <option value="경고">경고</option>
            <option value="게시글 삭제">게시글 삭제</option>
            <option value="댓글 삭제">댓글 삭제</option>
            <option value="계정 정지">계정 정지</option>
            <option value="기타">기타</option>
        </select>
        <button class="btn-blue" type="submit">처리 완료</button>
    </div>
</form>

<!-- 반려 -->
<form class="process-card"
      action="${pageContext.request.contextPath}/admin/adminReportProcess"
      method="post">

    <input type="hidden" name="report_id" value="${report.report_id}">
    <input type="hidden" name="action" value="REJECT">

    <div class="info-row action-row">
        <strong>반려 사유</strong>
        <input type="text" name="admin_reason" placeholder="반려 사유 입력" required>
        <button class="btn-gray" type="submit">신고 반려</button>
    </div>
</form>


    </c:if>


    <!-- 게시글 원문 -->
    <c:if test="${report.post_id ne null}">
        <div class="preview-box">
            <h3>📄 게시글 원문</h3>
            <div class="info-row"><strong>제목</strong> ${report.post_title}</div>
            <div class="preview-content">${report.post_content}</div>
        </div>
    </c:if>

    <!-- 댓글 원문 -->
    <c:if test="${report.comment_id ne null}">
        <div class="preview-box">
            <h3>💬 댓글 원문</h3>
            <div class="preview-content">${report.comment_content}</div>
        </div>
    </c:if>


    <!-- 처리 로그 -->
    <div class="preview-box">
        <h3>📝 처리 로그</h3>

        <c:if test="${empty actionLogs}">
            <div class="preview-content empty-log">처리 로그가 없습니다.</div>
        </c:if>

        <c:forEach var="log" items="${actionLogs}">
            <div class="preview-content log-item">
                <p><b>관리자:</b> ${log.admin_id}</p>
                <p><b>조치:</b> ${log.action}</p>
                <p><b>사유:</b> ${log.reason}</p>
                <p><b>시간:</b> ${log.created_at}</p>
            </div>
        </c:forEach>
    </div>


    <!-- 뒤로가기 -->
    <button class="back-btn"
            onclick="location.href='${pageContext.request.contextPath}/admin/adminReportList'">
        ← 목록으로 돌아가기
    </button>

</div>
</div>

</body>
</html>
