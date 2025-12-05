<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판 관리 | Hobee Admin</title>

<!-- 📌 공통 사이드바 + 스타일 불러오기 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminBoardList.css">

</head>
<body>

<!-- 📌 공통 헤더 + 공통 사이드바 포함 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

<!-- 📌 숨김/표시 처리 후 전달된 메시지(alert) -->
<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>

<!-- 📌 페이지 최상단 제목 -->
<div class="page-title">게시판 목록</div>

<!-- 📌 게시판 추가 / 목록 테이블을 감싸는 카드형 컨테이너 -->
<div class="card-box">

    <!-- 📌 새로운 게시판 추가 폼 -->
    <form class="add-form" action="${pageContext.request.contextPath}/admin/adminBoardAdd" method="post">

        <!-- 게시판 이름 입력 -->
        <input type="text" name="board_name" placeholder="게시판 이름" required>

        <!-- 게시판 설명 입력 -->
        <input type="text" name="board_desc" placeholder="게시판 설명" required>

        <!-- 활성 여부 선택 -->
        <select name="is_active">
            <option value="1">사용</option>
            <option value="0">미사용</option>
        </select>

        <!-- 추가 버튼 -->
        <button type="submit" class="btn-blue">추가</button>
    </form>

    <!-- 📌 게시판 목록 테이블 -->
    <table class="styled-table">
        <thead>
            <tr>
                <th style="width:40px;"></th> <!-- 📌 드래그 정렬 아이콘 영역 -->
                <th>ID</th>
                <th>게시판 이름</th>
                <th>설명</th>
                <th>게시글 수</th>
                <th>사용 여부</th>
                <th>관리</th>
            </tr>
        </thead>

        <!-- 📌 실제 게시판 목록을 출력하는 영역 (드래그 정렬 가능) -->
        <tbody id="board-sortable">
            <c:forEach var="board" items="${boardList}">
                <!-- 각 행에 board_id 저장 → 드래그 정렬에서 사용 -->
                <tr data-id="${board.board_id}">

                    <!-- 📌 드래그 핸들 -->
                    <td class="drag-icon">≡</td>

                    <!-- 게시판 ID -->
                    <td>${board.board_id}</td>

                    <!-- 게시판 이름 클릭 시 상세 페이지로 이동 -->
                    <td class="title-cell">
                        <a href="${pageContext.request.contextPath}/admin/adminBoardDetail?board_id=${board.board_id}">
                            ${board.board_name}
                        </a>
                    </td>

                    <!-- 게시판 설명 -->
                    <td>${board.board_desc}</td>

                    <!-- 게시판 내 게시글 수 -->
                    <td>${board.post_count}</td>

                    <!-- 사용 여부: badge 스타일로 표시 -->
                    <td>
                        <span class="${board.is_active == 1 ? 'badge-active' : 'badge-inactive'}">
                            ${board.is_active == 1 ? "사용" : "숨김"}
                        </span>
                    </td>

                    <!-- 📌 수정/숨김/표시 버튼 그룹 -->
                    <td class="btn-group">

                        <!-- 수정 화면 이동 -->
                        <a href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                            <button type="button" class="btn detail">수정</button>
                        </a>

                        <!-- 숨김 처리 -->
                        <c:if test="${board.is_active == 1}">
                            <form action="${pageContext.request.contextPath}/admin/adminBoardDisable" method="post">
                                <input type="hidden" name="board_id" value="${board.board_id}">
                                <button type="submit" class="btn btn-red">숨기기</button>
                            </form>
                        </c:if>

                        <!-- 표시 처리 -->
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

</div> <!-- card-box END -->

</main>

<!-- 📌 드래그 정렬 스크립트 (게시판 순서 저장 기능) -->
<script>
$(function() {
    $("#board-sortable").sortable({
        placeholder: "sortable-highlight",      // 드래그 중 표시 스타일
        handle: ".drag-icon",                   // 드래그 활성 영역 지정
        cancel: "a, button, input, select",     // 클릭 요소 제외
        axis: "y",                              // 세로 방향만 드래그

        // 📌 정렬 완료 시 서버로 순서 업데이트 요청
        update: function(event, ui) {

            let orderData = "";

            $("#board-sortable tr").each(function(index) {
                let boardId = $(this).data("id"); // 행의 board_id
                let order = index + 1;            // 새로운 순서 번호
                orderData += boardId + ":" + order + ",";
            });

            orderData = orderData.slice(0, -1); // 마지막 콤마 제거

            $.post("${pageContext.request.contextPath}/admin/updateBoardOrder",
                { orderData: orderData },
                function(res){
                    console.log("저장됨", res);  // 성공 여부 콘솔 출력
                }
            );
        }
    });
});
</script>

</body>
</html>
