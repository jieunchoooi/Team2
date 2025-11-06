<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/include/menu.css">
</head>
<body>

<header>
	<h1><a href="${pageContext.request.contextPath }/main/main">Hobee</a></h1>
	<nav>
		<div class="nav-left">
			<div class="mega-dropdown">
				<a href="${pageContext.request.contextPath }/main/main">카테고리 ▾</a>
				<div class="mega-content">
					<div class="mega-column">
						<h3>예체능</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath }/category/drawingList">디지털 드로잉</a></li>
							<li><a href="${pageContext.request.contextPath }/category/lecture">드로잉</a></li>
							<li><a href="${pageContext.request.contextPath }/category/lecture">공예</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>IT</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath }/category/lecture">AI 스킬업</a></li>
							<li><a href="${pageContext.request.contextPath }/category/lecture">프로그래밍</a></li>
							<li><a href="${pageContext.request.contextPath }/category/lecture">데이터사이언스</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>외국어</h3>
						<ul>
							<li><a href="${pageContext.request.contextPath }/category/lecture">영어</a></li>
							<li><a href="${pageContext.request.contextPath }/category/lecture">외국어 시험</a></li>
							<li><a href="${pageContext.request.contextPath }/category/lecture">제2 외국어</a></li>
						</ul>
					</div>
				</div>
			</div>
			<a href="${pageContext.request.contextPath }/board/write">커뮤니티</a>
			<a href="${pageContext.request.contextPath }/recommend/recoList">베스트 & 추천강의</a>
		</div>

		<div class="nav-right">
			<a href="#" class="auth-link">로그인</a>
			<a href="#" class="auth-link">회원가입</a>
		    <a href="${pageContext.request.contextPath }/member/mypage" class="auth-link">마이페이지</a>
			<a href="${pageContext.request.contextPath }/admin/adminCategory" class="auth-link">관리자</a>
		</div>
	</nav>
</header>

</body>
</html>