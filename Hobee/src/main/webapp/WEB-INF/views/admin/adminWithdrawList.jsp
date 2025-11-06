<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>아이디</th>
						<th>이메일</th>
						<th>탈퇴일</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>이탈퇴</td>
						<td>leave123</td>
						<td>leave@example.com</td>
						<td>2025-09-15</td>
						<td><span class="reason-badge user-request">본인 요청 탈퇴</span></td>
						<td><span class="reason-badge forced">강제 탈퇴</span></td>
						<td><span class="reason-badge violation">규정 위반</span></td>
					</tr>
				</tbody>
			</table>
		</div>
	</main>
</body>
</html>
