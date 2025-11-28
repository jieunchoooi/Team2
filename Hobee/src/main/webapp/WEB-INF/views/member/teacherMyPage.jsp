<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강사 마이페이지 | Hobee</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/member/teacherMyPage.css">
	<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/include/profileCard.css">
	<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/member/memberSidebar.css">
</head>
<body>

	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
		<!-- 좌측 사이드바 -->
	<jsp:include page="../include/memberSidebar.jsp"></jsp:include>
	<main class="main-content">
	<div class="content-wrapper">
		
	<jsp:include page="../include/profileCard.jsp" />
		<!-- 통계 카드 -->
		<div class="stats-container">
			<div class="stat-card ${filter == 'all' ? 'approval' : ''}" onclick="location.href='${pageContext.request.contextPath}/member/teacherMyPage?filter=all'">
				<h3>총 강의 수</h3>
				<div class="stat-number">${teacherMyPage}</div>
			</div>
			<div class="stat-card green ${filter == 'approval' ? 'approval' : ''}" onclick="location.href='${pageContext.request.contextPath}/member/teacherMyPage?filter=approval'">
				<h3>승인 완료</h3>
				<div class="stat-number">${teacherMyPageOk}</div>
			</div>
			<div class="stat-card orange ${filter == 'waiting' ? 'approval' : ''}" onclick="location.href='${pageContext.request.contextPath}/member/teacherMyPage?filter=waiting'">	
				<h3>승인 대기</h3>
				<div class="stat-number">${teacherMyPageWaiting}</div>
			</div>
			<div class="stat-card red ${filter == 'reject' ? 'approval' : ''}" onclick="location.href='${pageContext.request.contextPath}/member/teacherMyPage?filter=reject'">
				<h3>반려</h3>
				<div class="stat-number">${teacherMyPageReject}</div>
			</div>
		</div>
		
		<!-- 강의 목록 -->
		<div class="table-container">
			<div class="table-header">
				<h2>내 강의 목록</h2>
				<button class="btn btn-add">
					+ 강의 추가
				</button>
			</div>
			
			<!-- 강의가 없을 때 -->
			<div class="empty-message" style="display: none;">
				<div class="empty-icon">📚</div>
				<p>등록된 강의가 없습니다.</p>
				<p class="empty-sub">새로운 강의를 등록해보세요!</p>
				<button class="btn btn-primary">
					강의 등록하기
				</button>
			</div>
			
			<!-- 강의가 있을 때 -->
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>썸네일</th>
						<th>강의명</th>
						<th>금액</th>
						<th>상태</th>
						<th>등록일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="lectureVO" items="${manageMyCourses}">
					<tr>
						<td>${lectureVO.lecture_num}</td>
						<td><c:choose>
									<c:when test="${not empty lectureVO.lecture_img}">
										<img
											src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lectureVO.lecture_img}"
											alt="썸네일" style="width: 80px; height: 80px;">
									</c:when>
									<c:otherwise>
										<span style="color: #999;">이미지 없음</span>
									</c:otherwise>
								</c:choose></td>
						<td class="lecture-title">${lectureVO.lecture_title}</td>
						<td class="lecture-price">₩ <fmt:formatNumber value="${lectureVO.lecture_price}" pattern="#,###"/></td>
						<td>
						<c:if test="${lectureVO.status eq 'approval'}">
							<span class="badg badge-approved">승인</span>
						</c:if>
						<c:if test="${lectureVO.status eq 'waiting'}">	
							<span class="badg badge-pending">승인대기</span>
						</c:if>
						<c:if test="${lectureVO.status eq 'reject'}">	
							<span class="badg badge-rejected">반려</span>
						</c:if>
						</td>
						<td>${lectureVO.created_at}</td>
						<td>
							<button type="button" class="btn btn-edit-small">수정</button>
							<button type="button" class="btn btn-delete-small">삭제</button>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 페이지네이션 -->
			<div class="pagination">
				<a href="#">[이전]</a>
				<a href="#" class="active">1</a>
				<a href="#">2</a>
				<a href="#">3</a>
				<a href="#">[다음]</a>
			</div>
		</div>
	</div>	
	</main>
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
// 강의 삭제
let deleteButtons = document.querySelectorAll('.btn-delete-small');
deleteButtons.forEach(function(btn) {
    btn.onclick = function() {
        if(confirm("정말 이 강의를 삭제하시겠습니까?")) {
            alert("강의가 삭제되었습니다.");
            // location.href = "deleteLecture?lecture_num=" + lectureNum;
        }
    }
});

// 강의 수정
let editButtons = document.querySelectorAll('.btn-edit-small');
editButtons.forEach(function(btn) {
    btn.onclick = function() {
        // location.href = "editLecture?lecture_num=" + lectureNum;
        alert("수정 페이지로 이동합니다.");
    }
});

// 정보 수정
// let editInfoButton = document.querySelector('.btn-edit');
// editInfoButton.onclick = function() {
//     // location.href = "editInfo";
//     alert("정보 수정 페이지로 이동합니다.");
// }

// 강의 등록하기 (빈 메시지에서)
let primaryButton = document.querySelector('.btn-primary');
if(primaryButton) {
    primaryButton.onclick = function() {
        // location.href = "addLecture";
        alert("강의 등록 페이지로 이동합니다.");
    }
}
</script>
</html>