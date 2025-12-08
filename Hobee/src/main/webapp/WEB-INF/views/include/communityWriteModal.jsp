<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 🔥 글쓰기 모달 전체 -->
<div id="writeModal" class="modal-overlay">
	<div class="modal-card">

		<h2 class="modal-title">새 게시글 작성</h2>
		<p class="modal-subtitle">어떤 이야기를 공유해볼까요?</p>

		<form action="${pageContext.request.contextPath}/community/writePro"
			method="post">

			<div class="write-top-row">

				<select name="board_id" class="write-select small-select">
					<option value="0" selected="selected" style="display:none;">말머리</option>


					<c:forEach var="c" items="${categoryList}">

						<%-- 공지(board_id=1)는 관리자(admin/super_admin)만 노출 --%>
						<c:if test="${c.board_id == 1}">
							<c:if
								test="${sessionScope.userVO.user_role == 'admin' 
                         or sessionScope.userVO.user_role == 'super_admin'}">
								<option value="${c.board_id}">${c.board_name}</option>
							</c:if>
						</c:if>

						<%-- 일반 말머리 (공지 제외) --%>
						<c:if test="${c.board_id != 1}">
							<option value="${c.board_id}">${c.board_name}</option>
						</c:if>

					</c:forEach>
				</select> <select name="category_main_num" class="write-select small-select">
					
					<option value="0" selected="selected" style="display:none;">카테고리</option>

					<c:forEach var="m" items="${mainList}">
						<option value="${m.category_main_num}">${m.category_main_name}</option>
					</c:forEach>
				</select> <input type="text" name="title" class="write-input title-inline"
					placeholder="제목을 입력하세요">
			</div>

			<!-- 🔸 내용 -->
			<textarea name="content" class="modal-textarea"
				placeholder="내용을 입력하세요" required></textarea>

			<!-- 🔸 버튼 -->
			<div class="modal-btn-row">
				<button type="submit" class="modal-submit-btn">작성하기</button>
				<button type="button" class="modal-cancel-btn"
					onclick="closeWriteModal()">취소</button>
			</div>

		</form>

	</div>
</div>
