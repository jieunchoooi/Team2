<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>강의 상세보기 | Hobee Admin</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/admin/adminClassEditinfo.css">

</head>
<body>
	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/adminSidebar.jsp"></jsp:include>
	<main class="main-content">
		<div class="main-header">
			<h1>강의 상세 정보</h1>
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
 				<label>등록일 (신청일)</label>  
 				<input type="text" name="created_at" value="${lectureVO.created_at}" readonly> 
 			</div> 
			<div class="form-group">
				<label>강의 번호</label> <input type="number" name="lecture_num" id="lecture_num" value="${lectureVO.lecture_num}" readonly>
			</div>
			<!-- ✅ 카테고리 선택 추가 -->
			<div class="form-group">
				<label>카테고리</label> 
				<input type="text" name="category_detail" id="category_detail" value="${lectureVO.category_detail}" readonly>
			</div>
			<div class="form-group">
				<label>강의명</label> <input type="text" name="lecture_title" id="lecture_title" value="${lectureVO.lecture_title}" readonly>
			</div>
			<div class="form-group">
    		<label>강사명</label>
    		<!-- ✅ 검색 입력란 추가 -->
    		<input type="text" id="instructor-search" value="${lectureVO.lecture_author}" class="instructor-search" readonly>
    
			</div>

			<div class="form-group">
				<label>금액</label> <input type="number" name="lecture_price" id="lecture_price" value="${lectureVO.lecture_price}" readonly>
			</div>
			<div class="form-group">
				<label>상세정보</label>
				<textarea name="lecture_detail" id="lecture_detail" readonly>${lectureVO.lecture_detail}</textarea>
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
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
        
        <!-- ✅ 챕터가 없을 경우 기본 챕터 1개 표시 -->
        <c:if test="${empty chapterList}">
            <div class="chapter-item">
                <div class="chapter-header">
                    <span class="chapter_order">Chapter 1</span>
                    <input type="text" name="chapter_title[]" placeholder="챕터 제목" class="chapter-title">
                </div>
                <div class="details-container">
                    <div class="detail-item">
                        <span class="detail-order">1</span>
                        <input type="text" name="detail_title_0[]" placeholder="강의 제목" class="detail-title">
                        <input type="text" name="detail_time_0[]" placeholder="00:00 (분:초)" class="detail-time" maxlength="8">
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>
			<!-- ✅ 태그 섹션 -->
			<div class="form-group">
				<label>태그 (최대 10개)</label>
				<div class="tag-input-wrapper">
<!-- 					<input type="text" id="tag-input" placeholder="태그를 입력하세요" id="tag-input"class="lecture_tag"> -->
<!-- 						<button type="button" id="add-tag-btn" class="btn-add-detail1">+  -->
<!-- 						태그 추가</button> -->
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
				<c:if test="${lectureVO.status == 'waiting'}">
			    	<button class="btn btn-primary" type="button" data-num="${lectureVO.lecture_num}" style="margin:0;">승인</button>
			    	<button class="btn btn-companion" type="button" data-num="${lectureVO.lecture_num}" style="margin:0;">미승인</button>
				</c:if>
				<c:if test="${lectureVO.status == 'deleteWaiting'}">
			    	<button class="btn btn-delete1" type="button" data-num="${lectureVO.lecture_num}" style="margin:0;">삭제</button>
			    	<button class="btn btn-delete" type="button" data-num="${lectureVO.lecture_num}" style="margin:0;">삭제 미승인</button>
				</c:if>
				<c:if test="${lectureVO.status == 'cancelDelete'}">
			    	<button class="btn btn-cancelDelete" type="button" data-num="${lectureVO.lecture_num}" style="margin:0;">삭제취소</button>
				</c:if>
			</div>
		</form>
	</main>

<div id="rejectModal" class="dialog">
  <div class="tb">
    <div class="inner" style="max-width:700px; width:90%;">  <!-- 800px → 700px -->
      <div class="top">
        <div class="title">미승인 사유 입력</div>
      </div>
      <div class="ct">
        <div class="reject-form">
          <label for="rejectReason">미승인 사유를 입력해주세요</label>
          <textarea id="rejectReason" name="reason" placeholder="강사에게 전달될 미승인 사유를 구체적으로 작성해주세요.&#10;(예: 강의 내용이 부적절합니다, 커리큘럼 수정이 필요합니다 등)" rows="8"></textarea>
          
          <div class="modal-btn-group">
            <button type="button" class="modal-btn cancel">취소</button>
            <button type="button" class="modal-btn notApproved" data-num="${lectureVO.lecture_num}">미승인</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>



<script type="text/javascript">

let primaryBtn = document.querySelector(".btn-primary");
let companionBtn = document.querySelector(".btn-companion");
let dialogModal = document.querySelector(".dialog");
let close = document.querySelector(".cancel");
let notApproved = document.querySelector(".notApproved");

// 승인 버튼
if (primaryBtn) {
    primaryBtn.onclick = function(){
        let lectureNum = this.getAttribute("data-num");
        let result = confirm("강의를 승인하겠습니까?");
        if(result){
            alert("승인되었습니다.");
            location.href = "${pageContext.request.contextPath}/admin/classApproval?lecture_num=" + lectureNum;
        }
    }
}

// 모달창 띄우기
if (companionBtn) {
    companionBtn.onclick = function(){
        dialogModal.style.display = "flex";
    }
}
// 모달창 닫기
if (close) {
    close.onclick = function() {
        dialogModal.style.display = "none";
        // 미승인 사유 초기화
        if (document.getElementById("rejectReason")) {
            document.getElementById("rejectReason").value = "";
        }
    }
}

//미승인 처리
if (notApproved) {
    notApproved.onclick = function(){
        let lectureNum = this.getAttribute("data-num");
        let reason = document.getElementById("rejectReason").value.trim();
        
        if (reason === '') {
            alert('미승인 사유를 입력해주세요.');
            document.getElementById('rejectReason').focus();
            return;
        }
        
        let result = confirm("미승인 처리 하시겠습니까?");
        if(result){
            alert("처리되었습니다.");
            location.href = "${pageContext.request.contextPath}/admin/classNotApproval?lecture_num=" + lectureNum + '&reason=' + encodeURIComponent(reason);
        }
    }
}

//클래스 삭제	
let deleteBtn = document.querySelector('.btn-delete');

// 삭제 버튼
if (deleteBtn) {
	deleteBtn.onclick = function(){
        dialogModal.style.display = "flex";
    }
}

// 삭제
let deleteBtn1 = document.querySelector('.btn-delete1');

if(deleteBtn1){
	deleteBtn1.onclick = function(){
        let lectureNum = this.getAttribute("data-num");
		let result = confirm("삭제 하시겠습니까?");
		if(result){
			alert("삭제되었습니다.");
            location.href = "${pageContext.request.contextPath}/admin/deleteApproval?lecture_num=" + lectureNum;
		}
	}
}

//삭제취소
let cancelDeleteBtn = document.querySelector('.btn-cancelDelete');

if(cancelDeleteBtn){
	cancelDeleteBtn.onclick = function(){
        let lectureNum = this.getAttribute("data-num");
		let result = confirm("삭제취소 하시겠습니까?");
		if(result){
			alert("취소되었습니다.");
            location.href = "${pageContext.request.contextPath}/admin/cancelDeleteApproval?lecture_num=" + lectureNum;
		}
	}
}















//⭐ 기존 태그 로딩
document.addEventListener("DOMContentLoaded", function () {
    let tagContainer = document.getElementById("tag-container");
    let hiddenInput = document.getElementById("lecture_tag_hidden");
    let tags = [];

    function updateHiddenInput() {
        hiddenInput.value = tags.join(",");
    }

    function addTag(tagText) {
        tagText = tagText.trim();
        if (tagText === "") return;

        tags.push(tagText);

        let tagChip = document.createElement("div");
        tagChip.className = "tag-chip";
        tagChip.innerHTML = '<span class="tag-text">#' + tagText + '</span>';

        tagContainer.appendChild(tagChip);
        updateHiddenInput();
    }

    // ⭐⭐⭐ 기존 태그 자동 생성
    const existingTags = "${lectureVO.lecture_tag}";  // "드로잉,일러스트,취미"
    if (existingTags && existingTags.trim() !== "") {
        existingTags.split(",").forEach(tag => addTag(tag));
    }
});






</script>

</body>
</html>
