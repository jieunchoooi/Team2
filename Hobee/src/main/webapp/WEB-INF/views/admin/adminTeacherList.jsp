<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강사 목록 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminTeacherList.css">
</head>
<body>
<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>
<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
<main class="main-content">
  <div class="main-header">
    <h1>강사 목록</h1>
  </div>
  
  <div class="stats-container">
    <div class="stat-card">
      <h3>총 강사 수</h3>
      <div class="stat-number">48</div>
    </div>
    <div class="stat-card orange">
      <h3>총 클래스 수</h3>
      <div class="stat-number">156</div>
    </div>
    <div class="stat-card green">
      <h3>활성 강사</h3>
      <div class="stat-number">45</div>
    </div>
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
