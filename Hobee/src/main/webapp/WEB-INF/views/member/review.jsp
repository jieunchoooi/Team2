<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내가 쓴 리뷰 | Hobee</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageCommon.css">
</head>
<body>

<header>
  <h1><a href="${pageContext.request.contextPath }/main/main">Hobee</a></h1>
  <nav>
    <a href="${pageContext.request.contextPath }/main/main">홈</a>
    <a href="${pageContext.request.contextPath }/category/list">카테고리</a>
    <a href="${pageContext.request.contextPath }/mypage/mypage">마이페이지</a>
    <a href="${pageContext.request.contextPath }/member/logout" onclick="logout()">로그아웃</a>
  </nav>
</header>

<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<main class="main-content">
  <div class="main-header">
    <h1>내가 쓴 리뷰</h1>
  </div>

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
</main>

<script>
function logout() {
  alert("로그아웃되었습니다.");
  location.href = "${pageContext.request.contextPath}/member/logout";
}
</script>
</body>
</html>
