<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 상세보기 | Hobee Admin</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminBoardDetail.css">

    <!-- Chart.js (주간 그래프용) -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 페이지 제목 -->
    <div class="page-title">게시판 상세보기</div>

    <div class="center-wrapper">

        <!-- ===========================
             1) 게시판 기본 정보 카드
        ============================ -->
        <div class="card-box info-card">

            <h2 class="section-title">🗂 게시판 정보</h2>

            <div class="info-item"><strong>ID</strong><span>${board.board_id}</span></div>
            <div class="info-item"><strong>게시판 이름</strong><span>${board.board_name}</span></div>
            <div class="info-item"><strong>설명</strong><span>${board.board_desc}</span></div>

            <div class="info-item">
                <strong>사용 여부</strong>
                <span class="badge ${board.is_active == 1 ? 'badge-green' : 'badge-gray'}">
                    ${board.is_active == 1 ? '사용' : '숨김'}
                </span>
            </div>

            <div class="info-item"><strong>생성일</strong><span>${board.created_at}</span></div>

        </div>


        <!-- ===========================
             2) 게시글 통계 4종 카드
        ============================ -->
        <div class="stats-grid">

            <div class="stats-card">
                <div class="stats-icon blue">📝</div>
                <div class="stats-title">전체 글</div>
                <div class="stats-count">${board.post_count}</div>
            </div>

            <div class="stats-card">
                <div class="stats-icon green">📅</div>
                <div class="stats-title">이번달 글</div>
                <div class="stats-count">${board.post_count_month}</div>
            </div>

            <div class="stats-card">
                <div class="stats-icon navy">✔</div>
                <div class="stats-title">정상 글</div>
                <div class="stats-count">${board.post_count_visible}</div>
            </div>

            <div class="stats-card">
                <div class="stats-icon red">⚠</div>
                <div class="stats-title">신고됨</div>
                <div class="stats-count">${board.report_count}</div>
            </div>

        </div>


        <!-- ===========================
             3) 최근 7일 게시글 그래프
        ============================ -->
        <div class="card-box">
            <h2 class="section-title">📊 최근 7일 게시글 추세</h2>

            <canvas id="weeklyChart"></canvas>

            <script>
                const labels = [
                    <c:forEach var="day" items="${weeklyStats}">
                        "${day.day}",
                    </c:forEach>
                ];

                const data = [
                    <c:forEach var="day" items="${weeklyStats}">
                        ${day.count},
                    </c:forEach>
                ];

                new Chart(document.getElementById('weeklyChart'), {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '작성 글 수',
                            data: data,
                            borderWidth: 3,
                            borderColor: '#4a74ff',
                            backgroundColor: 'rgba(74,116,255,0.2)',
                            tension: 0.3
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: { beginAtZero: true }
                        }
                    }
                });
            </script>
        </div>


        <!-- ===========================
             4) 인기글 TOP 5
        ============================ -->
        <div class="card-box">
            <h2 class="section-title">🔥 인기글 TOP 5 (조회수 기준)</h2>

            <table class="styled-table small-table">
                <thead>
                <tr>
                    <th>제목</th>
                    <th>조회수</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="post" items="${topViews}">
                    <tr>
                        <td class="title-cell">${post.title}</td>
                        <td class="center-cell">${post.views}</td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>
        </div>


        <!-- ===========================
             5) 신고 많은 글 TOP 5
        ============================ -->
        <div class="card-box">
            <h2 class="section-title">⚠ 신고 많은 글 TOP 5</h2>

            <table class="styled-table small-table">
                <thead>
                <tr>
                    <th>제목</th>
                    <th>신고수</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="post" items="${topReports}">
                    <tr>
                        <td class="title-cell">${post.title}</td>
                        <td class="center-cell">${post.report_count}</td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>
        </div>



        <!-- ===========================
             6) 최근 게시글 5개
        ============================ -->
        <div class="card-box">

            <h2 class="section-title">📝 최근 게시글</h2>

            <table class="styled-table">
                <thead>
                <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>상태</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="post" items="${recentPosts}">
                    <tr>
                        <td class="title-cell">
                            <a href="${pageContext.request.contextPath}/community/postDetail?post_id=${post.post_id}"
                               class="post-link">
                               ${post.title}
                            </a>
                        </td>

                        <td class="center-cell">${post.user_num}</td>
                        <td class="center-cell">${post.created_at}</td>

                        <td class="status-cell">
                            <span class="badge ${post.is_deleted == 1 ? 'badge-red' : 'badge-blue'}">
                                ${post.is_deleted == 1 ? '삭제됨' : '정상'}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>

            <div class="btn-area">
                <a href="${pageContext.request.contextPath}/admin/adminBoardList">
                    <button class="btn-gray">목록으로</button>
                </a>

                <a href="${pageContext.request.contextPath}/admin/adminBoardEdit?board_id=${board.board_id}">
                    <button class="btn-blue">수정하기</button>
                </a>
            </div>

        </div>


    </div>

</main>

</body>
</html>
