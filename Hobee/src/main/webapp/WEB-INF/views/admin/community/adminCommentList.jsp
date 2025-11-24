<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>댓글 관리 | Hobee Admin</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCommentList.css">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 제목 -->
    <h1 class="page-title">댓글 관리</h1>

    <!-- 카드박스 전체 -->
    <div class="table-card">

        <!-- 검색박스 + 버튼 (1줄) -->
        <form action="${pageContext.request.contextPath}/admin/adminCommentList"
              method="get" class="search-box">

            <select name="type" class="search-select">
                <option value="title"  ${param.type == 'title' ? 'selected' : ''}>게시글 제목</option>
                <option value="userid" ${param.type == 'userid' ? 'selected' : ''}>작성자</option>
                <option value="content"${param.type == 'content' ? 'selected' : ''}>내용</option>
            </select>

            <select name="sort" class="search-select">
                <option value="recent" ${param.sort == 'recent' ? 'selected' : ''}>최신순</option>
                <option value="report" ${param.sort == 'report' ? 'selected' : ''}>신고 많은 순</option>
            </select>

            <input type="text" name="keyword" class="search-input"
                   value="${param.keyword}" placeholder="검색어 입력">

            <button type="submit" class="search-btn">검색</button>

            <button type="button" class="reset-btn"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList'">
                전체 목록
            </button>

            <button type="button" id="batchDeleteBtn" class="batch-red">선택 삭제</button>

        </form>

        <!-- 상태 필터 (2줄) -->
        <div class="status-filter">
            <a href="?status=normal" class="filter-btn ${status == 'normal' ? 'active' : ''}">정상 댓글</a>
            <a href="?status=deleted" class="filter-btn ${status == 'deleted' ? 'active' : ''}">삭제된 댓글</a>
            <a href="?status=all" class="filter-btn ${status == 'all' ? 'active' : ''}">전체 보기</a>
        </div>

        <!-- 테이블 (3줄) -->
        <table class="admin-table" id="commentTable">

            <thead>
            <tr>
                <th><input type="checkbox" id="checkAll"></th>
                <th>No</th>
                <th>게시글 제목</th>
                <th>작성자</th>
                <th>내용</th>
                <th>등록일</th>
                <th>신고</th>
                <th>상세</th>
                <th>관리</th>
            </tr>
            </thead>

            <tbody>

            <c:if test="${empty commentList}">
                <tr><td colspan="9" class="empty-text">댓글이 없습니다.</td></tr>
            </c:if>

            <c:forEach var="c" items="${commentList}">
                <tr>

                    <td><input type="checkbox" class="rowCheck" value="${c.comment_id}"></td>

                    <td>${c.comment_id}</td>

                    <td>
                        <a class="title-link"
                           href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${c.post_id}">
                            ${c.post_title}
                        </a>
                    </td>

                    <td>${c.user_id}</td>

                    <td>
                        <c:choose>
                            <c:when test="${fn:length(c.content) > 20}">
                                ${fn:substring(c.content, 0, 20)}...
                                <button type="button" class="btn-blue small viewDetailBtn"
                                        data-content="${fn:replace(c.content, '\"', '&quot;')}">
                                    전체보기
                                </button>
                            </c:when>
                            <c:otherwise>
                                ${c.content}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>${c.created_at}</td>

                    <td>
                        <c:choose>
                            <c:when test="${c.report_count == 0}">
                                <span class="badge green">${c.report_count}</span>
                            </c:when>
                            <c:when test="${c.report_count <= 2}">
                                <span class="badge yellow">${c.report_count}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge red">${c.report_count}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <button class="btn-blue"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentDetail?comment_id=${c.comment_id}'">
                            상세
                        </button>
                    </td>

                    <td>
                        <c:if test="${c.is_deleted == 0}">
                            <form action="${pageContext.request.contextPath}/admin/adminCommentDelete"
                                  method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                <input type="hidden" name="comment_id" value="${c.comment_id}">
                                <button class="btn-red">삭제</button>
                            </form>
                        </c:if>

                        <c:if test="${c.is_deleted == 1}">
                            <form action="${pageContext.request.contextPath}/admin/adminCommentRestore"
                                  method="post" onsubmit="return confirm('복구하시겠습니까?');">
                                <input type="hidden" name="comment_id" value="${c.comment_id}">
                                <button class="btn-green">복구</button>
                            </form>
                        </c:if>
                    </td>

                </tr>
            </c:forEach>

            </tbody>
        </table>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <c:if test="${pageMaker.prev}">
                <a class="page-btn"
                   href="?pageNum=${pageMaker.startPage - 1}&type=${param.type}&keyword=${param.keyword}&sort=${param.sort}&status=${status}">
                    이전
                </a>
            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <a class="page-btn ${num == pageMaker.page ? 'active' : ''}"
                   href="?pageNum=${num}&type=${param.type}&keyword=${param.keyword}&sort=${param.sort}&status=${status}">
                    ${num}
                </a>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <a class="page-btn"
                   href="?pageNum=${pageMaker.endPage + 1}&type=${param.type}&keyword=${param.keyword}&sort=${param.sort}&status=${status}">
                    다음
                </a>
            </c:if>
        </div>

    </div> <!-- table-card 끝 -->

</main>

<!-- 모달 -->
<div id="commentModal" class="modal">
    <div class="modal-overlay"></div>
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <h2>댓글 전체 내용</h2>
        <div class="modal-body">
            <p id="modalText"></p>
        </div>
    </div>
</div>

<script>
$(".viewDetailBtn").on("click", function () {
    $("#modalText").text($(this).data("content"));
    $("#commentModal").css("display", "flex");
});
$(".close-modal, .modal-overlay").on("click", function () {
    $("#commentModal").hide();
});
</script>

<script>
$("#batchDeleteBtn").on("click", function () {
    const table = $("#commentTable");
    const isSelectMode = table.hasClass("select-mode");

    if (!isSelectMode) {
        table.addClass("select-mode");
        $(this).text("삭제 실행");
        return;
    }

    const ids = $(".rowCheck:checked").map(function () {
        return $(this).val();
    }).get();

    if (ids.length === 0) {
        alert("삭제할 댓글을 선택해주세요.");
        return;
    }

    if (!confirm("선택한 댓글을 삭제하시겠습니까?")) return;

    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/admin/adminCommentBatchDelete",
        traditional: true,
        data: { ids: ids },
        success: function () {
            alert("삭제되었습니다.");
            location.reload();
        }
    });
});
</script>

<script>
$("#checkAll").on("click", function () {
    $(".rowCheck").prop("checked", $(this).prop("checked"));
});
</script>

</body>
</html>
