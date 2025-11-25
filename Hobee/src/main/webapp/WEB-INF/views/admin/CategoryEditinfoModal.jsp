<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 수정 | Hobee Admin</title>
</head>
<body>
<form id="categoryEditForm" method="post" action="${pageContext.request.contextPath}/admin/updateCategory">
    <input type="hidden" name="category_num" value="${category.category_num}">
    
    <div class="form-group" style="margin-bottom: 20px;">
        <label for="edit_category_main_name" style="display: block; margin-bottom: 8px; font-weight: 600;">대분류</label>
        <select name="category_main_name" id="edit_category_main_name" 
                style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;" required>

            <c:forEach var="category_mainVO" items="${categoMainryList}">
                <option value="${category_mainVO.category_main_name}" 
                        ${category.category_main_name == category_mainVO.category_main_name ? 'selected' : ''}>
                    ${category_mainVO.category_main_name}
                </option>
            </c:forEach>
			
        </select>
    </div>
    
    <div class="form-group" style="margin-bottom: 20px;">
        <label for="edit_category_detail" style="display: block; margin-bottom: 8px; font-weight: 600;">카테고리명</label>
        <input type="text" name="category_detail" id="edit_category_detail" 
               value="${category.category_detail}"
               style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;" 
               placeholder="카테고리명 입력" required>
    </div>
    
    <div class="modal-footer" style="display: flex; gap: 10px; justify-content: flex-end; padding-top: 20px; border-top: 1px solid #ddd;">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" 
                style="padding: 8px 20px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer;">
            취소
        </button>
        <button type="button" id="btnUpdateCategory" class="btn btn-primary" 
                style="padding: 8px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer;">
            수정
        </button>
    </div>
</form>
</body>
<script>
// 모달 열기
document.querySelector('.btn-open-modal').addEventListener('click', function() {
    document.querySelector('.modal').classList.add('show');
});

// 모달 닫기 (배경 클릭시)
document.querySelector('.modal').addEventListener('click', function(e) {
    if (e.target === this) {
        this.classList.remove('show');
    }
});

// 모달 닫기 버튼 (필요시 추가)
// document.querySelector('.modal_close')?.addEventListener('click', function() {
//     document.querySelector('.modal').classList.remove('show');
// });
</script>
</html>