<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스크랩 / 관심 | Hobee</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/scrap.css?v=20251112">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>

<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="cart-wrap">

  <div class="cart-container">
    <!-- ✅ 좌측 강의 리스트 -->
    <div class="cart-list">
      <div class="cart-header">
        <div class="select-group">
          <label><input type="checkbox" id="selectAll"> 전체 선택</label>
          <button type="button" class="btn-outline" onclick="deleteSelected()">선택 강의 스크랩 해제</button>
        </div>
      </div>

      <div class="cart-items">

        <%-- 
          ==============================================================
          TODO: 현재는 하드코딩된 임시 강의 데이터입니다.
          추후 Controller에서 lectureList를 전달받아 
          JSTL <c:forEach> 로 교체 예정.
          예시 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
          --------------------------------------------------------------
          <c:forEach var="lecture" items="${lectureList}">
            <div class="cart-item">
              <input type="checkbox" name="selectItem"
                     value="${lecture.lecture_num}"
                     data-price="${lecture.lecture_price}">
              <img src="${pageContext.request.contextPath}/resources/images/${lecture.lecture_img}" alt="썸네일">
              <div class="info">
                <p class="title">${lecture.lecture_title}</p>
                <p class="teacher">${lecture.lecture_author}</p>
              </div>
              <div class="price">₩${lecture.lecture_price}</div>
              <button class="btn btn-delete"
                      onclick="removeScrap(${lecture.lecture_num})">스크랩 해제</button>
            </div>
          </c:forEach>
          --------------------------------------------------------------
        --%>

        <!-- ✅ [임시 하드코딩 데이터: JSTL 교체 예정] -->
        <div class="cart-item">
          <input type="checkbox" name="selectItem" value="101" data-price="45000">
          <img src="${pageContext.request.contextPath}/resources/images/sample_thumb1.jpg" alt="썸네일">
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

        <div class="cart-item">
          <input type="checkbox" name="selectItem" value="103" data-price="55000">
          <img src="${pageContext.request.contextPath}/resources/images/sample_thumb3.jpg" alt="썸네일">
          <div class="info">
            <p class="title">디지털 드로잉 기초</p>
            <p class="teacher">박지훈 강사</p>
          </div>
          <div class="price">₩55,000</div>
          <button class="btn btn-delete" onclick="removeScrap(103)">스크랩 해제</button>
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

      <button class="btn-primary" type="button" onclick="requestPayment()">결제하기</button>
    </div>
  </div>
</main>

<script>
const IMP = window.IMP;
IMP.init("imp77215860");

// ✅ [임시 등급 데이터] - 추후 GradeVO 연동 예정
const discountRate = 5.0;
const rewardRate = 5.0;

// ✅ 금액 갱신
function updateSummary() {
  const selected = [...document.querySelectorAll("input[name='selectItem']:checked")];
  const totalPrice = selected.reduce((sum, cb) => sum + parseInt(cb.dataset.price), 0);
  const discount = Math.floor(totalPrice * (discountRate / 100));
  const finalAmount = totalPrice - discount;

  $("#totalPrice").text("₩" + totalPrice.toLocaleString());
  $("#discountPrice").text("-₩" + discount.toLocaleString());
  $("#finalPrice").text("₩" + finalAmount.toLocaleString());
}

// ✅ 전체 선택 / 해제
$("#selectAll").on("change", function() {
  $("input[name='selectItem']").prop("checked", $(this).is(":checked"));
  updateSummary();
});

// ✅ 개별 체크 시
$(document).on("change", "input[name='selectItem']", function() {
  const all = $("input[name='selectItem']").length;
  const checked = $("input[name='selectItem']:checked").length;
  $("#selectAll").prop("checked", all === checked);
  updateSummary();
});

// ✅ 스크랩 해제 (임시)
function removeScrap(num) {
  alert("스크랩 해제 기능은 구현 예정입니다. (lecture_num=" + num + ")");
}

// ✅ 선택 해제 (임시)
function deleteSelected() {
  const checked = $("input[name='selectItem']:checked");
  if (checked.length === 0) return alert("해제할 강의를 선택하세요.");
  alert("선택한 " + checked.length + "개의 강의 스크랩 해제 기능은 구현 예정입니다.");
}

// ✅ 결제 요청
function requestPayment() {
  const selected = [...document.querySelectorAll("input[name='selectItem']:checked")];
  if (selected.length === 0) return alert("결제할 강의를 선택하세요.");

  const totalPrice = selected.reduce((sum, cb) => sum + parseInt(cb.dataset.price), 0);
  const discount = Math.floor(totalPrice * (discountRate / 100));
  const finalAmount = totalPrice - discount;
  const savedPoints = Math.floor(totalPrice * (rewardRate / 100));
  const lectureNums = selected.map(cb => parseInt(cb.value));

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
      $.post("${pageContext.request.contextPath}/payment/verify", {
        imp_uid: rsp.imp_uid
      }, function(verifyResult) {
        if (verifyResult.verify_result === "success") {
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/payment/complete",
            traditional: true,
            data: {
              user_num: 1, // TODO: 세션 userVO.user_num 으로 교체
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
