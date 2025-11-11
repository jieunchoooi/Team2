<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스크랩 / 관심 | Hobee</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/scrap.css?v=20251111c">
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>

<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="cart-wrap">
  <h1 class="cart-title">스크랩 / 관심</h1>

  <div class="cart-container">
    <!-- ✅ 좌측 강의 리스트 -->
    <div class="cart-list">
      <div class="cart-header">
        <div class="select-group">
          <label><input type="checkbox" id="selectAll"> 전체 선택</label>
          <button type="button" class="btn-outline" onclick="deleteSelected()">선택 해제</button>
        </div>
      </div>

      <div class="cart-items">
        <div class="cart-item">
          <input type="checkbox" name="selectItem" value="101" data-price="45000">
          <img src="${pageContext.request.contextPath}/resources/images/sample_thumb.jpg" alt="썸네일">
          <div class="info">
            <p class="title">수채화 기초 클래스</p>
            <p class="teacher">이화가 강사</p>
          </div>
          <div class="price">₩45,000</div>
          <button class="btn btn-delete" onclick="removeScrap(101)">스크랩 해제</button>
        </div>

        <div class="cart-item">
          <input type="checkbox" name="selectItem" value="102" data-price="60000">
          <img src="${pageContext.request.contextPath}/resources/images/sample_thumb2.jpg" alt="썸네일">
          <div class="info">
            <p class="title">캘리그래피 입문</p>
            <p class="teacher">홍서연 강사</p>
          </div>
          <div class="price">₩60,000</div>
          <button class="btn btn-delete" onclick="removeScrap(102)">스크랩 해제</button>
        </div>
      </div>
    </div>

    <!-- ✅ 우측 결제 요약 -->
    <div class="cart-summary">
      <h2>결제 요약</h2>
      <div class="summary-line">
        <span>총 강의 금액</span>
        <strong id="totalPrice">₩0</strong>
      </div>
      <div class="summary-line">
        <span>멤버십 할인 (5%)</span>
        <strong id="discountPrice">-₩0</strong>
      </div>
      <hr>
      <div class="summary-total">
        <span>최종 결제 금액</span>
        <strong id="finalPrice">₩0</strong>
      </div>

      <div class="btn-row">
        <button class="btn btn-delete" type="button" onclick="deleteSelected()">선택 강의 해제</button>
        <button class="btn btn-primary" type="button" onclick="requestPayment()">결제하기</button>
      </div>
    </div>
  </div>
</main>

<script>
  const selectAll = document.getElementById("selectAll");
  const checkboxes = document.querySelectorAll("input[name='selectItem']");

  selectAll?.addEventListener("change", function() {
    checkboxes.forEach(cb => cb.checked = this.checked);
    updateTotal();
  });
  checkboxes.forEach(cb => cb.addEventListener("change", updateTotal));

  function updateTotal() {
    let total = 0;
    document.querySelectorAll("input[name='selectItem']:checked").forEach(cb => {
      total += parseInt(cb.dataset.price);
    });
    const discount = Math.floor(total * 0.05); // ✅ 5% 할인 적용

    document.getElementById("totalPrice").textContent = "₩" + total.toLocaleString();
    document.getElementById("discountPrice").textContent = "-₩" + discount.toLocaleString();
    document.getElementById("finalPrice").textContent = "₩" + (total - discount).toLocaleString();
  }

  function removeScrap(id) {
    if (confirm("이 강의를 스크랩에서 해제하시겠습니까?")) {
      alert("스크랩 해제 완료 (임시 기능)");
    }
  }

  function deleteSelected() {
    const selected = [...document.querySelectorAll("input[name='selectItem']:checked")];
    if (selected.length === 0) return alert("해제할 강의를 선택하세요.");
    if (confirm("선택한 강의를 스크랩에서 해제하시겠습니까?")) {
      selected.forEach(cb => cb.closest(".cart-item").remove());
      updateTotal();
      alert("선택 해제 완료 (임시 기능)");
    }
  }

  const IMP = window.IMP;
  IMP.init("imp77215860");

  function requestPayment() {
    const selected = [...document.querySelectorAll("input[name='selectItem']:checked")];
    if (selected.length === 0) return alert("결제할 강의를 선택하세요.");

    const totalPrice = selected.reduce((sum, cb) => sum + parseInt(cb.dataset.price), 0);
    const discount = Math.floor(totalPrice * 0.05);
    const finalAmount = totalPrice - discount;

    IMP.request_pay({
      pg: "kakaopay.TC0ONETIME",
      pay_method: "kakaopay",
      merchant_uid: "M" + new Date().getTime(),
      name: "Hobee 강의 결제",
      amount: finalAmount,
      buyer_email: "test@hobee.com",
      buyer_name: "홍길동",
      buyer_tel: "010-1234-5678"
    }, function(rsp) {
      if (rsp.success) {
        alert("결제가 완료되었습니다!");
        location.href = "${pageContext.request.contextPath}/payment/success";
      } else {
        alert("결제 실패: " + rsp.error_msg);
      }
    });
  }
</script>

</body>
</html>
