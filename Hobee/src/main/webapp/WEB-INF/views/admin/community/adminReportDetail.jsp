<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 상세 | Hobee Admin</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 신고 상세 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminReportDetail.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- 전체 컨테이너 -->
<div class="detail-container">

    <!-- 🔥 제목 (왼쪽 고정) -->
    <div class="detail-title-wrapper">
        <h1 class="detail-title">신고 상세</h1>
    </div>

    <!-- 🔥 아래는 모두 가운데 정렬 -->
    <div class="detail-center-wrapper">

        <!-- =============================
             신고 기본 정보 박스
        ============================== -->
        <div class="info-box">

            <div class="info-row"><strong>신고 번호</strong> ${report.report_id}</div>
            <div class="info-row"><strong>신고자</strong> ${report.reporter_id}</div>

            <div class="info-row">
                <strong>신고 유형</strong>
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
                    <c:when test="${report.is_done == 1}">
                        <span style="color:#397dff; font-weight:700;">완료</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color:#e74a3b; font-weight:700;">대기</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-row">
                <strong>처리 일시</strong>
                <c:choose>
                    <c:when test="${empty report.done_at}">-</c:when>
                    <c:otherwise>${report.done_at}</c:otherwise>
                </c:choose>
            </div>

            <c:if test="${report.is_done == 1}">
                <div class="info-row">
                    <strong>처리 사유</strong> ${report.done_reason}
                </div>
            </c:if>

        </div>


        <!-- =============================
             처리 사유 선택 + 처리 버튼
        ============================== -->
        <c:if test="${report.is_done != 1}">
            <form action="${pageContext.request.contextPath}/admin/adminReportDone"
                  method="post"
                  onsubmit="return confirm('해당 신고를 처리하시겠습니까?');">

                <input type="hidden" name="report_id" value="${report.report_id}">

                <div class="info-row">
                    <strong>처리 사유</strong>
                    <select name="done_reason" class="done-select">
                        <option value="경고">경고</option>
                        <option value="게시글 삭제">게시글 삭제</option>
                        <option value="댓글 삭제">댓글 삭제</option>
                        <option value="계정 정지">계정 정지</option>
                        <option value="기타">기타</option>
                    </select>
                </div>

                <button class="btn-red process-btn">처리 완료</button>
            </form>
        </c:if>


        <!-- =============================
             게시글 원문
        ============================== -->
        <c:if test="${report.post_id ne null}">
            <div class="preview-box">
                <h3>📄 게시글 원문</h3>
                <div class="info-row"><strong>제목</strong> ${report.post_title}</div>
                <div class="preview-content">${report.post_content}</div>
            </div>
        </c:if>

        <!-- =============================
             댓글 원문
        ============================== -->
        <c:if test="${report.comment_id ne null}">
            <div class="preview-box">
                <h3>💬 댓글 원문</h3>
                <div class="preview-content">${report.comment_content}</div>
            </div>
        </c:if>

        <!-- =============================
             목록 버튼
        ============================== -->
        <div class="btn-wrapper">
            <button class="back-btn"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminReportList'">
                ← 목록으로 돌아가기
            </button>
        </div>

    </div>
</div>

</body>
</html>
