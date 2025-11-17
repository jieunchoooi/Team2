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

		<div class="search-box">
			<input type="text" placeholder="이름, 아이디, 이메일로 검색...">
			<button>검색</button>
			<button>전체회원</button>
		</div>
		<div class="table-container">
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
								<button class="btn btn-delete" data-num="${user.user_num}" data-name="${user.user_name}">강제탈퇴</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
				<!-- 10 만큼 이전 -->
				<c:if test="${pageVO.startPage > pageVO.pageBlock }">
					<a href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${pageVO.startPage - pageVO.pageBlock}">[이전]</a>
				</c:if>

				<c:forEach var="i" begin="${pageVO.startPage}"
					end="${pageVO.endPage}" step="1">
					<a href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${i}">${i}</a>
				</c:forEach>

				<!-- 10만큼 다음 -->
				<c:if test="${pageVO.endPage < pageVO.pageCount }">
					<a href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${pageVO.startPage + pageVO.pageBlock}">[다음]</a>
				</c:if>
			</div>
		</div>

	</main>

</body>
<script type="text/javascript">
let detail = document.querySelectorAll(".detail");
let deletebtn = document.querySelectorAll(".btn-delete");

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
            location.href = "${pageContext.request.contextPath}/admin/MemberAdminDelete?user_num=" + userNum;
			alert("탈퇴되었습니다.");
        }
    }
});



</script>
</html>
