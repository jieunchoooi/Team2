<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPostStats.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
    
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="stats-grid">

        <!-- 조회수 TOP10 -->
        <div class="chart-box">
            <div class="chart-title">조회수 TOP 10</div>
            <div class="chart-area">
                <canvas id="viewChart"></canvas>
            </div>
            <div id="viewLegend" class="chart-legend"></div>
        </div>

        <!-- 댓글 수 TOP10 -->
        <div class="chart-box">
            <div class="chart-title">댓글 수 TOP 10</div>
            <div class="chart-area">
                <canvas id="commentChart"></canvas>
            </div>
            <div id="commentLegend" class="chart-legend"></div>
        </div>

        <!-- 최근 7일 -->
        <div class="chart-box">
            <div class="chart-title">최근 7일 게시글 추이</div>
            <div class="chart-area">
                <canvas id="weeklyChart"></canvas>
            </div>
            <div id="weeklyLegend" class="chart-legend"></div>
        </div>

        <!-- 게시판 비율 -->
        <div class="chart-box">
            <div class="chart-title">게시판별 게시글 비율</div>
            <div class="chart-area">
                <canvas id="categoryChart"></canvas>
            </div>
            <div id="categoryLegend" class="chart-legend"></div>
        </div>

    </div>

</main>

<script>
/* ===========================
    안전한 legend 생성 함수
=========================== */
function generateHtmlLegend(chart, legendId) {

    // 데이터셋 미존재 보호
    if (!chart.data || !chart.data.labels || !chart.data.datasets ||
        chart.data.datasets.length === 0 ||
        !chart.data.datasets[0].backgroundColor) 
    {
        console.warn("Legend skipped (empty dataset):", legendId);
        return;
    }

    const labels = chart.data.labels;
    const colors = chart.data.datasets[0].backgroundColor;

    // label과 color 길이가 맞지 않으면 legend 생성 중단
    if (labels.length === 0 || colors.length === 0) {
        console.warn("Legend skipped (no labels/colors):", legendId);
        return;
    }

    const ul = document.createElement('ul');

    labels.forEach((label, i) => {
        const li = document.createElement('li');
        const colorBox = document.createElement('span');
        colorBox.style.background = colors[i % colors.length];
        li.appendChild(colorBox);
        li.appendChild(document.createTextNode(label));
        ul.appendChild(li);
    });

    const legendContainer = document.getElementById(legendId);
    legendContainer.innerHTML = "";
    legendContainer.appendChild(ul);
}

/* ===== 조회수 TOP10 ===== */
const viewChart = new Chart(document.getElementById('viewChart'), {
    type: 'pie',
    data: {
        labels: [
            <c:forEach var="p" items="${viewStats}">
                "${p.title}",
            </c:forEach>
        ],
        datasets: [{
            data: [
                <c:forEach var="p" items="${viewStats}">
                    ${p.views},
                </c:forEach>
            ],
            backgroundColor: [
                '#4c7df5','#ff6384','#36a2eb','#ffcd56','#32c77b',
                '#ffa502','#6c5ce7','#ff6b6b','#1dd1a1','#2e86de'
            ]
        }]
    },
    plugins: [ChartDataLabels],
    options: {
        plugins: {
            legend: { display: false },
            datalabels: {
                color: '#fff',
                font: { weight: 'bold', size: 14 },
                formatter: (value, ctx) => value, // 숫자 그대로 출력

                // 🔥 가장 큰 값이면 글씨를 더 크게
                font: function(ctx) {
                    const dataset = ctx.chart.data.datasets[0].data;
                    const max = Math.max(...dataset);
                    return {
                        weight: 'bold',
                        size: ctx.dataIndex === dataset.indexOf(max) ? 18 : 14
                    };
                }
            }
        }
    }
});

generateHtmlLegend(viewChart, 'viewLegend');


/* ===== 댓글수 TOP10 ===== */
const commentChart = new Chart(document.getElementById('commentChart'), {
    type: 'doughnut',
    data: {
        labels: [
            <c:forEach var="c" items="${commentStats}">
                "${c.title}",
            </c:forEach>
        ],
        datasets: [{
            data: [
                <c:forEach var="c" items="${commentStats}">
                    ${c.comment_count},
                </c:forEach>
            ],
            backgroundColor: [
                '#ff6b6b','#1dd1a1','#ffcd56','#36a2eb','#a55eea',
                '#ff9f43','#f368e0','#54a0ff','#5f27cd','#10ac84'
            ]
        }]
    },
    options: { plugins: { legend: { display: false }}, cutout: "55%" }
});
generateHtmlLegend(commentChart, 'commentLegend');


/* ===== 최근 7일 ===== */
const weeklyChart = new Chart(document.getElementById('weeklyChart'), {
    type: 'line',
    data: {
        labels: [
            <c:forEach var="w" items="${weeklyStats}">
                "${w.date}",
            </c:forEach>
        ],
        datasets: [{
            label: "최근 7일 게시글 수",
            data: [
                <c:forEach var="w" items="${weeklyStats}">
                    ${w.count},
                </c:forEach>
            ],
            borderColor: '#4c7df5',
            borderWidth: 4,
            tension: 0.3,
            pointRadius: 6,
            pointBackgroundColor: '#4c7df5',
            pointBorderWidth: 2,
            pointHoverRadius: 8,
        }]
    },
    plugins: [ChartDataLabels],
    options: {

        /* 🔥🔥 여백 문제 해결 핵심 두 줄 🔥🔥 */
        maintainAspectRatio: false,
        responsive: true,

        plugins: {
            legend: { display: false },
            datalabels: {
                align: 'top',
                anchor: 'end',
                color: '#333',
                font: { weight: 'bold', size: 14 },
                formatter: (value) => value
            }
        },
        scales: {
            x: {
                ticks: { color: '#555', font: { size: 12 } },
                grid: { display: false }
            },
            y: {
                ticks: { color: '#888', font: { size: 12 } },
                grid: { color: '#eee' }
            }
        },
        layout: {
            padding: 0   // 🔥 오른쪽·왼쪽 여백 제거
        }
    }
});


/* ===== 게시판 비율 ===== */
const categoryChart = new Chart(document.getElementById('categoryChart'), {
    type: 'pie',
    data: {
        labels: [
            <c:forEach var="cg" items="${categoryStats}">
                "${cg.board_name}",
            </c:forEach>
        ],
        datasets: [{
            data: [
                <c:forEach var="cg" items="${categoryStats}">
                    ${cg.count},
                </c:forEach>
            ],
            backgroundColor: [
                '#4c7df5','#32c77b','#ffcd56','#ff6b6b','#6c5ce7',
                '#ffa502','#1dd1a1','#2e86de','#f368e0','#54a0ff'
            ]
        }]
    },
    plugins: [ChartDataLabels],
    options: { 
        plugins: { 
            legend: { display: false },
            datalabels: {
                color: '#fff',
                font: { weight: 'bold', size: 14 },
                formatter: (value) => value, // 숫자 표시

                font: function(ctx) {
                    const dataset = ctx.chart.data.datasets[0].data;
                    const max = Math.max(...dataset);

                    return {
                        weight: 'bold',
                        size: ctx.dataIndex === dataset.indexOf(max) ? 18 : 14
                    };
                }
            }
        }
    }
});
generateHtmlLegend(categoryChart, 'categoryLegend');


</script>

</body>
</html>
