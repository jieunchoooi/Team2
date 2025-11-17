<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee Header</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/loginModal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/insertModal.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<header>
	<h1><a href="${pageContext.request.contextPath}/main/main">Hobee</a></h1>

	<nav>
		<div class="nav-left">
			<div class="mega-dropdown">
				<a href="#">카테고리 ▾</a>

				<div class="mega-content">
					<div class="mega-column">
						<h3>ART</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath}/category/lectureList">디지털 드로잉</a></li>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">드로잉</a></li>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">공예</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>IT</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">AI 스킬업</a></li>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">프로그래밍</a></li>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">데이터사이언스</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>외국어</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">영어</a></li>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">외국어 시험</a></li>
							<li><a href="${pageContext.request.contextPath}/category/drawingList">제2 외국어</a></li>
						</ul>
					</div>
				</div>
			</div>

			<a href="${pageContext.request.contextPath}/board/comunityList">커뮤니티</a>
			<a href="${pageContext.request.contextPath}/recommend/recoList">베스트 & 추천강의</a>
		</div>

		<div class="nav-right">
			<c:choose>

				<c:when test="${empty sessionScope.user_id}">
					<a href="#" id="openLoginModal" class="auth-link">로그인</a>
					<a href="#" id="openInsertModal" class="auth-link">회원가입</a>
				</c:when>

				<c:otherwise>
					<span class="welcome-text">${sessionScope.user_name}님</span>

					<a href="${pageContext.request.contextPath}/member/mypage" class="auth-link">마이페이지</a>

					<c:if test="${sessionScope.user_id eq 'admin'}">
						<a href="${pageContext.request.contextPath}/admin/adminCategory" class="auth-link">관리자페이지</a>
					</c:if>

					<a href="${pageContext.request.contextPath}/user/logout" class="auth-link">로그아웃</a>
				</c:otherwise>

			</c:choose>
		</div>
	</nav>
</header>


<!-- 로그인 모달 include -->
<jsp:include page="/WEB-INF/views/include/loginModal.jsp"/>

<!-- 회원가입 모달 include -->
<jsp:include page="/WEB-INF/views/include/insertModal.jsp"/>


<!-- ========================================
     SCRIPT (로그인 + 회원가입)
=========================================== -->
<script>
$(document).ready(function(){

	const contextPath = "${pageContext.request.contextPath}";

	/* ======================
	   [ 1 ] 로그인 모달
	====================== */

	$("#openLoginModal").click(function(e){
		e.preventDefault();
		$("#loginModal").fadeIn().css("display","flex");
	});

	$(document).on("click", ".close-btn, .modal-overlay", function(){
		if($(this).closest("#loginModal").length > 0 ||
		   $(this).hasClass("modal-overlay")){
			$("#loginModal").fadeOut();
			$("#loginForm")[0].reset();
			$("#loginError").text("");
		}
	});

	$("#loginBtn").click(function(){
		loginRequest();
	});

	$("#loginForm input").keypress(function(e){
		if(e.which === 13){
			e.preventDefault();
			loginRequest();
		}
	});

	function loginRequest(){
		$.ajax({
			type:"POST",
			url: contextPath + "/user/loginPro",
			data: $("#loginForm").serialize(),
			dataType:"json",
			success:function(res){
				if(res.result === "success"){
					alert(res.user_name + "님, 환영합니다!");
					$("#loginModal").fadeOut();
					location.href = contextPath + "/";
				} else {
					alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				}
			}
		});
	}



	/* ======================
	   [ 2 ] 회원가입 모달
	====================== */

	$("#openInsertModal").click(function(e){
		e.preventDefault();
		$("#insertModal").fadeIn().css("display","flex");
	});

	$(document).on("click", ".close-btn, .modal-overlay", function(){
		if($(this).closest("#insertModal").length > 0 ||
		   $(this).hasClass("modal-overlay")){
			$("#insertModal").fadeOut();
			$("#insertForm")[0].reset();
			$("#insertError").text("");
			$("#insertSuccess").text("");
		}
	});

	/* ===============================
	   insertModal 유효성 검사 + Ajax
	================================ */

	let insIdOk = false;
	let insEmailOk = false;

	$("#ins_user_id").on("input", () => {
	    insIdOk = false;
	    $("#ins_idCheckMsg").text("");
	});

	$("#ins_user_email").on("input", () => {
	    insEmailOk = false;
	    $("#ins_emailCheckMsg").text("");
	});

	$("#ins_checkIdBtn").click(() => {
	    const id = $("#ins_user_id").val().trim();
	    const pattern = /^[A-Za-z0-9]{1,8}$/;

	    if(!pattern.test(id)){
	        $("#ins_idCheckMsg").text("영문+숫자 8자").css("color","red");
	        return;
	    }

	    $.ajax({
	        url: contextPath + "/user/checkId",
	        type:"GET",
	        data:{ user_id:id },
	        success:function(res){
	            if(res==="available"){
	                $("#ins_idCheckMsg").text("사용 가능").css("color","green");
	                insIdOk=true;
	            } else {
	                $("#ins_idCheckMsg").text("이미 사용중").css("color","red");
	                insIdOk=false;
	            }
	        }
	    });
	});

	$("#ins_checkEmailBtn").click(() => {
	    const email = $("#ins_user_email").val();
	    const pattern=/^[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\.[a-zA-Z]{2,}$/;

	    if(!pattern.test(email)){
	        $("#ins_emailCheckMsg").text("이메일 형식 오류").css("color","red");
	        return;
	    }

	    $.ajax({
	        url: contextPath + "/user/checkEmail",
	        type:"GET",
	        data:{ user_email:email },
	        success:function(res){
	            if(res==="available"){
	                $("#ins_emailCheckMsg").text("사용 가능").css("color","green");
	                insEmailOk=true;
	            } else {
	                $("#ins_emailCheckMsg").text("이미 사용중").css("color","red");
	                insEmailOk=false;
	            }
	        }
	    });
	});

	$("#ins_user_phone").on("input", function(){
	    let v = $(this).val().replace(/[^0-9]/g, "");
	    if(v.length < 4) $(this).val(v);
	    else if(v.length < 8) $(this).val(v.slice(0,3)+"-"+v.slice(3));
	    else $(this).val(v.slice(0,3)+"-"+v.slice(3,7)+"-"+v.slice(7,11));
	});

	$("#ins_agreeAll").on("change", function(){
	    $(".ins-agree-item").prop("checked", $(this).prop("checked"));
	});

	$("#insertBtn").click(function(){

	    $("#insertError").text("");

	    if(!insIdOk){
	        $("#insertError").text("아이디 중복확인을 해주세요.");
	        return;
	    }

	    if(!insEmailOk){
	        $("#insertError").text("이메일 중복확인을 해주세요.");
	        return;
	    }

	    const pw = $("#ins_user_password").val();
	    const pw2 = $("#ins_user_password2").val();
	    const pattern=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^*])[A-Za-z\d!@#$%^*]{8,12}$/;

	    if(!pattern.test(pw)){
	        $("#insertError").text("비밀번호 형식 오류입니다.");
	        return;
	    }

	    if(pw !== pw2){
	        $("#insertError").text("비밀번호가 일치하지 않습니다.");
	        return;
	    }

	    $.ajax({
	        type:"POST",
	        url: contextPath + "/user/insertAjax",
	        data: $("#insertForm").serialize(),
	        dataType:"json",
	        success:function(res){
	            if(res.result==="success"){
	                alert("회원가입 완료! 다시 로그인해주세요.");
	                $("#insertModal").fadeOut();
	                $("#loginModal").fadeIn().css("display","flex");
	            } else {
	                $("#insertError").text(res.message);
	            }
	        }
	    });

	});

});
</script>

</body>
</html>