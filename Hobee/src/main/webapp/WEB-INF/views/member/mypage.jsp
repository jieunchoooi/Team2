<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | Hobee</title>
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/member/memberSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/member/mypage.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/include/profileCard.css">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!-- 좌측 사이드바 -->
	<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

	<!-- 메인 영역 -->
	<main class="main-content">
		<div class="content-wrapper">
			<!-- 	프로필카드  -->
				<jsp:include page="../include/profileCard.jsp" />


			<div class="form-container">
				<div class="form-group">
					<label for="userId">아이디</label> <span class="form-value">${user.user_id}</span>
				</div>

<!-- 				<div class="form-group"> -->
<%-- 					<label for="password">비밀번호</label> <span class="form-value">${user.user_password}</span> --%>
<!-- 				</div> -->
				<div class="form-group">
					<label for="adress">주소</label> <span class="form-value">${user.user_address1},
						${user.user_address2}</span>
				</div>
				<div class="form-group">
					<label for="tel">휴대폰 번호</label> <span class="form-value">${user.user_phone}</span>
				</div>
				<div class="form-group">
					<label for="email">이메일</label> <span class="form-value">${user.user_email}</span>
				</div>
				<div class="form-group">
					<label for="gender">성별</label> <span class="form-value">${user.user_gender}</span>
				</div>
			</div>
		</div>

	</main>

		<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>
