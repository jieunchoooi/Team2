<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강사 목록 | Hobee Admin</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
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
			<div class="stat-card">
				<h3>총 강사 수</h3>
				<div class="stat-number">48</div>
			</div>
			<div class="stat-card orange">
				<h3>총 클래스 수</h3>
				<div class="stat-number">156</div>
			</div>
			<div class="stat-card green">
				<h3>활성 강사</h3>
				<div class="stat-number">45</div>
			</div>
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
						<th>등록 클래스 수</th>
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
							<td>클래스 수</td>
							<td>
								<button class="btn detail" data-num="${user.user_num}">상세보기</button>
								<button class="btn btn-delete">강제탈퇴</button>
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
</html>
