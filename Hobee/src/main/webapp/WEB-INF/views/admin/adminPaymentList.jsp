<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 내역 | Hobee Admin</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminPaymentList.css">

</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include>
<jsp:include page="../include/adminSidebar.jsp"></jsp:include>

<main class="main-content">

    <div class="main-header">
        <h1>결제 내역 관리</h1>
    </div>

    <%-- ======================================================
         📊 통계 카드 4개 (컨트롤러 바인딩된 변수 그대로 사용)
    ======================================================= --%>
    <div class="stats-container">

        <div class="stat-card">
            <h3>총 결제 금액</h3>
            <div class="stat-number">
                ₩ <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>
            </div>
        </div>

        <div class="stat-card">
            <h3>총 환불 금액</h3>
            <div class="stat-number refund">
                ₩ <fmt:formatNumber value="${totalRefund}" pattern="#,###"/>
            </div>
        </div>

        <div class="stat-card">
            <h3>결제된 강의 수</h3>
            <div class="stat-number">
                ${lectureSold}
            </div>
        </div>

        <div class="stat-card">
            <h3>환불된 강의 수</h3>
            <div class="stat-number refund">
                ${lectureRefunded}
            </div>
        </div>

    </div>


    <%-- ======================================================
         📌 탭 메뉴 (결제건별 / 강의별)
    ======================================================= --%>
    <div class="tab-wrapper">
        <a href="?viewType=payment" class="tab-btn ${viewType eq 'payment' ? 'active' : ''}">결제건별 보기</a>
        <a href="?viewType=lecture" class="tab-btn ${viewType eq 'lecture' ? 'active' : ''}">강의별 보기</a>
    </div>



    <%-- ======================================================
         📌 필터 영역
    ======================================================= --%>
    <div class="filter-container">

        <form action="${pageContext.request.contextPath}/admin/adminPaymentList" method="get" class="filter-form">

            <input type="hidden" name="viewType" value="${viewType}">

            <div class="filter-row">
                <label>주문번호</label>
                <input type="text" name="merchantUid" class="filter-input"
                       value="${param.merchantUid}" placeholder="예) M202512345678">
            </div>

            <div class="filter-row">
                <label>기간</label>
                <select name="period">
                    <option value="">전체</option>
                    <option value="today"  ${param.period == 'today' ? 'selected' : ''}>오늘</option>
                    <option value="week"   ${param.period == 'week' ? 'selected' : ''}>최근 1주</option>
                    <option value="month"  ${param.period == 'month' ? 'selected' : ''}>최근 1개월</option>
                    <option value="custom" ${param.period == 'custom' ? 'selected' : ''}>직접 선택</option>
                </select>

                <input type="date" name="startDate" value="${param.startDate}">
                <input type="date" name="endDate"   value="${param.endDate}">
            </div>

            <c:if test="${viewType eq 'payment'}">
                <div class="filter-row">
                    <label>상태</label>
                    <select name="status">
                        <option value="">전체</option>
                        <option value="paid"     ${param.status == 'paid' ? 'selected' : ''}>결제완료</option>
                        <option value="partial"  ${param.status == 'partial' ? 'selected' : ''}>부분환불</option>
                        <option value="refunded" ${param.status == 'refunded' ? 'selected' : ''}>전체환불</option>
                    </select>
                </div>
            </c:if>

            <c:if test="${viewType eq 'lecture'}">
                <div class="filter-row">
                    <label>강의명</label>
                    <input type="text" name="lectureTitle" value="${param.lectureTitle}">
                </div>
                <div class="filter-row">
                    <label>강사명</label>
                    <input type="text" name="lectureAuthor" value="${param.lectureAuthor}">
                </div>
            </c:if>

            <div class="filter-btn-row">
                <button type="submit" class="filter-btn search">검색</button>
                <a href="${pageContext.request.contextPath}/admin/adminPaymentList?viewType=${viewType}" class="filter-btn reset">초기화</a>
            </div>

        </form>

    </div>



    <%-- ======================================================
         📌 리스트 테이블
    ======================================================= --%>
    <div class="table-container">

        <table>
            <thead>
            <tr>
                <c:choose>
                    <c:when test="${viewType eq 'payment'}">
                        <th>결제번호</th>
                        <th>주문번호</th>
                        <th>회원명</th>
                        <th>결제금액</th>
                        <th>강의수</th>
                        <th>상태</th>
                        <th>결제일</th>
                    </c:when>

                    <c:otherwise>
                        <th>강의명</th>
                        <th>강사명</th>
                        <th>구매회원</th>
                        <th>판매가</th>
                        <th>상태</th>
                        <th>결제일</th>
                    </c:otherwise>
                </c:choose>
            </tr>
            </thead>

            <tbody>

            <c:if test="${empty list}">
                <tr><td colspan="7" class="empty-message">검색 결과가 없습니다.</td></tr>
            </c:if>

            <c:forEach var="item" items="${list}">

                <tr>
                    <c:choose>

                        <%-- ============================
                             📌 결제건별 보기
                        ============================ --%>
                        <c:when test="${viewType eq 'payment'}">

                            <td>${item.payment.payment_id}</td>
                            <td>${item.payment.merchant_uid}</td>
                            <td>${item.user.user_name}</td>

                            <td>
                                ₩ <fmt:formatNumber value="${item.payment.amount}" pattern="#,###"/>
                            </td>

                            <td>${item.lectureCount}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.payment.status eq 'paid'}">
                                        <span class="badge paid">결제완료</span>
                                    </c:when>
                                    <c:when test="${item.payment.status eq 'partial'}">
                                        <span class="badge partial">부분환불</span>
                                    </c:when>
                                    <c:when test="${item.payment.status eq 'refunded'}">
                                        <span class="badge refunded">환불완료</span>
                                    </c:when>
                                </c:choose>
                            </td>

                            <td><fmt:formatDate value="${item.payment.created_at}" pattern="yyyy-MM-dd HH:mm"/></td>

                        </c:when>



                        <%-- ============================
                             📌 강의별 보기
                        ============================ --%>
                        <c:otherwise>

                            <td>${item.lecture.lecture_title}</td>
                            <td>${item.lecture.lecture_author}</td>
                            <td>${item.user.user_name}</td>

                            <td>
                                ₩ <fmt:formatNumber value="${item.detail.sale_price}" pattern="#,###"/>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.detail.status eq 'paid'}">
                                        <span class="badge paid">결제완료</span>
                                    </c:when>
                                    <c:when test="${item.detail.status eq 'refunded'}">
                                        <span class="badge refunded">환불완료</span>
                                    </c:when>
                                </c:choose>
                            </td>

                            <td><fmt:formatDate value="${item.detail.created_at}" pattern="yyyy-MM-dd HH:mm"/></td>

                        </c:otherwise>

                    </c:choose>
                </tr>

            </c:forEach>

            </tbody>
        </table>


        <%-- 페이지네이션 --%>
        <div class="pagination">

            <c:if test="${pageVO.currentPage > 1}">
                <a href="?pageNum=1&viewType=${viewType}">[처음]</a>
            </c:if>

            <c:if test="${pageVO.startPage > pageVO.pageBlock}">
                <a href="?pageNum=${pageVO.startPage - pageVO.pageBlock}&viewType=${viewType}">[이전]</a>
            </c:if>

            <c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}">
                <c:choose>
                    <c:when test="${i == pageVO.currentPage}">
                        <a class="active">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="?pageNum=${i}&viewType=${viewType}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${pageVO.endPage < pageVO.pageCount}">
                <a href="?pageNum=${pageVO.startPage + pageVO.pageBlock}&viewType=${viewType}">[다음]</a>
            </c:if>

            <c:if test="${pageVO.currentPage < pageVO.pageCount}">
                <a href="?pageNum=${pageVO.pageCount}&viewType=${viewType}">[끝]</a>
            </c:if>

        </div>

    </div>

</main>
</body>
</html>
