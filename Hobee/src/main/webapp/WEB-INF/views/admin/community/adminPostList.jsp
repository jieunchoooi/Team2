<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostList.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

  
    <div class="card-box">

       <!-- 검색 영역 -->
       <form method="get" class="search-box">

           <select name="type" class="search-select">
               <option value="T" ${type == 'T' ? 'selected' : ''}>제목</option>
               <option value="A" ${type == 'A' ? 'selected' : ''}>작성자</option>
               <option value="B" ${type == 'B' ? 'selected' : ''}>게시판</option>
           </select>

           <select name="sort" class="search-select" onchange="this.form.submit()">
               <option value="recent">최신순</option>
               <option value="views">조회순</option>
               <option value="reply">댓글순</option>
               <option value="visible">공개순</option>
           </select>

           <!-- ⭐ 검색 입력 -->
           <div class="search-wrapper">
               <input type="text" name="keyword" class="search-input" placeholder="검색어 입력">
               <div id="autoBox" class="auto-box"></div> <!-- ⭐ 반드시 여기! -->
           </div>

           <button type="submit" class="search-btn">검색</button>

       </form>

        <!-- 일괄 처리 버튼 -->
        <div class="batch-actions">
            <button type="button" class="batch-btn" onclick="batchAction('hide')">선택 숨김</button>
            <button type="button" class="batch-btn" onclick="batchAction('show')">선택 표시</button>
            <button type="button" class="batch-btn delete" onclick="batchAction('delete')">선택 삭제</button>
        </div>

        <!-- 테이블 -->
        <table class="styled-table">
            <thead>
            <tr>
                <th><input type="checkbox" id="checkAll" onclick="toggleAll(this)"></th>
                <th>No</th>
                <th>제목</th>
                <th>작성자</th>
                <th>머리말</th>
                <th>등록일</th>
                <th>조회수</th>
                <th>노출</th>
                <th>관리</th>
            </tr>
            </thead>

            <tbody>

            <c:if test="${empty postList}">
                <tr><td colspan="9" class="no-data">등록된 게시글이 없습니다.</td></tr>
            </c:if>

            <c:forEach var="post" items="${postList}">
                <tr>

                    <!-- 체크박스 -->
                    <td>
                        <input type="checkbox" class="rowCheck" value="${post.post_id}">
                    </td>

                    <td>${post.post_id}</td>

                    <td class="title-cell" data-full-title="${post.title}">
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

                        <!-- 숨기기 / 표시 버튼 -->
                        <form action="${pageContext.request.contextPath}/admin/adminPostToggle" method="post">
                            <input type="hidden" name="post_id" value="${post.post_id}">
                            <button class="${post.is_visible == 1 ? 'btn-hide' : 'btn-show'}">
                                ${post.is_visible == 1 ? '숨기기' : '표시'}
                            </button>
                        </form>

                        <!-- 삭제 버튼 -->
                        <form action="${pageContext.request.contextPath}/admin/adminPostDelete"
                              method="post"
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <input type="hidden" name="post_id" value="${post.post_id}">
                            <button class="btn-danger">삭제</button>
                        </form>

                    </td>


                </tr>
            </c:forEach>

            </tbody>
        </table>

        <!-- 페이징 -->
        <div class="pagination">
            <c:if test="${pageDTO.prev}">
                <a href="?pageNum=${pageDTO.startPage - 1}&type=${type}&keyword=${keyword}" class="page-btn">이전</a>
            </c:if>

            <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="p">
                <a href="?pageNum=${p}&type=${type}&keyword=${keyword}"
                   class="page-btn ${pageNum == p ? 'active' : ''}">${p}</a>
            </c:forEach>

            <c:if test="${pageDTO.next}">
                <a href="?pageNum=${pageDTO.endPage + 1}&type=${type}&keyword=${keyword}" class="page-btn">다음</a>
            </c:if>
        </div>

    </div> <!-- card-box -->

</main>

<!-- ======================== -->
<!-- ★ 일괄 처리 JS -->
<!-- ======================== -->
<script>
function enableBatchMode() {
    document.body.classList.add("batch-mode");
}

function toggleAll(source) {
    document.querySelectorAll(".rowCheck").forEach(ch => ch.checked = source.checked);
}

function batchAction(action) {

    if (!document.body.classList.contains("batch-mode")) {
        enableBatchMode();
        alert("선택 모드가 활성화되었습니다.\n체크박스를 선택 후 다시 버튼을 눌러 실행하세요.");
        return;
    }

    const selected = [...document.querySelectorAll(".rowCheck:checked")].map(ch => ch.value);

    if (selected.length === 0) {
        alert("선택된 게시글이 없습니다.");
        return;
    }

    if (action === "delete" && !confirm("선택한 게시글을 삭제하시겠습니까?")) return;

    const form = document.createElement("form");
    form.method = "POST";
    form.action = "${pageContext.request.contextPath}/admin/adminPostBatch";

    selected.forEach(id => {
        let input = document.createElement("input");
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
}
</script>

<!-- ⭐ 자동완성 AJAX 코드 -->
<script>
const input = document.querySelector(".search-input");
const autoBox = document.getElementById("autoBox");

input.addEventListener("keyup", function () {
    const keyword = this.value.trim();

    // 입력 없으면 바로 숨김
    if (keyword === "") {
        autoBox.innerHTML = "";
        autoBox.style.display = "none";
        return;
    }

    fetch("${pageContext.request.contextPath}/admin/post/searchAuto?keyword=" + keyword)
        .then(res => res.json())
        .then(list => {

            // 결과가 없으면 자동완성 숨김
            if (!list || list.length === 0) {
                autoBox.innerHTML = "";
                autoBox.style.display = "none";   // ⭐ 핵심
                return;
            }

            // 결과가 있을 때만 표시
            autoBox.innerHTML = list
                .map(item => `<div class="auto-item" onclick="selectKeyword('${item}')">${item}</div>`)
                .join("");

            autoBox.style.display = "block";   // ⭐ 여기서만 보이도록
        })
        .catch(err => {
            console.error("자동완성 오류:", err);
            autoBox.style.display = "none";
        });
});

function selectKeyword(value) {
    input.value = value;
    autoBox.style.display = "none";
}

</script>


</body>
</html>