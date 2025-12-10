<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom fonts for this template-->
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin/adminSidebar.css">
    <!-- Custom styles for this template-->
    <link href="${ pageContext.request.contextPath }/resources/css/admin/dashboard.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
</head>

<body id="page-top">
    <!-- header -->
    <jsp:include page="../include/header.jsp"></jsp:include>
    <jsp:include page="../include/adminSidebar.jsp"></jsp:include>
    
    <!-- Page Wrapper -->
    <div id="dash-wrapper">
        <!-- Begin Page Content -->
        <div class="container-fluid">
        <div class="box" >

<!-- Content Row - 매출 & 신고 & 인기강의 -->
			<div class="row">
			    <!-- Earnings (Monthly) Card -->
			    <div class="col-xl-3 col-md-6 mb-4">
			        <div class="card border-left-primary shadow h-100 py-2">
			            <div class="card-body">
			                <div class="row no-gutters align-items-center">
			                    <div class="col mr-2">
			                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
			                            월간 매출 (전년도 월 평균 대비)</div>
			                        <div class="h5 mb-0 font-weight-bold text-gray-800">
			                        <fmt:formatNumber value="${monthsSales}" type="number" /></div>
			                        <span class="red"> ${percentRounded} %</span>
			                    </div>
			                    <div class="col-auto">
			                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			
			    <!-- Pending Requests Card -->
			    <div class="col-xl-3 col-md-6 mb-4">
			        <div class="card border-left-warning shadow h-100 py-2 class3">
			            <div class="card-body">
			                <div class="row no-gutters align-items-center">
			                    <div class="col mr-2">
			                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
			                            신고 관리(미처리)</div>
			                        <div class="h5 mb-0 font-weight-bold text-gray-800 red">${pending}</div>
			                    </div>
			                    <div class="col-auto">
			                        <i class="fas fa-comments fa-2x text-gray-300"></i>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			    
			    <!-- Pending Requests Card -->
			    <div class="col-xl-3 col-md-6 mb-4">
			        <div class="card border-left-warning shadow h-100 py-2 class1">
			            <div class="card-body">
			                <div class="row no-gutters align-items-center">
			                    <div class="col mr-2">
			                        <div class="text-xs font-weight-bold text-class text-uppercase mb-1">
			                            요청된 강의 수</div>
			                        <div class="h5 mb-0 font-weight-bold text-gray-800 yellow">${askClassCount1}</div>
			                    </div>
			                    <div class="col-auto">
			                        <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			    
			    <div class="col-xl-3 col-md-6 mb-4">
			        <div class="card border-left-warning shadow h-100 py-2 class2">
			            <div class="card-body">
			                <div class="row no-gutters align-items-center">
			                    <div class="col mr-2">
			                        <div class="text-xs font-weight-bold text-person text-uppercase mb-1">
			                           	신규 가입자(이번달)</div>
			                        <div class="h5 mb-0 font-weight-bold text-gray-800 green">${newPerson}</div>
			                    </div>
			                    <div class="col-auto">
			                         <i class="fa-solid fa-user-plus fa-2x text-gray-300"></i>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			
			</div>
			
			<!-- Content Row - 월별 매출 & 인기강의 & 카테고리별 결제 -->
			<div class="row  contentRow">
			    <!-- 월별 매출 그래프 -->
			    <div class="col-xl-6 col-lg-6" style="padding-right: 0;">
			        <div class="card shadow mb-4 h-100" id="mb">
			            <div class="card-header py-3">
			                <h6 class="m-0 font-weight-bold text-primary dash6">월별 매출 통계
			                <span style="font-size: 0.75rem; font-weight: normal; color: #858796;">&nbsp;(단위: 만원)</span></h6>
			            </div>
			            <div class="card-body">
			                <div class="chart-area">
			                    <canvas id="monthlyEarningsChart"></canvas>
			                </div>
			            </div>
			        </div>
			    </div>
			
			
			
			    <!-- 카테고리별 결제 통계 -->
			    <div class="col-xl-3 col-lg-3">
			        <div class="card shadow mb-4 h-100">
			            <div class="card-header py-3">
			                <h6 class="m-0 font-weight-bold text-primary dash6">카테고리별 결제 통계 (전월)</h6>
			            </div>
			            <div class="card-body">
			                <div class="chart-pie pt-2 pb-2">
			                    <canvas id="categoryPieChart"></canvas>
			                </div>
			               <div class="mt-3 text-center small">
							    <c:forEach items="${categoryList}" var="category" varStatus="status">
							        <span class="mr-2">
							            <c:choose>
							                <c:when test="${status.index == 0}">
							                    <i class="fas fa-circle" style="color: #4e73df;"></i>
							                </c:when>
							                <c:when test="${status.index == 1}">
							                    <i class="fas fa-circle" style="color: #1cc88a;"></i>
							                </c:when>
							                <c:when test="${status.index == 2}">
							                    <i class="fas fa-circle" style="color: #36b9cc;"></i>
							                </c:when>
							                <c:when test="${status.index == 3}"><br>
							                    <i class="fas fa-circle" style="color: #f6c23e;"></i>
							                </c:when>
							                <c:when test="${status.index == 4}">
							                    <i class="fas fa-circle" style="color: #e74a3b;"></i>
							                </c:when>
							                <c:when test="${status.index == 5}">
							                    <i class="fas fa-circle" style="color: #858796;"></i>
							                </c:when>
							                <c:otherwise>
							                    <i class="fas fa-circle" style="color: #5a5c69;"></i>
							                </c:otherwise>
							            </c:choose>
							            ${category.categoryName}
							        </span>
							    </c:forEach>
							</div>
			            </div>
			        </div>
			    </div>
			        <!-- 인기 강의 TOP 10 -->
			 <div class="col-xl-3 col-lg-3" style="margin-bottom: 0;">
			    <div class="card shadow h-100">
			        <div class="card-header py-3">
			            <h6 class="m-0 font-weight-bold text-primary dash6">인기 강의 TOP 10</h6>
			        </div>
			        <div class="card-body" style="padding: 0.5rem;">
			            <div class="popular-lectures-full">
			                <c:forEach items="${bestClassTop10}" var="lecture" varStatus="status">
			                  <div class="lecture-item-full" onclick="window.open('${pageContext.request.contextPath}/category/lecture?no=${lecture.lecture_num}', '_blank')" style="cursor: pointer;">
								    <div class="lecture-rank-full">${status.index + 1}</div>
								    <div class="lecture-thumbnail-full">
								        <img src="${pageContext.request.contextPath}/resources/img/lecture_picture/${lecture.lecture_img}" 
								             alt="${lecture.lecture_title}">
								    </div>
								    <div class="lecture-info-full">
								        <div class="category_detail-full">${lecture.category_detail}</div>
								        <div class="lecture-title-full">${lecture.lecture_title}</div>
								    </div>
								    <div class="lecture-scrap-full">
								        <i class="fas fa-bookmark"></i> ${lecture.scrapCount}
								    </div>
							  </div>
			                </c:forEach>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
			
			<!-- Content Row - 통계 카드들 -->
			<div class="row">
			    <div class="col-lg-2 col-md-6 mb-4">
			        <div class="card bg-info text-white shadow">
			            <div class="card-body color2" id="color">
			                총 회원수
			                <div class="text-white-50 small">${countMemberList1}</div>
			            </div>
			        </div>
			    </div>
			    <div class="col-lg-2 col-md-6 mb-4">
			        <div class="card bg-secondary text-white shadow">
			            <div class="card-body color3" id="color">
			                탈퇴 회원수
			                <div class="text-white-50 small">${dcount1}</div>
			            </div>
			        </div>
			    </div>
			    <div class="col-lg-2 col-md-6 mb-4">
			        <div class="card bg-warning text-white shadow">
			            <div class="card-body color4" id="color">
			                총 강사수
			                <div class="text-white-50 small">${totalcount1}</div>
			            </div>
			        </div>
			    </div>
			    <div class="col-lg-2 col-md-6 mb-4">
			        <div class="card bg-primary text-white shadow">
			            <div class="card-body color1" id="color">
			                총 강의 수
			                <div class="text-white-50 small">${classCount}</div>
			            </div>
			        </div>
			    </div>
			    <div class="col-lg-2 col-md-6 mb-4">
			        <div class="card bg-success text-white shadow">
			            <div class="card-body color5" id="color">
			                결제된 강의수(월간)
			                <div class="text-white-50 small">${lectureSold}</div>
			            </div>
			        </div>
			    </div>
			    <div class="col-lg-2 col-md-6 mb-4">
			        <div class="card bg-danger text-white shadow">
			            <div class="card-body color6" id="color">
			                환불된 강의수(월간)
			                <div class="text-white-50 small">${lectureRefunded}</div>
			            </div>
			        </div>
			    </div>
			</div>
         </div>  
	</div>
    </div>
    <!-- End of Main Content -->
	
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/chart-area-demo.js"></script>
    <script src="js/demo/chart-pie-demo.js"></script>

</body>

<!-- Chart.js 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
<script>
let color1 = document.querySelector(".color1");
let color2 = document.querySelector(".color2");
let color3 = document.querySelector(".color3");
let color4 = document.querySelector(".color4");
let color5 = document.querySelector(".color5");
let color6 = document.querySelector(".color6");
let class1 = document.querySelector(".class1");
let class2 = document.querySelector(".class2");
let class3 = document.querySelector(".class3");

// 총 강의수 
color1.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminClassList";
}
// 총 회원수
color2.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminMemberList";
}
// 탈퇴 회원수
color3.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminWithdrawList";
}
// 총 강사수
color4.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminTeacherList";
}
// 결제된 강의수
color5.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminPaymentList?viewType=payment&merchantUid=&period=&startDate=&endDate=&status=paid";
}
// 환불 강의수
color6.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminPaymentList?viewType=payment&merchantUid=&period=&startDate=&endDate=&status=refunded";
}
// 요청된 강의수
class1.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminClassList?filter=ask";
}
// 이번달 신규가입자
class2.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminMemberList";
}
// 신고관리
class3.onclick = function(){
	location.href = "${pageContext.request.contextPath}/admin/adminReportList";
}



// Number format function
function number_format(number, decimals, dec_point, thousands_sep) {
    number = (number + '').replace(',', '').replace(' ', '');
    var n = !isFinite(+number) ? 0 : +number,
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function(n, prec) {
            var k = Math.pow(10, prec);
            return '' + Math.round(n * k) / k;
        };
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}

//전체 카테고리와 색상 매핑
var allCategories = [];
var categoryColorMap = {};

<c:forEach items="${categoryList}" var="category" varStatus="status">
    var categoryName = "${category.categoryName}";
    allCategories.push(categoryName);
    
    <c:choose>
        <c:when test="${status.index == 0}">
            categoryColorMap[categoryName] = '#4e73df';
        </c:when>
        <c:when test="${status.index == 1}">
            categoryColorMap[categoryName] = '#1cc88a';
        </c:when>
        <c:when test="${status.index == 2}">
            categoryColorMap[categoryName] = '#36b9cc';
        </c:when>
        <c:when test="${status.index == 3}">
            categoryColorMap[categoryName] = '#f6c23e';
        </c:when>
        <c:when test="${status.index == 4}">
            categoryColorMap[categoryName] = '#e74a3b';
        </c:when>
        <c:when test="${status.index == 5}">
            categoryColorMap[categoryName] = '#858796';
        </c:when>
        <c:otherwise>
            categoryColorMap[categoryName] = '#5a5c69';
        </c:otherwise>
    </c:choose>
</c:forEach>

// DB에서 가져온 실제 데이터를 맵으로 저장
var statsMap = {};
<c:forEach items="${categoryStats}" var="stat">
    statsMap["${stat.categoryName}"] = ${stat.paymentCount};
</c:forEach>

// 모든 카테고리에 대해 데이터 생성 (없으면 0)
var categoryLabels = [];
var categoryData = [];
var categoryColors = [];

allCategories.forEach(function(categoryName) {
    categoryLabels.push(categoryName);
    categoryData.push(statsMap[categoryName] || 0); // ⭐ 데이터 없으면 0
    categoryColors.push(categoryColorMap[categoryName]);
});

console.log("categoryLabels:", categoryLabels);
console.log("categoryData:", categoryData);
console.log("categoryColors:", categoryColors);

// Pie Chart 생성
var ctx = document.getElementById("categoryPieChart");
var categoryPieChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: categoryLabels,
        datasets: [{
            data: categoryData,
            backgroundColor: categoryColors,
            hoverBackgroundColor: categoryColors,
            hoverBorderColor: "rgba(234, 236, 244, 1)",
        }],
    },
    options: {
        maintainAspectRatio: false,
        tooltips: {
            backgroundColor: "rgb(255,255,255)",
            bodyFontColor: "#858796",
            borderColor: '#dddfeb',
            borderWidth: 1,
            displayColors: false,
            caretPadding: 10,
            callbacks: {
                label: function(tooltipItem, chart) {
                    var datasetLabel = chart.labels[tooltipItem.index] || '';
                    var value = chart.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                    return datasetLabel + ': ' + value + '건';
                }
            }
        },
        legend: {
            display: false
        },
        cutoutPercentage: 80,
    },
});
// 월별 매출 데이터 준비
var monthlyLabels = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
var monthlyData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 초기값 0

// DB에서 가져온 데이터 채우기
<c:forEach items="${monthlySales}" var="sales">
    var yearMonth = "${sales.yearMonth}"; // 예: "2025-01"
    var month = parseInt(yearMonth.split('-')[1]); // "01" -> 1
    monthlyData[month - 1] = ${sales.totalSales}; // 1월 = 인덱스 0
</c:forEach>

console.log("monthlyData:", monthlyData);

// 월별 매출 라인 차트
var ctx2 = document.getElementById("monthlyEarningsChart");
var monthlyEarningsChart = new Chart(ctx2, {
    type: 'line',
    data: {
        labels: monthlyLabels,
        datasets: [{
            label: "매출",
            lineTension: 0.3,
            backgroundColor: "rgba(78, 115, 223, 0.05)",
            borderColor: "rgba(78, 115, 223, 1)",
            pointRadius: 3,
            pointBackgroundColor: "rgba(78, 115, 223, 1)",
            pointBorderColor: "rgba(78, 115, 223, 1)",
            pointHoverRadius: 3,
            pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
            pointHoverBorderColor: "rgba(78, 115, 223, 1)",
            pointHitRadius: 10,
            pointBorderWidth: 2,
            data: monthlyData, // ⭐ DB 데이터 사용
        }],
    },
    options: {
        maintainAspectRatio: false,
        layout: {
            padding: {
                left: 10,
                right: 25,
                top: 25,
                bottom: 0
            }
        },
        scales: {
            xAxes: [{
                gridLines: {
                    display: false,
                    drawBorder: false
                },
                ticks: {
                    maxTicksLimit: 12
                }
            }],
            yAxes: [{
                ticks: {
                    maxTicksLimit: 5,
                    padding: 10,
                    callback: function(value) {
                        return (value / 10000).toFixed(0);
                    }
                },
                gridLines: {
                    color: "rgb(234, 236, 244)",
                    zeroLineColor: "rgb(234, 236, 244)",
                    drawBorder: false,
                    borderDash: [2],
                    zeroLineBorderDash: [2]
                }
            }],
        },
        legend: {
            display: false
        },
        tooltips: {
            backgroundColor: "rgb(255,255,255)",
            bodyFontColor: "#858796",
            titleMarginBottom: 10,
            titleFontColor: '#6e707e',
            titleFontSize: 14,
            borderColor: '#dddfeb',
            borderWidth: 1,
            xPadding: 15,
            yPadding: 15,
            displayColors: false,
            intersect: false,
            mode: 'index',
            caretPadding: 10,
            callbacks: {
                label: function(tooltipItem, chart) {
                    var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                    return datasetLabel + ': ₩' + number_format(tooltipItem.yLabel);
                }
            }
        }
    }
});
</script>
</html>