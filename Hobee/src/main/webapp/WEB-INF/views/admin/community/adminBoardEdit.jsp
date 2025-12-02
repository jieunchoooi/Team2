<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 수정 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminBoardEdit.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 페이지 제목 -->
    <div class="page-title">게시판 수정</div>

    <!-- 카드 박스 -->
    <div class="card-box">

        <form action="${pageContext.request.contextPath}/admin/adminBoardEditPro"
              method="post">

            <input type="hidden" name="board_id" value="${board.board_id}"/>

            <!-- 게시판 기본 정보 -->
            <div class="edit-section">
                <h3 class="edit-title">게시판 기본 정보</h3>

                <label>게시판 이름</label>
                <input type="text" name="board_name"
                       value="${board.board_name}" required>

                <label>게시판 설명</label>
                <input type="text" name="board_desc"
                       value="${board.board_desc}" required>

                <label>사용 여부</label>
                <select name="is_active">
                    <option value="1" ${board.is_active == 1 ? 'selected' : ''}>사용</option>
                    <option value="0" ${board.is_active == 0 ? 'selected' : ''}>숨김</option>
                </select>
            </div>

            <!-- 게시판 옵션 -->
            <div class="edit-section">
                <h3 class="edit-title">게시판 옵션 설정</h3>

                <label>댓글 허용</label>
                <select name="allow_comment">
                    <option value="1" ${board.allow_comment == 1 ? 'selected' : ''}>허용</option>
                    <option value="0" ${board.allow_comment == 0 ? 'selected' : ''}>금지</option>
                </select>

                <label>이미지 첨부</label>
                <select name="allow_image">
                    <option value="1" ${board.allow_image == 1 ? 'selected' : ''}>허용</option>
                    <option value="0" ${board.allow_image == 0 ? 'selected' : ''}>금지</option>
                </select>

                <label>파일 첨부</label>
                <select name="allow_file">
                    <option value="1" ${board.allow_file == 1 ? 'selected' : ''}>허용</option>
                    <option value="0" ${board.allow_file == 0 ? 'selected' : ''}>금지</option>
                </select>

                <label>작성 권한</label>
                <select name="write_role">
                    <option value="all" ${board.write_role == 'all' ? 'selected' : ''}>전체 사용자</option>
                    <option value="member" ${board.write_role == 'member' ? 'selected' : ''}>로그인 사용자만</option>
                    <option value="admin" ${board.write_role == 'admin' ? 'selected' : ''}>관리자만</option>
                </select>

                <label>게시글 승인 필요 여부</label>
                <select name="require_approval">
                    <option value="0" ${board.require_approval == 0 ? 'selected' : ''}>승인 불필요</option>
                    <option value="1" ${board.require_approval == 1 ? 'selected' : ''}>승인 필요</option>
                </select>

                <label>금지 단어 (쉼표로 구분)</label>
                <input type="text" name="banned_words"
                       placeholder="예: 욕설1, 욕설2"
                       value="${board.banned_words}">
            </div>

            <!-- 저장 버튼 -->
            <div class="btn-area">
                <button type="submit" class="btn-blue">저장하기</button>
                <a href="${pageContext.request.contextPath}/admin/adminBoardList">
                    <button type="button" class="btn-gray">목록으로</button>
                </a>
            </div>

        </form>

    </div>

</main>

</body>
</html>
