<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 내역 | Hobee</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member/payment.css">
</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<main class="main-content">
  <div class="main-header">
    <h1>결제 내역</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>주문번호</th>
          <th>강의명</th>
          <th>결제금액</th>
          <th>결제일</th>
          <th>상태</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>#2025110501</td>
          <td>캘리그래피 입문</td>
          <td>₩60,000</td>
          <td>2025-11-02</td>
          <td>결제완료</td>
        </tr>
      </tbody>
    </table>
  </div>
</main>

<script>
function logout() {
  alert("로그아웃되었습니다.");
  location.href = "${pageContext.request.contextPath}/member/logout";
}
</script>
</body>
</html>
