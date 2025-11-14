<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클래스 수정 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminClassadd.css">

</head>
<body>

<!-- header -->

<jsp:include page="../include/header.jsp"></jsp:include>
<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
<main class="main-content">
  <div class="main-header">
    <h1>클래스 수정</h1>
  </div>

  <form class="form-container" action="${pageContext.request.contextPath}/admin/adminClassEditPro" method="post" enctype="multipart/form-data">
     <div class="form-group">	
    <img alt="lecture_img" src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lectureVO.lecture_img}">
      <label>썸네일 이미지 수정</label>
      <input type="file" name="lecture_img">
    </div>
      
<!--         ✅ 카테고리 선택 추가 -->
    <div class="form-group">
      <label>카테고리</label>
      <select name="category_detail" id="category" required>
        <option value="digital_drawing" ${lectureVO.category_detail == 'digital_drawing' ? 'selected' : ''}>디지털 드로잉</option>
    	<option value="drawing" ${lectureVO.category_detail == 'drawing' ? 'selected' : ''}>드로잉</option>
   		<option value="crafts" ${lectureVO.category_detail == 'crafts' ? 'selected' : ''}>공예</option>
    	<option value="AI" ${lectureVO.category_detail == 'AI' ? 'selected' : ''}>AI</option>
    	<option value="programming" ${lectureVO.category_detail == 'programming' ? 'selected' : ''}>프로그래밍</option>
    	<option value="data_science" ${lectureVO.category_detail == 'data_science' ? 'selected' : ''}>데이터 사이언스</option>
    	<option value="english" ${lectureVO.category_detail == 'english' ? 'selected' : ''}>영어</option>
    	<option value="foreign_language_test" ${lectureVO.category_detail == 'foreign_language_test' ? 'selected' : ''}>외국어 시험</option>
    	<option value="second_language" ${lectureVO.category_detail == 'second_language' ? 'selected' : ''}>제2외국어</option>
      </select>
    </div>

    <div class="form-group">
      <label>강의 번호</label>
      <input type="text" name="lecture_num" value="${lectureVO.lecture_num}">
    </div>
    <div class="form-group">
      <label>강의명</label>
      <input type="text" name="lecture_title" value="${lectureVO.lecture_title}">
    </div>
    <div class="form-group">
      <label>강사명</label>
      <input type="text" name="lecture_author" value="${lectureVO.lecture_author}">
    </div>
    <div class="form-group">
      <label>금액</label>
      <input type="number" name="lecture_price" value="${lectureVO.lecture_price}">
    </div>
    <div class="form-group">
      <label>상세정보</label>
      <textarea name="lecture_detail">${lectureVO.lecture_detail}</textarea>
    </div>
    <div class="form-group">
      <label>커리큘럼</label>
      <textarea name="curriculum" placeholder="커리큘럼을 입력하세요"></textarea>
    </div>
   
    <button class="btn">수정하기</button>
  </form>
</main>
</body>
</html>
