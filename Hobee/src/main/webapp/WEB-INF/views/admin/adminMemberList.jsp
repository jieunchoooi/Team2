<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 목록 | Hobee Admin</title>
<script type="text/javascript"
	src="${ pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminMemberList.css">
</head>
<body>


	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
	<main class="main-content">
		<div class="filter-container"></div>
		<div class="main-header">
			<h1>회원 목록</h1>
		</div>

		
		<div class="stats-container">
			<div class="stat-card ${filter == 'all' ? 'active' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminMemberList?filter=all'">
				<h3>총 회원 수</h3>
				<div class="stat-number">${totalcount}</div>
			</div>
			<div class="stat-card orange ${filter == 'active' ? 'active' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminMemberList?filter=active'">
				<h3>활동 회원 수</h3>
				<div class="stat-number">${acount}</div>
			</div>
			<div class="stat-card green  ${filter == 'inactive' ? 'active' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminMemberList?filter=inactive'">
				<h3>탈퇴 회원 수</h3>
				<div class="stat-number">${dcount}</div>
			</div>
		</div>

		<div class="table-container">
		<div class="search-box">
		<form action="${ pageContext.request.contextPath }/admin/adminMemberList" class="search-form" id="search_form">
			<input type="hidden" name="filter" value="${param.filter}"> 
			<select name="searchList" id="searchList">
				<option value="전체"	${pageVO.searchList == '전체' ? 'selected' : ''}>전체 검색</option>
				<option value="이름" ${pageVO.searchList == '이름' ? 'selected' : ''}>이름 검색</option>
				<option value="아이디" ${pageVO.searchList == '아이디' ? 'selected' : ''}>아이디 검색</option>
				<option value="이메일" ${pageVO.searchList == '이메일' ? 'selected' : ''}>이메일 검색</option>
			</select>
			<input type="text" name="search" id="search_box" value="${pageVO.search}" placeholder="이름, 아이디, 이메일로 검색...">
			<button type="submit" class="search-btn" id="search-btn">검색</button>
			<a href="${ pageContext.request.contextPath }/admin/adminMemberList" class="search-btn">전체 회원</a>
		</form>
		</div>
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>아이디</th>
						<th>이메일</th>
						<th>가입일</th>
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
							<td>
								<button class="btn detail" data-num="${user.user_num}">상세보기</button>
								<c:if test="${user.user_status eq 'active'}">
									<button class="btn btn-delete" data-num="${user.user_num}" data-name="${user.user_name}">강제탈퇴</button>
								</c:if>
								<c:if test="${user.user_status ne 'active'}">
									<button class="btn btn-revert" data-num="${user.user_num}" data-name="${user.user_name}">회원복구</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
				<!-- 10 만큼 이전 -->
				<c:if test="${pageVO.startPage > pageVO.pageBlock }">
					<a href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${pageVO.startPage - pageVO.pageBlock}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[이전]</a>
				</c:if>

				<c:forEach var="i" begin="${pageVO.startPage}"
					end="${pageVO.endPage}" step="1">
					<a href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${i}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">${i}</a>
				</c:forEach>

				<!-- 10만큼 다음 -->
				<c:if test="${pageVO.endPage < pageVO.pageCount }">
					<a href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${pageVO.startPage + pageVO.pageBlock}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[다음]</a>
				</c:if>
			</div>
		</div>

	</main>

</body>
<script type="text/javascript">
let detail = document.querySelectorAll(".detail");
let deletebtn = document.querySelectorAll(".btn-delete");
let search_box = document.querySelector("#search_box");
let search_btn = document.querySelector("#search-btn");
let search_form = document.querySelector("#search_form");

// 검색창 
search_btn.onclick = function(e){
	e.preventDefault();
	if(search_box.value == ""){
		alert("검색어를 입력해주세요.");
		search_box.focus();
		return false;
	}
	search_form.submit();
}


detail.forEach(function(btn){
    btn.onclick = function(){
        let userNum = this.getAttribute("data-num");
        location.href = "${pageContext.request.contextPath}/admin/MemberManagement?user_num=" + userNum;
    }
});

deletebtn.forEach(function(btn){
	btn.onclick = function(){
		let userNum = this.getAttribute("data-num");
        let userName = this.getAttribute("data-name"); 
        
        let result = confirm(userName + "님을 강제 탈퇴시키겠습니까?"); 
        if(result) {
        	location.href = "${pageContext.request.contextPath}/admin/MemberAdminDelete?user_num=" + userNum + "&returnPage=member";	
        	alert("탈퇴되었습니다.");
        }
    }
});

//회원복구 버튼
let revertbtn = document.querySelectorAll(".btn-revert");
revertbtn.forEach(function(btn){
	btn.onclick = function(){
		let userNum = this.getAttribute("data-num");
        let userName = this.getAttribute("data-name"); 
        
        let result = confirm(userName + "님을 복구하시겠습니까?"); 
        if(result) {
            location.href = "${pageContext.request.contextPath}/admin/MemberRevert?user_num=" + userNum;
			alert("복구되었습니다.");
        }
    }
});


</script>
</html>
