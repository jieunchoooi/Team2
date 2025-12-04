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
				<h3>미승인</h3>
				<div class="stat-number">${teacherMyPageReject}</div>
			</div>
			<div class="stat-card gray ${filter == 'delete' ? 'approval' : ''}" onclick="location.href='${pageContext.request.contextPath}/member/teacherMyPage?filter=delete'">
				<h3>삭제된 강의</h3>
				<div class="stat-number">${teacherMyPageDelete}</div>
			</div>
		</div>
		
		<!-- 강의 목록 -->
		<div class="table-container">
			<div class="table-header">
				<h2>내 강의 목록</h2>
				<a class="btn btn-add" href="${pageContext.request.contextPath}/member/classAdd">+ 강의 추가</a>
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
							<span class="badg badge-rejected">미승인</span>
						</c:if>
						<c:if test="${lectureVO.status eq 'deleteWaiting'}">	
							<span class="badg badge-deleteWaiting">삭제요청</span>
						</c:if>
						<c:if test="${lectureVO.status eq 'delete'}">	
							<span class="badg badge-delete">삭제</span>
						</c:if>
						<c:if test="${lectureVO.status eq 'cancelDelete'}">	
							<span class="badg badge-cancelDelete">삭제취소요청</span>
						</c:if>
						</td>
						<td>${lectureVO.created_at}</td>
						<td>
						<c:if test="${lectureVO.status != 'delete' and lectureVO.status != 'deleteWaiting' 
									and lectureVO.status != 'reject' and lectureVO.status != 'cancelDelete' and lectureVO.status != 'waiting'}">
							<button type="button" class="btn btn-edit-small" data-num="${lectureVO.lecture_num}">수정</button>
						</c:if>	
						<c:if test="${lectureVO.status == 'reject'}">
							<button type="button" class="btn btn-edit-small" data-num="${lectureVO.lecture_num}">상세보기</button>
						</c:if>	
						<c:if test="${lectureVO.status != 'delete' and lectureVO.status != 'deleteWaiting' and lectureVO.status != 'cancelDelete' and lectureVO.status != 'waiting'}">
							<button type="button" class="btn btn-delete-small" data-num="${lectureVO.lecture_num}">삭제</button>
						</c:if>	
						<c:if test="${lectureVO.status == 'delete'}">
							<button type="button" class="btn btn-cencelDelete-small" data-num="${lectureVO.lecture_num}">삭제취소</button>
						</c:if>	
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
   			 <!-- 맨 처음으로 -->
			    <c:if test="${pageVO.currentPage > 1}">
			        <a href="${pageContext.request.contextPath}/member/teacherMyPage?pageNum=1&filter=${param.filter}">[처음]</a>
			    </c:if>
			    
			    <!-- 10 페이지 이전 -->
			    <c:if test="${pageVO.startPage > pageVO.pageBlock}">
			        <a href="${pageContext.request.contextPath}/member/teacherMyPage?pageNum=${pageVO.startPage - pageVO.pageBlock}&filter=${param.filter}">[이전]</a>
			    </c:if>
			    
			    <!-- 페이지 번호 -->
			    <c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
			        <c:choose>
			            <c:when test="${i == pageVO.currentPage}">
			                <a href="${pageContext.request.contextPath}/member/teacherMyPage?pageNum=${i}&filter=${param.filter}" class="active">${i}</a>
			            </c:when>
			            <c:otherwise>
			                <a href="${pageContext.request.contextPath}/member/teacherMyPage?pageNum=${i}&filter=${param.filter}">${i}</a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			    
			    <!-- 10 페이지 다음 -->
			    <c:if test="${pageVO.endPage < pageVO.pageCount}">
			        <a href="${pageContext.request.contextPath}/member/teacherMyPage?pageNum=${pageVO.startPage + pageVO.pageBlock}&filter=${param.filter}">[다음]</a>
			    </c:if>
			    
			    <!-- 맨 끝으로 -->
			    <c:if test="${pageVO.currentPage < pageVO.pageCount}">
			        <a href="${pageContext.request.contextPath}/member/teacherMyPage?pageNum=${pageVO.pageCount}&filter=${param.filter}">[끝]</a>
			    </c:if>
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
        let lectureNum = this.getAttribute('data-num');

        if(confirm("정말 이 강의를 삭제하시겠습니까?")) {
            alert("강의 삭제 요청 하였습니다.");
            location.href = "${pageContext.request.contextPath}/member/deleteLecture?lecture_num=" + lectureNum;
        }
    }
});

// 강의 삭제 취소
let cencelDeleteBtn = document.querySelectorAll('.btn-cencelDelete-small');
cencelDeleteBtn.forEach(function(btn) {
    btn.onclick = function() {
        let lectureNum = this.getAttribute('data-num');

        if(confirm("삭제 취소 요청 하시겠습니까?")) {
            alert("강의 삭제 취소 요청 하였습니다.");
            location.href = "${pageContext.request.contextPath}/member/cenceldeleteLecture?lecture_num=" + lectureNum;
        }
    }
});

// 강의 수정
// let editButtons = document.querySelectorAll('.btn-edit-small');
// editButtons.forEach(function(btn) {
//     btn.onclick = function() {
//         let lectureNum = this.getAttribute('data-num');
// //         alert("수정 페이지로 이동합니다.");
//         location.href = "${pageContext.request.contextPath}/member/editLecture?lecture_num=" + lectureNum;
//     }
// });

let editButtons = document.querySelectorAll('.btn-edit-small');
editButtons.forEach(function(btn) {
    btn.onclick = function() {
    	 let lectureNum = this.getAttribute('data-num');
         
         // 동적으로 form 생성해서 POST 전송
         let form = document.createElement('form');
         form.method = 'POST';
         form.action = '${pageContext.request.contextPath}/member/editLecture';
         
         let input = document.createElement('input');
         input.type = 'hidden';
         input.name = 'lecture_num';
         input.value = lectureNum;
         
         form.appendChild(input);
         document.body.appendChild(form);
         form.submit();
     }
});


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