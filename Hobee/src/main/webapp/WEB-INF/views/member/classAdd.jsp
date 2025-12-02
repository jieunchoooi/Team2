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
	href="${ pageContext.request.contextPath }/resources/css/member/classAdd.css">

</head>
<body>
	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/memberSidebar.jsp"></jsp:include>
	<main class="main-content">

		<form id="classAddForm" class="form-container"
			action="${pageContext.request.contextPath}/member/classAddPro"
			method="post" enctype="multipart/form-data">
			
			<div class="profile-pic">
				<span>📚</span>
			</div>
			
			<div class="form-group">
				<label>썸네일 이미지</label> <input type="file" name="lecture_img" id="lecture_img">
			</div>
			<!-- ✅ 카테고리 선택 추가 -->
			<div class="form-group">
				<label>카테고리</label> 
				<select name="category_detail" id="category" required>
					<option value="">카테고리를 선택하세요</option>
					<c:forEach var="categoryVO" items="${categoryList}">
						<option value="${categoryVO.category_detail}">
							${categoryVO.category_detail}
						</option>
					</c:forEach>
		
				</select>
			</div>

			<div class="form-group">
				<label>강의명</label> <input type="text" name="lecture_title" id="lecture_title" placeholder="강의명을 입력하세요">
			</div>
			<div class="form-group">
    		<label>강사명</label>
    		<!-- ✅ 검색 입력란 추가 -->
    		<input type="text" name="lecture_author" id="instructor-search" value="${user.user_name}" class="instructor-search" readonly>
    		<input type="hidden" name="user_num">
			</div>

			<div class="form-group">
				<label>금액</label> <input type="number" name="lecture_price" id="lecture_price" placeholder="금액을 입력하세요 (숫자만 입력)">
			</div>
			<div class="form-group">
				<label>상세정보</label>
				<textarea name="lecture_detail" id="lecture_detail" placeholder="강의 상세 정보를 입력하세요"></textarea>
			</div>
			<div class="form-group">
				<label>커리큘럼</label>
				<div id="curriculum-container">
					<!-- 첫 번째 챕터 -->
					<div class="chapter-item">
						<div class="chapter-header">
							<span class="chapter_order">Chapter 1</span>
							<input type="text" name="chapter_title[]" id="chapter_title" placeholder="챕터 제목 (예: 1주차)" class="chapter-title">
							<button type="button" class="btn-remove-chapter">챕터 삭제</button>
						</div>
						<div class="details-container">
							<div class="detail-item">
								<span class="detail-order">1</span> 
								<input type="text" name="detail_title_0[]" id="detail_title" placeholder="강의 제목" class="detail-title"> 
								<input type="text" name="detail_time_0[]" id="detail_time" placeholder="00:00 (분:초)" class="detail-time" maxlength="8">
								<button type="button" class="btn-remove-detail">-</button><br>
							</div>
								<input type="file" name="noFile">
						</div>
						<button type="button" class="btn-add-detail">+ 강의 추가</button>
					</div>
				</div>
				<button type="button" id="add-chapter" class="btn-add">+ 챕터 추가</button>
			</div>
			<!-- ✅ 태그 섹션 -->
			<div class="form-group">
				<label>태그 (최대 10개)</label>
				<div class="tag-input-wrapper">
					<input type="text" id="tag-input" placeholder="태그를 입력하세요" id="tag-input"class="lecture_tag">
					<button type="button" id="add-tag-btn" class="btn-add-detail1">+ 
					태그 추가</button>
				</div>
				<!-- 태그들이 표시될 영역 -->
				<div id="tag-container" class="tag-display-area">
					<!-- 여기에 #태그 형태로 추가됨 -->
				</div>
				<!-- 서버로 전송할 hidden input (쉼표로 구분된 태그들) -->
				<input type="hidden" name="lecture_tag" id="lecture_tag_hidden">
			</div>

			<div style="text-align: center;">
				<button class="btn btn-submit" type="submit">승인요청</button>
			</div>
		</form>
	</main>
	<!-- footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>
<script type="text/javascript">

let lecture_img = document.querySelector("#lecture_img");
let classAddForm = document.querySelector("#classAddForm");
let lecture_title = document.querySelector("#lecture_title");
let lecture_price = document.querySelector("#lecture_price");
let lecture_detail = document.querySelector("#lecture_detail");
let chapter_title = document.querySelector("#chapter_title");
let detail_title = document.querySelector(".detail_title");
let detail_time = document.querySelector(".detail_time");
let tag_input = document.querySelector("#tag-input");
let add_tag_btn = document.querySelector("#add-tag-btn");
let allDetailTitles = document.querySelectorAll(".detail-title");
let btn = document.querySelector(".btn-submit");

btn.onclick = function(e){
    e.preventDefault(); // ✅ 기본 submit 방지
    
    // ✅ 1. 먼저 모든 검증 수행
    if(lecture_img.files.length === 0){
        alert("썸네일을 넣어주세요.");
        lecture_img.focus();
        return false;
    }
    
    if(lecture_title.value.length < 1 || lecture_title.value == ""){
        alert("강의명을 입력해주세요.");
        lecture_title.focus();
        return false;
    }
    
    if(lecture_price.value.length < 1 || lecture_price.value == ""){
        alert("금액을 입력해주세요.");
        lecture_price.focus();
        return false;
    }
    
    if(lecture_detail.value.length < 1 || lecture_detail.value == ""){
        alert("상세정보를 입력해주세요.");
        lecture_detail.focus();
        return false;
    }

    // ✅ 모든 챕터 제목 검증
    const chapterTitles = document.querySelectorAll('.chapter-title');
    for(let i = 0; i < chapterTitles.length; i++){
        if(!chapterTitles[i].value.trim()){
            alert("모든 Chapter 의 제목을 입력해주세요.");
            chapterTitles[i].focus();
            return false;
        }
    }
    
    // ✅ 모든 강의 제목 검증
    const detailTitles = document.querySelectorAll('.detail-title');
    for(let i = 0; i < detailTitles.length; i++){
        if(!detailTitles[i].value.trim()){
            alert("모든 강의 제목을 입력해주세요.");
            detailTitles[i].focus();
            return false;
        }
    }
    
    // ✅ 모든 강의 시간 검증 (비어있는지)
    const detailTimes = document.querySelectorAll('.detail-time');
    for(let i = 0; i < detailTimes.length; i++){
        if(!detailTimes[i].value.trim()){
            alert("모든 강의 시간을 입력해주세요.");
            detailTimes[i].focus();
            return false;
        }
    }
    
    // ✅ 모든 강의 시간 형식 검증
    const timePattern = /^(\d{2}:\d{2}(:\d{2})?)$/;
    for(let i = 0; i < detailTimes.length; i++){
        if(!timePattern.test(detailTimes[i].value)){
            alert("시간 형식이 올바르지 않습니다. MM:SS 또는 HH:MM:SS 형태로 입력해주세요.");
            detailTimes[i].focus();
            return false;
        }
    }
    
    // ✅ 태그 검증
    const hiddenTags = document.getElementById("lecture_tag_hidden").value;
    if (!hiddenTags || hiddenTags.trim() === "") {
        alert("태그를 1개 이상 입력해주세요.");
        document.getElementById("tag-input").focus();
        return false;
    }
    
    // ✅ 2. 모든 검증 통과 후 마지막에 확인 창
    let result = confirm("승인 요청 하시겠습니까?");
    if(result){
        reindexChapters(); // 챕터 인덱스 재정렬
        classAddForm.submit(); // 폼 제출
        alert("요청되었습니다.");
    } else {
        alert("취소되었습니다.");
        return false;
    }
}


// 파일 선택 시 미리보기
document.getElementById("lecture_img").addEventListener('change', function(e) {
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
        profilePic.innerHTML = ''

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


// 커리큘럼 추가버튼
	let TclassAdd = document.querySelectorAll(".btn-add");
	let newChapter = document.querySelector(".chapter-item");
	let cContainer = document.querySelector("#curriculum-container");
	let chapterNum = 1;
	TclassAdd.forEach(function(button){
		button.addEventListener('click', function(){
			chapterNum++;

			let newChapter = document.createElement("div");
			newChapter.classList.add("chapter-item");
			newChapter.innerHTML = 
				'<div class="chapter-header">' 
					+'<span class="chapter_order">Chapter ' + chapterNum + '</span>'
					+'<input type="text" name="chapter_title[]" id="chapter_title" placeholder="챕터 제목 (예: 1주차)" class="chapter-title">'
					+'<button type="button" class="btn-remove-chapter">챕터 삭제</button>'
				+'</div>'
				+'<div class="details-container">'
					+'<div class="detail-item">'
						+'<span class="detail-order">1</span>'
						+'<input type="text" name="detail_title_0[]" id="detail_title" placeholder="강의 제목" class="detail-title">' 
						+'<input type="text" name="detail_time_0[]" id="detail_time" placeholder="00:00 (분:초)" class="detail-time" maxlength="8">'
						+'<button type="button" class="btn-remove-detail">-</button><br>'
					+'</div>'
					+'<input type="file" name="noFile">'			
				+'</div>'
				+'<button type="button" class="btn-add-detail">+ 강의 추가</button>'
				
							

			cContainer.appendChild(newChapter);
		
		});
	});

	
	// 챕터 번호 업데이트 함수
	function updateChapterNumbers() {
	    let allChapters = document.querySelectorAll('.chapter-item');
	    allChapters.forEach(function(chapter, index) {
	        let chapterOrder = chapter.querySelector('.chapter_order');
	        chapterOrder.textContent = 'Chapter ' + (index + 1);
	    });
	    chapterNum = allChapters.length; // 전체 챕터 개수로 업데이트
	}

	// 이벤트 위임 - 모든 챕터에 적용됨
	cContainer.addEventListener('click', function(e) {
		// 챕터 삭제 
	    if (e.target.classList.contains('btn-remove-chapter')) {
	        let chapterItem = e.target.closest('.chapter-item');
	        if (document.querySelectorAll('.chapter-item').length > 1) {
	            cContainer.removeChild(chapterItem);
	            updateChapterNumbers();
	        } else	 {
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
	        
	        // ✅ detail-item 추가 후, details-container에 파일 input 추가
		    let fileInput = document.createElement("input");
		    fileInput.type = "file";
		    fileInput.name = "noFile";
		    detailsContainer.appendChild(fileInput);
	    }
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
	});
	
	// 강의 번호 업데이트 함수
	function updateDetailNumbers(container) {
	    let allDetails = container.querySelectorAll('.detail-item');
	    allDetails.forEach(function(detail, index) {
	        let detailOrder = detail.querySelector('.detail-order');
	        detailOrder.textContent = index + 1;
	    });
	}

	// 시간 입력 자동 포맷 (HH:MM:SS)
	cContainer.addEventListener('input', function(e) {
	    if (e.target.classList.contains('detail-time')) {
	        let input = e.target;
	        let value = input.value.replace(/[^0-9]/g, ''); // 숫자만 남기기
	        
	        // 최대 6자리 (HHMMSS)
	        if (value.length > 6) {
	            value = value.slice(0, 6);
	        }
	        
	        let formatted = '';
	        
	        // HH 부분
	        if (value.length >= 1) {
	            let hh = value.slice(0, 2);
	            formatted = hh;
	        }
	        
	        // MM 부분
	        if (value.length >= 3) {
	            let mm = value.slice(2, 4);
	            if (parseInt(mm) > 59) mm = '59';
	            formatted += ':' + mm;
	        }
	        
	        // SS 부분
	        if (value.length >= 5) {
	            let ss = value.slice(4, 6);
	            if (parseInt(ss) > 59) ss = '59';
	            formatted += ':' + ss;
	        }
	        
	        input.value = formatted;
	    }
	});

let tagBtn = document.querySelector(".btn-add-detail1");
let lectureTag = document.querySelector(".lecture_tag");



// 태그 추가/삭제 기능
document.addEventListener("DOMContentLoaded", function () {
    let tagInput = document.getElementById("tag-input"); 
    let addTagBtn = document.getElementById("add-tag-btn");
    let tagContainer = document.getElementById("tag-container");
    let hiddenInput = document.getElementById("lecture_tag_hidden");
    let tags = [];
    
    function updateHiddenInput() {
        hiddenInput.value = tags.join(",");
    }
    
    function addTag(tagText) {
        tagText = tagText.trim();
        
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
        
        tags.push(tagText);
        
        let tagChip = document.createElement("div");
        tagChip.className = "tag-chip";
        tagChip.innerHTML = '<span class="tag-text">#' + tagText + '</span>' + '<button type="button" class="tag-remove-btn">×</button>';
        
        tagChip.querySelector(".tag-remove-btn").addEventListener("click", function(){
            let index = tags.indexOf(tagText);
            if(index > -1) {
                tags.splice(index, 1);
            }
            tagChip.remove();
            updateHiddenInput();	
        });
        
        tagContainer.appendChild(tagChip);
        updateHiddenInput();
        tagInput.value = "";
        tagInput.focus();
    }
    
    addTagBtn.addEventListener("click", function(){
        addTag(tagInput.value);
    });
    
    tagInput.addEventListener("keypress", function(e){
        if(e.key === "Enter"){
            e.preventDefault();
            addTag(tagInput.value);
        }
    });
});

//✅ 폼 제출 전 챕터 인덱스 재정렬 함수
function reindexChapters() {
    let allChapters = document.querySelectorAll('.chapter-item');
    
    allChapters.forEach(function(chapter, chapterIndex) {
        // 해당 챕터의 모든 detail-title, detail-time input의 name 속성 변경
        let detailTitles = chapter.querySelectorAll('.detail-title');
        let detailTimes = chapter.querySelectorAll('.detail-time');
        
        detailTitles.forEach(function(input) {
            input.name = 'detail_title_' + chapterIndex + '[]';
        });
        
        detailTimes.forEach(function(input) {
            input.name = 'detail_time_' + chapterIndex + '[]';
        });
    });
    
    return true; // 폼 제출 계속 진행
}





</script>

</body>
</html>
