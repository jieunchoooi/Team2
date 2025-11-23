<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강사 상세 정보 | Hobee Admin</title>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/adminTeacherDetail.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
	
	<main class="main-content">
		<!-- 헤더 -->
		<div class="main-header">
			<h1>강사 상세 정보</h1>
			<button class="btn-back" onclick="history.back()">← 목록으로</button>
		</div>
		
		<!-- 강사 기본 정보 카드 -->
		<div class="info-container">
			<div class="profile-section">
				<!-- 프로필 사진 -->
				<div class="profile-image">
					<c:choose>
						<c:when test="${not empty userVO.user_file}">
							<img src="${pageContext.request.contextPath}/resources/img/user_picture/${userVO.user_file}"
								 alt="${userVO.user_name} 프로필">
						</c:when>
						<c:otherwise>
							<div class="no-image">
								<i class="icon">👤</i>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				
				<!-- 상태 배지 -->
				<div class="status-badge">
					<c:choose>
						<c:when test="${userVO.user_status eq 'active'}">
							<span class="badge badge-active">활동중</span>
						</c:when>
						<c:otherwise>
							<span class="badge badge-inactive">비활동</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<!-- 정보 섹션 -->
			<div class="info-section">
				<h2 class="info-title">기본 정보</h2>
				
				<div class="info-grid">
					<div class="info-item">
						<div class="info-label">강사명</div>
						<div class="info-value">${userVO.user_name}</div>
					</div>
					
					<div class="info-item">
						<div class="info-label">아이디</div>
						<div class="info-value">${userVO.user_id}</div>
					</div>
					
					<div class="info-item">
						<div class="info-label">이메일</div>
						<div class="info-value">${userVO.user_email}</div>
					</div>
					
					<div class="info-item">
						<div class="info-label">휴대폰 번호</div>
						<div class="info-value">
							<c:choose>
								<c:when test="${not empty userVO.user_phone}">
									${userVO.user_phone}
								</c:when>
								<c:otherwise>
									<span class="text-muted">등록된 번호 없음</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					
					<div class="info-item">
						<div class="info-label">가입일</div>
						<div class="info-value">
							<fmt:formatDate value="${userVO.created_at}" pattern="yyyy-MM-dd"/>
						</div>
					</div>
					
					<div class="info-item">
						<div class="info-label">회원번호</div>
						<div class="info-value">${userVO.user_num}</div>
					</div>
				</div>
				
				<!-- 관리 버튼 -->
				<div class="action-buttons">
					<c:if test="${userVO.user_status eq 'active'}">
						<button class="btn btn-warning" id="btn-suspend" 
								data-num="${userVO.user_num}" 
								data-name="${userVO.user_name}">
							강제 탈퇴
						</button>
					</c:if>
					<c:if test="${userVO.user_status ne 'active'}">
						<button class="btn btn-success" id="btn-revert"
								data-num="${userVO.user_num}"
								data-name="${userVO.user_name}">
							회원 복구
						</button>
					</c:if>
				</div>
			</div>
		</div>
		
		<!-- 강사 강의 목록 -->
		<div class="lectures-container">
			<div class="lectures-header">
				<h2>등록한 강의 목록</h2>
<%-- 				<span class="lectures-count">총 <strong>${lectureCount}</strong>개의 강의</span> --%>
			</div>
			
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${not empty lectureList}"> --%>
<!-- 					<div class="lectures-grid"> -->
<%-- 						<c:forEach var="lecture" items="${lectureList}"> --%>
<!-- 							<div class="lecture-card"> -->
<!-- 								썸네일 -->
<!-- 								<div class="lecture-thumbnail"> -->
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${not empty lectureVO.lecture_img}"> --%>
<%-- 											<img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lectureVO.lecture_img}" --%>
<%-- 												 alt="${lectureVO.lecture_title}"> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 											<div class="no-thumbnail"> -->
<!-- 												<span>📚</span> -->
<!-- 											</div> -->
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
<!-- 								</div> -->
								
<!-- 								강의 정보 -->
<!-- 								<div class="lecture-info"> -->
<%-- 									<h3 class="lecture-title">${lectureVO.lecture_title}</h3> --%>
<!-- 									<div class="lecture-meta"> -->
<%-- 										<span class="lecture-category">${lectureVO.category_detail}</span> --%>
<%-- 										<span class="lecture-price">₩ <fmt:formatNumber value="${lectureVO.lecture_price}" pattern="#,###"/></span> --%>
<!-- 									</div> -->
<!-- 									<div class="lecture-date"> -->
<%-- 										등록일: <fmt:formatDate value="${lectureVO.created_at}" pattern="yyyy-MM-dd"/> --%>
<!-- 									</div> -->
<!-- 								</div> -->
								
<!-- 								강의 관리 버튼 -->
<!-- 								<div class="lecture-actions"> -->
<!-- 									<button class="btn-small btn-edit"  -->
<%-- 											onclick="location.href='${pageContext.request.contextPath}/admin/adminEditClass?lecture_num=${lectureVO.lecture_num}'"> --%>
<!-- 										수정 -->
<!-- 									</button> -->
<!-- 									<button class="btn-small btn-delete"  -->
<%-- 											data-num="${lectureVO.lecture_num}" --%>
<%-- 											data-title="${lectureVO.lecture_title}"> --%>
<!-- 										삭제 -->
<!-- 									</button> -->
<!-- 								</div> -->
<!-- 							</div> -->
<%-- 						</c:forEach> --%>
<!-- 					</div> -->
<%-- 				</c:when> --%>
<%-- 				<c:otherwise> --%>
<!-- 					<div class="empty-state"> -->
<!-- 						<div class="empty-icon">📭</div> -->
<!-- 						<p class="empty-text">등록된 강의가 없습니다.</p> -->
<!-- 					</div> -->
<%-- 				</c:otherwise> --%>
<%-- 			</c:choose> --%>
		</div>
	</main>
</body>
<script type="text/javascript">
// 강제 탈퇴
const btnSuspend = document.querySelector("#btn-suspend");
if(btnSuspend) {
	btnSuspend.onclick = function(){
		const userNum = this.getAttribute("data-num");
		const userName = this.getAttribute("data-name");
		
		if(confirm(userName + " 강사를 강제 탈퇴시키겠습니까?")) {
			location.href = "${pageContext.request.contextPath}/admin/MemberAdminDelete?user_num=" + userNum + "&returnPage=teacher";
			alert("탈퇴 처리되었습니다.");
		}
	}
}

// 회원 복구
const btnRevert = document.querySelector("#btn-revert");
if(btnRevert) {
	btnRevert.onclick = function(){
		const userNum = this.getAttribute("data-num");
		const userName = this.getAttribute("data-name");
		
		if(confirm(userName + " 강사를 복구하시겠습니까?")) {
			location.href = "${pageContext.request.contextPath}/admin/MemberRevert?user_num=" + userNum;
			alert("복구되었습니다.");
		}
	}
}

// 강의 삭제
const deleteButtons = document.querySelectorAll(".btn-delete");
deleteButtons.forEach(function(btn) {
	btn.onclick = function(){
		const lectureNum = this.getAttribute("data-num");
		const lectureTitle = this.getAttribute("data-title");
		
		if(confirm('"' + lectureTitle + '" 강의를 삭제하시겠습니까?')) {
			location.href = "${pageContext.request.contextPath}/admin/deleteClass?lecture_num=" + lectureNum;
			alert("강의가 삭제되었습니다.");
		}
	}
});
</script>
</html>
