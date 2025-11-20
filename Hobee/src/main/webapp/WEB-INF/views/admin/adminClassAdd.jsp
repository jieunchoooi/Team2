<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>클래스 등록 | Hobee Admin</title>
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
			<h1>클래스 등록</h1>
		</div>

		<form class="form-container" action="${pageContext.request.contextPath}/admin/adminClassAddPro" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label>썸네일 이미지</label> <input type="file" name="lecture_img">
			</div>
			<!-- ✅ 카테고리 선택 추가 -->
			<div class="form-group">
				<label>카테고리</label> <select name="category_detail" id="category"
					required>
					<option value="">카테고리를 선택하세요</option>
					<option value="디지털드로잉">디지털 드로잉</option>
					<option value="드로잉">드로잉</option>
					<option value="공예">공예</option>
					<option value="AI 스킬업">AI 스킬업</option>
					<option value="프로그래밍">프로그래밍</option>
					<option value="데이터사이언스">데이터사이언스</option>
					<option value="영어">영어</option>
					<option value="외국어 시험">외국어 시험</option>
					<option value="제2외국어">제2외국어</option>
				</select>
			</div>

			<div class="form-group">
				<label>강의명</label> <input type="text" name="lecture_title"
					placeholder="강의명을 입력하세요">
			</div>
			<div class="form-group">
				<label>강사명</label> <input type="text" name="lecture_author"
					placeholder="강사명을 입력하세요">
			</div>
			<div class="form-group">
				<label>금액</label> <input type="number" name="lecture_price"
					placeholder="금액을 입력하세요">
			</div>
			<div class="form-group">
				<label>상세정보</label>
				<textarea name="lecture_detail" placeholder="강의 상세 정보를 입력하세요"></textarea>
			</div>
			<div class="form-group">
				<label>커리큘럼</label>
				<div id="curriculum-container">
					<!-- 첫 번째 챕터 -->
					<div class="chapter-item">
						<div class="chapter-header">
							<span class="chapter_order">Chapter 1</span> 
							<input type="text" name="chapter_title[]" placeholder="챕터 제목 (예: 1주차)" class="chapter-title">
							<button type="button" class="btn-remove-chapter">챕터 삭제</button>
						</div>
						<div class="details-container">
							<div class="detail-item">
								<span class="detail-order">1</span> 
								<input type="text" name="detail_title_0[]" placeholder="강의 제목" class="detail-title"> 
								<input type="text" name="detail_time_0[]" placeholder="00:00 (분:초)" class="detail-time">
								<button type="button" class="btn-remove-detail">-</button>
							</div>
						</div>
						<button type="button" class="btn-add-detail">+ 강의 추가</button>
					</div>
				</div>
				<button type="button" id="add-chapter" class="btn-add">+ 챕터 추가</button>
					
					<!-- ✅ 태그 섹션 -->
			<div class="form-group">
				<label>태그 (최대 10개)</label>
				<div class="tag-input-wrapper">
					<input type="text" id="tag-input" placeholder="태그를 입력하세요" class="lecture_tag">
					<button type="button" id="add-tag-btn" class="btn-add-detail1">+ 태그 추가</button>
				</div>
				<!-- 태그들이 표시될 영역 -->
				<div id="tag-container" class="tag-display-area">
					<!-- 여기에 #태그 형태로 추가됨 -->
				</div>
				<!-- 서버로 전송할 hidden input (쉼표로 구분된 태그들) -->
				<input type="hidden" name="lecture_tag" id="lecture_tag_hidden">
			</div>


			<button class="btn" type="submit">등록하기</button>
		</form>
	</main>

<script type="text/javascript">
let chapterIndex = 0; // 챕터 고유 인덱스 관리

//==================== 강의 추가 함수 ====================
function addDetail(chapterElement, chapterIdx) {
 const detailsContainer = chapterElement.querySelector('.details-container');
 const currentCount = detailsContainer.querySelectorAll('.detail-item').length;

 const newDetail = document.createElement('div');
 newDetail.className = 'detail-item';
 newDetail.innerHTML = `
     <span class="detail-order">${currentCount + 1}</span>
     <input type="text" name="detail_title_${chapterIdx}[]" placeholder="강의 제목" class="detail-title">
     <input type="text" name="detail_time_${chapterIdx}[]" placeholder="00:00 (분:초)" class="detail-time">
     <button type="button" class="btn-remove-detail">-</button>
 `;

 detailsContainer.appendChild(newDetail);

 // 삭제 버튼 이벤트
 newDetail.querySelector('.btn-remove-detail').addEventListener('click', function () {
     removeDetail(this, chapterElement);
 });

 updateDetailOrders(chapterElement);
}

//==================== 강의 삭제 함수 ====================
function removeDetail(button, chapterElement) {
 const detailsContainer = chapterElement.querySelector('.details-container');
 if (detailsContainer.querySelectorAll('.detail-item').length > 1) {
     button.closest('.detail-item').remove();
     updateDetailOrders(chapterElement);
 } else {
     alert('최소 1개의 강의는 필요합니다.');
 }
}

//==================== 강의 번호 재정렬 ====================
function updateDetailOrders(chapterElement) {
 const detailItems = chapterElement.querySelectorAll('.detail-item');
 detailItems.forEach(function (item, index) {
     item.querySelector('.detail-order').textContent = index + 1;
 });
}

//==================== 챕터 번호 재정렬 ====================
function updateChapterOrders() {
 const chapterItems = document.querySelectorAll('.chapter-item');
 chapterItems.forEach(function (chapter, index) {
     const chapterOrder = chapter.querySelector('.chapter_order');
     if (chapterOrder) {
         chapterOrder.textContent = 'Chapter ' + (index + 1);
     }

     // 각 강의 이름 재정렬 (강의 번호만)
     updateDetailOrders(chapter);
 });
}

//==================== 챕터 추가 ====================
document.getElementById('add-chapter').addEventListener('click', function () {
 chapterIndex++;
 const container = document.getElementById('curriculum-container');

 const newChapter = document.createElement('div');
 newChapter.className = 'chapter-item';
 newChapter.setAttribute('data-chapter-index', chapterIndex);
 newChapter.innerHTML = `
     <div class="chapter-header">
         <span class="chapter_order"></span>
         <input type="text" name="chapter_title[]" placeholder="챕터 제목" class="chapter-title">
         <button type="button" class="btn-remove-chapter">챕터 삭제</button>
     </div>
     <div class="details-container">
         <div class="detail-item">
             <span class="detail-order">1</span>
             <input type="text" name="detail_title_${chapterIndex}[]" placeholder="강의 제목" class="detail-title">
             <input type="text" name="detail_time_${chapterIndex}[]" placeholder="00:00 (분:초)" class="detail-time">
             <button type="button" class="btn-remove-detail">-</button>
         </div>
     </div>
     <button type="button" class="btn-add-detail">+ 강의 추가</button>
 `;

 container.appendChild(newChapter);

 // 번호 재정렬
 updateChapterOrders();

 // 챕터 삭제 버튼
 newChapter.querySelector('.btn-remove-chapter').addEventListener('click', function () {
     if (document.querySelectorAll('.chapter-item').length > 1) {
         newChapter.remove();
         updateChapterOrders();
     } else {
         alert('최소 1개의 챕터는 필요합니다.');
     }
 });

 // 강의 추가 버튼
 newChapter.querySelector('.btn-add-detail').addEventListener('click', function () {
     addDetail(newChapter, chapterIndex);
 });

 // 강의 삭제 버튼 초기 이벤트
 newChapter.querySelectorAll('.btn-remove-detail').forEach(function (btn) {
     btn.addEventListener('click', function () {
         removeDetail(this, newChapter);
     });
 });
});

//==================== 페이지 로드 시 초기 이벤트 ====================
window.addEventListener('load', function () {
 const firstChapter = document.querySelector('.chapter-item');
 if (!firstChapter) return;

 // 챕터 삭제 버튼
 const removeChapterBtn = firstChapter.querySelector('.btn-remove-chapter');
 if (removeChapterBtn) {
     removeChapterBtn.addEventListener('click', function () {
         if (document.querySelectorAll('.chapter-item').length > 1) {
             firstChapter.remove();
             updateChapterOrders();
         } else {
             alert('최소 1개의 챕터는 필요합니다.');
         }
     });
 }

 // 강의 추가 버튼
 const addDetailBtn = firstChapter.querySelector('.btn-add-detail');
 if (addDetailBtn) {
     addDetailBtn.addEventListener('click', function () {
         addDetail(firstChapter, 0);
     });
 }

 // 강의 삭제 버튼
 firstChapter.querySelectorAll('.btn-remove-detail').forEach(function (btn) {
     btn.addEventListener('click', function () {
         removeDetail(this, firstChapter);
     });
 });

 updateChapterOrders(); // 로드 시 번호 재정렬
});


//==================== 태그 추가/삭제 기능 ====================
// 태그 추가 버튼
document.addEventListener("DOMContentLoaded", function () {
	console.log("태그 스크립트 시작");
	
	let tagInput = document.getElementById("tag-input"); // 태그 입력하는 곳
	let addTagBtn = document.getElementById("add-tag-btn"); // +
	let tagContainer = document.getElementById("tag-container"); // 태그 추가되는곳
	let hiddenInput = document.getElementById("lecture_tag_hidden"); // 서버로 전송 hidden 
	
	  console.log("tagInput:", tagInput);
	    console.log("addTagBtn:", addTagBtn);
	    console.log("tagContainer:", tagContainer);
	    console.log("hiddenInput:", hiddenInput);
	
	let tags = [];
	
	function updateHiddenInput() {
	    hiddenInput.value = tags.join(",");
	    console.log("Hidden input 업데이트:", hiddenInput.value);
	}
	
	function addTag(tagText) {
        tagText = tagText.trim();
        console.log("addTag 호출됨, 입력값:", tagText);
        
        if (tagText === "") {
            alert("태그를 입력하세요.");
            return;
    	}

		if (tags.length >= 10){
			alert("최대 10개까지 입력 가능합니다.");
            return;
		}
		
		if (tags.includes(tagText)){
			alert("이미 추가된 태그 입니다.");
            return;
		}
		
		tags.push(tagText); // 태그 배열 추가
		
		// 태그 칩 생성
		let tagChip = document.createElement("div");
		tagChip.className = "tag-chip";
		tagChip.innerHTML = '<span class="tag-text">#' + tagText + '</span>' + '<button type="button" class="tag-remove-btn">×</button>';
		
            			      console.log("태그 칩 생성됨:", tagChip);
            				 
        // 삭제 버튼 이벤트
		tagChip.querySelector(".tag-remove-btn").addEventListener("click", function(){
			let index = tags.indexOf(tagText);
			if(index > -1) {
				tags.splice(index, 1); // 지정요소 삭제 (index 1번 삭제) , 정보제거
			}
			tagChip.remove(); // 화면에서 제거
			updateHiddenInput(); // 백엔드로 보내기 위한 최신 태그로 초기화
			
		});  				 
		
		tagContainer.appendChild(tagChip); // 테그 컨테이너 추가
		
		console.log("태그 컨테이너에 추가됨");
        console.log("tagContainer의 현재 HTML:", tagContainer.innerHTML);
		
		updateHiddenInput(); // 백엔드로 보내기 위한 최신 태그로 초기화
        
        // 입력창 초기화
		tagInput.value = "";
		tagInput.focus();
        
	}
	
	addTagBtn.addEventListener("click", function(){
		console.log("태그 추가 버튼 클릭됨");
		addTag(tagInput.value);
	});
	
	 // Enter 키로도 추가 가능하게
    tagInput.addEventListener("keypress", function(e){
        if(e.key === "Enter"){
            e.preventDefault();
            addTag(tagInput.value);
        }
    });
});
console.log("태그 스크립트 로드됨");






</script>
</body>
</html>
