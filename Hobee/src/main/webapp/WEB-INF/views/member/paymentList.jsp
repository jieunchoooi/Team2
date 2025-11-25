<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 내역 | Hobee</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/paymentList.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/include/profileCard.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

	<jsp:include page="../include/header.jsp" />
	<jsp:include page="../include/memberSidebar.jsp" />

	<main class="main-content">

		<div class="content-wrapper">

			<%-- ===========================
             🔥 프로필 카드
        ============================ --%>
				<jsp:include page="../include/profileCard.jsp" />

			<%-- ===========================
             🔥 결제 내역
        ============================ --%>
			<div class="payment-list">

				<c:choose>

					<%-- 결제 내역 없음 --%>
					<c:when test="${empty paymentList}">
						<div class="payment-empty-wrap">
							<div class="payment-empty-card">
								<div class="empty-icon">🧸</div>
								<div class="empty-title">아직 결제 내역이 없어요</div>

							</div>
						</div>
					</c:when>

					<%-- 결제 내역 있음 --%>
					<c:otherwise>

						<c:forEach var="pay" items="${paymentList}">

							<%-- 문자열 길이 체크용 --%>
							<c:set var="lectureTitleListString"
								value="${pay.lectureTitleList}" />
							<c:set var="lectureCount"
								value="${fn:length(lectureTitleListString)}" />

							<div class="payment-card">

								<%-- 좌측 --%>
								<div class="card-left">

									<p class="order-no">주문번호: ${pay.merchant_uid}</p>

									<p class="date-status">
										<fmt:formatDate value="${pay.created_at}"
											pattern="yyyy-MM-dd HH:mm" />
										&nbsp;:&nbsp;

										<c:choose>
											<c:when test="${pay.status eq 'paid'}">
												<span class="status-text status-paid">결제완료</span>
											</c:when>
											<c:when test="${pay.status eq 'refunded'}">
												<span class="status-text status-cancelled">환불완료</span>
											</c:when>
										</c:choose>
									</p>

									<%-- 강의명 --%>
									<p class="lecture-title">
										${pay.lectureTitleList[0]}
										<c:if test="${lectureCount > 1}">
                                        &nbsp;외 ${lectureCount - 1}개
                                    </c:if>
									</p>

								</div>

								<%-- 우측 버튼 영역 --%>
								<div class="card-right">

									<c:if test="${pay.status eq 'paid'}">

										<c:choose>

											<%-- 환불 가능 --%>
											<c:when test="${pay.refundable}">
												<button type="button" class="action-btn refund-btn"
													onclick="requestFullRefund(${pay.payment_id})">전체
													환불하기 ❯</button>
											</c:when>

											<%-- 환불 불가 --%>
											<c:otherwise>
												<span class="action-btn disabled-btn">환불 기간 만료</span>
											</c:otherwise>

										</c:choose>

									</c:if>

									<%-- 상세보기 버튼 --%>
									<button class="action-btn detail-btn"
										onclick="openPaymentModal(${pay.payment_id})">상세 보기 ❯
									</button>

								</div>

							</div>

						</c:forEach>

					</c:otherwise>

				</c:choose>

			</div>

		</div>
	</main>


	<%-- ===========================
     상세 모달
=========================== --%>
	<div id="paymentModal" class="modal-overlay">
		<div class="modal-box">
			<button class="modal-close" onclick="closePaymentModal()">✕</button>
			<iframe id="paymentFrame" class="modal-frame"></iframe>
		</div>
	</div>


	<script>
/* ===========================
   상세 모달 열기
=========================== */
function openPaymentModal(id) {
    $("#paymentModal").css("display", "flex");
    $("#paymentFrame").attr("src",
        "${pageContext.request.contextPath}/member/payment?payment_id=" + id
    );
}

function closePaymentModal() {
    $("#paymentModal").hide();
    $("#paymentFrame").attr("src", "");
}


/* ===========================
   전체 환불
=========================== */
function requestFullRefund(paymentId) {

    if (!confirm("정말 전체 환불을 진행하시겠습니까?\n포인트도 함께 회수됩니다.")) return;

    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/payment/refund/verify",
        data: { payment_id: paymentId },
        dataType: "json",
        success: function(v) {

            if (v.verify_result !== "success") {
                alert("환불 불가: " + v.message);
                return;
            }

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/payment/refund/complete",
                data: {
                    payment_id: paymentId,
                    type: "full"
                },
                dataType: "json",
                success: function(res) {

                    if (res.status === "success") {

                        let msg = res.message;
                        if (res.gradeMessage) msg += "\n\n" + res.gradeMessage;

                        alert(msg);
                        location.reload();

                    } else {
                        alert("환불 실패: " + res.message);
                    }

                }
            });
        }
    });
}

</script>

</body>
</html>
