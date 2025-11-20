<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    // 세션에서 등급 정보 가져오기 (gradeVO)
    com.itwillbs.domain.GradeVO grade =
        (com.itwillbs.domain.GradeVO) session.getAttribute("gradeVO");

    if (grade == null) {
        // 등급 정보 없으면 기본값(5%, 5%) 적용
        grade = new com.itwillbs.domain.GradeVO();
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스크랩 / 관심 | Hobee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/scrap.css?v=20251120">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>

<body>

<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="cart-wrap">

  <div class="cart-container">

    <%-- ===========================================
         좌측 스크랩 목록
    ============================================ --%>
    <div class="cart-list">

      <div class="cart-header">
        <div class="select-group">
          <label><input type="checkbox" id="selectAll"> 전체 선택</label>
          <button type="button" class="btn-outline" onclick="deleteSelected()">선택 강의 스크랩 해제</button>
        </div>
      </div>

      <div class="cart-items">

        <%-- 스크랩 비었을 때 --%>
        <c:if test="${empty scrapList}">
          <div class="empty-box">
            <p>스크랩한 강의가 없습니다.</p>
          </div>
        </c:if>

        <%-- 스크랩 데이터 반복 출력 --%>
        <c:forEach var="lecture" items="${scrapList}">
          <div class="cart-item">

            <input type="checkbox"
                   name="selectItem"
                   value="${lecture.lecture_num}"
                   data-price="${lecture.lecture_price}" />

            <img src="${lecture.lecture_img}" alt="썸네일">

            <div class="info">
              <p class="title">${lecture.lecture_title}</p>
              <p class="teacher">${lecture.lecture_author}</p>
            </div>

            <div class="price">
              ₩<fmt:formatNumber value="${lecture.lecture_price}" />
            </div>

            <button class="btn btn-delete"
                    onclick="removeScrap(${lecture.lecture_num})">
              스크랩 해제
            </button>

          </div>
        </c:forEach>

      </div>
    </div>

    <%-- ===========================================
         우측 결제 요약
    ============================================ --%>
    <div class="cart-summary">
      <h2>결제 요약</h2>

      <div class="summary-line">
        <span>총 강의 금액</span>
        <strong id="totalPrice">₩0</strong>
      </div>

      <div class="summary-line">
        <span>멤버십 할인 (<%= grade.getDiscount_rate() %>%)</span>
        <strong id="discountPrice">-₩0</strong>
      </div>

      <div class="summary-line">
        <span>적립 예정 포인트 (<%= grade.getReward_rate() %>%)</span>
        <strong id="rewardPoints">+0 P</strong>
      </div>

      <hr>

      <div class="summary-total">
        <span>최종 결제 금액</span>
        <strong id="finalPrice">₩0</strong>
      </div>

      <%-- 🔥 여기서 바로 IMP 결제 → verify → complete --%>
      <button class="btn-primary" type="button" onclick="requestPayment()">결제하기</button>
    </div>

  </div>
</main>


<script>
/* ======================================================
   IMP 초기화
====================================================== */
const IMP = window.IMP;
IMP.init("imp77215860"); // 너가 쓰던 가맹점 코드 그대로 사용

/* ======================================================
   회원 등급 할인율 / 적립률 (JSP → JS 치환)
====================================================== */
const discountRate = <%= grade.getDiscount_rate() %>;
const rewardRate   = <%= grade.getReward_rate() %>;

/* ======================================================
   금액 계산
====================================================== */
function updateSummary() {
  const selected = [...document.querySelectorAll("input[name='selectItem']:checked")];

  const totalPrice = selected.reduce((sum, cb) =>
    sum + parseInt(cb.dataset.price), 0);

  const discount = Math.floor(totalPrice * (discountRate / 100));
  const reward   = Math.floor(totalPrice * (rewardRate / 100));
  const finalAmount = totalPrice - discount;

  $("#totalPrice").text("₩" + totalPrice.toLocaleString());
  $("#discountPrice").text("-₩" + discount.toLocaleString());
  $("#rewardPoints").text("+" + reward.toLocaleString() + " P");
  $("#finalPrice").text("₩" + finalAmount.toLocaleString());
}

/* 전체 선택 */
$("#selectAll").on("change", function() {
  $("input[name='selectItem']").prop("checked", $(this).is(":checked"));
  updateSummary();
});

/* 개별 선택 */
$(document).on("change", "input[name='selectItem']", function() {
  const total = $("input[name='selectItem']").length;
  const checked = $("input[name='selectItem']:checked").length;
  $("#selectAll").prop("checked", total === checked);
  updateSummary();
});

/* ======================================================
   스크랩 삭제 (1개)
====================================================== */
function removeScrap(lectureNum) {
  if (!confirm("이 강의를 스크랩에서 해제하시겠습니까?")) return;

  $.post("${pageContext.request.contextPath}/member/scrap/delete", {
    lecture_num: lectureNum
  }, function(res) {
    if (res === "OK") {
      alert("스크랩 해제 완료!");
      location.reload();
    } else {
      alert("스크랩 해제 실패");
    }
  });
}

/* ======================================================
   선택 삭제 (여러 개)
====================================================== */
function deleteSelected() {
  const checked = $("input[name='selectItem']:checked");

  if (checked.length === 0) {
    alert("해제할 강의를 선택하세요.");
    return;
  }

  if (!confirm(checked.length + "개의 강의를 스크랩 해제하시겠습니까?")) return;

  let count = 0;

  checked.each(function() {
    const lectureNum = $(this).val();

    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/member/scrap/delete",
      data: { lecture_num: lectureNum },
      async: false,
      success: function(res) {
        if (res === "OK") count++;
      }
    });
  });

  alert(count + "개의 강의를 스크랩 해제했습니다.");
  location.reload();
}

/* ======================================================
   결제 요청 (IMP → verify → complete)
====================================================== */
function requestPayment() {

	  const selected = [...document.querySelectorAll("input[name='selectItem']:checked")];

	  if (selected.length === 0) {
	    alert("결제할 강의를 선택하세요.");
	    return;
	  }

	  /* -----------------------------
	     결제 금액 계산
	  ------------------------------ */
	  const totalPrice = selected.reduce((sum, cb) =>
	    sum + parseInt(cb.dataset.price), 0);

	  const discount = Math.floor(totalPrice * (discountRate / 100));
	  const finalAmount = totalPrice - discount;
	  const savedPoints = Math.floor(totalPrice * (rewardRate / 100));

	  const lectureNums = selected.map(cb => parseInt(cb.value));


	  /* -----------------------------
	     세션 userVO 정보 가져오기
	  ------------------------------ */
	  const userName  = "<c:out value='${sessionScope.userVO.user_name}'/>";
	  const userEmail = "<c:out value='${sessionScope.userVO.user_email}'/>";
	  const userPhone = "<c:out value='${sessionScope.userVO.user_phone}'/>";
	  const userNum   = "<c:out value='${sessionScope.userVO.user_num}'/>";

	  if (!userNum || userNum === "") {
	      alert("로그인이 필요한 서비스입니다.");
	      return;
	  }

	  /* -----------------------------
	     IMP 결제창 호출
	  ------------------------------ */
	  IMP.request_pay({
	    pg: "kakaopay.TC0ONETIME",
	    pay_method: "kakaopay",
	    merchant_uid: "M" + new Date().getTime(),
	    name: "Hobee 강의 결제",
	    amount: finalAmount,

	    buyer_email: userEmail,
	    buyer_name: userName,
	    buyer_tel: userPhone

	  }, function(rsp) {

	    if (rsp.success) {

	      /* -----------------------------
	         1) verify 요청
	      ------------------------------ */
	      $.post("${pageContext.request.contextPath}/payment/verify", {
	        imp_uid: rsp.imp_uid
	      }, function(verifyResult) {

	        if (verifyResult.verify_result === "success") {

	          /* -----------------------------
	             2) complete 요청 (DB 저장)
	          ------------------------------ */
	          $.ajax({
	            type: "POST",
	            url: "${pageContext.request.contextPath}/payment/complete",
	            traditional: true,
	            data: {
	              user_num: userNum,
	              imp_uid: rsp.imp_uid,
	              merchant_uid: rsp.merchant_uid,
	              amount: finalAmount,
	              used_points: 0,
	              saved_points: savedPoints,
	              lectureNums: lectureNums,
	              "grade.discount_rate": discountRate,
	              "grade.reward_rate": rewardRate
	            },
	            success: function(completeResult) {

	              if (completeResult.status === "success") {
	                alert("결제가 완료되었습니다!");
	                location.href = "${pageContext.request.contextPath}/payment/success";

	              } else if (completeResult.status === "duplicate") {
	                alert("이미 처리된 결제입니다.\n" + completeResult.message);
	                location.href = "${pageContext.request.contextPath}/payment/success";

	              } else {
	                alert("결제 저장 실패: " + completeResult.message);
	              }
	            },
	            error: function() {
	              alert("서버 통신 오류 (complete 단계)");
	            }
	          });

	        } else {
	          alert("결제 검증 실패: " + verifyResult.message);
	        }
	      });

	    } else {
	      alert("결제 실패: " + rsp.error_msg);
	    }
	  });
	}

$(document).ready(updateSummary);
</script>

</body>
</html>
