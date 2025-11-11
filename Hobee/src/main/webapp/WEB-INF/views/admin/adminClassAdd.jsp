<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클래스 등록 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminClassadd.css">

</head>
<body>

<!-- header -->

<jsp:include page="../include/header.jsp"></jsp:include>
<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
<main class="main-content">
  <div class="main-header">
    <h1>클래스 등록</h1>
  </div>

  <form class="form-container" action="${pageContext.request.contextPath}/admin/adminClassAddPro" method="post" enctype="multipart/form-data">
        <!-- ✅ 카테고리 선택 추가 -->
    <div class="form-group">
      <label>카테고리</label>
      <select name="category" id="category" required>
        <option value="">카테고리를 선택하세요</option>
        <option value="digital_drawing">디지털 드로잉</option>
        <option value="drawing">드로잉</option>
        <option value="crafts">공예</option>
        <option value="AI">AI</option>
        <option value="programming">프로그래밍</option>
        <option value="data_science">데이터 사이언스</option>
        <option value="english">영어</option>
        <option value="foreign_language_test">외국어 시험</option>
        <option value="second_language">제2외국어</option>
      </select>
    </div>
    
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
