<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 상세 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminBoardDetail.css?v=999">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- ========================================================= -->
    <!-- 📌 페이지 제목 -->
    <!-- ========================================================= -->
    <div class="page-title">게시판 상세정보</div>

    <!-- 📌 전체 영역 Wrapper -->
    <div class="detail-wrapper">

        <!-- ========================================================= -->
        <!-- 📌 기본정보 + 옵션설정 -->
        <!-- ========================================================= -->
        <div class="info-grid">

            <!-- ================= 기본 정보 카드 ================== -->
            <div class="card-box info-card basic">

                <div class="section-title">기본 정보</div>

                <div class="info-item">
                    <strong>게시판 ID</strong>
                    <span>${board.board_id}</span>
                </div>

                <div class="info-item">
                    <strong>게시판 이름</strong>
                    <span>${board.board_name}</span>
                </div>

                <div class="info-item">
                    <strong>게시판 설명</strong>
                    <span>${board.board_desc}</span>
                </div>

                <div class="info-item">
                    <strong>사용 여부</strong>
                    <span>${board.is_active == 1 ? "사용" : "숨김"}</span>
                </div>

                <div class="info-item">
                    <strong>작성 권한</strong>
                    <span>${board.write_role}</span>
                </div>

            </div>


            <!-- ================= 옵션 설정 카드 ================== -->
            <div class="card-box info-card options">

                <div class="section-title">옵션 설정</div>

                <!-- 댓글 옵션 -->
                <div class="info-item">
                    <strong>댓글</strong>
                    <div class="option-buttons">
                        <c:choose>
                            <c:when test="${board.allow_comment == 1}">
                                <button class="opt-btn active"
                                        data-option="comment" data-value="1">허용</button>
                                <button class="opt-btn"
                                        data-option="comment" data-value="0">금지</button>
                            </c:when>
                            <c:otherwise>
                                <button class="opt-btn"
                                        data-option="comment" data-value="1">허용</button>
                                <button class="opt-btn active"
                                        data-option="comment" data-value="0">금지</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 이미지 업로드 옵션 -->
                <div class="info-item">
                    <strong>이미지</strong>
                    <div class="option-buttons">
                        <c:choose>
                            <c:when test="${board.allow_image == 1}">
                                <button class="opt-btn active"
                                        data-option="image" data-value="1">허용</button>
                                <button class="opt-btn"
                                        data-option="image" data-value="0">금지</button>
                            </c:when>
                            <c:otherwise>
                                <button class="opt-btn"
                                        data-option="image" data-value="1">허용</button>
                                <button class="opt-btn active"
                                        data-option="image" data-value="0">금지</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 파일 업로드 옵션 -->
                <div class="info-item">
                    <strong>파일</strong>
                    <div class="option-buttons">
                        <c:choose>
                            <c:when test="${board.allow_file == 1}">
                                <button class="opt-btn active"
                                        data-option="file" data-value="1">허용</button>
                                <button class="opt-btn"
                                        data-option="file" data-value="0">금지</button>
                            </c:when>
                            <c:otherwise>
                                <button class="opt-btn"
                                        data-option="file" data-value="1">허용</button>
                                <button class="opt-btn active"
                                        data-option="file" data-value="0">금지</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 승인 필요 옵션 -->
                <div class="info-item">
                    <strong>승인 여부</strong>
                    <div class="option-buttons">
                        <c:choose>
                            <c:when test="${board.require_approval == 1}">
                                <button class="opt-btn active"
                                        data-option="approval" data-value="1">필요</button>
                                <button class="opt-btn"
                                        data-option="approval" data-value="0">불필요</button>
                            </c:when>
                            <c:otherwise>
                                <button class="opt-btn"
                                        data-option="approval" data-value="1">필요</button>
                                <button class="opt-btn active"
                                        data-option="approval" data-value="0">불필요</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </div>
        </div><!-- info-grid END -->


        <!-- ========================================================= -->
        <!-- 📌 통계 정보 -->
        <!-- ========================================================= -->
        <div class="stats-wrapper card-box">

            <div class="section-title">게시판 통계</div>

            <div class="stats-grid">

                <div class="stats-card delay-1">
                    <div class="stats-icon blue">📄</div>
                    <div class="stats-title">전체 글 수</div>
                    <div class="stats-count">${board.post_count}</div>
                </div>

                <div class="stats-card delay-2">
                    <div class="stats-icon green">🗓️</div>
                    <div class="stats-title">이번달 글 수</div>
                    <div class="stats-count">${board.post_count_month}</div>
                </div>

                <div class="stats-card delay-3">
                    <div class="stats-icon navy">✔</div>
                    <div class="stats-title">정상 글 수</div>
                    <div class="stats-count">${board.post_count_visible}</div>
                </div>

                <div class="stats-card delay-4">
                    <div class="stats-icon red">🚨</div>
                    <div class="stats-title">신고 글 수</div>
                    <div class="stats-count">${board.report_count}</div>
                </div>

            </div>
        </div>


        <!-- ========================================================= -->
        <!-- 📌 최근 게시글 + 조회수 TOP 5 -->
        <!-- ========================================================= -->
        <div class="bottom-grid">

            <!-- 최근 게시글 -->
            <div class="detail-section recent-section">
                <div class="section-title">최근 게시글 5개</div>

                <table>
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>작성일</th>
                        </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="post" items="${recentPosts}">
                        <tr>
                            <td>${post.post_id}</td>
                            <td>${post.title}</td>
                            <td>${post.created_at}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>


            <!-- 조회수 TOP5 -->
            <div class="detail-section topviews-section">
                <div class="section-title">조회수 TOP5</div>

                <table>
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>조회수</th>
                        </tr>
                    </thead>

                    <tbody>
                    <!-- 🔥 여기서 변수명 수정: topViews -> topViewPosts -->
                    <c:forEach var="post" items="${topViewPosts}">
                        <tr>
                            <td>${post.post_id}</td>
                            <td>${post.title}</td>
                            <td>${post.views}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

        </div><!-- bottom-grid END -->


        <!-- ========================================================= -->
        <!-- 📌 하단 버튼 -->
        <!-- ========================================================= -->
        <div class="btn-area">
            <a href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                <button class="btn-blue">게시판 수정</button>
            </a>

            <a href="${pageContext.request.contextPath}/admin/adminBoardList">
                <button class="btn-gray">목록으로</button>
            </a>
        </div>

    </div><!-- wrapper END -->

</main>


<!-- ========================================================= -->
<!-- 📌 옵션 버튼 AJAX + Ripple 효과 -->
<!-- ========================================================= -->
<script>
$(function() {

    $(".opt-btn").click(function(e) {

        /* Ripple 생성 */
        const rect = this.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const ripple = document.createElement("span");

        ripple.classList.add("ripple");
        ripple.style.width  = ripple.style.height = size + "px";
        ripple.style.left = (e.clientX - rect.left - size/2) + "px";
        ripple.style.top  = (e.clientY - rect.top  - size/2) + "px";

        this.appendChild(ripple);
        setTimeout(() => ripple.remove(), 600);

        /* AJAX 요청 */
        const $btn    = $(this);
        const boardId = ${board.board_id};
        const option  = $btn.data("option");
        const value   = $btn.data("value");

        $.ajax({
            url: "${pageContext.request.contextPath}/admin/adminBoardOptionUpdate",
            type: "POST",
            data: { board_id: boardId, option: option, value: value },
            success: function(res) {
                if (res === "success") {
                    $btn.closest(".option-buttons").find(".opt-btn").removeClass("active");
                    $btn.addClass("active");
                }
            }
        });

    });

});
</script>


<!-- ========================================================= -->
<!-- 📌 통계 카드 순차 애니메이션 -->
<!-- ========================================================= -->
<script>
document.addEventListener("DOMContentLoaded", function(){

    const statsObserver = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add("show");
            }
        });
    }, { threshold: 0.2 });

    document.querySelectorAll(".stats-card").forEach(card => {
        statsObserver.observe(card);
    });

});
</script>

</body>
</html>
