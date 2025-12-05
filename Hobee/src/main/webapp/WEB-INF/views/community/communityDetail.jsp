<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${dto.post.title}|Hobee커뮤니티</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/community/communityDetail.css" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/include/communityEditModal.css">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

	<jsp:include page="../include/header.jsp" />
	<jsp:include page="../include/communityEditModal.jsp" />

	<main class="detail-page-main">

		<!-- ===============================
         🔥 DETAIL 전체 레이아웃
         =============================== -->
		<div class="detail-layout">

			<!-- =======================
             LEFT: MAIN
             ======================= -->
			<div class="detail-left">

						<%-- =====================================================
     🔥 HOT TOPIC (LIST PAGE VERSION - FIXED)
====================================================== --%>

				<h2 class="hot-title-text" style="font-size: 1.4rem;
	font-weight: 700;
	color: #1f2d5c;
	margin-bottom: 16px;
	padding-left: 4px;">🔥실시간 핫트렌드</h2>

				<div class="swiper hotSwiper">
					<div class="swiper-wrapper">

						<c:choose>

							<%-- 1) 데이터가 있을 때 --%>
							<c:when test="${not empty hotTopicList}">
								<c:forEach var="ht" items="${hotTopicList}">
									<div class="swiper-slide hot-slide"
										onclick="location.href='${pageContext.request.contextPath}/community/detail?post_id=${ht.post_id}'">
										
										
										<div class="hot-top-wrap">
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
										
										<div class="hot-top">
											<div class="hot-tag">${ht.category_name}·실시간인기</div>
											<div class="hot-title">${ht.title}</div>
										</div>
										
										</div>
										
										
										<div class="hot-content">
											
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


				<!-- ===========================================
                 🔥 POST DETAIL CARD
            ============================================ -->
				<section class="detail-card">

					<!-- 제목 -->
					<h1 class="detail-title">
						<c:out value="${dto.post.title}" />
					</h1>

					<!-- 작성자 영역 -->
					<div class="detail-writer-box">

						<div class="detail-avatar">
							<img
								src="<c:choose>
                                     <c:when test='${not empty dto.post.user_file}'>
                                         ${pageContext.request.contextPath}/resources/img/user_picture/${dto.post.user_file}
                                     </c:when>
                                     <c:otherwise>
                                         ${pageContext.request.contextPath}/resources/img/common/default-profile.png
                                     </c:otherwise>
                                 </c:choose>" />
						</div>

						<div class="detail-writer-info">
							<span class="writer-name">${dto.post.user_name}</span> <span
								class="writer-date"> <fmt:formatDate
									value="${dto.post.created_at}" pattern="yyyy-MM-dd HH:mm" />
							</span>
						</div>

						<div class="detail-meta">
							👁 ${dto.post.views} &nbsp;&nbsp;|&nbsp;&nbsp; ❤️ <span
								id="topLikeCount">${dto.post.like_count}</span>
							&nbsp;&nbsp;|&nbsp;&nbsp; 💬 ${dto.post.comment_count}
						</div>

					</div>

					<!-- 내 글이면 수정/삭제 -->
					<c:if
						test="${not empty sessionScope.userVO
                            and sessionScope.userVO.user_num == dto.post.user_num}">
						<div class="post-action-box">
							<button type="button" class="post-action-btn"
								onclick="openEditModal(${dto.post.post_id})">수정</button>

							<button type="button" class="post-action-btn delete"
								onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/community/delete?post_id=${dto.post.post_id}'">
								삭제</button>
						</div>
					</c:if>

					<!-- 본문 -->
					<div class="detail-content">${dto.post.content}</div>

					<!-- 좋아요 버튼 -->
					<div class="detail-like-box">
						<button type="button" id="likeBtn"
							class="like-btn ${dto.post.user_reaction == 1 ? 'active' : ''}"
							data-post="${dto.post.post_id}"
							data-liked="${dto.post.user_reaction == 1 ? 'true' : 'false'}">

							<span class="like-count">${dto.post.like_count}</span> <span
								class="like-icon">❤️</span>
						</button>
						
						<div class="report">
<!-- 						신고하기  ajax로 실시간 내가 이미 신고했으면 버튼 비활성  -->
							
						</div>
					</div>

				</section>

				<!-- 🔵 목록으로 -->
				<div class="back-list-box">
					<a href="${pageContext.request.contextPath}/community/list"
						class="back-list-btn"> ← 목록으로 </a>
				</div>
				<!-- ===========================================
                 🔥 댓글 섹션
            ============================================ -->
				<section class="detail-comment-section">

					<h2 class="section-title">댓글 (${dto.post.comment_count})</h2>

					<!-- 댓글 입력창 -->
					<div class="comment-input-box">
						<textarea id="commentInput" placeholder="댓글을 입력하세요"></textarea>
						<button type="button" id="commentSubmit">등록</button>
					</div>


					<%-- ===========================================
     🔥 댓글 + 대댓글 출력
=========================================== --%>
					<div id="commentContainer" class="comment-list">

						<c:forEach var="cmt" items="${dto.comments}">
							<%-- ⭐ 최상위 댓글만 출력 (parent_id = null) --%>
							<c:if test="${cmt.parent_id == null}">

								<%-- 🟦 댓글 카드 --%>
								<div class="comment-item" data-comment="${cmt.comment_id}">

									<div class="comment-avatar">
										<img
											src="<c:choose>
                                 <c:when test='${not empty cmt.user_file}'>
                                     ${pageContext.request.contextPath}/resources/img/user_picture/${cmt.user_file}
                                 </c:when>
                                 <c:otherwise>
                                     ${pageContext.request.contextPath}/resources/img/common/default-profile.png
                                 </c:otherwise>
                             </c:choose>" />
									</div>

									<div class="comment-body">

										<div class="comment-header">
											<span class="comment-writer">${cmt.user_name}</span> <span
												class="comment-date"> <fmt:formatDate
													value="${cmt.created_at}" pattern="yyyy-MM-dd HH:mm" />
											</span>
										</div>

										<div class="comment-content">
											<c:out value="${cmt.content}" />
										</div>

										<%-- 본인 댓글이면 수정/삭제 버튼 --%>
										<c:if
											test="${not empty sessionScope.userVO
                                and sessionScope.userVO.user_num == cmt.user_num}">
											<div class="comment-actions-inline">
												<button type="button" class="comment-edit-btn"
													data-id="${cmt.comment_id}">수정</button>
												<button type="button" class="comment-delete-btn"
													data-id="${cmt.comment_id}">삭제</button>
											</div>
										</c:if>

										<%-- 수정 영역 --%>
										<div class="comment-edit-box" id="edit-box-${cmt.comment_id}"
											style="display: none;">
											<textarea class="edit-text">${cmt.content}</textarea>
											<button type="button" class="edit-submit"
												data-id="${cmt.comment_id}">저장</button>
										</div>

										<%-- 좋아요 / 대댓글 버튼 --%>
										<div class="comment-actions">
											<button type="button"
												class="comment-like-btn ${cmt.user_reaction == 1 ? 'active' : ''}"
												data-comment="${cmt.comment_id}"
												data-liked="${cmt.user_reaction == 1 ? 'true' : 'false'}">
												👍 <span class="cmt-like-count">${cmt.like_count}</span>
											</button>

											<button type="button" class="reply-btn"
												data-comment="${cmt.comment_id}">↩ 대댓글</button>
												
													<div class="report-comment">
<!-- 						신고하기  ajax로 실시간 내가 이미 신고했으면 버튼 비활성  -->
							
						</div>
										</div>

										<%-- 대댓글 입력창 (이 댓글에 대한 입력) --%>
										<div class="reply-input-box" id="reply-box-${cmt.comment_id}"
											style="display: none;">
											<textarea class="reply-text" placeholder="대댓글을 입력하세요"></textarea>
											<button type="button" class="reply-submit"
												data-parent="${cmt.comment_id}">등록</button>
										</div>

										<%-- ==========================
                         🟨 이 댓글의 대댓글 목록
                         ========================== --%>
										<c:forEach var="rep" items="${dto.comments}">
											<c:if test="${rep.parent_id == cmt.comment_id}">

												<div class="comment-item reply-item"
													data-comment="${rep.comment_id}">

													<div class="comment-avatar reply-avatar">
														<img
															src="<c:choose>
                                                 <c:when test='${not empty rep.user_file}'>
                                                     ${pageContext.request.contextPath}/resources/img/user_picture/${rep.user_file}
                                                 </c:when>
                                                 <c:otherwise>
                                                     ${pageContext.request.contextPath}/resources/img/common/default-profile.png
                                                 </c:otherwise>
                                             </c:choose>" />
													</div>

													<div class="comment-body reply-body">

														<div class="comment-header reply-header">
															<span class="comment-writer reply-writer">${rep.user_name}</span>
															<span class="comment-date reply-date"> <fmt:formatDate
																	value="${rep.created_at}" pattern="yyyy-MM-dd HH:mm" />
															</span>
														</div>

														<div class="comment-content reply-content">
															<c:out value="${rep.content}" />
														</div>

														<div class="comment-actions reply-actions">
															<button type="button"
																class="comment-like-btn ${rep.user_reaction == 1 ? 'active' : ''}"
																data-comment="${rep.comment_id}"
																data-liked="${rep.user_reaction == 1 ? 'true' : 'false'}">
																👍 <span class="cmt-like-count">${rep.like_count}</span>
															</button>
															
															<c:if
																test="${not empty sessionScope.userVO
                                                    and sessionScope.userVO.user_num == rep.user_num}">
																<button type="button" class="comment-delete-btn"
																	data-id="${rep.comment_id}">삭제</button>
															</c:if>
																	
															<div class="report-comment">
<!-- 						신고하기  ajax로 실시간 내가 이미 신고했으면 버튼 비활성  -->
							
																	</div>	
														</div>

													</div>
												</div>

											</c:if>
										</c:forEach>

									</div>
									<%-- /comment-body --%>
								</div>
								<%-- /comment-item (최상위) --%>

							</c:if>
						</c:forEach>

						<c:if test="${empty dto.comments}">
							<div class="no-data small">아직 등록된 댓글이 없습니다. 첫 댓글을 남겨보세요!</div>
						</c:if>

					</div>



				</section>

				<!-- ===========================================
                 🔥 주변 글 목록 (prev3 + current + next3)
            ============================================ -->
				<section class="related-post-section">
					<h2 class="section-title">비슷한 게시글</h2>

					<c:if
						test="${empty dto.prev3 and empty dto.current and empty dto.next3}">
						<div class="no-data small">주변 게시글 데이터가 없습니다.</div>
					</c:if>

					<c:if
						test="${not empty dto.prev3 or not empty dto.current or not empty dto.next3}">
						<div class="related-post-list">

							<!-- 🔹 이전글 3개 -->
							<c:forEach var="p" items="${dto.prev3}">
								<a class="related-post-card"
									href="${pageContext.request.contextPath}/community/detail?post_id=${p.post_id}">
									<div class="rpc-title">
										<c:out value="${p.title}" />
									</div>

									<div class="rpc-meta">
										<span class="rpc-writer">${p.user_name}</span> <span
											class="rpc-dot">·</span> <span class="rpc-date"><fmt:formatDate
												value="${p.created_at}" pattern="MM-dd" /></span> <span
											class="rpc-dot">·</span> <span class="rpc-stats">❤️
											${p.like_count} · 👁 ${p.views}</span>
									</div>
								</a>
							</c:forEach>

							<!-- 🔹 현재글 (가운데 강조) -->
							<c:if test="${not empty dto.current}">
								<a class="related-post-card current"
									href="${pageContext.request.contextPath}/community/detail?post_id=${dto.current.post_id}">
									<div class="rpc-title">
										<c:out value="${dto.current.title}" />
									</div>

									<div class="rpc-meta">
										<span class="rpc-writer">${dto.current.user_name}</span> <span
											class="rpc-dot">·</span> <span class="rpc-date"><fmt:formatDate
												value="${dto.current.created_at}" pattern="MM-dd" /></span> <span
											class="rpc-dot">·</span> <span class="rpc-stats">❤️
											${dto.current.like_count} · 👁 ${dto.current.views}</span>
									</div>
								</a>
							</c:if>

							<!-- 🔹 다음글 3개 -->
							<c:forEach var="p" items="${dto.next3}">
								<a class="related-post-card"
									href="${pageContext.request.contextPath}/community/detail?post_id=${p.post_id}">
									<div class="rpc-title">
										<c:out value="${p.title}" />
									</div>

									<div class="rpc-meta">
										<span class="rpc-writer">${p.user_name}</span> <span
											class="rpc-dot">·</span> <span class="rpc-date"><fmt:formatDate
												value="${p.created_at}" pattern="MM-dd" /></span> <span
											class="rpc-dot">·</span> <span class="rpc-stats">❤️
											${p.like_count} · 👁 ${p.views}</span>
									</div>
								</a>
							</c:forEach>

						</div>
					</c:if>

				</section>

			</div>
			<!-- // detail-left -->


			<!-- ================================
             RIGHT: WEEKLY POPULAR
        ================================= -->
			<aside class="detail-right">

				<div class="popular-box">

					<h2>이번 주 인기글 🔥</h2>

					<div class="popular-list">

						<c:forEach var="p" items="${popularList}">

							<!-- 썸네일 URL -->
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

									<span class="p-title"> <c:out value="${p.title}" />
									</span>

									<div class="p-summary">
										<c:choose>
											<c:when test="${not empty p.summary}">
												<c:out value="${p.summary}" />
											</c:when>
											<c:otherwise>내용 미리보기 없음</c:otherwise>
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
							<div class="no-data small">이번 주 인기글 데이터가 없습니다.</div>
						</c:if>

					</div>

				</div>

			</aside>

		</div>
		<!-- // detail-layout -->

	</main>

<jsp:include page="../include/footer.jsp"></jsp:include>

	<!-- ================================
     ❤️ 댓글 / 좋아요 / 대댓글 JS
================================ -->
	<script>

	/* ==================================
	   ❤️ 게시글 좋아요 (토글)
	================================== */
	$("#likeBtn").on("click", function () {

	    const postId = $(this).data("post");
	    let currentLiked = ($(this).data("liked") === true || $(this).data("liked") === "true");

	    $.post("${pageContext.request.contextPath}/community/post/like", {
	        postId: postId,
	        currentLiked: currentLiked
	    }, function (res) {

	        if (!res.success) {
	            if (res.needLogin) {
	                alert("로그인이 필요합니다!");
	                return;
	            }
	            alert("오류가 발생했습니다.");
	            return;
	        }

	        const newLiked = res.liked;
	        const btn = $("#likeBtn");

	        // 버튼 스타일 반영
	        if (newLiked) btn.addClass("active");
	        else btn.removeClass("active");

	        // 좋아요 개수 반영
	        let count = parseInt(btn.find(".like-count").text());
	        if (!currentLiked && newLiked) count++;   // 좋아요 추가
	        if (currentLiked && !newLiked) count--;   // 좋아요 취소

	        btn.find(".like-count").text(count);
	        $("#topLikeCount").text(count);

	        // 🔥 중요: 현재 좋아요 상태 갱신하기
	        btn.data("liked", newLiked);

	    });
	});



    /* ==================================
       💬 댓글 등록
       ================================== */
    $("#commentSubmit").on("click", function() {
        const text = $("#commentInput").val().trim();
        const postId = ${dto.post.post_id};

        if (text === "") {
            alert("댓글 내용을 입력하세요!");
            return;
        }

        $.post("${pageContext.request.contextPath}/community/comment/add", {
            post_id: postId,
            content: text
        }, function(res) {
            if (res.success) location.reload();
            else if (res.needLogin) alert("로그인이 필요합니다!");
        });
    });


    /* ==================================
       ✏ 댓글 수정
       ================================== */
    $(document).on("click", ".comment-edit-btn", function() {
        const id = $(this).data("id");
        $("#edit-box-" + id).toggle();
    });

    $(document).on("click", ".edit-submit", function() {
        const id = $(this).data("id");
        const text = $("#edit-box-" + id + " .edit-text").val().trim();

        if (text === "") {
            alert("내용을 입력하세요.");
            return;
        }

        $.post("${pageContext.request.contextPath}/community/comment/update", {
            comment_id: id,
            content: text
        }, function(res) {
            if (res.success) location.reload();
        });
    });


    /* ==================================
       ❌ 댓글 삭제
       ================================== */
    $(document).on("click", ".comment-delete-btn", function() {
        const id = $(this).data("id");

        if (!confirm("댓글을 삭제하시겠습니까?")) return;

        $.post("${pageContext.request.contextPath}/community/comment/delete", {
            comment_id: id
        }, function(res) {
            if (res.success) location.reload();
        });
    });


    /* ==================================
    👍 댓글 좋아요 (토글)
 ================================== */
 $(document).on("click", ".comment-like-btn", function() {

     const btn = $(this);
     const commentId = btn.data("comment");
     // 🔥 문자열/불린 둘 다 대응
     let currentLiked = (btn.data("liked") === true || btn.data("liked") === "true");

     $.post("${pageContext.request.contextPath}/community/comment/like", {
         commentId: commentId,
         currentLiked: currentLiked
     }, function(res) {

         if (!res.success) {
             if (res.needLogin) {
                 alert("로그인이 필요합니다!");
                 return;
             }
             alert("오류가 발생했습니다.");
             return;
         }

         const newLiked = res.liked;  // 서버가 돌려준 최종 상태 (true = 좋아요, false = 취소)

         // 버튼 스타일 토글
         if (newLiked) btn.addClass("active");
         else          btn.removeClass("active");

         // 좋아요 수 계산
         let count = parseInt(btn.find(".cmt-like-count").text(), 10) || 0;
         if (!currentLiked && newLiked) count++;   // 안 눌린 상태 → 좋아요
         if (currentLiked && !newLiked) count--;   // 눌린 상태 → 취소

         btn.find(".cmt-like-count").text(count);

         // 🔥 현재 상태 갱신 (다음 클릭 때 기준이 됨)
         btn.data("liked", newLiked);
     });
 });



    /* ==================================
       ↩ 대댓글 입력창 토글
       ================================== */
    $(document).on("click", ".reply-btn", function() {
        const id = $(this).data("comment");
        $("#reply-box-" + id).toggle();
    });


    /* ==================================
   			 ↩ 대댓글 등록
	================================== */
$(document).on("click", ".reply-submit", function() {

 const parent = $(this).data("parent");
 const text = $("#reply-box-" + parent + " .reply-text").val().trim();
 const postId = ${dto.post.post_id};

 if (text === "") {
     alert("대댓글 내용을 입력하세요");
     return;
 }

 $.post("${pageContext.request.contextPath}/community/comment/add", {
     post_id: postId,
     parent_id: parent,   // ⭐ 대댓글 구분 포인트
     content: text
 }, function(res) {
     if (res.success) location.reload();
 });
});



    /* ==================================
       🔥 HOT TOPIC 슬라이더 Swiper
       ================================== */
    var hotSwiper = new Swiper('.hotSwiper', {
    	autoHeight: false,
        loop: true,
        slidesPerView: 1,
        spaceBetween: 24,
        autoplay: {
            delay: 6000,
            disableOnInteraction: false
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev'
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true
        }
    });
    
    function openEditModal(postId) {

        const ctx = "${pageContext.request.contextPath}";
        const userRole = "${sessionScope.userVO.user_role}"; // 🔥 관리자 확인용

        $("#editModal").fadeIn(150);

        $.ajax({
            url: ctx + "/community/edit",
            type: "GET",
            data: { post_id: postId },
            success: function(res) {

                $("#editPostId").val(res.post.post_id);
                $("#editTitle").val(res.post.title);
                $("#editContent").val(res.post.content);

                // ============ 카테고리 (말머리) ============
                let $catSel = $("#editCategoryId");
                $catSel.empty();
                $catSel.append(`<option value="">말머리</option>`);

                $.each(res.categoryList, function (i, c) {

                    // 🔥 공지(category_id = 1)는 관리자만 허용
                    if (c.category_id == 1) {
                        if (!(userRole === "admin" || userRole === "super_admin")) {
                            return; // 일반 user / instructor는 공지 옵션 제외
                        }
                    }

                    let $opt = $("<option>")
                        .val(c.category_id)
                        .text(c.category_name);

                    if (String(c.category_id) === String(res.post.category_id)) {
                        $opt.prop("selected", true);
                    }

                    $catSel.append($opt);
                });

                // ============ 메인카테고리 =============
                let $mainSel = $("#editCategoryMainNum");
                $mainSel.empty();
                $mainSel.append(`<option value="">메인 카테고리</option>`);

                $.each(res.mainCategoryList, function (i, m) {
                    let $opt = $("<option>")
                        .val(m.category_main_num)
                        .text(m.category_main_name);

                    if (String(m.category_main_num) === String(res.post.category_main_num)) {
                        $opt.prop("selected", true);
                    }

                    $mainSel.append($opt);
                });
            },
            error: function() {
                alert("게시글 정보를 불러오지 못했습니다.");
            }
        });
    }





 // ======================================================
 // 📌 모달 닫기
 // ======================================================
 function closeEditModal() {
     $("#editModal").fadeOut(150);
 }



 // ======================================================
 // 📌 ESC 누르면 닫기
 // ======================================================
 document.addEventListener("keydown", function (e) {
     if (e.key === "Escape") {
         closeEditModal();
     }
 });



 // ======================================================
 // 📌 모달 바깥 클릭하면 닫기
 // ======================================================
 $(document).on("click", function (e) {
     if ($(e.target).closest(".edit-modal-content").length === 0 &&
         $(e.target).attr("id") === "editModal") {
         closeEditModal();
     }
 });


</script>

</body>
</html>
