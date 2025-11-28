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
         🔥 0) 실시간 HOT TOPIC 슬라이더
    ============================================================ --%>
    <c:if test="${not empty hotTopicList}">
        <section class="hot-topic-wrapper">

            <div class="hot-topic-title-row">
                <div>
                    <h2>실시간 HOT TOPIC 🔥</h2>
                    <p class="hot-topic-sub">지금 가장 뜨거운 커뮤니티 글을 만나보세요</p>
                </div>
            </div>

            <div class="hot-slider" id="hotSlider">

                <div class="hot-slides">
                    <c:forEach var="ht" items="${hotTopicList}" varStatus="s">

                        <%-- 🔥 작성자 프로필 썸네일 URL 생성 --%>
                        <c:choose>
                            <c:when test="${not empty ht.user_file}">
                                <c:set var="hotThumbUrl"
                                       value="${pageContext.request.contextPath}/resources/img/user_picture/${ht.user_file}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="hotThumbUrl"
                                       value="${pageContext.request.contextPath}/resources/img/common/default-profile.png" />
                            </c:otherwise>
                        </c:choose>

                        <div class="hot-slide"
                             data-index="${s.index}"
                             onclick="location.href='${pageContext.request.contextPath}/community/detail?post_id=${ht.post_id}'">

                            <div class="hot-avatar">
                                <img src="${hotThumbUrl}" alt="작성자 프로필">
                            </div>

                            <div class="hot-content">
                                <div class="hot-tag">
                                    <c:out value="${ht.category_name}" /> · 실시간 인기
                                </div>

                                <div class="hot-title">
                                    <c:out value="${ht.title}" />
                                </div>

                                <div class="hot-summary">
                                    <c:choose>
                                        <c:when test="${not empty ht.summary}">
                                            <c:out value="${ht.summary}" />
                                        </c:when>
                                        <c:otherwise>
                                            내용 미리보기 없음
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="hot-meta-row">
                                    <div class="hot-meta-left">
                                        <span><c:out value="${ht.user_name}" /></span>
                                        <span>
                                            <fmt:formatDate value="${ht.created_at}" pattern="yyyy-MM-dd HH:mm" />
                                        </span>
                                    </div>
                                    <div class="hot-meta-right">
                                        ❤️ <c:out value="${ht.like_count}" />
                                        · 💬 <c:out value="${ht.comment_count}" />
                                        · 👁 <c:out value="${ht.views}" />
                                    </div>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </div>

                <%-- 슬라이더 버튼 --%>
                <button type="button" class="hot-nav-btn hot-nav-prev" id="hotPrevBtn">‹</button>
                <button type="button" class="hot-nav-btn hot-nav-next" id="hotNextBtn">›</button>

                <%-- 인디케이터 --%>
                <div class="hot-dots" id="hotDots">
                    <c:forEach var="ht" items="${hotTopicList}" varStatus="s">
                        <div class="hot-dot ${s.index == 0 ? 'active' : ''}" data-index="${s.index}"></div>
                    </c:forEach>
                </div>
            </div>

        </section>
    </c:if>



    <%-- ===========================================================
         🔥 1) 전체 레이아웃 : 왼쪽 메인 피드 + 오른쪽 주간 인기글
    ============================================================ --%>
    <div class="community-layout">


        <%-- =======================================================
             🔵 왼쪽 : 대형 카드 메인 피드
        ======================================================== --%>
        <section class="community-left">

            <h1>커뮤니티</h1>

            <%-- 🔥 카테고리 CHIP --%>
            <div class="category-chips">

                <a href="${pageContext.request.contextPath}/community/list"
                   class="chip ${(empty cri.category_id and empty cri.category_main_num) ? 'active' : ''}">
                    전체
                </a>

                <a href="${pageContext.request.contextPath}/community/list?category_id=1"
                   class="chip ${cri.category_id == 1 ? 'active' : ''}">공지</a>
                <a href="${pageContext.request.contextPath}/community/list?category_id=2"
                   class="chip ${cri.category_id == 2 ? 'active' : ''}">잡담</a>
                <a href="${pageContext.request.contextPath}/community/list?category_id=3"
                   class="chip ${cri.category_id == 3 ? 'active' : ''}">Q&amp;A</a>
                <a href="${pageContext.request.contextPath}/community/list?category_id=4"
                   class="chip ${cri.category_id == 4 ? 'active' : ''}">후기</a>

                <c:forEach var="cm" items="${categoryMainList}">
                    <a href="${pageContext.request.contextPath}/community/list?category_main_num=${cm.category_main_num}"
                       class="chip ${cri.category_main_num == cm.category_main_num ? 'active' : ''}">
                        ${cm.category_main_name}
                    </a>
                </c:forEach>

            </div>


            <%-- 🔥 정렬 / 기간 / 검색 --%>
            <div class="filter-bar">

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
                    <button type="button" onclick="applyFilters()">🔍</button>
                </div>

            </div>


            <%-- 🔥 대형 카드 리스트 (한 줄 1개씩) --%>
            <div class="card-list">

                <c:forEach var="post" items="${communityList}">

                    <%-- 프로필 썸네일 URL 생성 --%>
                    <c:choose>
                        <c:when test="${not empty post.user_file}">
                            <c:set var="postThumbUrl"
                                   value="${pageContext.request.contextPath}/resources/img/user_picture/${post.user_file}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="postThumbUrl"
                                   value="${pageContext.request.contextPath}/resources/img/common/default-profile.png" />
                        </c:otherwise>
                    </c:choose>

                    <div class="post-card"
                         onclick="location.href='${pageContext.request.contextPath}/community/detail?post_id=${post.post_id}'">

                        <div class="post-header">

                            <div class="post-avatar">
                                <img src="${postThumbUrl}" alt="작성자 프로필">
                            </div>

                            <div class="post-header-info">
                                <div class="post-header-top">
                                    <span class="post-category-pill">${post.category_name}</span>
                                    <span class="post-writer">${post.user_name}</span>
                                </div>
                                <span class="post-date">
                                    <fmt:formatDate value="${post.created_at}" pattern="yyyy-MM-dd HH:mm" />
                                </span>
                            </div>

                        </div>

                        <div class="post-title">
                            <c:out value="${post.title}" />
                        </div>

                        <div class="post-summary">
                            <c:choose>
                                <c:when test="${not empty post.summary}">
                                    <c:out value="${post.summary}" />
                                </c:when>
                                <c:otherwise>
                                    내용 미리보기 없음
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="post-meta-row">
                            <div class="post-meta-left">
                                👁 <c:out value="${post.views}" />
                            </div>
                            <div class="post-meta-right">
                                ❤️ <c:out value="${post.like_count}" />
                                · 💬 <c:out value="${post.comment_count}" />
                            </div>
                        </div>

                    </div>
                </c:forEach>

                <c:if test="${empty communityList}">
                    <div class="no-data">등록된 게시글이 없습니다.</div>
                </c:if>

            </div>


            <%-- 🔥 페이징 --%>
            <div class="pagination">

                <c:if test="${pageMaker.prev}">
                    <a href="#" onclick="return movePage(${pageMaker.startPage - 1});">이전</a>
                </c:if>

                <c:forEach var="p" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <a href="#"
                       class="${p == cri.page ? 'active' : ''}"
                       onclick="return movePage(${p});">${p}</a>
                </c:forEach>

                <c:if test="${pageMaker.next}">
                    <a href="#" onclick="return movePage(${pageMaker.endPage + 1});">다음</a>
                </c:if>

            </div>

        </section>



        <%-- =======================================================
             🟠 오른쪽 : 주간 인기글 (popularList)
        ======================================================== --%>
        <aside class="community-right">

            <div class="popular-box">
                <h2>이번 주 인기글 🔥</h2>

                <div class="popular-list">

                    <c:forEach var="p" items="${popularList}">

                        <%-- 인기글 썸네일 URL 생성 --%>
                        <c:choose>
                            <c:when test="${not empty p.user_file}">
                                <c:set var="popularThumbUrl"
                                       value="${pageContext.request.contextPath}/resources/img/user_picture/${p.user_file}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="popularThumbUrl"
                                       value="${pageContext.request.contextPath}/resources/img/common/default-profile.png" />
                            </c:otherwise>
                        </c:choose>

                        <div class="popular-row"
                             onclick="location.href='${pageContext.request.contextPath}/community/detail?post_id=${p.post_id}'">

                            <div class="popular-thumb">
                                <img src="${popularThumbUrl}" alt="작성자 프로필">
                            </div>

                            <div class="popular-text">
                                <span class="p-title">${p.title}</span>

                                <div class="p-summary">
                                    <c:choose>
                                        <c:when test="${not empty p.summary}">
                                            <c:out value="${p.summary}" />
                                        </c:when>
                                        <c:otherwise>
                                            내용 미리보기 없음
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <span class="p-meta">
                                    ❤️ ${p.like_count}
                                    · 💬 ${p.comment_count}
                                    · <fmt:formatDate value="${p.created_at}" pattern="MM-dd" />
                                </span>
                            </div>

                        </div>
                    </c:forEach>

                    <c:if test="${empty popularList}">
                        <div class="no-data small">이번 주 인기글 데이터 없음</div>
                    </c:if>

                </div>

            </div>

        </aside>

    </div> <%-- /community-layout --%>

</main>



<%-- ===========================================================
     🔥 SCRIPT: 필터, 페이징, 슬라이더
=========================================================== --%>
<script>
/* =============================================
   🔥 필터 적용
============================================= */
function applyFilters() {
    var url = '${pageContext.request.contextPath}/community/list?';

    var categoryId  = "${cri.category_id}";
    var mainCat     = "${cri.category_main_num}";
    var sort        = document.getElementById('sortFilter').value;
    var period      = document.getElementById('periodFilter').value;
    var searchType  = document.getElementById('searchType').value;
    var keyword     = document.getElementById('searchKeyword').value;

    if (categoryId) url += 'category_id=' + categoryId + '&';
    if (mainCat)    url += 'category_main_num=' + mainCat + '&';
    if (sort)       url += 'sort=' + sort + '&';
    if (period)     url += 'period=' + period + '&';
    if (searchType) url += 'searchType=' + searchType + '&';
    if (keyword)    url += 'keyword=' + encodeURIComponent(keyword) + '&';

    url += 'page=1';

    location.href = url;
}


/* =============================================
   🔥 페이징 이동
============================================= */
function movePage(page) {
    var url = '${pageContext.request.contextPath}/community/list?';

    var categoryId  = "${cri.category_id}";
    var mainCat     = "${cri.category_main_num}";
    var sort        = "${cri.sort}";
    var period      = "${cri.period}";
    var searchType  = "${cri.searchType}";
    var keyword     = "${cri.keyword}";

    if (categoryId) url += 'category_id=' + categoryId + '&';
    if (mainCat)    url += 'category_main_num=' + mainCat + '&';
    if (sort)       url += 'sort=' + sort + '&';
    if (period)     url += 'period=' + period + '&';
    if (searchType) url += 'searchType=' + searchType + '&';
    if (keyword)    url += 'keyword=' + encodeURIComponent(keyword) + '&';

    url += 'page=' + page;

    location.href = url;
    return false;
}


/* =============================================
   🔥 실시간 HOT 슬라이더
   - JS 템플릿 리터럴 없이 문자열 연결로만 처리
============================================= */
(function() {
    var $wrap   = $('.hot-slides');
    var $slides = $('.hot-slide');
    var $dots   = $('.hot-dot');
    var count   = $slides.length;
    if (count === 0) return;

    var current = 0;
    var timer   = null;
    var INTERVAL = 5000;

    function go(i) {
        current = i;
        var offset = -100 * i;
        $wrap.css('transform', 'translateX(' + offset + '%)');
        $dots.removeClass('active').eq(i).addClass('active');
    }

    function next() { go((current + 1) % count); }
    function prev() { go((current - 1 + count) % count); }

    function start() {
        if (timer) clearInterval(timer);
        timer = setInterval(next, INTERVAL);
    }

    function stop() {
        if (timer) {
            clearInterval(timer);
            timer = null;
        }
    }

    $('#hotNextBtn').on('click', function(e){
        e.stopPropagation();
        next();
        start();
    });

    $('#hotPrevBtn').on('click', function(e){
        e.stopPropagation();
        prev();
        start();
    });

    $dots.on('click', function(e){
        e.stopPropagation();
        var idx = $(this).data('index');
        go(idx);
        start();
    });

    $('#hotSlider').on('mouseenter', stop)
                   .on('mouseleave', start);

    go(0);
    start();
})();

/* Enter 검색 */
$('#searchKeyword').on('keypress', function(e){
    if (e.key === 'Enter') {
        applyFilters();
    }
});
</script>

</body>
</html>
