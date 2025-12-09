<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의 목록 | Hobee Admin</title>
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
<!-- 		<div class="main-header"> -->
<!-- 			<h1>강의 목록</h1> -->
<!-- 		</div> -->
			
		<div class="stats-container">
			<div class="stat-card ${filter == 'all' ? 'ok' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminClassList?filter=all'">
				<h3>총 강의 수</h3>
				<div class="stat-number">${classCount}</div>
			</div>
			<div class="stat-card ${filter == 'ok' ? 'ok' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminClassList?filter=ok'">
				<h3>승인 된 수</h3>
				<div class="stat-number">${okClassCount}</div>
			</div>
			<div class="stat-card ${filter == 'ask' ? 'ok' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminClassList?filter=ask'">
				<h3>승인(삭제) 요청 강의</h3>
				<div class="stat-number">${askClassCount}</div>
			</div>
			<div class="stat-card ${filter == 'comp' ? 'ok' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminClassList?filter=comp'">
				<h3>미승인 강의</h3>
				<div class="stat-number">${compClassCount}</div>
			</div>
			<div class="stat-card ${filter == 'delete' ? 'ok' : ''}" onclick="location.href='${pageContext.request.contextPath}/admin/adminClassList?filter=delete'">
				<h3>삭제된 강의</h3>
				<div class="stat-number">${deleteClassCount}</div>
			</div>
		</div>
		
		
		
		<div class="table-container">
			<!-- 검색 영역 -->
			<div class="search-wrapper">
				<form action="${ pageContext.request.contextPath }/admin/adminClassList" class="search-form" id="search_form">
				<input type="hidden" name="filter" value="${param.filter}"> 
				<select name="searchList" id="searchList">
				<option value="전체"	${pageVO.searchList == '전체' ? 'selected' : ''}>전체 검색</option>
				<option value="강의명" ${pageVO.searchList == '강의명' ? 'selected' : ''}>강의명 검색</option>
				<option value="강사명" ${pageVO.searchList == '강사명' ? 'selected' : ''}>강사명 검색</option>
			</select>
					<input type="text" name="search" class="search-input" id="search_box" value="${pageVO.search}" placeholder="강의명, 강사 이름으로 검색..."> 
					<button type="submit" class="search-btn" id="search">검색</button>
					<a href="${ pageContext.request.contextPath }/admin/adminClassList" class="search-btn">전체 회원</a>
				</form>
			</div>
			
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>썸네일</th>
						<th>강의명</th>
						<th>강사명</th>
						<th>금액</th>
						<th>상태</th>
						<th>등록일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				    <!-- 강의 목록이 비어 있을 때 -->
				    <c:if test="${empty lectureList}">
				        <tr>
				            <td colspan="8" style="text-align:center; padding: 20px; color:#777;">
				                강의가 없습니다.
				            </td>
				        </tr>
				    </c:if>
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
							<td><c:if test="${lectureVO.status eq 'approval'}">
			                        <span class="badge badge-approved">승인</span>
			                    </c:if>
			                    <c:if test="${lectureVO.status eq 'waiting'}">	
			                        <span class="badge badge-pending">승인대기</span>
			                    </c:if>
			                    <c:if test="${lectureVO.status eq 'reject'}">	
			                        <span class="badge badge-rejected">미승인</span>
			                    </c:if>
			                    <c:if test="${lectureVO.status eq 'deleteWaiting'}">	
			                        <span class="badge badge-deleteWaiting">삭제요청</span>
			                    </c:if>
			                    <c:if test="${lectureVO.status eq 'delete'}">	
			                        <span class="badge badge-delete">삭제</span>
			                    </c:if>
			                    <c:if test="${lectureVO.status eq 'cancelDelete'}">	
									<span class="badge badge-cancelDelete">삭제취소요청</span>
								</c:if>
			                </td>
			                <td>${lectureVO.created_at}</td>
							<td>
								<button type="button" class="btn edit" data-num="${lectureVO.lecture_num}">상세보기</button>
								
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
   			 <!-- 맨 처음으로 -->
			    <c:if test="${pageVO.currentPage > 1}">
			        <a href="${pageContext.request.contextPath}/admin/adminClassList?pageNum=1&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[처음]</a>
			    </c:if>
			    
			    <!-- 10 페이지 이전 -->
			    <c:if test="${pageVO.startPage > pageVO.pageBlock}">
			        <a href="${pageContext.request.contextPath}/admin/adminClassList?pageNum=${pageVO.startPage - pageVO.pageBlock}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[이전]</a>
			    </c:if>
			    
			    <!-- 페이지 번호 -->
			    <c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
			        <c:choose>
			            <c:when test="${i == pageVO.currentPage}">
			                <a href="${pageContext.request.contextPath}/admin/adminClassList?pageNum=${i}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}" class="active">${i}</a>
			            </c:when>
			            <c:otherwise>
			                <a href="${pageContext.request.contextPath}/admin/adminClassList?pageNum=${i}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">${i}</a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			    
			    <!-- 10 페이지 다음 -->
			    <c:if test="${pageVO.endPage < pageVO.pageCount}">
			        <a href="${pageContext.request.contextPath}/admin/adminClassList?pageNum=${pageVO.startPage + pageVO.pageBlock}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[다음]</a>
			    </c:if>
			    
			    <!-- 맨 끝으로 -->
			    <c:if test="${pageVO.currentPage < pageVO.pageCount}">
			        <a href="${pageContext.request.contextPath}/admin/adminClassList?pageNum=${pageVO.pageCount}&filter=${param.filter}&search=${pageVO.search}&searchList=${pageVO.searchList}">[끝]</a>
			    </c:if>
			</div>

		</div>
	</main>
</body>
<script type="text/javascript">
let search = document.querySelector(".search-btn");
let search_box = document.querySelector(".search-input");
let search_form = document.querySelector("#search_form");

search.onclick = function(e){
	e.preventDefault();
	
	if(search_box.value == ""){
		alert("검색어를 입력해주세요.");
		search_box.focus();
		return false;
	}
	search_form.submit();
}

// 클래스 삭제	
// let deleteBtn = document.querySelectorAll('.btn-delete');

// deleteBtn.forEach(function(btn) {
//     btn.onclick = function() {
//         let lectureNum = this.getAttribute('data-num');
//         let result = confirm("강의를 삭제하시겠습니까?");
//         if(result) {
//             alert("강의가 삭제되었습니다.");
//             location.href = "${pageContext.request.contextPath}/admin/deleteClass?lecture_num=" + lectureNum;
//         }
//     }
// });


// 클래스 수정
let edit = document.querySelectorAll(".edit");

edit.forEach(function(btn){
    btn.onclick = function(){
        let lectureNum = this.getAttribute("data-num");
        
        let form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin/adminClassEditinfo';
        
        let input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'lecture_num';
        input.value = lectureNum;
        
        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
});

</script>
</html>
