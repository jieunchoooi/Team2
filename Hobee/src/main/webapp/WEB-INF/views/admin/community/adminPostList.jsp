<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 관리 | Hobee Admin</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostList.css">
</head>

<body>

    <!-- header + sidebar -->
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
    <jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

    <main class="main-content">

        <!-- 제목 -->
        <div class="page-title">게시글 관리</div>

        <!-- 카드 박스 -->
        <div class="card-box">

            <!-- 🔍 검색 영역 -->
            <form method="get" class="search-box">

                <!-- 검색 기준 -->
                <select name="type" class="search-select">
                    <option value="T" ${type == 'T' ? 'selected' : ''}>제목</option>
                    <option value="A" ${type == 'A' ? 'selected' : ''}>작성자</option>
                    <option value="B" ${type == 'B' ? 'selected' : ''}>게시판</option>
                </select>

                <!-- 🔥 정렬 기준 -->
                <select name="sort" class="search-select" onchange="this.form.submit()">
                    <option value="recent" ${sort == 'recent' ? 'selected' : ''}>최신순</option>
                    <option value="views" ${sort == 'views' ? 'selected' : ''}>조회순</option>
                    <option value="reply" ${sort == 'reply' ? 'selected' : ''}>댓글순</option>
                    <option value="visible" ${sort == 'visible' ? 'selected' : ''}>공개순</option>
                </select>

                <!-- 검색어 -->
                <input type="text" name="keyword" value="${keyword}" 
                       placeholder="검색어를 입력하세요" class="search-input">

                <!-- 검색 버튼 -->
                <button type="submit" class="search-btn">검색</button>

                <!-- 전체 목록 버튼 -->
                <button type="button" class="reset-btn"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
                    전체 목록
                </button>

            </form>

            <!-- 🔥 일괄 처리 버튼 -->
            <div class="batch-actions">
                <button type="button" class="batch-btn" onclick="enableBatchMode()">선택 숨김</button>
                <button type="button" class="batch-btn" onclick="enableBatchMode()">선택 표시</button>
                <button type="button" class="batch-btn delete" onclick="enableBatchMode()">선택 삭제</button>
            </div>

            <!-- 테이블 -->
            <table class="styled-table">
                <thead>
                    <tr>
                        <!-- ★ 체크박스 컬럼 (선택 모드에서만 보임) -->
                        <th>
                            <input type="checkbox" id="checkAll" onclick="toggleAll(this)">
                        </th>

                        <th>No</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>게시판</th>
                        <th>등록일</th>
                        <th>조회수</th>
                        <th>노출</th>
                        <th>관리</th>
                    </tr>
                </thead>

                <tbody>

                    <c:if test="${empty postList}">
                        <tr>
                            <td colspan="9" class="no-data">등록된 게시글이 없습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="post" items="${postList}">
                        <tr>

                            <!-- ★ 개별 선택 체크박스 -->
                            <td>
                                <input type="checkbox" class="rowCheck" value="${post.post_id}">
                            </td>

                            <td>${post.post_id}</td>

                            <td class="title-cell">
                                <a href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${post.post_id}"
                                   class="post-link">
                                    ${post.title}
                                </a>
                            </td>

                            <td>${post.author}</td>
                            <td>${post.board_name}</td>
                            <td>${post.created_at}</td>
                            <td>${post.views}</td>

                            <td>
                                <span class="${post.is_visible == 1 ? 'badge-active' : 'badge-inactive'}">
                                    ${post.is_visible == 1 ? '공개' : '숨김'}
                                </span>
                            </td>

                            <td class="btn-group">

                                <!-- 숨김/표시 -->
                                <form action="${pageContext.request.contextPath}/admin/adminPostToggle" method="post">
                                    <input type="hidden" name="post_id" value="${post.post_id}">
                                    <button class="${post.is_visible == 1 ? 'btn-red' : 'btn-green'}">
                                        ${post.is_visible == 1 ? '숨기기' : '표시'}
                                    </button>
                                </form>

                                <!-- 삭제 -->
                                <form action="${pageContext.request.contextPath}/admin/adminPostDelete"
                                      method="post"
                                      onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                    <input type="hidden" name="post_id" value="${post.post_id}">
                                    <button class="btn-red">삭제</button>
                                </form>

                            </td>

                        </tr>
                    </c:forEach>

                </tbody>
            </table>

            <!-- 페이징 -->
            <div class="pagination">

                <c:if test="${pageDTO.prev}">
                    <a href="?pageNum=${pageDTO.startPage - 1}&type=${type}&keyword=${keyword}"
                       class="page-btn">이전</a>
                </c:if>

                <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="p">
                    <a href="?pageNum=${p}&type=${type}&keyword=${keyword}"
                       class="page-btn ${pageNum == p ? 'active' : ''}">
                       ${p}
                    </a>
                </c:forEach>

                <c:if test="${pageDTO.next}">
                    <a href="?pageNum=${pageDTO.endPage + 1}&type=${type}&keyword=${keyword}"
                       class="page-btn">다음</a>
                </c:if>

            </div>

        </div> <!-- card-box -->


<!-- ============================================================= -->
<!-- 🔥 선택 모드 + 일괄 처리 JS (★ 전체 추가됨) -->
<!-- ============================================================= -->
<script>
/* ================================
   ✔ 선택 모드 활성화(체크박스 보임)
================================ */
function enableBatchMode() {
    document.body.classList.add("batch-mode");
    alert("선택 모드가 활성화되었습니다.\n체크박스를 선택 후 다시 버튼을 눌러 실행하세요.");
}

/* ================================
   ✔ 전체 선택 / 전체 해제
================================ */
function toggleAll(source) {
    const checks = document.querySelectorAll(".rowCheck");
    checks.forEach(ch => ch.checked = source.checked);
}

/* ================================
   ✔ 일괄 처리 (숨김/표시/삭제)
================================ */
function batchAction(action) {

    // 체크박스가 안 보이면 모드 활성화만 하고 종료
    if (!document.body.classList.contains("batch-mode")) {
        enableBatchMode();
        return;
    }

    // 선택된 게시글 수집
    const selected = [...document.querySelectorAll(".rowCheck:checked")]
                     .map(ch => ch.value);

    if (selected.length === 0) {
        alert("선택된 게시글이 없습니다.");
        return;
    }

    if (action === 'delete' && !confirm("선택한 게시글을 삭제하시겠습니까?")) {
        return;
    }

    // 폼 생성하여 전송
    const form = document.createElement("form");
    form.method = "POST";
    form.action = "${pageContext.request.contextPath}/admin/adminPostBatch";

    selected.forEach(id => {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "postIds";
        input.value = id;
        form.appendChild(input);
    });

    const actionInput = document.createElement("input");
    actionInput.type = "hidden";
    actionInput.name = "action";
    actionInput.value = action;
    form.appendChild(actionInput);

    document.body.appendChild(form);
    form.submit();

    // 처리 후 선택 모드 해제
    document.body.classList.remove("batch-mode");
}
</script>
<!-- ============================================================= -->

    </main>

</body>
</html>
