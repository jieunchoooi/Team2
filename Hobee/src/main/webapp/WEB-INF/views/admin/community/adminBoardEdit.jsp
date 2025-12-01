<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<main class="main-content">

    <!-- 페이지 제목 -->
    <div class="page-title">게시판 수정</div>

    <!-- 카드 박스 -->
    <div class="card-box">

        <div class="edit-title">게시판 정보 수정</div>

        <form action="${pageContext.request.contextPath}/admin/adminBoardEditPro" 
              method="post" 
              class="edit-form">

            <input type="hidden" name="board_id" value="${board.board_id}">

            <!-- 게시판 이름 -->
            <label>게시판 이름</label>
            <input type="text" name="board_name" value="${board.board_name}" required>

            <!-- 게시판 설명 -->
            <label>설명</label>
            <input type="text" name="board_desc" value="${board.board_desc}" required>

            <!-- 사용 여부 -->
            <label>사용 여부</label>
            <select name="is_active">
                <option value="1" ${board.is_active == 1 ? 'selected' : ''}>사용</option>
                <option value="0" ${board.is_active == 0 ? 'selected' : ''}>숨김</option>
            </select>

            <!-- ⭐ 대분류/소분류 선택 -->
            <label>카테고리 위치</label>
            <select name="parent_id" class="select-box">

                <!-- 대분류로 설정 -->
                <option value="" 
                    <c:if test="${board.parent_id == null}">selected</c:if>>
                    (대분류로 설정)
                </option>

                <!-- 모든 대분류 리스트 -->
                <c:forEach var="parent" items="${parentList}">
                    <!-- 본인을 본인의 부모로 선택 방지 -->
                    <c:if test="${parent.board_id != board.board_id}">
                        <option value="${parent.board_id}"
                            <c:if test="${board.parent_id == parent.board_id}">selected</c:if>>
                            ${parent.board_name}
                        </option>
                    </c:if>
                </c:forEach>

            </select>


            <!-- 버튼 영역 -->
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
