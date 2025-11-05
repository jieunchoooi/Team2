<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강사 목록 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/adminCommon.css">
</head>
<body>
<header>
  <h1>Hobee 관리자</h1>
</header>

<jsp:include page="../include/adminSidebar.jsp"></jsp:include>

<main class="main-content">
  <div class="main-header">
    <h1>강사 목록</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>프로필</th>
          <th>이름</th>
          <th>아이디</th>
          <th>이메일</th>
          <th>등록 클래스 수</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td><img src="teacher1.jpg" width="50" height="50" style="border-radius:50%;"></td>
          <td>김강사</td>
          <td>teachkim</td>
          <td>teacher@example.com</td>
          <td>5개</td>
          <td>
            <button class="btn">상세보기</button>
            <button class="btn btn-delete">계정 정지</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
