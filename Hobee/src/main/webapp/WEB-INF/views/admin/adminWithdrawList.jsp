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
								<button class="btn btn-revert" data-num="${user.user_num}" ata-name="${user.user_name}">탈퇴 취소</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
				<!-- 10 만큼 이전 -->
				<c:if test="${pageVO.startPage > pageVO.pageBlock }">
					<a
						href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${pageVO.startPage - pageVO.pageBlock}">[이전]</a>
				</c:if>

				<c:forEach var="i" begin="${pageVO.startPage}"
					end="${pageVO.endPage}" step="1">
					<a
						href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${i}">${i}</a>
				</c:forEach>

				<!-- 10만큼 다음 -->
				<c:if test="${pageVO.endPage < pageVO.pageCount }">
					<a
						href="${ pageContext.request.contextPath }/admin/adminMemberList?pageNum=${pageVO.startPage + pageVO.pageBlock}">[다음]</a>
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
