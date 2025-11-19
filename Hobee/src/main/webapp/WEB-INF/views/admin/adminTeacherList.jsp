<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판 목록 관리 | Hobee Admin</title>

<!-- 공통 관리자 CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

<!-- 게시판 목록 전용 CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/adminBoardList.css">

</head>
<body>

<!-- 공통 header -->
<jsp:include page="../include/header.jsp"/>

<!-- 공통 sidebar -->
<jsp:include page="../include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 제목 영역 -->
    <div class="main-header">
        <h1>게시판 목록 관리</h1>
    </div>

    <div class="table-container">
        
        <!-- 게시판 추가 영역 -->
        <div class="board-add-box">
            <h3>게시판 추가</h3>

            <form action="${pageContext.request.contextPath}/admin/adminBoardInsert" method="post">
                <input type="text" name="board_name" placeholder="게시판 이름" required>
                <input type="text" name="board_desc" placeholder="게시판 설명" required>

                <select name="is_active">
                    <option value="1">사용</option>
                    <option value="0">미사용</option>
                </select>

                <button class="btn-blue" type="submit">추가</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>게시판 이름</th>
                    <th>설명</th>
                    <th>사용 여부</th>
                    <th>관리</th>
                </tr>
            </thead>

            <tbody>
                <c:if test="${empty boardList}">
                    <tr>
                        <td colspan="5" style="text-align:center; padding:20px;">등록된 게시판이 없습니다.</td>
                    </tr>
                </c:if>

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
                            <a class="btn detail"
                               href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                               수정
                            </a>

                            <form action="${pageContext.request.contextPath}/admin/adminBoardDelete"
                                  method="post"
                                  style="display:inline-block"
                                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                <input type="hidden" name="board_id" value="${board.board_id}">
                                <button class="btn btn-red">삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </div>
</main>
</body>
</html>
