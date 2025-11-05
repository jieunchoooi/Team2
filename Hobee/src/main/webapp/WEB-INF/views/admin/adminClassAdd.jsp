<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클래스 등록 | Hobee Admin</title>
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
    <div class="menu-item active" onclick="location.href='adminClassAdd.jsp'">➕ <span>클래스 등록</span></div>
    <div class="menu-item" onclick="location.href='adminClassList.jsp'">📋 <span>클래스 목록</span></div>
  </div>
  <button class="logout-btn" onclick="logout()">로그아웃</button>
</aside>

<main class="main-content">
  <div class="main-header">
    <h1>클래스 등록</h1>
  </div>

  <form class="form-container" enctype="multipart/form-data">
    <div class="form-group">
      <label>강의명</label>
      <input type="text" name="title" placeholder="강의명을 입력하세요">
    </div>
    <div class="form-group">
      <label>강사명</label>
      <input type="text" name="teacher" placeholder="강사명을 입력하세요">
    </div>
    <div class="form-group">
      <label>금액</label>
      <input type="number" name="price" placeholder="금액을 입력하세요">
    </div>
    <div class="form-group">
      <label>상세정보</label>
      <textarea name="description" placeholder="강의 상세 정보를 입력하세요"></textarea>
    </div>
    <div class="form-group">
      <label>커리큘럼</label>
      <textarea name="curriculum" placeholder="커리큘럼을 입력하세요"></textarea>
    </div>
    <div class="form-group">
      <label>썸네일 이미지</label>
      <input type="file" name="thumbnail">
    </div>
    <button class="btn" type="submit">등록하기</button>
  </form>
</main>
</body>
</html>
