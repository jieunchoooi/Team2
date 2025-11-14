<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee Header</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/include/header.css">
</head>
<body>

<header>
	<h1><a href="${pageContext.request.contextPath }/main/main">Hobee</a></h1>

	<nav>
		<div class="nav-left">

			<!-- 기존 메뉴 그대로 유지 -->
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

		<!-- ⭐ 로그인 상태에 따른 메뉴 분기 -->
		<div class="nav-right">

			<!-- 🔹 로그인 전: 팀 기존 메뉴 그대로 유지 -->
			<c:if test="${empty sessionScope.user_id}">
				<a href="${pageContext.request.contextPath }/user/login" class="auth-link">로그인</a>
				<a href="${pageContext.request.contextPath }/user/insert" class="auth-link">회원가입</a>
				<a href="${pageContext.request.contextPath }/member/mypage" class="auth-link">마이페이지</a> 
				<a href="${pageContext.request.contextPath }/admin/adminCategory" class="auth-link">관리자</a>
			</c:if>

			<!-- 🔹 로그인 후: 사용자 메뉴 -->
			<c:if test="${not empty sessionScope.user_id}">
				<span class="welcome-text">${sessionScope.user_name}님</span>

				<!-- 마이페이지 -->
				<a href="${pageContext.request.contextPath }/member/mypage" class="auth-link">마이페이지</a>

				<!-- 로그아웃 -->
				<a href="${pageContext.request.contextPath }/user/logout" class="auth-link">로그아웃</a>
			</c:if>

		</div>

	</nav>
</header>

</body>
</html>
