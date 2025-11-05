<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>탈퇴 회원 목록 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/adminCommon.css">
</head>
<body>
<header>
  <h1>Hobee 관리자</h1>
</header>

<jsp:include page="../include/adminSidebar.jsp"></jsp:include>

<main class="main-content">
  <div class="main-header">
    <h1>탈퇴 회원 목록</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>이름</th>
          <th>아이디</th>
          <th>이메일</th>
          <th>탈퇴일</th>
          <th>비고</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>이탈퇴</td>
          <td>leave123</td>
          <td>leave@example.com</td>
          <td>2025-09-15</td>
          <td>본인 요청 탈퇴</td>
        </tr>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
