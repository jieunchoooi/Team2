
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
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

	<jsp:include page="../include/header.jsp" />

	<main class="main-content">

		<%-- ===========================================================
	         ⚡ 전체 레이아웃 wrapper (왼쪽 + 오른쪽)
	    ============================================================ --%>
		<div class="community-layout">

			<%-- =======================================================
	             🔵 LEFT COLUMN (HOT + 게시글 피드)
	        ======================================================== --%>
			<div class="community-left">

				<%-- =====================================================
	                 🔥 HOT TOPIC
	            ====================================================== --%>
				<h2 class="hot-title-text">실시간 핫트렌드 🔥</h2>
				<div class="swiper hotSwiper">

					<div class="swiper-wrapper">

						<c:forEach var="ht" items="${hotTopicList}" varStatus="s">

							<div class="swiper-slide hot-slide"
								onclick="location.href='${pageContext.request.contextPath}/community/detail?post_id=${ht.post_id}'">

								<div class="hot-avatar">
									<img
										src="${not empty ht.user_file 
	                        ? pageContext.request.contextPath += '/resources/img/user_picture/' += ht.user_file 
	                        : pageContext.request.contextPath += '/resources/img/common/default-profile.png'}" />
								</div>

								<div class="hot-content">
									<div class="hot-tag">${ht.category_name}·실시간인기</div>
									<div class="hot-title">${ht.title}</div>
									<div class="hot-summary">${ht.summary != null ? ht.summary : '내용 미리보기 없음'}</div>

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
				<h1>커뮤니티</h1>

				<%-- 🔵 카테고리 CHIP --%>
				<%-- 🔵 카테고리 CHIP (말머리 + 메인 카테고리 2줄 분리) --%>
				<div class="category-chips">

					<%-- 1️⃣ 말머리 (공지 / 잡담 / Q&A / 후기) --%>
					<div class="chip-row">

						<%-- 전체 (말머리 + 메인카테고리 모두 해제) --%>
						<a
							href="${pageContext.request.contextPath}/community/list?category_id=&category_main_num=&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
							class="chip ${(empty cri.category_id and empty cri.category_main_num) ? 'active' : ''}">
							전체 </a>

						<%-- 공지 --%>
						<a
							href="${pageContext.request.contextPath}/community/list?category_id=1&category_main_num=${cri.category_main_num}&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
							class="chip ${cri.category_id == 1 ? 'active' : ''}"> 공지 </a>

						<%-- 잡담 --%>
						<a
							href="${pageContext.request.contextPath}/community/list?category_id=2&category_main_num=${cri.category_main_num}&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
							class="chip ${cri.category_id == 2 ? 'active' : ''}"> 잡담 </a>

						<%-- Q&A --%>
						<a
							href="${pageContext.request.contextPath}/community/list?category_id=3&category_main_num=${cri.category_main_num}&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
							class="chip ${cri.category_id == 3 ? 'active' : ''}"> Q&A </a>

						<%-- 후기 --%>
						<a
							href="${pageContext.request.contextPath}/community/list?category_id=4&category_main_num=${cri.category_main_num}&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
							class="chip ${cri.category_id == 4 ? 'active' : ''}"> 후기 </a>

					</div>

					<%-- 2️⃣ 메인 카테고리 (예체능 / IT / 외국어 ... ) --%>
					<div class="chip-row">
						<c:forEach var="cm" items="${categoryMainList}">
							<a
								href="${pageContext.request.contextPath}/community/list?category_main_num=${cm.category_main_num}&category_id=${cri.category_id}&sort=${cri.sort}&period=${cri.period}&searchType=${cri.searchType}&keyword=${cri.keyword}"
								class="chip ${cri.category_main_num == cm.category_main_num ? 'active' : ''}">
								${cm.category_main_name} </a>
						</c:forEach>
					</div>

				</div>



				<%-- 🔵 정렬 / 기간 / 검색 필터 --%>
				<div class="filter-bar">

					<select id="sortFilter" onchange="applyFilters()">
						<option value="latest" ${cri.sort == 'latest'   ? 'selected' : ''}>▾최신순</option>
						<option value="views" ${cri.sort == 'views'    ? 'selected' : ''}>▾조회수</option>
						<option value="likes" ${cri.sort == 'likes'    ? 'selected' : ''}>▾좋아요</option>
						<option value="comments"
							${cri.sort == 'comments' ? 'selected' : ''}>댓글</option>
					</select> <select id="periodFilter" onchange="applyFilters()">
						<option value="all" ${cri.period == 'all'   ? 'selected' : ''}>▾전체</option>
						<option value="today" ${cri.period == 'today' ? 'selected' : ''}>▾오늘</option>
						<option value="week" ${cri.period == 'week'  ? 'selected' : ''}>▾1주일</option>
						<option value="month" ${cri.period == 'month' ? 'selected' : ''}>▾1개월</option>
					</select>

					<div class="search-box">
						<select id="searchType">
							<option value="title"
								${cri.searchType == 'title' ? 'selected' : ''}>▾제목</option>
							<option value="titleContent"
								${cri.searchType == 'titleContent' ? 'selected' : ''}>▾제목+내용</option>
							<option value="writer"
								${cri.searchType == 'writer' ? 'selected' : ''}>▾작성자</option>
							<option value="comment"
								${cri.searchType == 'comment' ? 'selected' : ''}>▾댓글</option>
						</select> <input type="text" id="searchKeyword" value="${cri.keyword}"
							placeholder="검색어 입력">
						<button type="button" onclick="applyFilters()">🔍</button>
					</div>

				</div>


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


		</div>
		<%-- community-layout END --%>

	</main>
	<aside class="community-right">

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
