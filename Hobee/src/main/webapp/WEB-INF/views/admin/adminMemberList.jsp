<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 목록 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/adminCommon.css">
</head>
<body>
<header>
  <h1>Hobee 관리자</h1>
</header>

<jsp:include page="../include/adminSidebar.jsp"></jsp:include>

<main class="main-content">
  <div class="main-header">
    <h1>회원 목록</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>이름</th>
          <th>아이디</th>
          <th>이메일</th>
          <th>가입일</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>홍길동</td>
          <td>hong123</td>
          <td>hong@example.com</td>
          <td>2025-10-01</td>
          <td>
            <button class="btn">상세보기</button>
            <button class="btn btn-delete">강제탈퇴</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
