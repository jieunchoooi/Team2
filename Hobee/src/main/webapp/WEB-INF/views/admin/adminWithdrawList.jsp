<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>탈퇴 회원 목록 | Hobee Admin</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminWithDrawList.css">
</head>
<body>


	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
	<main class="main-content">
		<div class="main-header">
			<h1>탈퇴 회원 목록</h1>
		</div>

		<div class="stats-container">
			<div class="stat-card ${filter == 'all' ? 'user' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminWithdrawList?filter=all'">
				<h3>총 탈퇴 회원 수</h3>
				<div class="stat-number">${totalCount}</div>
			</div>
			<div class="stat-card orange ${filter == 'user' ? 'user' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminWithdrawList?filter=user'">
				<h3>탈퇴 회원 수</h3>
				<div class="stat-number">${mdCount}</div>
			</div>
			<div class="stat-card green ${filter == 'instructor' ? 'user' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminWithdrawList?filter=instructor'">
				<h3>탈퇴 강사 수</h3>
				<div class="stat-number">${intCount}</div>
			</div>
		</div>

		<div class="table-container">
			<div class="search-wrapper">
				<form action="${ pageContext.request.contextPath }/admin/adminWithdrawList" class="search-form" id="search_form">
				  <input type="hidden" name="filter" value="${param.filter}">
					<select name="searchList" id="searchList">
						<option value="전체"	${pageVO.searchList == '전체' ? 'selected' : ''}>전체 검색</option>
						<option value="이름" ${pageVO.searchList == '이름' ? 'selected' : ''}>이름 검색</option>
						<option value="아이디" ${pageVO.searchList == '아이디' ? 'selected' : ''}>아이디 검색</option>
						<option value="이메일" ${pageVO.searchList == '이메일' ? 'selected' : ''}>이메일 검색</option>
					</select>
					<input type="text" name="search" class="search-input" id="search_box" value="${pageVO.search}" placeholder="이름, 아이디, 이메일로 검색..."> 
					<button type="submit" class="search-btn" id="search">검색</button>
				<a href="${ pageContext.request.contextPath }/admin/adminWithdrawList" class="search-btn" id="search_btn">전체 강의</a>
			</form>
			</div>
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>아이디</th>
						<th>이메일</th>
						<th>탈퇴일</th>
						<th>회원</th>
						<th>비고</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${memberList}">
						<tr>
							<td>${user.user_num}</td>
							<td>${user.user_name}</td>
							<td>${user.user_id}</td>
							<td>${user.user_email}</td>
							<td>${user.created_at}</td>
							<td><c:if test="${user.user_role eq 'user'}">학생</c:if>
								<c:if test="${user.user_role eq 'instructor'}">강사</c:if></td>
							<td><c:choose>
									<c:when test="${user.user_status == 'self-withdraw'}">
										<span class="reason-badge user-request">본인 요청 탈퇴</span>
									</c:when>
									<c:when test="${user.user_status == 'withdraw'}">
										<span class="reason-badge forced">강제 탈퇴</span>
									</c:when>
									<c:otherwise>
										<span class="reason-badge">알 수 없음</span>
									</c:otherwise>
								</c:choose></td>
							<td>
								<button class="btn detail" data-num="${user.user_num}">상세보기</button>
								<button class="btn btn-revert" data-num="${user.user_num}" data-name="${user.user_name}">탈퇴 취소</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
				<!-- 10 만큼 이전 -->
				<c:if test="${pageVO.startPage > pageVO.pageBlock }">
					<a
						href="${ pageContext.request.contextPath }/admin/adminWithdrawList?pageNum=${pageVO.startPage - pageVO.pageBlock}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[이전]</a>
				</c:if>

				<c:forEach var="i" begin="${pageVO.startPage}"
					end="${pageVO.endPage}" step="1">
					<a
						href="${ pageContext.request.contextPath }/admin/adminWithdrawList?pageNum=${i}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">${i}</a>
				</c:forEach>

				<!-- 10만큼 다음 -->
				<c:if test="${pageVO.endPage < pageVO.pageCount }">
					<a
						href="${ pageContext.request.contextPath }/admin/adminWithdrawList?pageNum=${pageVO.startPage + pageVO.pageBlock}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[다음]</a>
				</c:if>
			</div>
		</div>
	</main>
</body>
<script type="text/javascript">
let revert = document.querySelectorAll(".btn-revert");
let detail = document.querySelectorAll(".detail");

detail.forEach(function(btn){
    btn.onclick = function(){
        let userNum = this.getAttribute("data-num");
        location.href = "${pageContext.request.contextPath}/admin/MemberManagement?user_num=" + userNum;
    }
});

revert.forEach(function(btn){
	btn.onclick = function(){
		let userNum = this.getAttribute("data-num");
		let userName = this.getAttribute("data-name");
		let result = confirm(userName + "님을 복구시키겠습니까?");
		
		if(result){
			alert("복구되었습니다.");	
            location.href = "${pageContext.request.contextPath}/admin/MemberRevert?user_num=" + userNum;
		}
	}
});




</script>

</html>
