<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판 목록 관리 | Hobee Admin</title>

<!-- 공통 관리자 레이아웃 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

<!-- 게시판 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminBoardList.css">

</head>
<body>

<!-- ⭐ 공통 헤더 & 사이드바 (절대경로) -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 콘텐츠 시작 -->
<main class="main-content">

    <!-- 제목 -->
    <div class="main-header">
        <h1>게시판 목록 관리</h1>
    </div>

    <!-- ⭐ 카드 형태 컨테이너 -->
    <div class="table-container">

        <!-- ===============================
             게시판 추가 폼
        =============================== -->
        <div class="board-add-box">
            <h3>게시판 추가</h3>

            <form action="${pageContext.request.contextPath}/admin/adminBoardAdd" method="post">
                <input type="text" name="board_name" placeholder="게시판 이름" required>
                <input type="text" name="board_desc" placeholder="게시판 설명" required>

                <select name="is_active">
                    <option value="1">사용</option>
                    <option value="0">미사용</option>
                </select>

                <button type="submit" class="btn-blue">추가</button>
            </form>
        </div>

        <!-- ===============================
             게시판 리스트 테이블
        =============================== -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>게시판 이름</th>
                    <th>설명</th>
                    <th>사용 여부</th>
                    <th>관리</th>
                </tr>
            </thead>

            <tbody>

                <!-- 데이터 없을 때 -->
                <c:if test="${empty boardList}">
                    <tr>
                        <td colspan="5" style="padding:20px; text-align:center;">
                            등록된 게시판이 없습니다.
                        </td>
                    </tr>
                </c:if>

                <!-- 데이터 있을 때 -->
                <c:forEach var="board" items="${boardList}">
                    <tr>
                        <td>${board.board_id}</td>
                        <td>${board.board_name}</td>
                        <td>${board.board_desc}</td>

                        <td>
                            <span class="${board.is_active == 1 ? 'badge-active' : 'badge-inactive'}">
                                ${board.is_active == 1 ? '사용' : '미사용'}
                            </span>
                        </td>

                        <td>
                            <!-- 수정 -->
                            <a href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                                <button class="btn detail">수정</button>
                            </a>

                            <!-- 삭제 -->
                            <a href="${pageContext.request.contextPath}/admin/adminBoardDelete?board_id=${board.board_id}"
                               onclick="return confirm('정말 삭제하시겠습니까?');">
                                <button class="btn btn-red">삭제</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>

            </tbody>
        </table>

    </div>
    <!-- table-container 종료 -->

</main>
<!-- ⭐ 메인 콘텐츠 종료 -->

</body>
</html>
