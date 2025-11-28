<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>커뮤니티 | Hobee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityList.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

<jsp:include page="../include/header.jsp" />

<main class="main-content">

    <%-- ===========================================================
         🔥 전체 레이아웃: 왼쪽 본문 + 오른쪽 인기글
    ============================================================ --%>
    <div class="community-layout">

        <%-- ===========================================================
             🔥 왼쪽 영역 (본래 네가 작성한 모든 메인 기능)
        ============================================================ --%>
        <section class="community-left">

            <h1>커뮤니티</h1>

            <%-- ===========================================================
                 🔥 1) 카테고리 CHIP
            ============================================================ --%>
            <div class="category-chips">

                <%-- 전체 --%>
                <a href="/community/list"
                   class="chip ${(empty cri.category_id and empty cri.category_main_num) ? 'active' : ''}">
                    전체
                </a>

                <%-- 기본 말머리 (category_id) --%>
                <a href="/community/list?category_id=1" class="chip ${cri.category_id == 1 ? 'active' : ''}">공지</a>
                <a href="/community/list?category_id=2" class="chip ${cri.category_id == 2 ? 'active' : ''}">잡담</a>
                <a href="/community/list?category_id=3" class="chip ${cri.category_id == 3 ? 'active' : ''}">Q&A</a>
                <a href="/community/list?category_id=4" class="chip ${cri.category_id == 4 ? 'active' : ''}">후기</a>

                <%-- DB 기반 메인 카테고리(category_main_num) --%>
                <c:forEach var="cm" items="${categoryMainList}">
                    <a href="/community/list?category_main_num=${cm.category_main_num}"
                       class="chip ${cri.category_main_num == cm.category_main_num ? 'active' : ''}">
                        ${cm.category_main_name}
                    </a>
                </c:forEach>

            </div>


            <%-- ===========================================================
                 🔥 2) 정렬 / 기간 / 검색 / 카드형 토글
            ============================================================ --%>
            <div class="filter-bar">

                <button id="toggleViewBtn" class="toggle-btn">카드형 보기</button>

                <select id="sortFilter" onchange="applyFilters()">
                    <option value="latest"   ${cri.sort == 'latest'   ? 'selected' : ''}>최신순</option>
                    <option value="views"    ${cri.sort == 'views'    ? 'selected' : ''}>조회수</option>
                    <option value="likes"    ${cri.sort == 'likes'    ? 'selected' : ''}>좋아요</option>
                    <option value="comments" ${cri.sort == 'comments' ? 'selected' : ''}>댓글</option>
                </select>

                <select id="periodFilter" onchange="applyFilters()">
                    <option value="all"   ${cri.period == 'all'   ? 'selected' : ''}>전체</option>
                    <option value="today" ${cri.period == 'today' ? 'selected' : ''}>오늘</option>
                    <option value="week"  ${cri.period == 'week'  ? 'selected' : ''}>1주일</option>
                    <option value="month" ${cri.period == 'month' ? 'selected' : ''}>1개월</option>
                </select>

                <div class="search-box">
                    <select id="searchType">
                        <option value="title"        ${cri.searchType == 'title' ? 'selected' : ''}>제목</option>
                        <option value="titleContent" ${cri.searchType == 'titleContent' ? 'selected' : ''}>제목+내용</option>
                        <option value="writer"       ${cri.searchType == 'writer' ? 'selected' : ''}>작성자</option>
                        <option value="comment"      ${cri.searchType == 'comment' ? 'selected' : ''}>댓글</option>
                    </select>
                    <input type="text" id="searchKeyword" value="${cri.keyword}" placeholder="검색어 입력">
                    <button onclick="applyFilters()">🔍</button>
                </div>

            </div>


            <%-- ===========================================================
                 🔥 3) 리스트형 VIEW
            ============================================================ --%>
            <div class="list-container">

                <c:forEach var="post" items="${communityList}">
                    <div class="list-row"
                        onclick="location.href='/community/detail?post_id=${post.post_id}'">

                        <span class="tag">${post.category_name}</span>
                        <span class="title">${post.title}</span>
                        <span class="likes">❤️ ${post.like_count}</span>
                        <span class="writer">${post.user_name}</span>

                        <span class="date">
                            <fmt:formatDate value="${post.created_at}" pattern="yyyy-MM-dd"/>
                        </span>

                        <span class="views">${post.views}</span>
                    </div>
                </c:forEach>

                <c:if test="${empty communityList}">
                    <div class="no-data">등록된 게시글이 없습니다.</div>
                </c:if>

            </div>


            <%-- ===========================================================
                 🔥 4) 카드형 VIEW
            ============================================================ --%>
            <div class="card-list">

                <c:forEach var="post" items="${communityList}">
                    <div class="post-card"
                         onclick="location.href='/community/detail?post_id=${post.post_id}'">

                        <div class="post-title">${post.title}</div>

                        <div class="post-meta">
                            ${post.category_name} · ${post.user_name} ·
                            <fmt:formatDate value="${post.created_at}" pattern="yyyy-MM-dd"/>
                        </div>

                        <div class="post-stats">
                            ❤️ ${post.like_count}
                            · 💬 ${post.comment_count}
                            · 👁 ${post.views}
                        </div>

                    </div>
                </c:forEach>

                <c:if test="${empty communityList}">
                    <div class="no-data">등록된 게시글이 없습니다.</div>
                </c:if>

            </div>


            <%-- ===========================================================
                 🔥 5) 페이징
            ============================================================ --%>
            <div class="pagination">

                <c:if test="${pageMaker.prev}">
                    <a href="#" onclick="return movePage(${pageMaker.startPage - 1});">이전</a>
                </c:if>

                <c:forEach var="p" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <a href="#" class="${p == cri.page ? 'active' : ''}"
                       onclick="return movePage(${p});">${p}</a>
                </c:forEach>

                <c:if test="${pageMaker.next}">
                    <a href="#" onclick="return movePage(${pageMaker.endPage + 1});">다음</a>
                </c:if>

            </div>

        </section>


        <%-- ===========================================================
             🔥 오른쪽 사이드바: 인기글 TOP10 (네 기존 코드 그대로 이동)
        ============================================================ --%>
        <aside class="community-right">

            <div class="popular-box">
                <h2>🔥 인기 글 TOP 10</h2>

                <div class="popular-list">
                    <c:forEach var="p" items="${popularList}">
                        <div class="popular-row"
                             onclick="location.href='/community/detail?post_id=${p.post_id}'">

                            <span class="p-title">${p.title}</span>
                            <span class="p-meta">
                                ❤️ ${p.like_count}
                                · <fmt:formatDate value="${p.created_at}" pattern="yyyy-MM-dd"/>
                            </span>
                        </div>
                    </c:forEach>

                    <c:if test="${empty popularList}">
                        <div class="no-data small">인기글 데이터 없음</div>
                    </c:if>
                </div>
            </div>

        </aside>

    </div> <%-- community-layout END --%>

</main>



<script>
/* =============================================
   🔥 필터 적용
============================================= */
function applyFilters() {
    let url = '/community/list?';

    const categoryId  = "${cri.category_id}";
    const mainCat     = "${cri.category_main_num}";
    const sort        = $('#sortFilter').val();
    const period      = $('#periodFilter').val();
    const searchType  = $('#searchType').val();
    const keyword     = $('#searchKeyword').val();

    if (categoryId) url += `category_id=${categoryId}&`;
    if (mainCat)    url += `category_main_num=${mainCat}&`;
    if (sort)       url += `sort=${sort}&`;
    if (period)     url += `period=${period}&`;
    if (searchType) url += `searchType=${searchType}&`;
    if (keyword)    url += `keyword=${keyword}&`;

    url += `page=1`;

    location.href = url;
}


/* =============================================
   🔥 페이징 이동
============================================= */
function movePage(page) {
    let url = '/community/list?';

    const categoryId  = "${cri.category_id}";
    const mainCat     = "${cri.category_main_num}";
    const sort        = "${cri.sort}";
    const period      = "${cri.period}";
    const searchType  = "${cri.searchType}";
    const keyword     = "${cri.keyword}";

    if (categoryId) url += `category_id=${categoryId}&`;
    if (mainCat)    url += `category_main_num=${mainCat}&`;
    if (sort)       url += `sort=${sort}&`;
    if (period)     url += `period=${period}&`;
    if (searchType) url += `searchType=${searchType}&`;
    if (keyword)    url += `keyword=${keyword}&`;

    url += `page=${page}`;
    location.href = url;

    return false;
}


/* =============================================
   🔥 리스트형 ↔ 카드형 전환
============================================= */
let currentView = "list";

$("#toggleViewBtn").on("click", function () {

    if (currentView === "list") {
        $(".list-container").hide();
        $(".card-list").css("display", "grid");
        $(this).text("리스트형 보기");
        currentView = "card";
    } else {
        $(".card-list").hide();
        $(".list-container").show();
        $(this).text("카드형 보기");
        currentView = "list";
    }
});


/* Enter 검색 */
$('#searchKeyword').on('keypress', function(e) {
    if (e.key === 'Enter') applyFilters();
});
</script>

</body>
</html>
