<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판 관리 | Hobee Admin</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminBoardList.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>


    <!-- 최상단 큰 제목 -->
    <div class="page-title">게시판 추가</div>

    <!-- 카드형 컨테이너 -->
    <div class="card-box">

        <!-- 추가 폼 -->
        <form class="add-form" action="${pageContext.request.contextPath}/admin/adminBoardAdd" method="post">

            <input type="text" name="board_name" placeholder="게시판 이름" required>
            <input type="text" name="board_desc" placeholder="게시판 설명" required>

            <select name="is_active">
                <option value="1">사용</option>
                <option value="0">미사용</option>
            </select>

            <button type="submit" class="btn-blue">추가</button>
        </form>

        <!-- 게시판 목록 테이블 -->
        <table class="styled-table">
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

                <c:if test="${empty boardList}">
                    <tr>
                        <td colspan="5" class="no-data">등록된 게시판이 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="board" items="${boardList}">
                    <tr>
                        <td>${board.board_id}</td>
                        <td>${board.board_name}</td>
                        <td>${board.board_desc}</td>

                        <td>
                            <span class="${board.is_active == 1 ? 'badge-active' : 'badge-inactive'}">
                                ${board.is_active == 1 ? '사용' : '숨김'}
                            </span>
                        </td>

                        <td class="btn-group">
                            <!-- 수정 버튼 -->
                            <a href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                                <button type="button" class="btn detail">수정</button>
                            </a>

                            <!-- 숨기기 -->
                            <c:if test="${board.is_active == 1}">
                                <form action="${pageContext.request.contextPath}/admin/adminBoardDisable" method="post">
                                    <input type="hidden" name="board_id" value="${board.board_id}">
                                    <button class="btn btn-red">숨기기</button>
                                </form>
                            </c:if>

                            <!-- 표시 -->
                            <c:if test="${board.is_active == 0}">
                                <form action="${pageContext.request.contextPath}/admin/adminBoardEnable" method="post">
                                    <input type="hidden" name="board_id" value="${board.board_id}">
                                    <button class="btn btn-green">표시</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

            </tbody>
        </table>

    </div>

</main>

</body>
</html>
