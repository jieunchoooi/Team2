<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리 편집 | Hobee Admin</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminCategory.css">
<!-- Bootstrap CSS 추가 -->

<!-- jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap JS 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
    <div class="form-group inline-form">
  <form action="${ pageContext.request.contextPath }/admin/addCategoryMain" class="addMainForm" method="post">
      <label>카테고리 대분류 추가</label>
      <div class="form-row">
        <input type="text" name="category_main_name" class="mainCatecory" placeholder="새 카테고리 대분류 입력">
        <button type="button" class="btn" id="mainBtn">추가</button>
      </div>
      </form>
      <form action="${ pageContext.request.contextPath }/admin/CategoryMainDelete" class="deleteMainForm" method="post">
      <label>카테고리 대분류 삭제</label>
      <div class="form-row">
        <select name="category_main_name" id="category_main" required>
          <option value="">삭제할 대분류 선택</option>
          <c:forEach var="category_mainVO" items="${categoMainryList}">
            <option value="${category_mainVO.category_main_name}" 
                    data-category_mian-num="${category_mainVO.category_main_num}">
              ${category_mainVO.category_main_name}
            </option>
          </c:forEach>
        </select>
        <button type="button" class="btn btn-delete" id="deleteBtn">삭제</button>
      </div>
      </form>
    </div>
  
</div>
<div class="form-container" style="margin-top: 20px;">
  <div class="form-group inline-form">
  <form action="${ pageContext.request.contextPath }/admin/addCategory" class="addCategoryForm" method="post">
    <label>카테고리 추가</label>
    <div class="form-row">
      <select name="category_main_name" id="category_main_name" required>
        <option value="">대분류 선택</option>
        <c:forEach var="category_mainVO" items="${categoMainryList}">
          <option value="${category_mainVO.category_main_name}" 
                  data-category_mian-num="${category_mainVO.category_main_num}">
           		 ${category_mainVO.category_main_name}
          </option>
        </c:forEach>
      </select>
      <input type="text" name="category_detail" class="category_detail" placeholder="새 카테고리 입력">
      <button class="btn" id="cateDetailBtn">추가</button>
    </div>
    </form>
  </div>
</div>

    <div class="table-container" style="margin-top:30px;">
      <table>
        <thead>
          <tr>
            <th>번호</th>
            <th>대분류</th>
            <th>카테고리명</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody>
		<c:forEach var="categoryVO" items="${categoryList}">
          <tr>
            <td>${categoryVO.category_num}</td>
            <td>${categoryVO.category_main_name}</td>
            <td>${categoryVO.category_detail}</td>
            <td>
              <button class="btn btn-modal" data-toggle="modal" data-target="#myModal" data-num="${categoryVO.category_num}">수정</button>
              <button type="button" class="btn categoryDe" id="categoryDe" data-num="${categoryVO.category_num}">삭제</button>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </main>
</div>
</body>
<!-- 모달 -->
<div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="categoryModalLabel">카테고리 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body" id="modalBody">
        <!-- AJAX로 CategoryEditinfoModal.jsp 내용이 삽입됨 -->
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
let mainBtn = document.querySelector("#mainBtn");
let mainCatecory = document.querySelector(".mainCatecory");
let addMainForm = document.querySelector(".addMainForm");
let deleteMainForm = document.querySelector(".deleteMainForm");
let category_main = document.querySelector("#category_main");
let deleteBtn = document.querySelector("#deleteBtn");
let addCategoryForm = document.querySelector(".addCategoryForm");
let category_main_name = document.querySelector("#category_main_name");
let category_detail = document.querySelector(".category_detail");
let cateDetailBtn = document.querySelector("#cateDetailBtn");

// 카태고리 대분류 추가
mainBtn.onclick = function(e){
	e.preventDefault();
	
	if(mainCatecory.value == ""){
		alert("카테고리 대분류를 입력해 주세요.");
		mainCatecory.focus();
		return false;
	}
	
	let result = confirm("카테고리 대분류를 추가하시겠습니까?");
	if(result){
		alert("카테고리 대분류에 추가되었습니다.");
		addMainForm.submit();
	}
}

// 카태고리 대분류 삭제
deleteBtn.onclick = function(e){
	e.preventDefault();
	
	if(category_main.value == ""){
		alert("카테고리 대분류를 선택해 주세요.");
		category_main.focus();
		return false;
	}
	
	let selectedName = category_main.value;
	let result = confirm(selectedName + "을(를) 카테고리 대분류에서 삭제하시겠습니까?");
	if(result){
		alert(selectedName + "가 카테고리 대분류에서 삭제되었습니다.");
		deleteMainForm.submit();
	}
	
}
// 카태고리 추가
cateDetailBtn.onclick = function(e){
	e.preventDefault();
	
	if(category_main_name.value == ""){
		alert("카테고리를 선택해 주세요.");
		category_main_name.focus();
		return false;
	}
	
	if(category_detail.value == ""){
		alert("새 카테고리를 입력해 주세요.");
		category_detail.focus();
		return false;
	}
	
	let result = confirm("카테고리를 추가하시겠습니까?");
	if(result){
		alert("카테고리가 추가되었습니다.");
		addCategoryForm.submit();
	}
}

// 강의 삭제
let categoryDe = document.querySelectorAll('.categoryDe');

categoryDe.forEach(function(btn){
	btn.onclick = function(){
		let categoryNum = this.getAttribute("data-num");
		let result = confirm("카테고리를 삭제하시겠습니까?");
		if(result){
			alert("카테고리가 삭제되었습니다.");
            location.href = "${pageContext.request.contextPath}/admin/deleteCategory?category_num=" + categoryNum;
		}
	}
});

//모달 열기
$(".btn-modal").click(function(){
    let num = $(this).data('num');
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/categoryEditInfoModal",
        data: { category_num: num },
        type: "GET",
        success: function(res){
            $("#modalBody").html(res);
            
            // 모달 표시
            let modal = new bootstrap.Modal(document.getElementById('categoryModal'));
            modal.show();
            
            // 모달 내부의 수정 버튼 이벤트 바인딩 (DOM 삽입 후)
            document.getElementById('btnUpdateCategory').onclick = function() {
                let category_main_name = document.getElementById('edit_category_main_name');
                let category_detail = document.getElementById('edit_category_detail');
                
                if(category_main_name.value == "") {
                    alert("대분류를 선택해 주세요.");
                    category_main_name.focus();
                    return false;
                }
                
                if(category_detail.value.trim() == "") {
                    alert("카테고리명을 입력해 주세요.");
                    category_detail.focus();
                    return false;
                }
                
                let result = confirm("카테고리를 수정하시겠습니까?");
                if(result) {
                    document.getElementById('categoryEditForm').submit();
				    alert("카테고리 수정이 완료되었습니다.");
                }
            };
        },
        error: function(xhr, status, error){ 
            console.log("xhr:", xhr);
            console.log("status:", status);
            console.log("error:", error);
            alert("카테고리 정보를 불러오는 중 오류가 발생했습니다."); 
        }
    });
});










</script>


</html>
