<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 통계 | Hobee Admin</title>

    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 통계 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostStats.css">

    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="page-title">게시글 통계</div>

    <div class="stats-wrapper">

        <!-- 조회수 파이 차트 -->
        <div class="chart-box">
            <h3>조회수 TOP 10</h3>
            <canvas id="viewPieChart"></canvas>
        </div>

        <!-- 댓글수 도넛 차트 -->
        <div class="chart-box">
            <h3>댓글 수 TOP 10</h3>
            <canvas id="commentDoughnutChart"></canvas>
        </div>

    </div>

</main>


<!-- ===============================
     📌 Chart.js 데이터 연결
================================ -->
<script>
    /* ====== 조회수 데이터 ====== */
    const viewPieLabels = [
        <c:forEach var="p" items="${viewStats}">
            "${p.title}",
        </c:forEach>
    ];

    const viewPieData = [
        <c:forEach var="p" items="${viewStats}">
            ${p.views},
        </c:forEach>
    ];

    /* ====== 댓글 수 데이터 ====== */
    const commentLabels = [
        <c:forEach var="c" items="${commentStats}">
            "${c.title}",
        </c:forEach>
    ];

    const commentData = [
        <c:forEach var="c" items="${commentStats}">
            ${c.comment_count},
        </c:forEach>
    ];


    /* ====== 조회수 파이 차트 ====== */
    new Chart(document.getElementById('viewPieChart'), {
        type: 'pie',
        data: {
            labels: viewPieLabels,
            datasets: [{
                data: viewPieData,
                backgroundColor: [
                    '#4c7df5', '#ff6384', '#36a2eb', '#ffcd56',
                    '#32c77b', '#ffa502', '#6c5ce7', '#ff6b6b',
                    '#1dd1a1', '#2e86de'
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });


    /* ====== 댓글수 도넛 차트 ====== */
    new Chart(document.getElementById('commentDoughnutChart'), {
        type: 'doughnut',
        data: {
            labels: commentLabels,
            datasets: [{
                data: commentData,
                backgroundColor: [
                    '#ff6b6b', '#1dd1a1', '#ffcd56', '#36a2eb',
                    '#a55eea', '#ff9f43', '#f368e0', '#54a0ff',
                    '#5f27cd', '#10ac84'
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '55%',
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>

</body>
</html>
