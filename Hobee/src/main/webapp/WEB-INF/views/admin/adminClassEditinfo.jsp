<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의 등록 | Hobee Admin</title>
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

		<form id="classAddForm" class="form-container"
			action="${pageContext.request.contextPath}/admin/adminClassUpdate"
			method="post" enctype="multipart/form-data" onsubmit="return reindexChapters()">
			
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
				<label>썸네일 이미지</label> <input type="file" name="lecture_img" id="lecture_img">
				<input type="hidden" name="oldfile" value="${lectureVO.lecture_img}">
			</div>
			<div class="form-group">
				<label>강의 번호</label> <input type="number" name="lecture_num" id="lecture_num" value="${lectureVO.lecture_num}" readonly>
			</div>
			<!-- ✅ 카테고리 선택 추가 -->
			<div class="form-group">
				<label>카테고리</label> 
				<select name="category_detail" id="category" required>
					<option value="">카테고리를 선택하세요</option> 
					<c:forEach var="categoryVO" items="${categoryList}">
						<option value="${categoryVO.category_detail}"
   				 			${lectureVO.category_detail == categoryVO.category_detail ? 'selected' : ''}>
    						${categoryVO.category_detail}
						</option>

					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label>강의명</label> <input type="text" name="lecture_title" id="lecture_title" value="${lectureVO.lecture_title}">
			</div>
			<div class="form-group">
    		<label>강사명</label>
    		<!-- ✅ 검색 입력란 추가 -->
    		<input type="text" id="instructor-search" value="${lectureVO.lecture_author}" class="instructor-search">
    
    		<select name="lecture_author" id="instructor" required>
        		<option value="">강사를 선택하세요</option>
        		<c:forEach var="instructor" items="${instructorList}">
            		<option value="${instructor.user_num}:${instructor.user_name}" 
            				${lectureVO.user_num == instructor.user_num ? 'selected' : ''}
            				data-user-num="${instructor.user_num}" data-user-name="${instructor.user_name}">
                		${instructor.user_num}. ${instructor.user_name}
            		</option>
        		</c:forEach>
    		</select>
			</div>

			<div class="form-group">
				<label>금액</label> <input type="number" name="lecture_price" id="lecture_price" value="${lectureVO.lecture_price}">
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
                            <button type="button" class="btn-remove-detail">-</button>
                        </div>
                    </c:forEach>
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
                        <button type="button" class="btn-remove-detail">-</button>
                    </div>
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
<div class="btn-wrapper">
    <button class="btn" type="button" onclick="history.back();" style="margin:0;">목록</button>
    <button class="btn btn-primary" type="submit" style="margin:0;">수정하기</button>
</div>
		</form>
	</main>

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
const existingImg = document.querySelector(".profile-pic img");


classAddForm.onsubmit = function(e){

	if (lecture_img.files.length === 0 && !existingImg) {
	    e.preventDefault(); 
	    alert("썸네일을 넣어주세요.");
	    lecture_img.focus();
	    return false;
	}
	
	if(lecture_title.value.length < 1 && lecture_title.value == ""){
		e.preventDefault(); 
		alert("강의명을 입력해주세요.");
		lecture_title.focus();
		return false;
	}
	
	if(lecture_price.value.length < 1 && lecture_price.value == ""){
		e.preventDefault(); 
		alert("금액을 입력해주세요.");
		lecture_price.focus();
		return false;
	}
	
	if(lecture_detail.value.length < 1 && lecture_detail.value == ""){
		e.preventDefault(); 
		alert("상세정보를 입력해주세요.");
		lecture_detail.focus();
		return false;
	}

	// ✅ 모든 챕터 제목 검증
	const chapterTitles = document.querySelectorAll('.chapter-title');
	for(let i = 0; i < chapterTitles.length; i++){
		if(!chapterTitles[i].value.trim()){
			e.preventDefault();
			alert(`Chapter ${i + 1}의 제목을 입력해주세요.`);
			chapterTitles[i].focus();
			return false;
		}
	}
	
	// ✅ 모든 강의 제목 검증
	const detailTitles = document.querySelectorAll('.detail-title');
	for(let i = 0; i < detailTitles.length; i++){
		if(!detailTitles[i].value.trim()){
			e.preventDefault();
			alert("모든 강의 제목을 입력해주세요.");
			detailTitles[i].focus();
			return false;
		}
	}
	
	// ✅ 모든 강의 시간 검증 (비어있는지)
	const detailTimes = document.querySelectorAll('.detail-time');
	for(let i = 0; i < detailTimes.length; i++){
		if(!detailTimes[i].value.trim()){
			e.preventDefault(); 
			alert("모든 강의 시간을 입력해주세요.");
			detailTimes[i].focus();
			return false;
		}
	}
	
	// ✅ 모든 강의 시간 형식 검증
	const timePattern = /^(\d{2}:\d{2}(:\d{2})?)$/;
	for(let i = 0; i < detailTimes.length; i++){
		if(!timePattern.test(detailTimes[i].value)){
			e.preventDefault();
			alert("시간 형식이 올바르지 않습니다. MM:SS 또는 HH:MM:SS 형태로 입력해주세요.");
			detailTimes[i].focus();
			return false;
		}
	}
	
	// ✅ 태그 검증
	const hiddenTags = document.getElementById("lecture_tag_hidden").value;
	if (!hiddenTags || hiddenTags.trim() === "") {
		e.preventDefault();
		alert("태그를 1개 이상 입력해주세요.");
		document.getElementById("tag-input").focus();
		return false;
	}
	
	// ✅✅✅ 중요! 모든 검증 통과 후 챕터 인덱스 재정렬
	return reindexChapters();
}

//시간 자동 포맷 적용 함수
function attachStrictTimeFormatter(input) {
    input.addEventListener("input", function() {
        let numbers = this.value.replace(/\D/g, "");
        if(numbers.length > 6) numbers = numbers.slice(0,6);

        if(numbers.length <= 2){
            this.value = numbers;
        } else if(numbers.length <= 4){
            this.value = numbers.slice(0,2) + ":" + numbers.slice(2);
        } else {
            this.value = numbers.slice(0,2) + ":" + numbers.slice(2,4) + ":" + numbers.slice(4,6);
        }
    });

    input.addEventListener("blur", function(){
        const timePattern = /^(\d{2}:\d{2}(:\d{2})?)$/;
        this.style.borderColor = this.value && !timePattern.test(this.value) ? "red" : "";
    });
}

//기존 입력칸에 적용
document.querySelectorAll(".detail-time").forEach(input => attachStrictTimeFormatter(input));

//✅ 강사 검색 기능
document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById("instructor-search");
    const selectBox = document.getElementById("instructor");
    const allOptions = Array.from(selectBox.options);
    
    // 검색 입력 시 필터링
    searchInput.addEventListener("input", function() {
        const searchText = this.value.toLowerCase().trim();
        
        // 검색어가 비어있으면 모든 옵션 표시
        if (searchText === "") {
            allOptions.forEach(option => {
                option.style.display = "";
            });
            return;
        }
        
        // 검색어로 필터링
        let foundMatch = false;
        allOptions.forEach((option, index) => {
            if (index === 0) { // "강사를 선택하세요" 옵션은 항상 표시
                option.style.display = "";
                return;
            }
            
            const userName = option.getAttribute("data-user-name") || "";
            const userNum = option.getAttribute("data-user-num") || "";
            const optionText = option.textContent.toLowerCase();
            
            if (userName.toLowerCase().includes(searchText) || 
                userNum.includes(searchText) || 
                optionText.includes(searchText)) {
                option.style.display = "";
                
                // 첫 번째 매칭된 항목 자동 선택
                if (!foundMatch) {
                    selectBox.value = option.value;
                    foundMatch = true;
                }
            } else {
                option.style.display = "none";
            }
        });
        
        // 매칭되는 항목이 없으면 기본 선택
        if (!foundMatch) {
            selectBox.value = "";
        }
    });
    
    // Enter 키 입력 시 첫 번째 보이는 항목 선택
    searchInput.addEventListener("keypress", function(e) {
        if (e.key === "Enter") {
            e.preventDefault();
            
            const visibleOptions = allOptions.filter((option, index) => 
                index > 0 && option.style.display !== "none"
            );
            
            if (visibleOptions.length > 0) {
                selectBox.value = visibleOptions[0].value;
                this.value = visibleOptions[0].getAttribute("data-user-name");
            }
        }
    });
    
    // Select 변경 시 검색창도 업데이트
    selectBox.addEventListener("change", function() {
        const selectedOption = this.options[this.selectedIndex];
        if (selectedOption.index > 0) {
            searchInput.value = selectedOption.getAttribute("data-user-name") || "";
        } else {
            searchInput.value = "";
        }
    });
});

//⭐ 기존 태그 로딩 (lectureVO.lecture_tag 값 사용)
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
        tagChip.innerHTML =
            '<span class="tag-text">#' + tagText + '</span>' +
            '<button type="button" class="tag-remove-btn">×</button>';

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

    // ⭐⭐⭐ 기존 태그 자동 생성
    const existingTags = "${lectureVO.lecture_tag}";  // "드로잉,일러스트,취미"
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



















// 파일 선택 시 미리보기
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
        profilePic.innerHTML = '';

        let img = document.createElement('img');
        img.alt = '강의 사진';
        img.src = e.target.result;
        img.style.width = '200px';
        img.style.height = '200px';
        img.style.objectFit = 'contain'; /* ✅ cover에서 contain으로 변경 */

        profilePic.appendChild(img);
    }

    reader.readAsDataURL(file);
});
let chapterIndex = 0;

//✅ 폼 제출 전 챕터 인덱스 재정렬
function reindexChapters() {
    const chapterItems = document.querySelectorAll('.chapter-item');
    
    chapterItems.forEach(function(chapter, chapterIdx) {
        const detailTitles = chapter.querySelectorAll('input[name^="detail_title_"]');
        const detailTimes = chapter.querySelectorAll('input[name^="detail_time_"]');
        
        detailTitles.forEach(function(input) {
            input.name = 'detail_title_' + chapterIdx + '[]';
        });
        
        detailTimes.forEach(function(input) {
            input.name = 'detail_time_' + chapterIdx + '[]';
        });
    });
    
    console.log('=== 챕터 인덱스 재정렬 완료 ===');
    return true;
}

// ✅ addDetail 함수 - 하나로 통합
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

    // ✅ 시간 포맷 적용
    attachStrictTimeFormatter(newDetail.querySelector(".detail-time"));

    newDetail.querySelector('.btn-remove-detail').addEventListener('click', function () {
        removeDetail(this, chapterElement);
    });

    updateDetailOrders(chapterElement);
}

function removeDetail(button, chapterElement) {
    const detailsContainer = chapterElement.querySelector('.details-container');
    if (detailsContainer.querySelectorAll('.detail-item').length > 1) {
        button.closest('.detail-item').remove();
        updateDetailOrders(chapterElement);
    } else {
        alert('최소 1개의 강의는 필요합니다.');
    }
}

function updateDetailOrders(chapterElement) {
    const detailItems = chapterElement.querySelectorAll('.detail-item');
    detailItems.forEach(function (item, index) {
        item.querySelector('.detail-order').textContent = index + 1;
    });
}

function updateChapterOrders() {
    const chapterItems = document.querySelectorAll('.chapter-item');
    chapterItems.forEach(function (chapter, index) {
        const chapterOrder = chapter.querySelector('.chapter_order');
        if (chapterOrder) {
            chapterOrder.textContent = 'Chapter ' + (index + 1);
        }
        updateDetailOrders(chapter);
    });
}

document.getElementById('add-chapter').addEventListener('click', function () {
    chapterIndex++;
    const container = document.getElementById('curriculum-container');
    const currentChapterIdx = chapterIndex;

    const newChapter = document.createElement('div');
    newChapter.className = 'chapter-item';
    newChapter.setAttribute('data-chapter-index', currentChapterIdx);
    newChapter.innerHTML = `
        <div class="chapter-header">
            <span class="chapter_order"></span>
            <input type="text" name="chapter_title[]" placeholder="챕터 제목" class="chapter-title">
            <button type="button" class="btn-remove-chapter">챕터 삭제</button>
        </div>
        <div class="details-container">
            <div class="detail-item">
                <span class="detail-order">1</span>
                <input type="text" name="detail_title_${currentChapterIdx}[]" placeholder="강의 제목" class="detail-title">
                <input type="text" name="detail_time_${currentChapterIdx}[]" placeholder="00:00 (분:초)" class="detail-time">
                <button type="button" class="btn-remove-detail">-</button>
            </div>
        </div>
        <button type="button" class="btn-add-detail">+ 강의 추가</button>
    `;

    container.appendChild(newChapter);
    
    // ✅ 새 챕터의 첫 번째 시간 입력에도 포맷 적용
    attachStrictTimeFormatter(newChapter.querySelector(".detail-time"));
    
    updateChapterOrders();

    newChapter.querySelector('.btn-remove-chapter').addEventListener('click', function () {
        if (document.querySelectorAll('.chapter-item').length > 1) {
            newChapter.remove();
            updateChapterOrders();
        } else {
            alert('최소 1개의 챕터는 필요합니다.');
        }
    });

    newChapter.querySelector('.btn-add-detail').addEventListener('click', function () {
        addDetail(newChapter, currentChapterIdx);
    });

    newChapter.querySelectorAll('.btn-remove-detail').forEach(function (btn) {
        btn.addEventListener('click', function () {
            removeDetail(this, newChapter);
        });
    });
});

//✅ 페이지 로드 시 기존 챕터들에 이벤트 바인딩
window.addEventListener('load', function() {
    // 기존 챕터들에 이벤트 바인딩
    document.querySelectorAll('.chapter-item').forEach(function(chapter, index) {
        const chapterIdx = index;
        
        // 챕터 삭제 버튼
        const removeChapterBtn = chapter.querySelector('.btn-remove-chapter');
        if (removeChapterBtn) {
            removeChapterBtn.addEventListener('click', function() {
                if (document.querySelectorAll('.chapter-item').length > 1) {
                    chapter.remove();
                    updateChapterOrders();
                } else {
                    alert('최소 1개의 챕터는 필요합니다.');
                }
            });
        }
        
        // 강의 추가 버튼
        const addDetailBtn = chapter.querySelector('.btn-add-detail');
        if (addDetailBtn) {
            addDetailBtn.addEventListener('click', function() {
                addDetail(chapter, chapterIdx);
            });
        }
        
        // 강의 삭제 버튼들
        chapter.querySelectorAll('.btn-remove-detail').forEach(function(btn) {
            btn.addEventListener('click', function() {
                removeDetail(this, chapter);
            });
        });
        
        // 시간 입력 포맷 적용
        chapter.querySelectorAll('.detail-time').forEach(function(input) {
            attachStrictTimeFormatter(input);
        });
    });
    
    updateChapterOrders();
});

</script>

</body>
</html>
