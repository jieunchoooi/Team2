<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내가 쓴 리뷰 | Hobee</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/review.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/profileCard.css">
</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<main class="main-content">
	
	<!-- 중앙 고정 레이아웃 wrapper -->
	<div class="content-wrapper">
		
		<!-- 프로필카드 -->
		<jsp:include page="../include/profileCard.jsp"></jsp:include>
	
<!-- 	  <div class="main-header"> -->
<!-- 	  </div> -->
	
	  <div class="table-container">
	    <table>
	      <thead>
	        <tr>
	          <th>강의명</th>
	          <th>평점</th>
	          <th>내용</th>
	          <th>작성일</th>
	          <th>관리</th>
	        </tr>
	      </thead>
	      <tbody>
	      	<c:forEach var="rev" items="${personalReview}">
		        <tr>
		          <td>${rev.lecture_title}</td>
		          <td>${rev.review_score}</td>
		          <td>${rev.review_content}</td>
		          <td>2025-10-30</td>
		          <td>
		            <button class="btn">수정</button>
		            <button class="btn btn-delete">삭제</button>
		          </td>
		        </tr>
	        </c:forEach>
	      </tbody>
	    </table>
	  </div>
  </div>
</main>


</body>
</html>
