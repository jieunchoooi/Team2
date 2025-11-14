<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee Header</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/include/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/loginModal.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<header>
	<h1><a href="${pageContext.request.contextPath }/main/main">Hobee</a></h1>

	<nav>
		<div class="nav-left">
			<div class="mega-dropdown">
				<a href="#">카테고리 ▾</a>
				<div class="mega-content">
					<div class="mega-column">
						<h3>ART</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath }/category/lectureList">디지털 드로잉</a></li>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">드로잉</a></li>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">공예</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>IT</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">AI 스킬업</a></li>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">프로그래밍</a></li>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">데이터사이언스</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>외국어</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">영어</a></li>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">외국어 시험</a></li>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">제2 외국어</a></li>
						</ul>
					</div>
				</div>
			</div>

			<a href="${pageContext.request.contextPath }/board/comunityList">커뮤니티</a>
			<a href="${pageContext.request.contextPath }/recommend/recoList">베스트 & 추천강의</a>
		</div>

		<div class="nav-right">
  <c:choose>

    <%-- 🔹 로그인 전 --%>
    <c:when test="${empty sessionScope.user_id}">
      <a href="#" id="openLoginModal" class="auth-link">로그인</a>
      <a href="${pageContext.request.contextPath }/user/insert" class="auth-link">회원가입</a>
    </c:when>

    <%-- 🔹 로그인 후 --%>
    <c:otherwise>
      <span class="welcome-text">${sessionScope.user_name}님</span>

      <%-- ✅ 관리자(admin) 계정일 때만 관리자 메뉴 표시 --%>
      <c:choose>
        <c:when test="${sessionScope.user_id eq 'admin'}">
          <a href="${pageContext.request.contextPath }/admin/adminCategory" class="auth-link">관리자페이지</a>
          <a href="${pageContext.request.contextPath }/user/logout" class="auth-link">로그아웃</a>
        </c:when>

        <%-- ✅ 일반 사용자일 경우 --%>
        <c:otherwise>
          <a href="${pageContext.request.contextPath }/member/mypage" class="auth-link">마이페이지</a>
          <a href="${pageContext.request.contextPath }/user/logout" class="auth-link">로그아웃</a>
        </c:otherwise>
      </c:choose>

    </c:otherwise>

  </c:choose>
</div>

	</nav>
</header>

<!-- ✅ 로그인 모달 include -->
<jsp:include page="/WEB-INF/views/include/loginModal.jsp" />

<!-- ✅ 로그인 관련 스크립트 -->
<script>
$(document).ready(function(){
  const contextPath = "${pageContext.request.contextPath}";

  // 🔹 모달 열기
  $("#openLoginModal").click(function(e){
    e.preventDefault();
    $("#loginModal").fadeIn(200).css("display","flex");
  });

  // 🔹 모달 닫기
  $(".close-btn, .modal-overlay").click(function(){
    $("#loginModal").fadeOut(200);
    $("#loginForm")[0].reset();
    $("#loginError").text("");
  });

  // 🔹 엔터키 로그인
  $("#loginForm input").keypress(function(e){
    if (e.which === 13) {
      e.preventDefault();
      loginRequest();
    }
  });

  // 🔹 버튼 클릭 로그인
  $("#loginBtn").click(function(){
    loginRequest();
  });

  // 🔹 Ajax 로그인 처리
  function loginRequest() {
    $.ajax({
      type: "POST",
      url: contextPath + "/user/loginPro", // ✅ Controller 매핑 일치
      data: $("#loginForm").serialize(),
      dataType: "json",
      success: function(res){
        if (res.result === "success") {
          alert(res.user_name + "님, 환영합니다 😊");
          $("#loginModal").fadeOut();
          window.location.href = contextPath + "/"; // 메인으로 이동
        } else {
          alert("아이디 또는 비밀번호가 일치하지 않습니다.");
        }
      },
      error: function(){
        alert("서버 통신 오류가 발생했습니다.");
      }
    });
  }
});
</script>

</body>
</html>
