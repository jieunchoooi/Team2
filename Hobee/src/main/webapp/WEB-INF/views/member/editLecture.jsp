<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의 등록 | Hobee Admin</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/member/memberSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminClassEditinfo.css">

</head>
<body>
	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/memberSidebar.jsp"></jsp:include>
	<main class="main-content">
		<div class="main-header">
			<h1>강의 상세 정보</h1>
		</div>

		<form id="classAddForm" class="form-container"
			action="${pageContext.request.contextPath}/member/classUpdate"
			method="post" enctype="multipart/form-data">
			
			<input type="hidden" name="lecture_num" value="${lectureVO.lecture_num}">
		    <input type="hidden" name="oldfile" value="${lectureVO.lecture_img}">
		    
		    <!-- ✅ 미승인 사유 버튼 상단 우측으로 이동 -->
		    <c:if test="${lectureVO.status == 'reject'}">
		    	<button type="button" class="rejectBtn" data-num="${lectureVO.lecture_num}">미승인 사유</button>
		    </c:if>
		    <div class="profile-pic">
				<c:choose>
					<c:when test="${empty lectureVO.lecture_img}">
						<span>📚</span>
					</c:when>
					<c:otherwise>
						<img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lectureVO.lecture_img}" alt="프로필 사진" 
						     style="width: 200px; height: 200px; object-fit: cover;">
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="form-group">
				<label>썸네일 이미지 변경</label> 
				<input type="file" name="lecture_img" id="lecture_img">
			</div>
			
			<div class="form-group">
 				<label>등록일 (신청일)</label>  
 				<input type="text" name="created_at" value="${lectureVO.created_at}" readonly> 
 			</div> 

			<div class="form-group">
				<label>카테고리</label> 
				<input type="text" name="category_detail" id="category_detail" value="${lectureVO.category_detail}" readonly>
			</div>
			
			<div class="form-group">
				<label>강의명</label> 
				<input type="text" name="lecture_title" id="lecture_title" value="${lectureVO.lecture_title}">
			</div>
			
			<div class="form-group">
    			<label>강사명</label>
    			<input type="text" name="lecture_author" id="instructor-search" value="${lectureVO.lecture_author}" class="instructor-search" readonly>
			</div>

			<div class="form-group">
				<label>금액</label> 
				<input type="number" name="lecture_price" id="lecture_price" value="${lectureVO.lecture_price}">
			</div>
			
			<div class="form-group">
				<label>상세정보</label>
				<textarea name="lecture_detail" id="lecture_detail">${lectureVO.lecture_detail}</textarea>
			</div>
			
			<div class="form-group">
				<label>커리큘럼</label>
				<div id="curriculum-container">
					<!-- ✅ 기존 챕터 데이터 렌더링 -->
					<c:forEach var="chapter" items="${chapterList}" varStatus="chapterStatus">
						<div class="chapter-item" data-chapter-index="${chapterStatus.index}">
							<div class="chapter-header">
								<span class="chapter_order">Chapter ${chapterStatus.index + 1}</span>
								<input type="text" name="chapter_title[]" 
								       value="${chapter.chapter_title}" 
								       placeholder="챕터 제목" class="chapter-title">
								<button type="button" class="btn-remove-chapter">챕터 삭제</button>
							</div>
							<div class="details-container">
								<!-- ✅ 챕터의 강의 목록 렌더링 -->
								<c:forEach var="detail" items="${chapter.detailList}" varStatus="detailStatus">
									<div class="detail-item">
										<span class="detail-order">${detailStatus.index + 1}</span>
										<input type="text" name="detail_title_${chapterStatus.index}[]" 
										       value="${detail.detail_title}" 
										       placeholder="강의 제목" class="detail-title">
										<input type="text" name="detail_time_${chapterStatus.index}[]" 
										       value="${detail.detail_time}" 
										       placeholder="00:00 (분:초)" class="detail-time" maxlength="8">
										<button type="button" class="btn-remove-detail">-</button><br>
									</div>
								</c:forEach>
								<input type="file" name="noFile">
							</div>
							<button type="button" class="btn-add-detail">+ 강의 추가</button>
						</div>
					</c:forEach>
					
					<!-- ✅ 챕터가 없을 경우 기본 챕터 1개 표시 -->
					<c:if test="${empty chapterList}">
						<div class="chapter-item">
							<div class="chapter-header">
								<span class="chapter_order">Chapter 1</span>
								<input type="text" name="chapter_title[]" placeholder="챕터 제목" class="chapter-title">
								<button type="button" class="btn-remove-chapter">챕터 삭제</button>
							</div>
							<div class="details-container">
								<div class="detail-item">
									<span class="detail-order">1</span>
									<input type="text" name="detail_title_0[]" placeholder="강의 제목" class="detail-title">
									<input type="text" name="detail_time_0[]" placeholder="00:00 (분:초)" class="detail-time" maxlength="8">
									<button type="button" class="btn-remove-detail">-</button><br>
								</div>
								<input type="file" name="noFile">
							</div>
							<button type="button" class="btn-add-detail">+ 강의 추가</button>
						</div>
					</c:if>
				</div>
				<button type="button" id="add-chapter" class="btn-add">+ 챕터 추가</button>
			</div>
			
			<!-- ✅ 태그 섹션 -->
			<div class="form-group">
				<label>태그 (최대 10개)</label>
				<div class="tag-input-wrapper">
					<input type="text" id="tag-input" placeholder="태그를 입력하세요" class="lecture_tag">
					<button type="button" id="add-tag-btn" class="btn-add-detail1">+ 태그 추가</button>
				</div>
				<div id="tag-container" class="tag-display-area"></div>
				<input type="hidden" name="lecture_tag" id="lecture_tag_hidden">
			</div>

			<div class="btn-wrapper">
				<button class="btn" type="button" onclick="history.back();" style="margin:0;">목록</button>
				<button class="btn btn-primary" type="submit" style="margin:0;">수정하기</button>
			</div>
		</form>
	</main>

<div id="rejectModal" class="dialog">
  <div class="tb">
    <div class="inner" style="max-width:700px; width:90%;">  <!-- 800px → 700px -->
      <div class="top">
        <div class="title">미승인 사유</div>
      </div>
      <div class="ct">
        <div class="reject-form">
<!--           <label for="rejectReason">미승인 사유를 입력해주세요</label> -->
          <textarea id="rejectReason" name="reason" rows="8" readonly>${notApprovedVO.reason}</textarea>
          
          <div class="modal-btn-group">
            <button type="button" class="modal-btn cancel">취소</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">

let lecture_img = document.querySelector("#lecture_img");
let classAddForm = document.querySelector("#classAddForm");
let lecture_title = document.querySelector("#lecture_title");
let lecture_price = document.querySelector("#lecture_price");
let lecture_detail = document.querySelector("#lecture_detail");
const existingImg = document.querySelector(".profile-pic img");
let cContainer = document.querySelector("#curriculum-container");
let chapterNum = ${not empty chapterList ? chapterList.size() : 1};

// 폼 제출 검증
classAddForm.onsubmit = function(e){
	if (lecture_img.files.length === 0 && !existingImg) {
		e.preventDefault(); 
		alert("썸네일을 넣어주세요.");
		lecture_img.focus();
		return false;
	}
	
	if(lecture_title.value.length < 1 || lecture_title.value == ""){
		e.preventDefault(); 
		alert("강의명을 입력해주세요.");
		lecture_title.focus();
		return false;
	}
	
	if(lecture_price.value.length < 1 || lecture_price.value == ""){
		e.preventDefault(); 
		alert("금액을 입력해주세요.");
		lecture_price.focus();
		return false;
	}
	
	if(lecture_detail.value.length < 1 || lecture_detail.value == ""){
		e.preventDefault(); 
		alert("상세정보를 입력해주세요.");
		lecture_detail.focus();
		return false;
	}

	const chapterTitles = document.querySelectorAll('.chapter-title');
	for(let i = 0; i < chapterTitles.length; i++){
		if(!chapterTitles[i].value.trim()){
			e.preventDefault();
			alert(`Chapter ${i + 1}의 제목을 입력해주세요.`);
			chapterTitles[i].focus();
			return false;
		}
	}
	
	const detailTitles = document.querySelectorAll('.detail-title');
	for(let i = 0; i < detailTitles.length; i++){
		if(!detailTitles[i].value.trim()){
			e.preventDefault();
			alert("모든 강의 제목을 입력해주세요.");
			detailTitles[i].focus();
			return false;
		}
	}
	
	const detailTimes = document.querySelectorAll('.detail-time');
	for(let i = 0; i < detailTimes.length; i++){
		if(!detailTimes[i].value.trim()){
			e.preventDefault(); 
			alert("모든 강의 시간을 입력해주세요.");
			detailTimes[i].focus();
			return false;
		}
	}
	
	const timePattern = /^(\d{2}:\d{2}(:\d{2})?)$/;
	for(let i = 0; i < detailTimes.length; i++){
		if(!timePattern.test(detailTimes[i].value)){
			e.preventDefault();
			alert("시간 형식이 올바르지 않습니다. MM:SS 형태로 입력해주세요.");
			detailTimes[i].focus();
			return false;
		}
	}
	
	const hiddenTags = document.getElementById("lecture_tag_hidden").value;
	if (!hiddenTags || hiddenTags.trim() === "") {
		e.preventDefault();
		alert("태그를 1개 이상 입력해주세요.");
		document.getElementById("tag-input").focus();
		return false;
	}
	
	return reindexChapters();
}

// 시간 자동 포맷 적용 함수
function attachStrictTimeFormatter(input) {
	input.addEventListener("input", function() {
		let value = this.value.replace(/[^0-9]/g, '');
		if (value.length > 4) value = value.slice(0, 4);
		
		let formatted = '';
		if (value.length >= 1) {
			formatted = value.slice(0, 2);
		}
		if (value.length >= 3) {
			let ss = value.slice(2, 4);
			if (parseInt(ss) > 59) ss = '59';
			formatted += ':' + ss;
		}
		
		this.value = formatted;
	});
}

// 기존 입력칸에 적용
document.querySelectorAll(".detail-time").forEach(input => attachStrictTimeFormatter(input));

// 파일 선택 시 미리보기
lecture_img.addEventListener('change', function(e) {
	let file = e.target.files[0];
	if (!file) return;

	if (!file.type.startsWith('image/')) {
		alert('이미지 파일만 선택해주세요.');
		this.value = '';
		return;
	}

	let reader = new FileReader();
	reader.onload = function(e) {
		let profilePic = document.querySelector(".profile-pic");
		profilePic.innerHTML = '';

		let img = document.createElement('img');
		img.alt = '강의 사진';
		img.src = e.target.result;
		img.style.width = '200px';
		img.style.height = '200px';
		img.style.objectFit = 'cover';

		profilePic.appendChild(img);
	}
	reader.readAsDataURL(file);
});

// 태그 기능
document.addEventListener("DOMContentLoaded", function () {
	let tagInput = document.getElementById("tag-input");
	let addTagBtn = document.getElementById("add-tag-btn");
	let tagContainer = document.getElementById("tag-container");
	let hiddenInput = document.getElementById("lecture_tag_hidden");
	let tags = [];

	function updateHiddenInput() {
		hiddenInput.value = tags.join(",");
	}

	function addTag(tagText, isInitial = false) {
		tagText = tagText.trim();
		if (tagText === "") return;
		if (!isInitial) {
			if (tags.length >= 10) {
				alert("최대 10개까지 입력 가능합니다.");
				return;
			}
			if (tags.includes(tagText)) {
				alert("이미 추가된 태그입니다.");
				return;
			}
		}

		tags.push(tagText);

		let tagChip = document.createElement("div");
		tagChip.className = "tag-chip";
		tagChip.innerHTML = '<span class="tag-text">#' + tagText + '</span><button type="button" class="tag-remove-btn">×</button>';

		tagChip.querySelector(".tag-remove-btn").addEventListener("click", function () {
			let index = tags.indexOf(tagText);
			if (index > -1) tags.splice(index, 1);
			tagChip.remove();
			updateHiddenInput();
		});

		tagContainer.appendChild(tagChip);
		updateHiddenInput();
		if (!isInitial) tagInput.value = "";
	}

	const existingTags = "${lectureVO.lecture_tag}";
	if (existingTags && existingTags.trim() !== "") {
		existingTags.split(",").forEach(tag => addTag(tag, true));
	}

	addTagBtn.addEventListener("click", function () {
		addTag(tagInput.value);
	});

	tagInput.addEventListener("keypress", function (e) {
		if (e.key === "Enter") {
			e.preventDefault();
			addTag(tagInput.value);
		}
	});
});

// 챕터 번호 업데이트 함수
function updateChapterNumbers() {
	let allChapters = document.querySelectorAll('.chapter-item');
	allChapters.forEach(function(chapter, index) {
		let chapterOrder = chapter.querySelector('.chapter_order');
		chapterOrder.textContent = 'Chapter ' + (index + 1);
	});
	chapterNum = allChapters.length;
}

// 강의 번호 업데이트 함수
function updateDetailNumbers(container) {
	let allDetails = container.querySelectorAll('.detail-item');
	allDetails.forEach(function(detail, index) {
		let detailOrder = detail.querySelector('.detail-order');
		detailOrder.textContent = index + 1;
	});
}

// 이벤트 위임
cContainer.addEventListener('click', function(e) {
	// 챕터 삭제 
	if (e.target.classList.contains('btn-remove-chapter')) {
		let chapterItem = e.target.closest('.chapter-item');
		if (document.querySelectorAll('.chapter-item').length > 1) {
			cContainer.removeChild(chapterItem);
			updateChapterNumbers();
		} else {
			alert('최소 1개의 챕터가 필요합니다.');
		}
		return;
	}
	
	// 강의 추가 버튼
	if (e.target.classList.contains('btn-add-detail')) {
		let detailsContainer = e.target.previousElementSibling;
		let currentDetails = detailsContainer.querySelectorAll('.detail-item');
		let lectureNum = currentDetails.length + 1;
		
		let newBox = document.createElement("div");
		newBox.classList.add("detail-item");
		newBox.innerHTML = 
			'<span class="detail-order">' + lectureNum + '</span>' 
			+'<input type="text" name="detail_title_0[]" placeholder="강의 제목" class="detail-title">' 
			+'<input type="text" name="detail_time_0[]" placeholder="00:00 (분:초)" class="detail-time" maxlength="8">'
			+'<button type="button" class="btn-remove-detail">-</button><br>';

		detailsContainer.appendChild(newBox);
		
		attachStrictTimeFormatter(newBox.querySelector(".detail-time"));
		
		let fileInput = document.createElement("input");
		fileInput.type = "file";
		fileInput.name = "noFile";
		detailsContainer.appendChild(fileInput);
	}
	
	// 강의 삭제 버튼
	if (e.target.classList.contains('btn-remove-detail')){
		let detailItem = e.target.closest('.detail-item');
		let detailsContainer = detailItem.parentElement;

		// 강의 삭제 버튼
		if (e.target.classList.contains('btn-remove-detail')){
		    let detailItem = e.target.closest('.detail-item');
		    let detailsContainer = detailItem.parentElement;

		    if (detailsContainer.querySelectorAll('.detail-item').length > 1) {
		        // ✅ detail-item의 인덱스 찾기
		        let detailItems = Array.from(detailsContainer.querySelectorAll('.detail-item'));
		        let detailIndex = detailItems.indexOf(detailItem);
		        
		        // ✅ 해당 인덱스에 해당하는 파일 input 찾아서 삭제
		        let fileInputs = detailsContainer.querySelectorAll('input[type="file"]');
		        if (fileInputs[detailIndex]) {
		            fileInputs[detailIndex].remove();
		        }
		        
		        // ✅ detail-item 삭제
		        detailsContainer.removeChild(detailItem);
		        
		        updateDetailNumbers(detailsContainer); // 강의 번호 업데이트
		    } else {
		        alert('최소 1개의 강의가 필요합니다.');
		    }
		}
	}
});

// 챕터 추가 버튼
document.getElementById('add-chapter').addEventListener('click', function () {
	chapterNum++;

	let newChapter = document.createElement("div");
	newChapter.classList.add("chapter-item");
	newChapter.innerHTML = 
		'<div class="chapter-header">' 
			+'<span class="chapter_order">Chapter ' + chapterNum + '</span>'
			+'<input type="text" name="chapter_title[]" placeholder="챕터 제목" class="chapter-title">'
			+'<button type="button" class="btn-remove-chapter">챕터 삭제</button>'
		+'</div>'
		+'<div class="details-container">'
			+'<div class="detail-item">'
				+'<span class="detail-order">1</span>'
				+'<input type="text" name="detail_title_0[]" placeholder="강의 제목" class="detail-title">' 
				+'<input type="text" name="detail_time_0[]" placeholder="00:00 (분:초)" class="detail-time" maxlength="8">'
				+'<button type="button" class="btn-remove-detail">-</button><br>'
			+'</div>'
			+'<input type="file" name="noFile">'			
		+'</div>'
		+'<button type="button" class="btn-add-detail">+ 강의 추가</button>';

	cContainer.appendChild(newChapter);
	
	attachStrictTimeFormatter(newChapter.querySelector(".detail-time"));
	updateChapterNumbers();
});

// 폼 제출 전 챕터 인덱스 재정렬
function reindexChapters() {
	let allChapters = document.querySelectorAll('.chapter-item');
	
	allChapters.forEach(function(chapter, chapterIndex) {
		let detailTitles = chapter.querySelectorAll('.detail-title');
		let detailTimes = chapter.querySelectorAll('.detail-time');
		
		detailTitles.forEach(function(input) {
			input.name = 'detail_title_' + chapterIndex + '[]';
		});
		
		detailTimes.forEach(function(input) {
			input.name = 'detail_time_' + chapterIndex + '[]';
		});
	});
	
	console.log('=== 챕터 인덱스 재정렬 완료 ===');
	return true;
}

let dialogModal = document.querySelector(".dialog");
let close = document.querySelector(".cancel");
let rejectBtn = document.querySelector(".rejectBtn");


// 모달창 띄우기
rejectBtn.onclick = function(){
	dialogModal.style.display = "block";
}

// 모달창 닫기
close.onclick = function() {
	dialogModal.style.display = "none";
}









</script>

</body>
</html>