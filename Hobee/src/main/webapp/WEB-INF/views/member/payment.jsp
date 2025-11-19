<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 상세 | Hobee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/payment.css">
	
</head>

<body>

<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="main-content">


<%-- ============================================
     계산용 변수 (EL 연산 금지 우회)
============================================ --%>
<c:set var="grossPrice" value="${payment.amount + payment.used_points}" />

<%-- ============================================
     🧾 영수증 박스 전체
============================================ --%>
<div class="receipt-box">

    <%-- 결제 상태 --%>
    <div class="receipt-row status-row">
        <span class="label">결제 상태</span>
        <span class="value">
            <c:choose>
                <c:when test="${payment.status eq 'paid'}">
                    <span class="status-paid">결제완료</span>
                </c:when>
                <c:when test="${payment.status eq 'cancelled'}">
                    <span class="status-cancelled">환불완료</span>
                </c:when>
                <c:otherwise>
                    <span class="status-etc">기타</span>
                </c:otherwise>
            </c:choose>
        </span>
    </div>

    <%-- 주문 번호 --%>
    <div class="receipt-row">
        <span class="label">주문번호</span>
        <span class="value">${payment.merchant_uid}</span>
    </div>

    <%-- 결제 일시 --%>
    <div class="receipt-row">
        <span class="label">결제일시</span>
        <span class="value">
            <fmt:formatDate value="${payment.created_at}" pattern="yyyy-MM-dd HH:mm" />
        </span>
    </div>

    <%-- 포트원 UID --%>
    <div class="receipt-row">
        <span class="label">포트원 번호</span>
        <span class="value">${payment.imp_uid}</span>
    </div>

    <div class="divider"></div>

    <%-- ============================================================
         ⭐ 수강 강의 목록 (제목 + 가격)
    ============================================================ --%>
    <div class="section-title">수강 강의</div>

    <c:choose>

        <%-- 제목 리스트 존재 시 --%>
        <c:when test="${not empty payment.lectureTitles}">

            <%-- split --%>
            <c:set var="titles" value="${fn:split(payment.lectureTitles, ',')}" />
            <c:set var="prices" value="${fn:split(payment.lecturePrices, ',')}" />

            <ul class="lecture-list">

                <c:forEach var="t" items="${titles}" varStatus="s">
                    <li class="lecture-item">
                        <span class="lecture-title-text">- ${t}</span>
                        <span class="lecture-price-text">
                            ₩ <fmt:formatNumber value="${prices[s.index]}" type="number" />
                        </span>
                    </li>
                </c:forEach>

            </ul>

        </c:when>

        <%-- 없음 --%>
        <c:otherwise>
            <p class="empty-lecture">강의 정보가 없습니다.</p>
        </c:otherwise>

    </c:choose>

    <div class="divider"></div>

    <%-- 결제 금액 정보 --%>
    <div class="receipt-row">
        <span class="label">결제금액</span>
        <span class="value">
            ₩ <fmt:formatNumber value="${grossPrice}" type="number" />
        </span>
    </div>

    <div class="receipt-row">
        <span class="label">사용 포인트</span>
        <span class="value minus">
            - <fmt:formatNumber value="${payment.used_points}" type="number" />
        </span>
    </div>

    <div class="receipt-row">
        <span class="label">적립 포인트</span>
        <span class="value plus">
            + <fmt:formatNumber value="${payment.saved_points}" type="number" />
        </span>
    </div>

    <div class="divider"></div>

    <%-- 최종 금액 --%>
    <div class="receipt-row total">
        <span class="label">최종 결제금액</span>
        <span class="value total-amount">
            ₩ <fmt:formatNumber value="${payment.amount}" type="number" />
        </span>
    </div>

    <%-- ============================================================
         환불 요청 버튼 (영수증 내부 오른쪽 정렬)
    ============================================================ --%>
    <c:if test="${payment.status eq 'paid' && payment.refundable}">
        <button class="refund-btn"
            onclick="if(confirm('환불을 요청하시겠습니까?\n포인트도 함께 회수됩니다.')) 
                     location.href='${pageContext.request.contextPath}/payment/refund?payment_id=${payment.payment_id}'">
            환불 요청하기 ❯
        </button>
    </c:if>

</div> <%-- receipt-box 끝 --%>

</main>

</body>
</html>
