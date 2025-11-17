<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 상세보기 | Hobee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/payment.css">
</head>

<body>

<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="main-content">

<h1>결제 상세정보</h1>

<!-- 주문 카드 -->
<div class="payment-detail-box">

	<h2>주문번호: ${payment.merchant_uid}</h2>

	<table class="info-table">

		<tr>
			<th>결제 금액</th>
			<td>₩ <fmt:formatNumber value="${payment.amount}" type="number" /></td>
		</tr>

		<tr>
			<th>사용 포인트</th>
			<td><fmt:formatNumber value="${payment.used_points}" /> P</td>
		</tr>

		<tr>
			<th>적립 포인트</th>
			<td><fmt:formatNumber value="${payment.saved_points}" /> P</td>
		</tr>

		<tr>
			<th>결제 상태</th>
			td>
				<c:choose>
					<c:when test="${payment.status eq 'paid'}">
						<span class="status paid">결제완료</span>
					</c:when>
					<c:when test="${payment.status eq 'cancelled'}">
						<span class="status cancelled">결제취소</span>
					</c:when>
				</c:choose>
			</td>
		</tr>

		<tr>
			<th>결제일</th>
			<td><fmt:formatDate value="${payment.created_at}" pattern="yyyy-MM-dd HH:mm" /></td>
		</tr>

		<tr>
			<th>강의 목록</th>
			<td>${payment.lectureTitles}</td>
		</tr>

	</table>

	<!-- 환불 버튼 -->
	<c:choose>
		<c:when test="${payment.refundable}">
			<button class="btn-refund"
				onclick="location.href='${pageContext.request.contextPath}/payment/refund?payment_id=${payment.payment_id}'">
				결제 취소
			</button>
		</c:when>
		<c:otherwise>
			<button class="btn-refund disabled" disabled>
				취소 불가 (3일 초과)
			</button>
		</c:otherwise>
	</c:choose>

</div>



<!-- 🔥 포인트 변동 내역 -->
<c:if test="${not empty payment.pointHistoryList}">
<div class="point-history-box">

	<h2>포인트 변동 내역</h2>

	<c:forEach var="p" items="${payment.pointHistoryList}">
		
		<div class="ph-row">

			<!-- + / - 포인트 표시 -->
			<span class="ph-point 
				<c:if test='${p.point_change > 0}'>plus</c:if>
				<c:if test='${p.point_change < 0}'>minus</c:if>
			">
				<fmt:formatNumber value="${p.point_change}" /> P
			</span>

			<!-- 설명 -->
			<span class="ph-desc">${p.description}</span>

			<!-- 날짜 -->
			<span class="ph-date">
				<fmt:formatDate value="${p.created_at}" pattern="yyyy-MM-dd HH:mm" />
			</span>

		</div>

	</c:forEach>

</div>
</c:if>

</main>

</body>
</html>
