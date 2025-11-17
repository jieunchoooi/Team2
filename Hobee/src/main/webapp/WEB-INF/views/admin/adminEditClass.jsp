<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클래스 수정 | Hobee Admin</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminClassadd.css">

</head>
<body>

	<!-- header -->

	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
	<main class="main-content">
		<div class="main-header">
			<h1>클래스 수정</h1>
		</div>

		<form class="form-container"
			action="${pageContext.request.contextPath}/admin/adminClassEditPro"
			method="post" enctype="multipart/form-data">
			<div class="form-group">
				<img id="preview-img" alt="lecture_img"
					src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lectureVO.lecture_img}">
				<label class="file-input-label" for="profilePic">썸네일 이미지 수정</label>
				<input type="hidden" name="oldfile" value="${lectureVO.lecture_img}" readonly>
				<input type="file" name="lecture_img" id="profilePic"
					accept="image/*">
			</div>

			<!--         ✅ 카테고리 선택 추가 -->
			<div class="form-group">
				<label>카테고리</label> <select name="category_detail" id="category"
					required>
					<option value="디지털 드로잉"
						${lectureVO.category_detail == '디지털 드로잉' ? 'selected' : ''}>디지털
						드로잉</option>
					<option value="드로잉"
						${lectureVO.category_detail == '드로잉' ? 'selected' : ''}>드로잉</option>
					<option value="공예"
						${lectureVO.category_detail == '공예' ? 'selected' : ''}>공예</option>
					<option value="AI"
						${lectureVO.category_detail == 'AI' ? 'selected' : ''}>AI</option>
					<option value="프로그래밍"
						${lectureVO.category_detail == '프로그래밍' ? 'selected' : ''}>프로그래밍</option>
					<option value="데이터 사이언스"
						${lectureVO.category_detail == '데이터 사이언스' ? 'selected' : ''}>데이터
						사이언스</option>
					<option value="영어"
						${lectureVO.category_detail == 'english' ? 'selected' : ''}>영어</option>
					<option value="외국어 시험"
						${lectureVO.category_detail == 'foreign_language_test' ? 'selected' : ''}>외국어
						시험</option>
					<option value="제2외국어"
						${lectureVO.category_detail == '제2외국어' ? 'selected' : ''}>제2외국어</option>
				</select>
			</div>

			<div class="form-group">
				<label>강의 번호</label> <input type="text" name="lecture_num"
					value="${lectureVO.lecture_num}">
			</div>
			<div class="form-group">
				<label>강의명</label> <input type="text" name="lecture_title"
					value="${lectureVO.lecture_title}">
			</div>
			<div class="form-group">
				<label>강사명</label> <input type="text" name="lecture_author"
					value="${lectureVO.lecture_author}">
			</div>
			<div class="form-group">
				<label>금액</label> <input type="number" name="lecture_price"
					value="${lectureVO.lecture_price}">
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

<script type="text/javascript">
	// 이미지 미리보기 기능
	document
			.getElementById('profilePic')
			.addEventListener(
					'change',
					function(event) {
						const file = event.target.files[0];

						if (file) {
							// 이미지 파일인지 확인
							if (!file.type.startsWith('image/')) {
								alert('이미지 파일만 선택할 수 있습니다.');
								event.target.value = '';
								return;
							}

							// FileReader를 사용해서 이미지 미리보기
							const reader = new FileReader();

							reader.onload = function(e) {
								// 미리보기 이미지 업데이트
								document.getElementById('preview-img').src = e.target.result;
							};

							reader.readAsDataURL(file);
						}
					});
</script>
</html>
