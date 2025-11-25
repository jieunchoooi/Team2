<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 상세보기 | Hobee Admin</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostDetail.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="page-title">게시글 상세보기</div>

    <div class="detail-card">

        <!-- ============================================
             🔥 삭제된 게시글 안내 배너
        ============================================== -->
        <c:if test="${post.is_deleted == 1}">
            <div class="deleted-notice">
                ※ 이 게시글은 삭제된 상태입니다. (복구 가능합니다)
            </div>

            <form action="${pageContext.request.contextPath}/admin/adminPostRestore" method="post">
                <input type="hidden" name="post_id" value="${post.post_id}">
                <button class="action-btn btn-green" style="margin-bottom:20px;">복구하기</button>
            </form>
        </c:if>

        <!-- =========================
             기본 정보
        ========================== -->
        <div class="detail-info-box">

            <div class="detail-info-row">
                <span class="info-label">제목</span>
                <span class="info-value">${post.title}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">작성자</span>
                <span class="info-value">${post.author}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">게시판</span>
                <span class="info-value">${post.board_name}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">등록일</span>
                <span class="info-value">${post.created_at}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">조회수</span>
                <span class="info-value">${post.views}</span>
            </div>

            <div class="detail-info-row">
                <span class="info-label">노출 여부</span>

                <div class="exposure-box">

                    <!-- 상태 배지 -->
                    <button class="action-btn ${post.is_visible == 1 ? 'btn-green' : 'btn-gray'}" disabled>
                        ${post.is_visible == 1 ? '공개' : '숨김'}
                    </button>

                    <!-- 🔥 삭제된 글은 숨김/표시 버튼 비활성화 -->
                    <c:choose>
                        <c:when test="${post.is_deleted == 1}">
                            <button class="action-btn btn-gray" disabled>변경 불가</button>
                        </c:when>

                        <c:otherwise>
                            <!-- 노출 변경 버튼 -->
                            <form action="${pageContext.request.contextPath}/admin/adminPostToggle" method="post">
                                <input type="hidden" name="post_id" value="${post.post_id}">
                                <button class="action-btn ${post.is_visible == 1 ? 'btn-red' : 'btn-green'}">
                                    ${post.is_visible == 1 ? '숨기기' : '표시하기'}
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>

        </div> <!-- detail-info-box -->

        <!-- =========================
             내용
        ========================== -->
        <div class="detail-content-box">
            <h3>내용</h3>
            <div class="detail-content-area">
                ${post.content}
            </div>
        </div>

        <!-- =========================
             댓글 목록
        ========================== -->
        <div class="comment-section">
            <h3>댓글 목록</h3>

            <c:if test="${empty comments}">
                <p class="no-comment">등록된 댓글이 없습니다.</p>
            </c:if>

            <c:forEach var="cmt" items="${comments}">
                <div class="comment-box ${cmt.is_deleted == 1 ? 'deleted' : ''}">

                    <div class="comment-row">
                        <span class="comment-writer">${cmt.user_id}</span>
                        <span class="comment-date">${cmt.created_at}</span>
                    </div>

                    <c:if test="${cmt.report_count > 0}">
                        <div class="report-badge">${cmt.report_count}회 신고됨</div>
                    </c:if>

                    <div class="comment-content">${cmt.content}</div>

                    <div class="comment-actions">

                        <!-- 삭제된 댓글 → 복구 -->
                        <c:if test="${cmt.is_deleted == 1}">
                            <form action="${pageContext.request.contextPath}/admin/postDetailCommentRestore" method="post">
                                <input type="hidden" name="post_id" value="${post.post_id}">
                                <input type="hidden" name="comment_id" value="${cmt.comment_id}">
                                <button class="action-btn btn-green">복구</button>
                            </form>
                        </c:if>

                        <!-- 정상 댓글 → 삭제 -->
                        <c:if test="${cmt.is_deleted == 0}">
                            <form action="${pageContext.request.contextPath}/admin/postDetailCommentDelete"
                                  method="post"
                                  onsubmit="return confirm('댓글을 삭제하시겠습니까?');">
                                <input type="hidden" name="post_id" value="${post.post_id}">
                                <input type="hidden" name="comment_id" value="${cmt.comment_id}">
                                <button class="action-btn btn-red">삭제</button>
                            </form>
                        </c:if>

                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- =========================
             버튼 영역
        ========================== -->
        <div class="detail-btn-area">

            <button class="btn-blue"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminPostEdit?post_id=${post.post_id}'">
                수정하기
            </button>

            <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
                목록으로
            </button>

            <form action="${pageContext.request.contextPath}/admin/adminPostDelete"
                  method="post"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <input type="hidden" name="post_id" value="${post.post_id}">
                <button class="btn-red">삭제</button>
            </form>

        </div>

    </div> <!-- detail-card -->

</main>

</body>
</html>
