<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/member/payment.css">

<%-- ======================================
     총 금액 계산 (포인트 + 실제 결제)
====================================== --%>
<c:set var="grossPrice" value="${payment.amount + payment.used_points}" />

<div class="payment-detail-container">

    <%-- 결제 상태 --%>
    <div class="receipt-row status-row">
        <span class="label">결제 상태</span>
        <span class="value">
            <c:choose>
                <c:when test="${payment.status eq 'paid'}">
                    <span class="status-paid">결제완료</span>
                </c:when>
                <c:when test="${payment.status eq 'refunded'}">
                    <span class="status-cancelled">환불완료</span>
                </c:when>
                <c:otherwise>
                    <span class="status-etc">기타</span>
                </c:otherwise>
            </c:choose>
        </span>
    </div>

    <%-- 주문번호 --%>
    <div class="receipt-row">
        <span class="label">주문번호</span>
        <span class="value">${payment.merchant_uid}</span>
    </div>

    <%-- 결제일시 --%>
    <div class="receipt-row">
        <span class="label">결제일시</span>
        <span class="value">
            <fmt:formatDate value="${payment.created_at}" pattern="yyyy-MM-dd HH:mm"/>
        </span>
    </div>

    <div class="divider"></div>

    <%-- ==========================
         📌 수강 강의 리스트
    =========================== --%>
    <div class="section-title">수강 강의</div>

    <%-- 리스트 여부 확인 --%>
    <c:if test="${not empty payment.details}">
        <ul class="lecture-list">

            <c:forEach var="d" items="${payment.details}" varStatus="s">

                <li class="lecture-item">

                    <%-- 강의 제목 + 가격 --%>
                    <div class="lecture-title-left">
                        <span class="lecture-title-text">${d.lecture_title}</span>
                        <span class="lecture-price-text">
                            ₩ <fmt:formatNumber value="${d.lecture_price}" type="number" />
                        </span>
                    </div>

                    <%-- =============================
                         🔥 강의별 환불 상태 표시
                         d.status 사용
                    ============================== --%>
                    <c:choose>

                        <%-- ① 이미 부분 환불된 강의 --%>
                        <c:when test="${d.status eq 'refunded'}">
                            <span class="refund-done">환불 완료</span>
                        </c:when>

                        <%-- ② 전체 결제 3일 초과 → 환불 불가 --%>
                        <c:when test="${not payment.refundable}">
                            <span class="refund-impossible">환불 불가</span>
                        </c:when>

                        <%-- ③ 부분 환불 가능 (paid + refundable=true) --%>
                        <c:otherwise>
                            <button type="button"
                                    class="mini-refund-btn"
                                    onclick="parent.requestPartialRefund(${payment.payment_id}, ${d.lecture_num})">
                                부분 환불
                            </button>
                        </c:otherwise>

                    </c:choose>

                </li>

            </c:forEach>

        </ul>
    </c:if>

    <c:if test="${empty payment.details}">
        <p class="empty-lecture">강의 정보가 없습니다.</p>
    </c:if>

    <div class="divider"></div>

    <%-- 결제금액 정보 --%>
    <div class="receipt-row">
        <span class="label">총 금액</span>
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

    <%-- 최종 결제금액 --%>
    <div class="receipt-row total">
        <span class="label">최종 결제금액</span>
        <span class="value total-amount">
            ₩ <fmt:formatNumber value="${payment.amount}" type="number" />
        </span>
    </div>

</div>
