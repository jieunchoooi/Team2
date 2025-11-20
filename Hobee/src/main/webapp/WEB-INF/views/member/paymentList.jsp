<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<jsp:include page="../include/header.jsp"/>
<jsp:include page="../include/memberSidebar.jsp"/>

<main class="main-content">

<div class="payment-list">

<c:choose>

    <c:when test="${empty paymentList}">
        <div class="empty-card">
            <p class="icon">🧸</p>
            <p class="msg">아직 결제 내역이 없어요</p>
            <p class="sub">관심 가는 클래스를 찾아보세요 ✨</p>
        </div>
    </c:when>

    <c:otherwise>
        <c:forEach var="pay" items="${paymentList}">
            <div class="payment-card">

                <!-- 🔥 충돌 제거: .left → .card-left -->
                <div class="card-left">
                    <p class="order-no">주문번호: ${pay.merchant_uid}</p>

                    <p class="date-status">
                        <fmt:formatDate value="${pay.created_at}" pattern="yyyy-MM-dd HH:mm"/>
                        &nbsp;:&nbsp;
                        <c:choose>
                            <c:when test="${pay.status eq 'paid'}">
                                <span class="status-text status-paid">결제완료</span>
                            </c:when>
                            <c:when test="${pay.status eq 'cancelled'}">
                                <span class="status-text status-cancelled">환불완료</span>
                            </c:when>
                        </c:choose>
                    </p>

                    <p class="lecture-title">${pay.lectureTitles}</p>
                </div>

                <!-- 🔥 충돌 제거: .right → .card-right -->
                <div class="card-right">

                    <c:choose>
                        <c:when test="${pay.status eq 'cancelled'}"></c:when>

                        <c:when test="${pay.refundable}">

                            <%-- 🔥🔥 POST 방식 환불 버튼 (form 사용) --%>
                            <form action="${pageContext.request.contextPath}/payment/refund"
                                  method="post"
                                  style="display:inline;">
                                <input type="hidden" name="payment_id" value="${pay.payment_id}">
                                
                                <button type="submit"
                                    class="action-btn refund-btn"
                                    onclick="return confirm('환불을 요청할까요?');">
                                    환불 요청하기 ❯
                                </button>
                            </form>

                        </c:when>

                        <c:otherwise>
                            <span class="action-btn disabled-btn">환불 기간 만료</span>
                        </c:otherwise>
                    </c:choose>

                    <button class="action-btn detail-btn"
                            onclick="openPaymentModal(${pay.payment_id})">
                        상세 보기 ❯
                    </button>

                </div>
            </div>
        </c:forEach>
    </c:otherwise>

</c:choose>

</div>
</main>


<!-- =========================
     📌 결제 상세 모달
============================ -->
<div id="paymentModal" class="modal-overlay">
    <div class="modal-box">
        <button class="modal-close" onclick="closePaymentModal()">✕</button>
        <iframe id="paymentFrame" class="modal-frame"></iframe>
    </div>
</div>

<script>
function openPaymentModal(id) {
    const modal = document.getElementById("paymentModal");
    const frame = document.getElementById("paymentFrame");

    modal.style.display = "flex";
    frame.src = "${pageContext.request.contextPath}/member/payment?payment_id=" + id;
}

function closePaymentModal() {
    const modal = document.getElementById("paymentModal");
    const frame = document.getElementById("paymentFrame");

    modal.style.display = "none";
    frame.src = "";
}
</script>

</body>
</html>
