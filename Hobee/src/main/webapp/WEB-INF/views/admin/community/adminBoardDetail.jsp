<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>머리말 상세 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminBoardDetail.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 제목 -->
    <div class="page-title">머리말 상세</div>

    <div class="detail-wrapper">

        <!-- 카드 2개 (기본 정보 + 옵션 설정) -->
        <div class="info-grid">

            <!-- 기본 정보 카드 -->
            <div class="card-box info-card">
                <h3 class="section-title">📌 기본 정보</h3>

                <div class="info-item">
                    <strong>머리말 이름</strong>
                    <span>${board.board_name}</span>
                </div>

                <div class="info-item">
                    <strong>머리말 설명</strong>
                    <span class="desc-ellipsis"
      					  title="${board.board_desc}">
   						  ${board.board_desc}
					</span>

                </div>

                <div class="info-item">
                    <strong>사용 여부</strong>
                    <span>
                        <c:choose>
                            <c:when test="${board.is_active == 1}">
                                <span class="badge badge-green">사용</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-gray">숨김</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>


                <div class="info-item">
                    <strong>생성 날짜</strong>
                    <span>${board.created_at}</span>
                </div>
            </div>

            <!-- 옵션 설정 카드 -->
            <div class="card-box info-card">
                <h3 class="section-title">⚙ 머리말 옵션 설정</h3>

                <!-- 댓글 허용 -->
                <div class="info-item">
                    <strong>댓글 허용</strong>
                    <span class="option-buttons">
                        <button type="button"
                                class="opt-btn ${board.allow_comment == 1 ? 'active' : ''}"
                                data-option="comment" data-value="1">허용</button>

                        <button type="button"
                                class="opt-btn ${board.allow_comment == 0 ? 'active' : ''}"
                                data-option="comment" data-value="0">금지</button>
                    </span>
                </div>

                <!-- 이미지 첨부 -->
                <div class="info-item">
                    <strong>이미지 첨부</strong>
                    <span class="option-buttons">
                        <button type="button"
                                class="opt-btn ${board.allow_image == 1 ? 'active' : ''}"
                                data-option="image" data-value="1">허용</button>

                        <button type="button"
                                class="opt-btn ${board.allow_image == 0 ? 'active' : ''}"
                                data-option="image" data-value="0">금지</button>
                    </span>
                </div>

                <!-- 파일 첨부 -->
                <div class="info-item">
                    <strong>파일 첨부</strong>
                    <span class="option-buttons">
                        <button type="button"
                                class="opt-btn ${board.allow_file == 1 ? 'active' : ''}"
                                data-option="file" data-value="1">허용</button>

                        <button type="button"
                                class="opt-btn ${board.allow_file == 0 ? 'active' : ''}"
                                data-option="file" data-value="0">금지</button>
                    </span>
                </div>

                <!-- 승인 필요 -->
                <div class="info-item">
                    <strong>승인 필요</strong>
                    <span class="option-buttons">
                        <button type="button"
                                class="opt-btn ${board.require_approval == 1 ? 'active' : ''}"
                                data-option="approval" data-value="1">필요</button>

                        <button type="button"
                                class="opt-btn ${board.require_approval == 0 ? 'active' : ''}"
                                data-option="approval" data-value="0">불필요</button>
                    </span>
                </div>

                <!-- 작성 권한 -->
                <div class="info-item">
                    <strong>작성 권한</strong>
                    <span>
                        <c:choose>
                            <c:when test="${board.write_role == 'all'}">전체 사용자</c:when>
                            <c:when test="${board.write_role == 'member'}">로그인 사용자만</c:when>
                            <c:when test="${board.write_role == 'admin'}">관리자만</c:when>
                        </c:choose>
                    </span>
                </div>

                <!-- 금지 단어 -->
                <div class="info-item">
                    <strong>금지 단어</strong>
                    <span>${empty board.banned_words ? "없음" : board.banned_words}</span>
                </div>

            </div>
        </div> <!-- info-grid 끝 -->

        <!-- 통계 카드 -->
        <div class="card-box stats-wrapper">
            <h3 class="section-title">📊 머리말 통계</h3>

            <div class="stats-grid">
                <div class="stats-card">
                    <div class="stats-icon blue">📄</div>
                    <div class="stats-title">전체 게시글</div>
                    <div class="stats-count">${board.post_count}</div>
                </div>

                <div class="stats-card">
                    <div class="stats-icon green">🗓</div>
                    <div class="stats-title">이번달 등록</div>
                    <div class="stats-count">${board.post_count_month}</div>
                </div>

                <div class="stats-card">
                    <div class="stats-icon navy">✅</div>
                    <div class="stats-title">정상 게시글</div>
                    <div class="stats-count">${board.post_count_visible}</div>
                </div>

                <div class="stats-card">
                    <div class="stats-icon red">🚨</div>
                    <div class="stats-title">신고된 게시글</div>
                    <div class="stats-count">${board.report_count}</div>
                </div>
            </div>
        </div>

        <!-- 최근 글 / 조회수 탑 카드 -->
        <div class="bottom-grid">

            <!-- 최근 게시글 -->
            <div class="detail-section">
                <h3 class="section-title">📝 머리말 내 최근 게시글</h3>

                <table class="styled-table">
                    <thead>
                    <tr>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="post" items="${recentPosts}">
                        <tr>
                            <td>${post.title}</td>
                            <td>${post.user_num}</td>
                            <td>${post.created_at}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 조회수 TOP5 -->
            <div class="detail-section">
                <h3 class="section-title">🔥 머리말 내 조회수 TOP 5</h3>

                <table class="styled-table">
                    <thead>
                    <tr>
                        <th>제목</th>
                        <th>조회수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="post" items="${topViews}">
                        <tr>
                            <td>${post.title}</td>
                            <td>${post.views}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>

        <!-- 버튼 영역 -->
        <div class="btn-area">
            <a href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                <button class="btn-blue" type="button">수정하기</button>
            </a>

            <a href="${pageContext.request.contextPath}/admin/adminBoardList">
                <button class="btn-gray" type="button">목록으로</button>
            </a>
        </div>

    </div> <!-- detail-wrapper -->

    <!-- 옵션 변경 AJAX -->
    <script>
        $(function() {

            $(".opt-btn").click(function() {

                const $btn   = $(this);
                const boardId = ${board.board_id};
                const option  = $btn.data("option");
                const value   = $btn.data("value");

                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/adminBoardOptionUpdate",
                    type: "POST",
                    data: {
                        board_id: boardId,
                        option: option,
                        value: value
                    },
                    success: function (res) {
                        if (res === "success") {
                            $btn.closest(".option-buttons").find(".opt-btn").removeClass("active");
                            $btn.addClass("active");
                        } else {
                            alert("옵션 변경 실패");
                        }
                    }
                });

            });

        });
    </script>

</main>

</body>
</html>
