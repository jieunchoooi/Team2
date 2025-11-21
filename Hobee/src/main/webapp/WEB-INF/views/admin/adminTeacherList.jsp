<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판 목록 관리 | Hobee Admin</title>

<!-- 공통 관리자 CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

<!-- 게시판 목록 전용 CSS -->
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminTeacherList.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
	<main class="main-content">
		<div class="main-header">
			<h1>강사 목록</h1>
		</div>
		
		<div class="stats-container">
			<div class="stat-card ${filter == 'all' ? 'active' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminTeacherList?filter=all'">
				<h3>총 강사 수</h3>
				<div class="stat-number">${totalCount}</div>
			</div>
			<div class="stat-card orange ${filter == 'active' ? 'active' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminTeacherList?filter=active'">
				<h3>활동 강사 수</h3>
				<div class="stat-number">${tCount}</div>
			</div>
			<div class="stat-card green ${filter == 'inactive' ? 'active' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminTeacherList?filter=inactive'">
				<h3>비활동 강사 수</h3>
				<div class="stat-number">${intCount}</div>
			</div>
		</div>

		<div class="search-box">
			<input type="text" placeholder="이름, 아이디, 이메일로 검색...">
			<button>검색</button>
		</div>
		
		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>프로필</th>
						<th>이름</th>
						<th>아이디</th>
						<th>이메일</th>
						<th>상태</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${teacherList}">
						<tr>
							<td>${user.user_num}</td>
							<td><c:choose>
								<c:when test="${not empty user.user_file}">
									<img src="${pageContext.request.contextPath}/resources/img/user_picture/${user.user_file}"
										 alt="프로필" style="width: 80px; height: 80px;"></c:when>
									<c:otherwise>
										<span style="color: #999;">이미지 없음</span>
									</c:otherwise>
								</c:choose> </td>
							<td>${user.user_name}</td>
							<td>${user.user_id}</td>
							<td>${user.user_email}</td>
							<td>
								<c:choose>
									<c:when test="${user.user_status eq 'active'}">
										<span class="badge badge-active">활동중</span>
									</c:when>
									<c:otherwise>
										<span class="badge badge-inactive">비활동</span>
									</c:otherwise>
								</c:choose>
							</td>
							
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
		</div>
		<div class="pagination">
				<!-- 10 만큼 이전 -->
				<c:if test="${pageVO.startPage > pageVO.pageBlock }">
					<a href="${ pageContext.request.contextPath }/admin/adminTeacherList?pageNum=${pageVO.startPage - pageVO.pageBlock}">[이전]</a>
				</c:if>
				
				<c:forEach var="i" begin="${pageVO.startPage}"
					end="${pageVO.endPage}" step="1">
					<a href="${ pageContext.request.contextPath }/admin/adminTeacherList?pageNum=${i}">${i}</a>
				</c:forEach>

				<!-- 10만큼 다음 -->
				<c:if test="${pageVO.endPage < pageVO.pageCount }">
					<a href="${ pageContext.request.contextPath }/admin/adminTeacherList?pageNum=${pageVO.startPage + pageVO.pageBlock}">[다음]</a>
				</c:if>
			</div>
	</main>
</body>
<script type="text/javascript">
let deletebtn = document.querySelectorAll(".btn-delete");
let sumtc = document.querySelector(".stat-number");

//강제 탈퇴 버튼
sumtc = function(){
	href = "${pageContext.request.contextPath}/admin/sumTeacher"
}

deletebtn.forEach(function(btn){
	btn.onclick = function(){
		let userNum = this.getAttribute("data-num");
        let userName = this.getAttribute("data-name"); 
        
        let result = confirm(userName + "님을 강제 탈퇴시키겠습니까?"); 
        if(result) {
            location.href = "${pageContext.request.contextPath}/admin/MemberAdminDelete?user_num=" + userNum + "&returnPage=teacher";
			alert("탈퇴되었습니다.");
        }
    }
});

// 회원복구 버튼
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