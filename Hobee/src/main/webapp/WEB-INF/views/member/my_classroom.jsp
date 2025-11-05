<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 강의실 | Hobee</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageCommon.css">
</head>
<body>

<!-- 헤더 -->
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

<!-- 메인 콘텐츠 -->
<main class="main-content">
  <div class="main-header">
    <h1>내 강의실</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>강의명</th>
          <th>강사명</th>
          <th>진행률</th>
          <th>최근 학습일</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>도자기 공예 입문</td>
          <td>김선생</td>
          <td>60%</td>
          <td>2025-11-01</td>
          <td><button class="btn">계속 학습</button></td>
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
