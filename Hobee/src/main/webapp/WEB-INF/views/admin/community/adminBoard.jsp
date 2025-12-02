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
    <div class="page-title">게시판 목록</div>

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
                    <th style="width:40px;"></th> <!-- 드래그 핸들 -->
                    <th>ID</th>
                    <th>게시판 이름</th>
                    <th>설명</th>
                    <th>게시글 수</th>
                    <th>사용 여부</th>
                    <th>관리</th>
                </tr>
            </thead>

            <tbody id="board-sortable">
                <c:forEach var="board" items="${boardList}">
                    <tr data-id="${board.board_id}">

                        <!-- 드래그 아이콘 -->
                        <td class="drag-icon">≡</td>

                        <td>${board.board_id}</td>

                        <!-- 제목 → 상세 페이지 이동 -->
                        <td class="title-cell">
                            <a href="${pageContext.request.contextPath}/admin/adminBoardDetail?board_id=${board.board_id}">
                                ${board.board_name}
                            </a>
                        </td>

                        <td>${board.board_desc}</td>

                        <td>${board.post_count}</td>

                        <!-- 표시/숨김 뱃지 -->
                        <td>
                            <span class="${board.is_active == 1 ? 'badge-active' : 'badge-inactive'}">
                                ${board.is_active == 1 ? "사용" : "숨김"}
                            </span>
                        </td>

                        <!-- 버튼 그룹 -->
                        <td class="btn-group">

                            <!-- 수정 -->
                            <a href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                                <button type="button" class="btn detail">수정</button>
                            </a>

                            <!-- 숨김/표시 -->
                            <c:if test="${board.is_active == 1}">
                                <form action="${pageContext.request.contextPath}/admin/adminBoardDisable" method="post">
                                    <input type="hidden" name="board_id" value="${board.board_id}">
                                    <button type="submit" class="btn btn-red">숨기기</button>
                                </form>
                            </c:if>

                            <c:if test="${board.is_active == 0}">
                                <form action="${pageContext.request.contextPath}/admin/adminBoardEnable"
                                      method="post"
                                      style="display:inline-block;">

                                    <input type="hidden" name="board_id" value="${board.board_id}">

                                    <button type="submit" class="btn btn-show">표시</button>
                                </form>
                            </c:if>

                        </td>

                    </tr>
                </c:forEach>
            </tbody>


        </table>

    </div>

</main>

<!-- 드래그 스크립트 -->
<script>
$(function() {
    $("#board-sortable").sortable({
        placeholder: "sortable-highlight",
        handle: ".drag-icon",
        cancel: "a, button, input, select",
        axis: "y",
        update: function(event, ui) {
            let orderData = "";
            $("#board-sortable tr").each(function(index) {
                let boardId = $(this).data("id");
                let order = index + 1;
                orderData += boardId + ":" + order + ",";
            });
            orderData = orderData.slice(0, -1);
            $.post("${pageContext.request.contextPath}/admin/updateBoardOrder",
                { orderData: orderData },
                function(res){ console.log("저장됨", res); }
            );
        }
    });
});

</script>

</body>
</html>
