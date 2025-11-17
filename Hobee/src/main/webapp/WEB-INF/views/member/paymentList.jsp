<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 내역 | Hobee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/paymentList.css">


</head>

<body>

<c:if test="${not empty msg}">
<script>
    alert("${msg}");
</script>
</c:if>

<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="main-content">

<h1>결제 내역</h1>

<!-- 🔥 미니 프로필 -->
<div class="main-header">
	<div class="profile-box">
		<div class="profile-pic">
			<c:choose>
				<c:when test="${empty userVO.user_file}">
					<span>🐵</span>
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}/resources/img/user_picture/${userVO.user_file}">
				</c:otherwise>
			</c:choose>
		</div>

		<div class="profile-info">
			<p>
				<c:choose>
					<c:when test="${userVO.grade_id == 1}"><span class="badge bronze">🥉</span></c:when>
					<c:when test="${userVO.grade_id == 2}"><span class="badge silver">🥈</span></c:when>
					<c:when test="${userVO.grade_id == 3}"><span class="badge gold">🥇</span></c:when>
					<c:otherwise><span class="badge bronze">🥉</span></c:otherwise>
				</c:choose>
				${userVO.user_name}
			</p>
			<p>${userVO.user_email}</p>
			<p>🪙 <fmt:formatNumber value="${userVO.points}" type="number" /> P</p>
		</div>
	</div>
</div>

<!-- 🔥 결제 내역 리스트 -->
<div class="payment-list">

	<c:choose>
		<c:when test="${empty paymentList}">
			<p class="empty-text">결제 내역이 없습니다.</p>
		</c:when>

		<c:otherwise>

			<c:forEach var="pay" items="${paymentList}">
				<div class="payment-card">

					<div class="left">
						<p class="merchant">주문번호: ${pay.merchant_uid}</p>
						<p class="lecture-title">${pay.lectureTitles}</p>
						<p class="price">₩ <fmt:formatNumber value="${pay.amount}" type="number" /></p>
						<p class="date"><fmt:formatDate value="${pay.created_at}" pattern="yyyy-MM-dd HH:mm" /></p>
					</div>

					<div class="right">

						<!-- 상태 표시 -->
						<c:choose>
							<c:when test="${pay.status eq 'paid'}">
								<span class="status paid">결제완료</span>
							</c:when>
							<c:when test="${pay.status eq 'cancelled'}">
								<span class="status cancelled">환불완료</span>
							</c:when>
							<c:otherwise>
								<span class="status unknown">기타</span>
							</c:otherwise>
						</c:choose>

						<!-- 상세페이지 이동 -->
						<a class="detail-link"
						   href="${pageContext.request.contextPath}/member/payment?payment_id=${pay.payment_id}">
						   상세보기 →
						</a>

						<!-- 환불 버튼 처리 -->
						<c:choose>

							<%-- 이미 취소된 결제 --%>
							<c:when test="${pay.status eq 'cancelled'}">
								<button class="btn-refund disabled" disabled>환불완료</button>
							</c:when>

								<%-- 2) 환불 가능 --%>
							<c:when test="${pay.refundable}">
								<form action="${pageContext.request.contextPath}/payment/refund" method="post">
									<input type="hidden" name="payment_id" value="${pay.payment_id}">
									<button type="submit" class="btn-refund">결제 취소</button>
								</form>
							</c:when>

							<%-- 3) 환불 불가 --%>
							<c:otherwise>
								<button class="btn-refund disabled"
										disabled
										title="결제일 기준 3일 이후로는 환불이 불가능합니다.">
									취소 불가
								</button>
							</c:otherwise>

						</c:choose>

					</div>

				</div>
			</c:forEach>

		</c:otherwise>
	</c:choose>

</div>

</main>

</body>
</html>
