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

<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="main-content">


<div class="payment-list">

<c:choose>
<c:when test="${empty paymentList}">
    <p class="empty-text">결제 내역이 없습니다.</p>
</c:when>

<c:otherwise>

<c:forEach var="pay" items="${paymentList}">

    <%-- 🔥 카드 전체 --%>
    <div class="payment-card">

        <div class="left">

            <%-- 주문번호 (맨 위) --%>
            <p class="order-no">주문번호: ${pay.merchant_uid}</p>

            <%-- 날짜 + 상태 (한 줄로) --%>
<p class="date-status">
    <fmt:formatDate value="${pay.created_at}" pattern="yyyy-MM-dd HH:mm" />
    &nbsp;:&nbsp;
    <c:choose>
        <c:when test="${pay.status eq 'paid'}">
            <span class="status-text status-paid">결제완료</span>
        </c:when>
        <c:when test="${pay.status eq 'cancelled'}">
            <span class="status-text status-cancelled">환불완료</span>
        </c:when>
        <c:otherwise>
            <span class="status-text status-etc">기타</span>
        </c:otherwise>
    </c:choose>
</p>

            <%-- 강의 제목 --%>
            <p class="lecture-title">${pay.lectureTitles}</p>

        </div>

        <%-- 오른쪽 액션 영역 --%>
        <div class="right">

            <c:choose>
                <%-- 환불 불가 또는 환불완료일 때 --%>
                <c:when test="${pay.status eq 'cancelled'}">
                    <%-- 환불 버튼 없음 --%>
                </c:when>

                <%-- 환불 가능 --%>
                <c:when test="${pay.refundable}">
                    <button type="button"
                            class="action-btn refund-btn"
                            onclick="if(confirm('환불 요청을 진행할까요?\n포인트도 회수됩니다.')) location.href='${pageContext.request.contextPath}/payment/refund?payment_id=${pay.payment_id}'">
                        환불 요청하기 ❯
                    </button>
                </c:when>

                <%-- 환불 불가 --%>
                <c:otherwise>
                    <span class="action-btn disabled-btn">환불 기간 만료</span>
                </c:otherwise>
            </c:choose>

            <button type="button"
                    class="action-btn detail-btn"
                    onclick="location.href='${pageContext.request.contextPath}/member/payment?payment_id=${pay.payment_id}'">
                상세 보기 ❯
            </button>

        </div>

    </div>

</c:forEach>

</c:otherwise>
</c:choose>

</div>

</main>

</body>
</html>
