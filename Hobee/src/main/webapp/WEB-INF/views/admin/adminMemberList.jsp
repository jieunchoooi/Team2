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
		<div class="filter-container">
			<div class="search-box">
				<input type="text" placeholder="이름, 아이디, 이메일로 검색...">
				<button>검색</button>
			</div>
			<select class="filter-select">
				<option>전체 회원</option>
				<option>최근 가입</option>
				<option>활성 회원</option>
			</select>
		</div>
		<div class="main-header">
			<h1>회원 목록</h1>
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
					<c:forEach var="user" items="${memberList}" varStatus="status">
						<tr>
							<td>${user.user_num}</td>
							<td>${user.user_name}</td>
							<td>${user.user_id}</td>
							<td>${user.user_email}</td>
							<td>${user.created_at}</td>
							<td>
								<button class="btn">상세보기</button>
								<button class="btn btn-delete">강제탈퇴</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</main>
</body>
</html>
