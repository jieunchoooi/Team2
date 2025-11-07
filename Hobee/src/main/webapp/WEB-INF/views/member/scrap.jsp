<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스크랩 / 관심 | Hobee</title>
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
    <h1>스크랩 / 관심</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>썸네일</th>
          <th>강의명</th>
          <th>강사명</th>
          <th>가격</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><img src="${pageContext.request.contextPath}/resources/images/sample.jpg" width="80"></td>
          <td>수채화 기초 클래스</td>
          <td>이화가</td>
          <td>₩45,000</td>
          <td><button class="btn btn-delete">스크랩 해제</button></td>
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
