<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>${post.title} | Hobee 커뮤니티</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityDetail.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<body>

<jsp:include page="../include/header.jsp" />

<main class="detail-container">

    <%-- 🔥 제목 영역 --%>
    <h1 class="detail-title">
        <c:out value="${post.title}" />
    </h1>

    <%-- 🔥 작성자 영역 --%>
    <div class="detail-writer-box">

        <div class="writer-avatar">
            <img src="${post.user_file != null 
                      ? pageContext.request.contextPath += '/resources/img/user_picture/' += post.user_file
                      : pageContext.request.contextPath += '/resources/img/common/default-profile.png'}"/>
        </div>

        <div class="writer-info">
            <span class="writer-name">${post.user_name}</span>
            <span class="writer-date">
                <fmt:formatDate value="${post.created_at}" pattern="yyyy-MM-dd HH:mm" />
            </span>
        </div>

        <div class="writer-meta">
            👁 ${post.views} &nbsp;&nbsp; ❤️ ${post.like_count}
        </div>

    </div>

    <%-- 🔥 내 글이면 수정/삭제 버튼 --%>
    <c:if test="${sessionScope.userVO.user_num == post.user_num}">
        <div class="post-action-box">
            <button onclick="location.href='${pageContext.request.contextPath}/community/edit?post_id=${post.post_id}'">
                수정
            </button>

            <button onclick="if(confirm('정말 삭제하시겠습니까?')) 
                    location.href='${pageContext.request.contextPath}/community/delete?post_id=${post.post_id}'">
                삭제
            </button>
        </div>
    </c:if>

    <%-- 🔥 본문 내용 --%>
    <div class="detail-content">
        ${post.content}
    </div>

    <%-- 🔥 이전글 / 다음글 --%>
    <div class="post-navigate">

        <c:if test="${prevPost != null}">
            <div>
                이전글:
                <a href="${pageContext.request.contextPath}/community/detail?post_id=${prevPost.post_id}">
                    ${prevPost.title}
                </a>
            </div>
        </c:if>

        <c:if test="${nextPost != null}">
            <div>
                다음글:
                <a href="${pageContext.request.contextPath}/community/detail?post_id=${nextPost.post_id}">
                    ${nextPost.title}
                </a>
            </div>
        </c:if>

    </div>

    <%-- 🔥 게시글 좋아요 버튼 --%>
    <div class="detail-like-box">
        <button type="button" id="likeBtn"
            data-post="${post.post_id}"
            class="${post.user_reaction == 1 ? 'liked' : ''}">
            ❤️ 좋아요 ${post.like_count}
        </button>
    </div>

    <%-- 🔥 관련 글 목록 5개 --%>
    <div class="related-posts">
        <h3>관련 글</h3>
        <ul>
            <c:forEach var="rp" items="${relatedPosts}">
                <li>
                    <a href="${pageContext.request.contextPath}/community/detail?post_id=${rp.post_id}">
                        ${rp.title}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <%-- 🔥 댓글 섹션 --%>
    <div class="detail-comment-section">

        <h2>댓글 (${post.comment_count})</h2>

        <%-- 댓글 입력창 --%>
        <div class="comment-input-box">
            <textarea id="commentInput" placeholder="댓글을 입력하세요"></textarea>
            <button type="button" id="commentSubmit">등록</button>
        </div>

        <%-- 🔥 댓글 리스트 --%>
        <div id="commentContainer" class="comment-list">

            <c:forEach var="cmt" items="${commentList}">

                <div class="comment-item" data-comment="${cmt.comment_id}">

                    <div class="comment-avatar">
                        <img src="${cmt.user_file != null 
                                 ? pageContext.request.contextPath += '/resources/img/user_picture/' += cmt.user_file
                                 : pageContext.request.contextPath += '/resources/img/common/default-profile.png'}" />
                    </div>

                    <div class="comment-body">

                        <div class="comment-header">
                            <span class="comment-writer">${cmt.user_name}</span>
                            <span class="comment-date">
                                <fmt:formatDate value="${cmt.created_at}" pattern="yyyy-MM-dd HH:mm" />
                            </span>
                        </div>

                        <div class="comment-content">
                            <c:out value="${cmt.content}" />
                        </div>

                        <%-- 🔥 댓글 수정/삭제 버튼 --%>
                        <c:if test="${sessionScope.userVO.user_num == cmt.user_num}">
                            <div class="comment-actions-inline">
                                <button class="comment-edit-btn" data-id="${cmt.comment_id}">수정</button>
                                <button class="comment-delete-btn" data-id="${cmt.comment_id}">삭제</button>
                            </div>
                        </c:if>

                        <%-- 🔥 댓글 수정 창 --%>
                        <div class="comment-edit-box" id="edit-box-${cmt.comment_id}" style="display:none;">
                            <textarea class="edit-text">${cmt.content}</textarea>
                            <button class="edit-submit" data-id="${cmt.comment_id}">저장</button>
                        </div>

                        <%-- 🔥 댓글 좋아요 / 싫어요 / 대댓글 --%>
                        <div class="comment-actions">

                            <button class="comment-like-btn"
                                data-comment="${cmt.comment_id}">
                                👍 ${cmt.like_count}
                            </button>

                            <button class="comment-dislike-btn"
                                data-comment="${cmt.comment_id}">
                                👎 ${cmt.dislike_count}
                            </button>

                            <button class="reply-btn" data-comment="${cmt.comment_id}">
                                ↩ 대댓글
                            </button>

                        </div>

                        <%-- 🔥 대댓글 입력창 --%>
                        <div class="reply-input-box" id="reply-box-${cmt.comment_id}" style="display:none;">
                            <textarea class="reply-text" placeholder="대댓글을 입력하세요"></textarea>
                            <button class="reply-submit" data-parent="${cmt.comment_id}">등록</button>
                        </div>

                    </div>
                </div>

            </c:forEach>

        </div>

    </div>

</main>


<script>

/* 🔥 게시글 좋아요 */
$("#likeBtn").on("click", function () {
    const postId = $(this).data("post");

    $.post(
        "${pageContext.request.contextPath}/community/toggleLike",
        { post_id: postId },
        function (res) {
            if (res.success) {
                $("#likeBtn").toggleClass("liked");
                $("#likeBtn").text("❤️ 좋아요 " + res.like_count);
            } else {
                alert(res.message);
            }
        }
    );
});

/* 🔥 댓글 등록 */
$("#commentSubmit").on("click", function () {
    const text = $("#commentInput").val().trim();
    const postId = ${post.post_id};

    if (text === "") {
        alert("댓글 내용을 입력하세요!");
        return;
    }

    $.post(
        "${pageContext.request.contextPath}/community/comment/add",
        { post_id: postId, content: text },
        function (res) {
            if (res.success) {
                location.reload();
            }
        }
    );
});

/* 🔥 댓글 수정창 토글 */
$(document).on("click", ".comment-edit-btn", function () {
    const id = $(this).data("id");
    $("#edit-box-" + id).toggle();
});

/* 🔥 댓글 수정 */
$(document).on("click", ".edit-submit", function () {
    const id = $(this).data("id");
    const text = $("#edit-box-" + id + " .edit-text").val().trim();

    if (text === "") {
        alert("내용을 입력하세요.");
        return;
    }

    $.post(
        "${pageContext.request.contextPath}/community/comment/update",
        { comment_id: id, content: text },
        function (res) {
            if (res.success) location.reload();
        }
    );
});

/* 🔥 댓글 삭제 */
$(document).on("click", ".comment-delete-btn", function () {
    const id = $(this).data("id");

    if (!confirm("댓글을 삭제하시겠습니까?")) return;

    $.post(
        "${pageContext.request.contextPath}/community/comment/delete",
        { comment_id: id },
        function (res) {
            if (res.success) location.reload();
        }
    );
});

/* 🔥 댓글 좋아요 */
$(document).on("click", ".comment-like-btn", function () {
    const id = $(this).data("comment");

    $.post(
        "${pageContext.request.contextPath}/community/comment/like",
        { comment_id: id, is_like: 1 },
        function (res) {
            if (res.success) location.reload();
        }
    );
});

/* 🔥 댓글 싫어요 */
$(document).on("click", ".comment-dislike-btn", function () {
    const id = $(this).data("comment");

    $.post(
        "${pageContext.request.contextPath}/community/comment/like",
        { comment_id: id, is_like: 0 },
        function (res) {
            if (res.success) location.reload();
        }
    );
});

/* 🔥 대댓글 입력창 토글 */
$(document).on("click", ".reply-btn", function () {
    const id = $(this).data("comment");
    $("#reply-box-" + id).toggle();
});

/* 🔥 대댓글 등록 */
$(document).on("click", ".reply-submit", function () {
    const parent = $(this).data("parent");
    const text = $("#reply-box-" + parent + " .reply-text").val().trim();
    const postId = ${post.post_id};

    if (text === "") {
        alert("대댓글 내용을 입력하세요.");
        return;
    }

    $.post(
        "${pageContext.request.contextPath}/community/comment/reply",
        { post_id: postId, parent_id: parent, content: text },
        function (res) {
            if (res.success) location.reload();
        }
    );
});

</script>

</body>
</html>
