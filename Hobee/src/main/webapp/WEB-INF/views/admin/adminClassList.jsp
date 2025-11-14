<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클래스 목록 | Hobee Admin</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminClassList.css">
</head>
<body>

	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
	<main class="main-content">
		<div class="main-header">
			<h1>클래스 목록</h1>
		</div>

		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>썸네일</th>
						<th>강의명</th>
						<th>강사명</th>
						<th>금액</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="lectureVO" items="${lectureList}">
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
							<td>${lectureVO.lecture_title}</td>
							<td>${lectureVO.lecture_author}</td>
							<td>₩ <fmt:formatNumber value="${lectureVO.lecture_price}" pattern="#,###"/></td>
							<td>
								<button class="btn">수정</button>
								<button class="btn btn-delete" data-num="${lectureVO.lecture_num}">삭제</button>
								
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
				<!-- 10 만큼 이전 -->
				<c:if test="${pageVO.startPage > pageVO.pageBlock }">
					<a href="${ pageContext.request.contextPath }/admin/adminClassList?pageNum=${pageVO.startPage - pageVO.pageBlock}">[이전]</a>
				</c:if>

				<c:forEach var="i" begin="${pageVO.startPage}"
					end="${pageVO.endPage}" step="1">
					<a href="${ pageContext.request.contextPath }/admin/adminClassList?pageNum=${i}">${i}</a>
				</c:forEach>

				<!-- 10만큼 다음 -->
				<c:if test="${pageVO.endPage < pageVO.pageCount }">
					<a href="${ pageContext.request.contextPath }/admin/adminClassList?pageNum=${pageVO.startPage + pageVO.pageBlock}">[다음]</a>
				</c:if>
			</div>
		</div>
	</main>
</body>
<script type="text/javascript">
	
let deleteBtn = document.querySelectorAll('.btn-delete');

deleteBtn.forEach(function(btn) {
    btn.onclick = function() {
        let lectureNum = this.getAttribute('data-num');
        let result = confirm("클래스를 삭제하시겠습니까?");
        if(result) {
            alert("강의가 삭제되었습니다.");
            location.href = "${pageContext.request.contextPath}/admin/deleteClass?lecture_num=" + lectureNum;
        }
    }
});



</script>
</html>
