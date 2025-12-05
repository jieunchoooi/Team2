<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 수정 | Hobee Admin</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminBoardEdit.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<div class="main-content">

    <div class="page-title">게시판 수정</div>

    <!-- =======================================================
         📌 저장하기 form
    ======================================================== -->
    <form id="editForm" action="${pageContext.request.contextPath}/admin/adminBoardEditPro" method="post">

        <input type="hidden" name="board_id" value="${board.board_id}">

        <div class="edit-wrapper">

            <!-- ====================================== -->
            <!-- 📄 기본 정보 -->
            <!-- ====================================== -->
            <div class="edit-card basic-card">

                <div class="card-header">
                    <h3>📄 게시판 기본 정보</h3>
                    <p class="card-desc">게시판의 기본 설정을 변경할 수 있습니다.</p>
                </div>

                <div class="form-grid-basic">

                    <!-- 게시판 이름 -->
                    <div class="form-item">
                        <label>게시판 이름</label>
                        <input type="text" name="board_name" value="${board.board_name}">
                    </div>

                    <!-- 사용 여부 -->
                    <div class="form-item">
                        <label>사용 여부</label>
                        <select name="is_active">
                            <option value="1" ${board.is_active == 1 ? 'selected' : ''}>사용</option>
                            <option value="0" ${board.is_active == 0 ? 'selected' : ''}>숨김</option>
                        </select>
                    </div>

                    <!-- 설명 -->
                    <div class="form-item full">
                        <label>게시판 설명</label>
                        <input type="text" name="board_desc" value="${board.board_desc}">
                    </div>

                </div>
            </div>


            <!-- ====================================== -->
            <!-- ⚙ 게시판 옵션 -->
            <!-- ====================================== -->
            <div class="edit-card option-card">

                <div class="card-header">
                    <h3>⚙ 게시판 옵션 설정</h3>
                    <p class="card-desc">작성 / 첨부 / 승인 관련 옵션을 설정하세요.</p>
                </div>

                <div class="form-grid-3">

                    <!-- 댓글 허용 -->
                    <div class="form-item">
                        <label>댓글 허용</label>
                        <input type="hidden" name="allow_comment" value="0">

                        <div class="toggle-switch">
                            <input type="checkbox"
                                   id="opt_comment"
                                   name="allow_comment"
                                   value="1"
                                   <c:if test="${board.allow_comment == 1}">checked</c:if>
                            >
                            <label for="opt_comment"></label>
                        </div>
                    </div>

                    <!-- 이미지 첨부 -->
                    <div class="form-item">
                        <label>이미지 첨부</label>
                        <input type="hidden" name="allow_image" value="0">

                        <div class="toggle-switch">
                            <input type="checkbox"
                                   id="opt_image"
                                   name="allow_image"
                                   value="1"
                                   <c:if test="${board.allow_image == 1}">checked</c:if>
                            >
                            <label for="opt_image"></label>
                        </div>
                    </div>

                    <!-- 파일 첨부 -->
                    <div class="form-item">
                        <label>파일 첨부</label>
                        <input type="hidden" name="allow_file" value="0">

                        <div class="toggle-switch">
                            <input type="checkbox"
                                   id="opt_file"
                                   name="allow_file"
                                   value="1"
                                   <c:if test="${board.allow_file == 1}">checked</c:if>
                            >
                            <label for="opt_file"></label>
                        </div>
                    </div>

                    <!-- 승인 필요 -->
                    <div class="form-item">
                        <label>승인 필요</label>
                        <input type="hidden" name="require_approval" value="0">

                        <div class="toggle-switch">
                            <input type="checkbox"
                                   id="opt_approve"
                                   name="require_approval"
                                   value="1"
                                   <c:if test="${board.require_approval == 1}">checked</c:if>
                            >
                            <label for="opt_approve"></label>
                        </div>
                    </div>

                    <!-- 작성 권한 -->
                    <div class="form-item">
                        <label>작성 권한</label>
                        <select name="write_role">
                            <option value="ALL" ${board.write_role == 'ALL' ? 'selected' : ''}>전체 사용자</option>
                            <option value="ADMIN" ${board.write_role == 'ADMIN' ? 'selected' : ''}>관리자만</option>
                        </select>
                    </div>

                    <!-- 금지 단어 -->
                    <div class="form-item full">
                        <label>금지 단어</label>
                        <input type="text" name="banned_words" value="${board.banned_words}">
                    </div>

                </div>
            </div>


            <!-- =========================== -->
            <!-- 📌 버튼 영역 -->
            <!-- =========================== -->
            <div class="btn-area">

                <!-- 저장 -->
                <button type="submit" class="btn-blue">저장하기</button>

                <!-- 삭제 -->
                <button type="button" class="btn-red" onclick="deleteBoard();">
                    삭제하기
                </button>

                <!-- 목록 -->
                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList'">
                    목록으로
                </button>

            </div>

        </div><!-- wrapper end -->

    </form>


    <!-- 삭제 폼 -->
    <form id="deleteForm"
          action="${pageContext.request.contextPath}/admin/adminBoardDelete"
          method="post">
        <input type="hidden" name="board_id" value="${board.board_id}">
    </form>

</div><!-- main-content end -->


<script>
    function deleteBoard() {
        if (confirm('정말 삭제하시겠습니까?')) {
            document.getElementById('deleteForm').submit();
        }
    }
</script>

</body>
</html>
