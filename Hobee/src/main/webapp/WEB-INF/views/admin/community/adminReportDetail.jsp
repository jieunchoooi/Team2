<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>신고 상세보기</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminReportDetail.css">

</head>
<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="reportList"/>
</jsp:include>


<!-- 중앙 정렬 컨테이너 -->
<div class="admin-detail-container">

    <div class="detail-card">

        <h2>🚨 신고 상세</h2>

        <!-- 신고 번호 -->
        <div class="detail-row">
            <span class="key">신고 번호</span>
            <span class="value">${report.report_id}</span>
        </div>

        <!-- 신고자 -->
        <div class="detail-row">
            <span class="key">신고자</span>
            <span class="value">${report.reporter_id}</span>
        </div>

        <!-- 신고 대상 -->
        <div class="detail-row">
            <span class="key">신고 대상</span>
            <span class="value">
                <c:choose>
                    <c:when test="${report.post_id != null}">
                        게시글 #${report.post_id}
                    </c:when>
                    <c:when test="${report.comment_id != null}">
                        댓글 #${report.comment_id}
                    </c:when>
                    <c:otherwise>
                        -
                    </c:otherwise>
                </c:choose>
            </span>
        </div>

        <!-- 신고일 -->
        <div class="detail-row">
            <span class="key">신고일</span>
            <span class="value">${report.created_at}</span>
        </div>

        <!-- 신고 사유 -->
        <div class="detail-row">
            <span class="key">신고 사유</span>
            <div class="value reason-box">
                ${report.reason}
            </div>
        </div>

        <!-- 신고된 내용 -->
        <div class="detail-row">
            <span class="key">대상 내용</span>
            <div class="value content-box">

                <c:choose>
                    <c:when test="${report.post_id != null}">
                        <div class="content-title">📄 게시글 제목</div>
                        <div class="content-detail">${report.post_title}</div>
                    </c:when>

                    <c:when test="${report.comment_id != null}">
                        <div class="content-title">💬 댓글 내용</div>
                        <div class="content-detail">${report.comment_content}</div>
                    </c:when>

                    <c:otherwise>
                        내용 없음
                    </c:otherwise>
                </c:choose>

            </div>
        </div>


        <!-- 버튼 영역 -->
        <div class="btn-area">

            <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminReportList'">
                목록
            </button>

            <c:if test="${report.is_done == 0}">
                <form method="post"
                    action="${pageContext.request.contextPath}/admin/adminReportDone"
                    style="display:inline-block;">
                    <input type="hidden" name="report_id" value="${report.report_id}">
                    <button class="btn-red">처리 완료</button>
                </form>
            </c:if>

            <c:if test="${report.is_done == 1}">
                <button class="btn-blue" disabled>이미 처리됨</button>
            </c:if>

        </div>

    </div>

</div>

</body>
</html>
