<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 관리 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminReportList.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 🔥 제목은 왼쪽 정렬 + 전체 1200px 가운데 위치 -->
    <div class="page-title-wrapper">
        <h1 class="page-title">신고 관리</h1>
    </div>

    <!-- 🔥 모든 컨텐츠 가운데 정렬 -->
    <div class="center-wrapper">

        <!-- 통계 박스 -->
        <div class="stats-box">
            <div class="stat-card">
                <div class="stat-title">전체 신고</div>
                <div class="stat-value">${stats.total} 건</div>
            </div>

            <div class="stat-card">
                <div class="stat-title">이번달 신고</div>
                <div class="stat-value">${stats.month} 건</div>
            </div>

            <div class="stat-card">
                <div class="stat-title">게시글 신고</div>
                <div class="stat-value">${stats.post} 건</div>
            </div>

            <div class="stat-card">
                <div class="stat-title">댓글 신고</div>
                <div class="stat-value">${stats.comment} 건</div>
            </div>
        </div>

        <!-- 🔎 필터 박스 -->
        <div class="filter-box">
            <form method="get" action="${pageContext.request.contextPath}/admin/adminReportList">

                <select name="type" class="filter-select">
                    <option value="">전체 유형</option>
                    <option value="post" ${param.type == 'post' ? 'selected' : ''}>게시글</option>
                    <option value="comment" ${param.type == 'comment' ? 'selected' : ''}>댓글</option>
                </select>

                <select name="status" class="filter-select">
                    <option value="">전체 상태</option>
                    <option value="wait" ${param.status == 'wait' ? 'selected' : ''}>대기</option>
                    <option value="done" ${param.status == 'done' ? 'selected' : ''}>완료</option>
                </select>

                <button type="submit" class="btn-blue">필터 적용</button>
            </form>
        </div>

        <!-- 📄 테이블 박스 -->
        <div class="table-card">

            <table class="admin-table">
                <thead>
                <tr>
                    <th>신고자</th>
                    <th>대상</th>
                    <th>유형</th>
                    <th>신고 내용</th>
                    <th>신고일</th>
                    <th>상태</th>
                    <th>상세</th>
                    <th>처리</th>
                </tr>
                </thead>

                <tbody>

                <c:if test="${empty reportList}">
                    <tr>
                        <td colspan="8" class="empty-text">등록된 신고가 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="r" items="${reportList}">
                    <tr>

                        <td>${r.reporter_id}</td>

                        <td>
                            <c:choose>
                                <c:when test="${r.post_id ne null}">게시글 #${r.post_id}</c:when>
                                <c:when test="${r.comment_id ne null}">댓글 #${r.comment_id}</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${r.post_id ne null}">게시글</c:when>
                                <c:when test="${r.comment_id ne null}">댓글</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>

                        <td class="reason-cell" title="${r.reason}">
                            ${r.reason}
                        </td>

                        <td>${r.created_at}</td>

                        <td>
                            <c:choose>
                                <c:when test="${r.is_done == 1}">
                                    <span class="status-badge done">완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge wait">대기</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <button class="btn-blue"
                                    onclick="location.href='${pageContext.request.contextPath}/admin/adminReportDetail?report_id=${r.report_id}'">
                                상세
                            </button>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${r.is_done == 1}">
                                    <button class="btn-gray" disabled>완료</button>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/admin/adminReportDone"
                                          method="post"
                                          onsubmit="return confirm('신고 처리 완료로 변경하시겠습니까?');">
                                        <input type="hidden" name="report_id" value="${r.report_id}">
                                        <button class="btn-red">처리</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>

                    </tr>
                </c:forEach>

                </tbody>
            </table>

            <div class="pagination">

                <c:if test="${currentPage > 1}">
                    <a class="page-btn"
                       href="${pageContext.request.contextPath}/admin/adminReportList?currentPage=${currentPage - 1}&type=${type}&status=${status}">
                        ◀ 이전
                    </a>
                </c:if>

                <c:forEach begin="1" end="${totalPage}" var="i">
                    <a class="page-btn"
                       href="${pageContext.request.contextPath}/admin/adminReportList?currentPage=${i}&type=${type}&status=${status}"
                       style="${i == currentPage ? 'background:#397dff;color:#fff;' : ''}">
                        ${i}
                    </a>
                </c:forEach>

                <c:if test="${currentPage < totalPage}">
                    <a class="page-btn"
                       href="${pageContext.request.contextPath}/admin/adminReportList?currentPage=${currentPage + 1}&type=${type}&status=${status}">
                        다음 ▶
                    </a>
                </c:if>

            </div>

        </div> <!-- table-card 끝 -->

    </div> <!-- center-wrapper 끝 -->

</main>

</body>
</html>
