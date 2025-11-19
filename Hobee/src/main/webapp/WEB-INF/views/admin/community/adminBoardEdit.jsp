<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판 수정 | Hobee Admin</title>

<!-- 공통 관리자 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

<!-- 게시판 수정 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminBoardList.css">

<style>
/* 추가 입력 폼 디자인 */
.edit-box {
    background: #fff;
    padding: 30px;
    border-radius: 14px;
    width: 90%;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
}

.edit-box h2 {
    margin-bottom: 25px;
    font-size: 22px;
    color: #333;
    font-weight: 700;
}

.edit-row {
    margin-bottom: 20px;
}

.edit-row label {
    display: block;
    margin-bottom: 6px;
    font-size: 14px;
    font-weight: 600;
}

.edit-row input,
.edit-row select,
.edit-row textarea {
    width: 350px;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
}

.edit-row textarea {
    height: 100px;
    resize: none;
}

.btn-save {
    padding: 10px 20px;
    background:#397dff;
    border: none;
    border-radius: 8px;
    color: #fff;
    font-size: 14px;
    cursor: pointer;
    margin-right: 10px;
}

.btn-save:hover {
    background:#2f67d4;
}

.btn-back {
    padding: 10px 20px;
    background:#aaa;
    border: none;
    border-radius: 8px;
    color: white;
    font-size: 14px;
    cursor: pointer;
}

.btn-back:hover {
    background:#888;
}
</style>

</head>
<body>

<!-- 공통 헤더 / 사이드바 -->
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp" />

<!-- 메인 콘텐츠 -->
<main class="main-content">

    <div class="main-header">
        <h1>게시판 수정</h1>
    </div>

    <div class="edit-box">

        <h2>게시판 정보 수정</h2>

        <form action="${pageContext.request.contextPath}/admin/adminBoardEditPro" method="post">

            <!-- PK hidden -->
            <input type="hidden" name="board_id" value="${board.board_id}">

            <!-- 게시판 이름 -->
            <div class="edit-row">
                <label>게시판 이름</label>
                <input type="text" name="board_name" value="${board.board_name}" required>
            </div>

            <!-- 설명 -->
            <div class="edit-row">
                <label>설명</label>
                <textarea name="board_desc" required>${board.board_desc}</textarea>
            </div>

            <!-- 사용 여부 -->
            <div class="edit-row">
                <label>사용 여부</label>
                <select name="is_active">
                    <option value="1" ${board.is_active == 1 ? 'selected' : ''}>사용</option>
                    <option value="0" ${board.is_active == 0 ? 'selected' : ''}>미사용</option>
                </select>
            </div>

            <button type="submit" class="btn-save">저장하기</button>

            <button type="button" class="btn-back"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminBoard';">
                목록으로
            </button>

        </form>
    </div>

</main>

</body>
</html>
