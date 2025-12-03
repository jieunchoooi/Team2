<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- ================================================================
     📌 게시글 수정 모달 (include 파일)
     파일명 : /WEB-INF/views/community/include/editModal.jsp
================================================================ --%>


<div id="editModal" class="edit-modal">
	<div class="edit-modal-content">

		<%-- 닫기 버튼 --%>
		<span class="edit-modal-close" onclick="closeEditModal()">&times;</span>

		<%-- 폼 영역 --%>
		<h2 class="edit-modal-title">게시글 수정</h2>

		<form id="editForm" method="post"
			action="${pageContext.request.contextPath}/community/editPro">

			<input type="hidden" name="post_id" id="editPostId">

			<%-- 메인카테고리 & 말머리 --%>
			<div class="edit-row">

				<select name="category_id" id="editCategoryId" class="edit-select">
					<option value="">말머리</option>
				</select> <select name="category_main_num" id="editCategoryMainNum"
					class="edit-select">
					<option value="">메인 카테고리</option>
				</select>


			</div>

			<input type="text" name="title" id="editTitle" class="edit-input"
				placeholder="제목을 입력하세요">

			<textarea name="content" id="editContent" class="edit-textarea"
				placeholder="내용을 입력하세요"></textarea>

			<button type="submit" class="edit-submit-btn">수정 완료</button>

		</form>
	</div>
</div>


