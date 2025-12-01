<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 관리 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeList.css">

</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header">
        <h1>공지사항 관리</h1>
    </div>

    <div class="table-card">

        <!-- 🔸 검색 + 버튼 정렬 -->
        <div class="top-bar">

            <!-- 🔍 검색창 -->
            <form method="get"
                  action="${pageContext.request.contextPath}/admin/adminNoticeList"
                  class="search-box">

                <select name="type" class="search-select">
                    <option value="title"  ${param.type == 'title' ? 'selected' : ''}>제목</option>
                    <option value="content" ${param.type == 'content' ? 'selected' : ''}>내용</option>
                    <option value="admin_id" ${param.type == 'admin_id' ? 'selected' : ''}>작성자</option>
                </select>

                <input type="text" name="keyword" class="search-input"
                       value="${param.keyword}" placeholder="검색어를 입력하세요">

                <button class="btn-search" type="submit">검색</button>

            </form>

            <!-- ➕ 공지작성 + 선택삭제 -->
            <div class="right-area">
                <button class="btn-write"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeWrite'">
                    + 공지 작성
                </button>

                <button type="button" class="bulk-delete-btn" id="deleteModeBtn">
                    선택 삭제
                </button>
            </div>

        </div>

        <!-- ⭐ 정렬 버튼 -->
        <div class="sort-box">
            <a href="?sort=recent&type=${type}&keyword=${keyword}"
               class="sort-btn ${sort == 'recent' ? 'active' : ''}">
                최신순
            </a>

            <a href="?sort=views&type=${type}&keyword=${keyword}"
               class="sort-btn ${sort == 'views' ? 'active' : ''}">
                조회많은순
            </a>
        </div>

        <!-- 📋 공지 리스트 테이블 -->
        <table class="admin-table">
            <thead>
            <tr>
                <th><input type="checkbox" id="checkAll" class="bulk-check-header" style="display:none;"></th>
                <th>No</th>
                <th>제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>중요도</th>
                <th>조회</th>
                <th>공개</th>
                <th>PIN</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
            </thead>

            <tbody>
            <c:if test="${empty noticeList}">
                <tr>
                    <td colspan="10" class="empty-text">등록된 공지사항이 없습니다.</td>
                </tr>
            </c:if>

            <c:forEach var="n" items="${noticeList}">
                <tr>

                    <td>
                        <input type="checkbox" name="noticeIds"
                               value="${n.notice_id}" class="bulk-check"
                               style="display:none;">
                    </td>

                    <td>${n.notice_id}</td>

                    <td>
                        <a class="title-link"
                           href="${pageContext.request.contextPath}/admin/adminNoticeDetail?notice_id=${n.notice_id}">
                            ${n.title}
                        </a>
                    </td>

                    <td>${n.admin_id}</td>
                    <td>${n.created_at}</td>
                    
                    <td>
    					<c:choose>
        					<c:when test="${n.priority == 4}">
            					<span style="color:#ff3333; font-weight:700;">🔥 긴급</span>
        					</c:when>
        					<c:when test="${n.priority == 3}">
            					<span style="color:#ff6600; font-weight:700;">매우 중요</span>
        					</c:when>
        					<c:when test="${n.priority == 2}">
            					<span style="color:#2573ff; font-weight:600;">중요</span>
       					 	</c:when>
        				<c:otherwise>일반</c:otherwise>
    					</c:choose>
					</td>
					
					
                    <td>${n.view_count}</td>
                    
                   
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/adminNoticeVisible" method="post">
                            <input type="hidden" name="notice_id" value="${n.notice_id}">
                            <input type="hidden" name="is_visible" value="${n.is_visible == 1 ? 0 : 1}">
                            <button class="${n.is_visible == 1 ? 'btn-blue' : 'btn-gray'}">
                                ${n.is_visible == 1 ? '공개' : '숨김'}
                            </button>
                        </form>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/admin/adminNoticePinned" method="post">
                            <input type="hidden" name="notice_id" value="${n.notice_id}">
                            <input type="hidden" name="is_pinned" value="${n.is_pinned == 1 ? 0 : 1}">
                            <button class="${n.is_pinned == 1 ? 'btn-orange' : 'btn-gray'}">
                                ${n.is_pinned == 1 ? '고정 해제' : '상단 고정'}
                            </button>
                        </form>
                    </td>

                    <td>
                        <button class="btn-edit"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeEdit?notice_id=${n.notice_id}'">
                            수정
                        </button>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/admin/adminNoticeDelete"
                              method="post"
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <input type="hidden" name="notice_id" value="${n.notice_id}">
                            <button class="btn-red">삭제</button>
                        </form>
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 📌 페이징 -->
        <div class="pagination">
            <c:if test="${pageDTO.prev}">
                <a href="?page=${pageDTO.startPage - 1}&sort=${sort}&type=${type}&keyword=${keyword}"
                   class="page-btn">이전</a>
            </c:if>

            <c:forEach var="p" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
                <a href="?page=${p}&sort=${sort}&type=${type}&keyword=${keyword}"
                   class="page-btn ${pageDTO.page == p ? 'active' : ''}">
                    ${p}
                </a>
            </c:forEach>

            <c:if test="${pageDTO.next}">
                <a href="?page=${pageDTO.endPage + 1}&sort=${sort}&type=${type}&keyword=${keyword}"
                   class="page-btn">다음</a>
            </c:if>
        </div>

    </div>

</main>

<!-- 선택삭제 JS -->
<script>
    const deleteModeBtn = document.getElementById("deleteModeBtn");
    const deleteForm = document.getElementById("deleteForm");
    const checks = document.querySelectorAll(".bulk-check");
    const headerCheck = document.querySelector(".bulk-check-header");

    let bulkMode = false;

    deleteModeBtn.addEventListener("click", function (e) {
        if (!bulkMode) {
            e.preventDefault();
            bulkMode = true;

            checks.forEach(cb => cb.style.display = "inline-block");
            headerCheck.style.display = "inline-block";

            deleteModeBtn.textContent = "선택 삭제 실행";
            alert("삭제할 공지를 체크하세요!");
            return;
        }

        const selected = document.querySelectorAll(".bulk-check:checked");
        if (selected.length === 0) {
            alert("삭제할 공지를 선택하세요!");
            return;
        }

        selected.forEach(cb => {
            const hidden = document.createElement("input");
            hidden.type = "hidden";
            hidden.name = "noticeIds";
            hidden.value = cb.value;
            deleteForm.appendChild(hidden);
        });

        deleteForm.submit();
    });

    headerCheck.addEventListener("change", function () {
        checks.forEach(cb => cb.checked = this.checked);
    });
</script>

</body>
</html>
