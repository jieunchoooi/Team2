<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 성공 | Hobee</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/payment.css">
<script>
window.onload = function() {
  alert("🎉 결제가 완료되었습니다!\n이제 내 강의실로 이동합니다.");
  // 2초 후 자동 이동
  setTimeout(() => {
    location.href = "${pageContext.request.contextPath}/member/my_classroom";
  }, 1000);
};
</script>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<main class="success-page">
  <h1>결제가 완료되었습니다 🎉</h1>
  <p>잠시 후 내 강의실로 이동합니다...</p>
  <button onclick="location.href='${pageContext.request.contextPath}/member/my_classroom'">즉시 이동</button>
</main>

</body>
</html>
