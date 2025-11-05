<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리 편집 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/adminCommon.css">
</head>
<body>
<header>
  <h1>Hobee 관리자</h1>
</header>

<aside class="sidebar">
  <h2>클래스 관리</h2>
  <div class="menu">
    <div class="menu-item active" onclick="location.href='${ pageContext.request.contextPath }/admin/adminCategory'">📂 <span>카테고리 편집</span></div>
    <div class="menu-item" onclick="location.href='${ pageContext.request.contextPath }/admin/adminClassAdd'">➕ <span>클래스 등록</span></div>
    <div class="menu-item" onclick="location.href='${ pageContext.request.contextPath }/admin/adminClassList'">📋 <span>클래스 목록</span></div>
  </div>
  <button class="logout-btn" onclick="logout()">로그아웃</button>
</aside>

<main class="main-content">
  <div class="main-header">
    <h1>카테고리 관리</h1>
  </div>

  <div class="form-container">
    <div class="form-group">
      <label>카테고리명 추가</label>
      <input type="text" placeholder="새 카테고리 입력">
      <button class="btn" style="margin-top:10px;">추가</button>
    </div>
  </div>

  <div class="table-container" style="margin-top:30px;">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>카테고리명</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>공예</td>
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
