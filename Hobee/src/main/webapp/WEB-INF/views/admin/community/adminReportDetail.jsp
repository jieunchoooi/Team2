<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>신고 상세 | Hobee Admin</title>

<link rel="stylesheet" 
      href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/adminReportDetail.css">

</head>
<body>

<!-- 공통 상단 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 공통 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 -->
<main class="main-content">

	<div class="main-header">
		<h1>신고 상세</h1>
	</div>

	<div class="detail-card">

		<div class="detail-section">

			<div class="detail-row">
				<span class="detail-label">신고 ID</span>
				<span class="detail-value">${report.report_id}</span>
			</div>

			<div class="detail-row">
				<span class="detail-label">신고자</span>
				<span class="detail-value">${report.reporter_id}</span>
			</div>

			<div class="detail-row">
				<span class="detail-label">대상</span>
				<span class="detail-value">
					<c:choose>
						<c:when test="${report.post_id ne null}">
							게시글 #${report.post_id}
						</c:when>
						<c:when test="${report.comment_id ne null}">
							댓글 #${report.comment_id}
						</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
				</span>
			</div>

			<div class="detail-row">
				<span class="detail-label">신고 내용</span>
				<span class="detail-value">${report.reason}</span>
			</div>

			<div class="detail-row">
				<span class="detail-label">신고일</span>
				<span class="detail-value">${report.created_at}</span>
			</div>

			<div class="detail-row">
				<span class="detail-label">상태</span>
				<span class="detail-value">
					<c:choose>
						<c:when test="${report.is_done == 1}">
							<span class="status-badge done">완료</span>
						</c:when>
						<c:otherwise>
							<span class="status-badge wait">대기</span>
						</c:otherwise>
					</c:choose>
				</span>
			</div>
		</div>

		<!-- 버튼 영역 -->
		<div class="button-area">

			<c:if test="${report.is_done == 0}">
				<form action="${pageContext.request.contextPath}/admin/adminReportDone"
				      method="post"
				      onsubmit="return confirm('신고를 처리 완료로 변경하시겠습니까?');">
					<input type="hidden" name="report_id" value="${report.report_id}">
					<button class="btn-blue">처리 완료</button>
				</form>
			</c:if>

			<button class="btn-gray"
			        onclick="location.href='${pageContext.request.contextPath}/admin/adminReportList'">
				목록으로
			</button>
		</div>

	</div>

</main>

</body>
</html>
