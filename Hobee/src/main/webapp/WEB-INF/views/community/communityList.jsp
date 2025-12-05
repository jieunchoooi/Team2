
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>커뮤니티 | Hobee</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/community/communityList.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/community/communityWriteModal.css">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/communityWriteModal.js"></script>

</head>

<body>

	<jsp:include page="../include/header.jsp" />
	<jsp:include page="../include/communityWriteModal.jsp" />
	<main class="main-content">

		<%-- ===========================================================
	         ⚡ 전체 레이아웃 wrapper (왼쪽 + 오른쪽)
	    ============================================================ --%>
		<div class="detail-layout">

			<%-- =======================================================
	             🔵 LEFT COLUMN (HOT + 게시글 피드)
	        ======================================================== --%>
			<div class="detail-left">

				<%-- =====================================================
     🔥 HOT TOPIC (LIST PAGE VERSION - FIXED)
====================================================== --%>

				<h2 class="hot-title-text">🔥실시간 핫트렌드</h2>

				<div class="swiper hotSwiper">
					<div class="swiper-wrapper">

						<c:choose>

							<%-- 1) 데이터가 있을 때 --%>
							<c:when test="${not empty hotTopicList}">
								<c:forEach var="ht" items="${hotTopicList}">
									<div class="swiper-slide hot-slide"
										onclick="location.href='${pageContext.request.contextPath}/community/detail?post_id=${ht.post_id}'">

										<div class="hot-avatar">
											<img
												src="<c:choose>
                                         <c:when test='${not empty ht.user_file}'>
                                             ${pageContext.request.contextPath}/resources/img/user_picture/${ht.user_file}
                                         </c:when>
                                         <c:otherwise>
                                             ${pageContext.request.contextPath}/resources/img/common/default-profile.png
                                         </c:otherwise>
                                      </c:choose>" />
										</div>

										<div class="hot-content">
											<div class="hot-tag">${ht.category_name}·실시간인기</div>
											<div class="hot-title">${ht.title}</div>
											<div class="hot-summary">
												<c:choose>
													<c:when test="${not empty ht.summary}">
                                        ${ht.summary}
                                    </c:when>
													<c:otherwise>내용 미리보기 없음</c:otherwise>
												</c:choose>
											</div>

											<div class="hot-meta-row">
												<div>
													${ht.user_name} ·
													<fmt:formatDate value="${ht.created_at}"
														pattern="yyyy-MM-dd HH:mm" />
												</div>
												<div>❤️ ${ht.like_count} · 💬 ${ht.comment_count} · 👁
													${ht.views}</div>
											</div>
										</div>

									</div>
								</c:forEach>
							</c:when>


							<%-- 2) 데이터가 없을 때 (fallback 슬라이더 3개 자동 생성) --%>
							<c:otherwise>

								<%-- 카드 1 --%>
								<div class="swiper-slide hot-slide">

									<div class="hot-content">
										<div class="hot-tag">Hobee 커뮤니티</div>
										<div class="hot-title">🔥 핫트렌드를 만들어가세요!</div>
										<div class="hot-summary">여러분의 첫 글이 실시간 핫트렌드의 시작입니다.</div>
										<div class="hot-meta-row">
											<div>안내 · 지금</div>
										</div>
									</div>
								</div>

								<%-- 카드 2 --%>
								<div class="swiper-slide hot-slide">


									<div class="hot-content">
										<div class="hot-tag">Hobee 커뮤니티</div>
										<div class="hot-title">✍️ 첫 게시글을 작성해보세요</div>
										<div class="hot-summary">24시간 인기글이 자동으로 업데이트됩니다.</div>
										<div class="hot-meta-row">
											<div>안내 · 지금</div>

										</div>
									</div>
								</div>

								<%-- 카드 3 --%>
								<div class="swiper-slide hot-slide">


									<div class="hot-content">
										<div class="hot-tag">Hobee 커뮤니티</div>
										<div class="hot-title">🌟 오늘의 첫 주인공이 되어보세요!</div>
										<div class="hot-summary">지금 작성된 글이 실시간 트렌드를 채웁니다.</div>
										<div class="hot-meta-row">
											<div>안내 · 지금</div>

										</div>
									</div>
								</div>

							</c:otherwise>

						</c:choose>

					</div>

					<!-- arrows -->
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>

					<!-- dots -->
					<div class="swiper-pagination"></div>

				</div>





				<%-- =====================================================
	                 🔵 커뮤니티 메인 피드
	            ====================================================== --%>
<!-- ==========================
     📌 커뮤니티 헤더
=========================== -->
<section class="community-top-card">
   <!-- 🔵 헤더 -->
    <div class="community-header-row">
        <span class="ch-emoji">💬</span>
        <span class="ch-title">커뮤니티</span>
        <span class="ch-sub">🫧다양한 주제로 자유롭게 소통해보세요!🫧</span>
    </div>
<!-- ================================
     📌 필터 박스 전체
================================ -->
<div class="filter-box">

    <!-- 🔵 말머리 -->
    <div class="chip-label">말머리</div>
    <div class="chip-row no-wrap-row">

		<c:forEach var="cl" items="${categoryList}">
        <a href="${pageContext.request.contextPath}/community/list?category_id=${cl.category_id}&category_main_num=${cri.category_main_num}&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
           class="chip ${cri.category_id == cl.category_id ? 'active' : ''}">
             ${cl.category_name}
        </a>
		</c:forEach>
    </div>


    <!-- 🔵 카테고리 -->
    <div class="chip-label">카테고리</div>
    <div class="chip-row wrap-row">

        <c:forEach var="cm" items="${categoryMainList}">
            <a href="${pageContext.request.contextPath}/community/list?category_main_num=${cm.category_main_num}&category_id=${cri.category_id}&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
               class="chip ${cri.category_main_num == cm.category_main_num ? 'active' : ''}">
                ${cm.category_main_name}
            </a>
        </c:forEach>

    </div>

</div>




				<%-- 🔵 정렬 + 기간 + 검색타입 (왼쪽 그룹) / 검색창 + 글쓰기 (오른쪽 그룹) --%>
				<div class="filter-bar">

					<%-- 🔹 왼쪽 필터 그룹 --%>
					<div class="filter-left">
						<select id="sortFilter" onchange="applyFilters()">
							<option value="latest"
								${cri.sort == 'latest'   ? 'selected' : ''}>최신순</option>
							<option value="views" ${cri.sort == 'views'    ? 'selected' : ''}>조회수</option>
							<option value="likes" ${cri.sort == 'likes'    ? 'selected' : ''}>좋아요</option>
							<option value="comments"
								${cri.sort == 'comments' ? 'selected' : ''}>댓글 수</option>
						</select> <select id="periodFilter" onchange="applyFilters()">
							<option value="all" ${cri.period == 'all'   ? 'selected' : ''}>전체</option>
							<option value="today" ${cri.period == 'today' ? 'selected' : ''}>오늘</option>
							<option value="week" ${cri.period == 'week'  ? 'selected' : ''}>1주일</option>
							<option value="month" ${cri.period == 'month' ? 'selected' : ''}>1개월</option>
						</select> <select id="searchType">
							<option value="title"
								${cri.searchType == 'title'        ? 'selected' : ''}>제목</option>
							<option value="titleContent"
								${cri.searchType == 'titleContent' ? 'selected' : ''}>제목+내용</option>
							<option value="writer"
								${cri.searchType == 'writer'       ? 'selected' : ''}>작성자</option>
							<option value="comment"
								${cri.searchType == 'comment'      ? 'selected' : ''}>댓글</option>
						</select>
					</div>

					<%-- 🔹 오른쪽 검색창 + 글쓰기 버튼 그룹 --%>
					<div class="filter-right">

						<div class="filter-search">
							<input type="text" id="searchKeyword" value="${cri.keyword}"
								placeholder="검색어 입력">

							<button type="button" class="search-btn" onclick="applyFilters()">🔍</button>
						</div>

						<button type="button" class="write-btn"
							onclick="openWriteModal();">✏️ 글쓰기</button>

					</div>

				</div>

</section>


				<%-- 🔵 게시글 카드 리스트 --%>
				<div class="card-list">

					<c:forEach var="post" items="${communityList}">

						<%-- 썸네일 처리 --%>
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

										<%-- 말머리(pill) --%>
										<c:if test="${not empty post.category_name}">
											<span class="post-category-pill">${post.category_name}</span>
										</c:if>

										<%-- 메인 카테고리 (가운데 점으로 구분) --%>
										<c:if test="${not empty post.category_main_name}">
											<span class="post-maincategory">·
												${post.category_main_name}</span>
										</c:if>

										<%-- 작성자 --%>
										<span class="post-writer">·👤 ${post.user_name}</span>
									</div>
									<span class="post-date"> <fmt:formatDate
											value="${post.created_at}" pattern="yyyy-MM-dd HH:mm" />
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
									👁
									<c:out value="${post.views}" />
								</div>
								<div class="post-meta-right">
									❤️
									<c:out value="${post.like_count}" />
									· 💬
									<c:out value="${post.comment_count}" />
								</div>
							</div>

						</div>
					</c:forEach>

					<c:if test="${empty communityList}">
						<div class="no-data">등록된 게시글이 없습니다.</div>
					</c:if>

				</div>


				<%-- 🔵 페이징 --%>
				<div class="pagination">

					<c:if test="${pageMaker.prev}">
						<a href="#" onclick="return movePage(${pageMaker.startPage - 1});">이전</a>
					</c:if>

					<c:forEach var="p" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<a href="#" class="${p == cri.page ? 'active' : ''}"
							onclick="return movePage(${p});">${p}</a>
					</c:forEach>

					<c:if test="${pageMaker.next}">
						<a href="#" onclick="return movePage(${pageMaker.endPage + 1});">다음</a>
					</c:if>

				</div>

			</div>
			<%-- LEFT END --%>

			<%-- =======================================================
	             🟠 RIGHT COLUMN (주간 인기글)
	        ======================================================== --%>

			<aside class="detail-right">

				<div class="popular-box">

					<h2>이번 주 인기글 🔥</h2>

					<div class="popular-list">

						<c:forEach var="p" items="${popularList}">

							<%-- 인기글 썸네일 --%>
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

									<span class="p-meta"> ❤️ ${p.like_count} · 💬
										${p.comment_count} · <fmt:formatDate value="${p.created_at}"
											pattern="MM-dd" />
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




		</div>
		<%-- community-layout END --%>

	</main>

<jsp:include page="../include/footer.jsp"></jsp:include>

	<%-- ===========================================================
	     🔥 SCRIPT (슬라이더 / 필터 / 페이징)
	=========================================================== --%>
	<script>
	/* 🔥 필터 적용 */
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
	
	/* 🔥 페이징 이동 */
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
	
	
	
	
	/* 🔥 Enter 검색 */
	$('#searchKeyword').on('keypress', function(e){
	    if (e.key === 'Enter') {
	        applyFilters();
	    }
	});
	
	
	var hotSwiper = new Swiper('.hotSwiper', {
		 autoHeight: false,  // 자동높이 제거
	    loop: true,
	    slidesPerView: 1,
	    spaceBetween: 24,
	    autoplay: {
	        delay: 6000,
	        disableOnInteraction: false,
	    },
	    navigation: {
	        nextEl: '.swiper-button-next',
	        prevEl: '.swiper-button-prev',
	    },
	    pagination: {
	        el: '.swiper-pagination',
	        clickable: true,
	    },
	});
	
 
	
	
	
	
	
	</script>

</body>
</html>
