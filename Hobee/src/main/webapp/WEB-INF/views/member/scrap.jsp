<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- ==========================================
     세션 데이터 → JSP 변수로 안전하게 세팅
     - gradeVO가 없을 때도 0으로 처리
     - userVO.points 없을 때도 0으로 처리
========================================== --%>
<c:set var="grade" value="${sessionScope.gradeVO}" />
<c:set var="discountRate"
       value="${empty grade or grade.discount_rate == null ? 0 : grade.discount_rate}" />
<c:set var="rewardRate"
       value="${empty grade or grade.reward_rate == null ? 0 : grade.reward_rate}" />
<c:set var="userPoints"
       value="${empty sessionScope.userVO or sessionScope.userVO.points == null ? 0 : sessionScope.userVO.points}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스크랩 / 관심 | Hobee</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/member/scrap.css?v=20251120">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/include/profileCard.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>

<body>

    <jsp:include page="../include/header.jsp" />
    <jsp:include page="../include/memberSidebar.jsp" />

    <main class="main-content">

        <div class="content-wrapper">

            <%-- 프로필 카드 --%>
            <jsp:include page="../include/profileCard.jsp" />

            <%-- 스크랩 + 결제 요약 레이아웃 --%>
            <div class="cart-container">

                <%-- 좌측 스크랩 목록 --%>
                <div class="cart-list">

                    <div class="cart-header">
                        <div class="select-group">
                            <label>
                                <input type="checkbox" id="selectAll"> 전체 선택
                            </label>
                            <button type="button" class="btn-outline"
                                    onclick="deleteSelected()">선택 강의 스크랩 해제</button>
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

                                <input type="checkbox" name="selectItem"
                                       value="${lecture.lecture_num}"
                                       data-price="${lecture.lecture_price}" />

                                <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lecture.lecture_img}"
                                     alt="썸네일">

                                <div class="info"
                                     onclick="location.href='${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}'">
                                    <p class="title">${lecture.lecture_title}</p>
                                    <p class="teacher">${lecture.lecture_author}</p>
                                </div>

                                <div class="price">
                                    ₩
                                    <fmt:formatNumber value="${lecture.lecture_price}" />
                                </div>

                                <button class="btn btn-delete"
                                        onclick="removeScrap(${lecture.lecture_num})">스크랩 해제</button>

                            </div>
                        </c:forEach>

                    </div>
                </div>

                <%-- 우측 결제 요약 --%>
                <div class="cart-summary">
                    <h2>결제 요약</h2>

                    <div class="summary-line">
                        <span>총 강의 금액</span>
                        <strong id="totalPrice">₩0</strong>
                    </div>

                    <div class="summary-line">
                        <span>멤버십 할인 (${discountRate}%)</span>
                        <strong id="discountPrice">-₩0</strong>
                    </div>

                    <%-- 포인트 입력 영역 --%>
                    <div class="point-box">

                        <div class="point-row">
                            <span>보유 포인트</span>
                            <strong id="myPoints">
                                <fmt:formatNumber value="${userPoints}" /> P
                            </strong>
                        </div>

                        <div class="point-row">
                            <span>포인트 사용</span>
                            <div class="point-input-area">
                                <input type="number" id="usedPointsInput"
                                       min="0"
                                       max="${userPoints}"
                                       placeholder="0"
                                       class="point-input">
                                <button type="button" class="btn-use-all"
                                        onclick="useAllPoints()">모두 사용</button>
                            </div>
                        </div>

                        <div class="point-row">
                            <span>사용 후 잔여 포인트</span>
                            <strong id="remainPoints">0 P</strong>
                        </div>

                    </div>

                    <hr>

                    <div class="summary-total">
                        <span>최종 결제 금액</span>
                        <strong id="finalPrice">₩0</strong>
                    </div>

                    <div class="summary-line">
                        <span>적립 예정 (${rewardRate}%)</span>
                        <strong id="rewardPoints">+0 P</strong>
                    </div>

                    <button class="btn-primary" type="button"
                            onclick="requestPayment()">결제하기</button>
                </div>

            </div>
            <%-- cart-container --%>

        </div>
        <%-- content-wrapper --%>

    </main>

    <jsp:include page="../include/footer.jsp"></jsp:include>

    <script>
    /* ======================================================
    IMP 초기화
 ====================================================== */
 const IMP = window.IMP;
 IMP.init("imp77215860");

 /* ======================================================
    JSP → JS 전달 상수
 ====================================================== */
 const discountRate = parseFloat("${discountRate}");
 const rewardRate   = parseFloat("${rewardRate}");
 const userPoints   = parseInt("${userPoints}");

 const userName  = "<c:out value='${sessionScope.userVO.user_name}'/>";
 const userEmail = "<c:out value='${sessionScope.userVO.user_email}'/>";
 const userPhone = "<c:out value='${sessionScope.userVO.user_phone}'/>";
 const userNum   = "<c:out value='${sessionScope.userVO.user_num}'/>";

 const ctx = "${pageContext.request.contextPath}";


 /* ======================================================
    선택된 체크박스 → 강의 배열 반환
 ====================================================== */
 function getSelectedItems() {
     return [...document.querySelectorAll("input[name='selectItem']:checked")];
 }


 /* ======================================================
    강의별 할인/적립 계산
    PaymentDetailVO의 주요 4가지 값 생성:
    - original_price
    - sale_price
    - saved_points
    - used_points (포인트 배분은 뒤에서 따로 계산)
 ====================================================== */
 function calculateLectureDetails(selectedItems) {

     const details = selectedItems.map(cb => {
         const original = parseInt(cb.dataset.price || "0");
         const sale     = Math.floor(original * (1 - discountRate / 100));
         const reward   = Math.floor(sale * (rewardRate / 100));

         return {
             lecture_num: parseInt(cb.value),
             original_price: original,
             sale_price: sale,
             saved_points: reward,
             used_points: 0 // 나중에 분배
         };
     });

     return details;
 }


 /* ======================================================
    사용 포인트를 강의별 금액 비율로 분배
 ====================================================== */
 function distributeUsedPoints(details, totalUsedPoints) {

     if (totalUsedPoints <= 0) return details;

     const totalSaleSum = details.reduce((sum, d) => sum + d.sale_price, 0);

     if (totalSaleSum === 0) return details;

     let distributed = 0;

     details.forEach((d, index) => {
         if (index === details.length - 1) {
             // 마지막 강의는 나머지 포인트를 몰아줌 (총합 맞추기)
             d.used_points = totalUsedPoints - distributed;
         } else {
             const ratio = d.sale_price / totalSaleSum;
             const portion = Math.floor(totalUsedPoints * ratio);

             d.used_points = portion;
             distributed += portion;
         }
     });

     return details;
 }


 /* ======================================================
    전체 결제 요약 재계산 (UI 업데이트)
 ====================================================== */
 function updateSummary() {

     const selected = getSelectedItems();

     const totalPrice = selected.reduce((sum, cb) => {
         const price = parseInt(cb.dataset.price || "0");
         return sum + price;
     }, 0);

     const discount = Math.floor(totalPrice * (discountRate / 100));
     const priceAfterDiscount = totalPrice - discount;

     let usedPoints = parseInt($("#usedPointsInput").val() || "0");
     if (isNaN(usedPoints) || usedPoints < 0) usedPoints = 0;
     if (usedPoints > userPoints) usedPoints = userPoints;
     if (usedPoints > priceAfterDiscount) usedPoints = priceAfterDiscount;

     $("#usedPointsInput").val(usedPoints);

     // 잔여 포인트
     $("#remainPoints").text((userPoints - usedPoints).toLocaleString() + " P");

     // 강의별 적립 계산
     let totalReward = 0;
     selected.forEach(cb => {
         const original = parseInt(cb.dataset.price || "0");
         const sale = Math.floor(original * (1 - discountRate / 100));
         const reward = Math.floor(sale * (rewardRate / 100));
         totalReward += reward;
     });

     $("#rewardPoints").text("+" + totalReward.toLocaleString() + " P");

     const finalAmount = priceAfterDiscount - usedPoints;

     $("#finalPrice").text("₩" + finalAmount.toLocaleString());
     $("#totalPrice").text("₩" + totalPrice.toLocaleString());
     $("#discountPrice").text("-₩" + discount.toLocaleString());
 }


 /* ======================================================
    포인트 모두 사용
 ====================================================== */
 function useAllPoints() {
     $("#usedPointsInput").val(userPoints);
     updateSummary();
 }


 /* ======================================================
    스크랩 해제 (단건)
 ====================================================== */
 function removeScrap(lectureNum) {
     if (!confirm("이 강의를 스크랩에서 해제하시겠습니까?")) return;

     $.post(ctx + "/member/scrap/delete", {
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
    스크랩 해제 (복수)
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
             url: ctx + "/member/scrap/delete",
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
    requestPayment() — 핵심
    1) selectedItems 가져오기
    2) 강의별 sale_price / saved_points 계산
    3) used_points 비율 배분
    4) detailList = JSON.stringify()
    5) 기존 form 방식 그대로 AJAX 요청
 ====================================================== */
 function requestPayment() {

     const selectedItems = getSelectedItems();

     if (selectedItems.length === 0) {
         alert("결제할 강의를 선택하세요.");
         return;
     }

     if (!userNum || userNum === "") {
         alert("로그인이 필요한 서비스입니다.");
         return;
     }

     updateSummary(); // 최신값 반영

     // DOM에서 읽기
     const finalAmount = parseInt($("#finalPrice").text().replace(/[^0-9]/g, "")) || 0;
     const totalUsedPoints = parseInt($("#usedPointsInput").val() || "0") || 0;
     const savedPoints = parseInt($("#rewardPoints").text().replace(/[^0-9]/g, "")) || 0;

     if (finalAmount <= 0) {
         alert("결제할 금액이 없습니다.");
         return;
     }

     // 1) 강의별 detailList 생성
     let details = calculateLectureDetails(selectedItems);

     // 2) used_points 분배
     details = distributeUsedPoints(details, totalUsedPoints);

     // 3) lectureNums 배열 (기존 구조 유지)
     const lectureNums = selectedItems.map(cb => parseInt(cb.value));

     /* ***********************************
        포트원 결제 시작
     **************************************** */
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

         if (!rsp.success) {
             alert("결제 실패: " + rsp.error_msg);
             return;
         }

         // 1) 결제 검증
         $.post(ctx + "/payment/verify", {
             imp_uid: rsp.imp_uid
         }, function(verifyResult) {

             if (verifyResult.verify_result !== "success") {
                 alert("결제 검증 실패: " + verifyResult.message);
                 return;
             }

             // 2) 결제 완료 처리 (기존 구조 유지 + detailList 전송)
             $.ajax({
                 type: "POST",
                 url: ctx + "/payment/complete",
                 traditional: true,
                 data: {
                     user_num: userNum,
                     imp_uid: rsp.imp_uid,
                     merchant_uid: rsp.merchant_uid,
                     amount: finalAmount,
                     used_points: totalUsedPoints,
                     saved_points: savedPoints,
                     lectureNums: lectureNums,
                     detailList: JSON.stringify(details),   // ★ 핵심
                     "grade.discount_rate": discountRate,
                     "grade.reward_rate": rewardRate
                 },
                 success: function(result) {

                     if (result.status === "success") {

                         if (result.gradeChanged && result.gradeMessage) {
                             alert("\n" + result.gradeMessage);
                         }

                         location.href = ctx + "/payment/success";
                     }
                     else if (result.status === "duplicate") {
                         alert("이미 처리된 결제입니다.\n" + result.message);
                         location.href = ctx + "/payment/success";
                     }
                     else {
                         alert("결제 저장 실패: " + result.message);
                     }
                 },
                 error: function() {
                     alert("서버 통신 오류 (complete 단계)");
                 }
             });

         });
     });
 }


 /* ======================================================
    체크박스 이벤트 바인딩
 ====================================================== */
 $(function() {

     $("#usedPointsInput").on("input", updateSummary);

     $("#selectAll").on("change", function() {
         $("input[name='selectItem']").prop("checked", $(this).is(":checked"));
         updateSummary();
     });

     $(document).on("change", "input[name='selectItem']", function() {
         const total = $("input[name='selectItem']").length;
         const checked = $("input[name='selectItem']:checked").length;
         $("#selectAll").prop("checked", total === checked);
         updateSummary();
     });

     updateSummary(); // 초기 호출
 });

    </script>

</body>
</html>
