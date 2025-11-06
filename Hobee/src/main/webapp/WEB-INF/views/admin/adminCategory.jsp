<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리 편집 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminCategory.css">

</head>

<body>
<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<div class="admin-container">
  <!-- 왼쪽 사이드바 -->
  <jsp:include page="../include/adminSidebar.jsp"></jsp:include>

  <!-- 오른쪽 메인 콘텐츠 -->
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
</div>
</body>

</html>
