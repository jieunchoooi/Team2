<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원관리 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/MemberManagement.css">
	
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!-- 좌측 사이드바 -->
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>

	<!-- 메인 영역 -->
	<form action="${ pageContext.request.contextPath }/admin/managementPro" method="post">
	<input type="hidden" name="user_num" value="${user.user_num}">
	<main class="main-content">
<!-- 		<h1>회원 관리</h1> -->
		<div class="content-wrapper">
			
			<div class="form-container">
			   <div class="profile-pic">
					<c:choose>
						<c:when test="${empty user.user_file}">
							<span>🐵</span>
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/resources/img/user_picture/${user.user_file}" alt="프로필 사진">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<label for="user_num">번호</label> <span class="form-value">${user.user_num}</span>
				</div>
				<div class="form-group">
					<label for="user_role">권한</label> 
					
					<c:if test="${user.user_role == 'user'}">
						<span class="form-value">유저</span>
					</c:if>
					<c:if test="${user.user_role == 'instructor'}">
						<span class="form-value">강사</span>
					</c:if>
					<c:if test="${user.user_role == 'admin'}">
						<span class="form-value">관리자</span>
					</c:if>
					<c:if test="${user1.user_role == 'super_admin'}">
						<select name="user_role" id="category" required>
	        				<option value="admin" ${user.user_role == 'admin' ? 'selected' : ''}>관리자</option>
	        				<option value="user" ${user.user_role == 'user' ? 'selected' : ''}>유저</option>
						</select>
						<button type="submit" class="user_role_btn" onclick="submitForm()">수정</button>
					</c:if>
				</div>
   			    
				<div class="form-group">
					<label for="userId">아이디</label> <span class="form-value">${user.user_id}</span>
				</div>

<!-- 				<div class="form-group"> -->
<%-- 					<label for="password">비밀번호</label> <span class="form-value">${user.user_password}</span> --%>
<!-- 				</div> -->
				<div class="form-group">
					<label for="adress">주소</label> <span class="form-value">${user.user_address1}, ${user.user_address2}</span>
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
				<div class="form-group">
					<label for="user_status">회원 활동 여부</label> <span class="form-value">${user.user_status}</span>
				</div>
				<div class="form-group">
					<label for="created_at">가입일시</label> <span class="form-value">${user.created_at}</span>
				</div>
				<div class="form-group">
					<label for="grade_id">현재등급</label> <span class="form-value">${user.grade_id}</span>
				</div>
				
				<div class="btnBox">
					<button class="btn" type="button" onclick="history.back();">목록</button>
<!-- 					<button class="btn" type="submit" onclick="return submitForm();">정보 수정</button> -->
				</div>
<!-- 				<a onclick="history.back();"> 목록</a>				 -->
			</div>
		</div>
		
	</main>
</form>

</body>
<script type="text/javascript">

function submitForm() {
    let selectBox = document.getElementById("category");
    let selectedText = selectBox.options[selectBox.selectedIndex].text;
    
    if(confirm("회원 권한을 '" + selectedText + "'(으)로 변경하시겠습니까?")) {
        return true; // 폼 제출 허용
    }
    
    return false; // 폼 제출 막기
}
</script>
</html>