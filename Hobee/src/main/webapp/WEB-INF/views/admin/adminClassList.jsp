<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클래스 목록 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/adminCommon.css">
</head>
<body>
<header>
  <h1>Hobee 관리자</h1>
</header>

<aside class="sidebar">
  <h2>클래스 관리</h2>
  <div class="menu">
    <div class="menu-item" onclick="location.href='adminCategory.jsp'">📂 <span>카테고리 편집</span></div>
    <div class="menu-item" onclick="location.href='adminClassAdd.jsp'">➕ <span>클래스 등록</span></div>
    <div class="menu-item active" onclick="location.href='adminClassList.jsp'">📋 <span>클래스 목록</span></div>
  </div>
  <button class="logout-btn" onclick="logout()">로그아웃</button>
</aside>

<main class="main-content">
  <div class="main-header">
    <h1>클래스 목록</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>썸네일</th>
          <th>강의명</th>
          <th>강사명</th>
          <th>금액</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td><img src="sample.jpg" width="60"></td>
          <td>도자기 공예 입문</td>
          <td>김선생</td>
          <td>₩50,000</td>
          <td>
            <button class="btn">수정</button>
            <button class="btn btn-delete">삭제</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
