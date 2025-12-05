<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	        <tr>
	          <td>캔들 만들기 입문</td>
	          <td>⭐⭐⭐⭐☆</td>
	          <td>재료도 좋고 강사님 설명이 친절했어요!</td>
	          <td>2025-10-30</td>
	          <td>
	            <button class="btn">수정</button>
	            <button class="btn btn-delete">삭제</button>
	          </td>
	        </tr>
	      </tbody>
	    </table>
	  </div>
  </div>
</main>


</body>
</html>
