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

        <!-- ⭐ 대분류 -->
        <c:if test="${board.parent_id == null}">
            <tr class="parent-row" data-id="${board.board_id}">

                <td class="drag-icon">≡</td>
                <td>${board.board_id}</td>
                <td class="title-cell">
                    <strong>📁 ${board.board_name}</strong>
                </td>
                <td>${board.board_desc}</td>
                <td>${board.post_count}</td>

                <td>
                    <span class="${board.is_active == 1 ? 'badge-active' : 'badge-inactive'}">
                        ${board.is_active == 1 ? "사용" : "숨김"}
                    </span>
                </td>

                <td class="btn-group">
                    <a href="${contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                        <button class="btn detail">수정</button>
                    </a>

                    <c:if test="${board.is_active == 1}">
                        <form action="${contextPath}/admin/adminBoardDisable" method="post">
                            <input type="hidden" name="board_id" value="${board.board_id}">
                            <button class="btn btn-red">숨기기</button>
                        </form>
                    </c:if>

                    <c:if test="${board.is_active == 0}">
                        <form action="${contextPath}/admin/adminBoardEnable" method="post">
                            <input type="hidden" name="board_id" value="${board.board_id}">
                            <button class="btn btn-green">표시</button>
                        </form>
                    </c:if>
                </td>

            </tr>

            <!-- ⭐ 소분류 반복 -->
            <c:forEach var="child" items="${boardList}">
                <c:if test="${child.parent_id == board.board_id}">
                    <tr class="child-row" data-id="${child.board_id}">
                        <td class="drag-icon">≡</td>
                        <td>${child.board_id}</td>

                        <td class="title-cell child-indent">
                            ↳ ${child.board_name}
                        </td>

                        <td>${child.board_desc}</td>
                        <td>${child.post_count}</td>

                        <td>
                            <span class="${child.is_active == 1 ? 'badge-active' : 'badge-inactive'}">
                                ${child.is_active == 1 ? "사용" : "숨김"}
                            </span>
                        </td>

                        <td class="btn-group">
                            <a href="${contextPath}/admin/adminBoardEdit?board_id=${child.board_id}">
                                <button class="btn detail">수정</button>
                            </a>

                            <c:if test="${child.is_active == 1}">
                                <form action="${contextPath}/admin/adminBoardDisable" method="post">
                                    <input type="hidden" name="board_id" value="${child.board_id}">
                                    <button class="btn btn-red">숨기기</button>
                                </form>
                            </c:if>

                            <c:if test="${child.is_active == 0}">
                                <form action="${contextPath}/admin/adminBoardEnable" method="post">
                                    <input type="hidden" name="board_id" value="${child.board_id}">
                                    <button class="btn btn-green">표시</button>
                                </form>
                            </c:if>
                        </td>

                    </tr>
                </c:if>
            </c:forEach>

        </c:if>

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
        handle: ".drag-handle",
        update: function(event, ui) {

            let orderData = "";

            $("#board-sortable tr").each(function(index) {
                let boardId = $(this).data("id");
                let order = index + 1;
                orderData += boardId + ":" + order + ",";
            });

            orderData = orderData.slice(0, -1);

            $.ajax({
                url: "${pageContext.request.contextPath}/admin/updateBoardOrder",
                type: "POST",
                data: { orderData: orderData },
                success: function(res) {
                    console.log("정렬 저장 완료");
                }
            });
        }
    });

});
</script>

</body>
</html>
