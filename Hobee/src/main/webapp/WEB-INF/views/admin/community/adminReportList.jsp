<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 관리 | Hobee Admin</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 신고관리 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminReportList.css">
</head>

<body>

<!-- 공통 상단 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 공통 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 콘텐츠 영역 -->
<main class="main-content">

    <div class="main-header">
        <h1>신고 관리</h1>
    </div>

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
                    <td colspan="8" class="empty-text">
                        등록된 신고가 없습니다.
                    </td>
                </tr>
            </c:if>

            <c:forEach var="r" items="${reportList}">
                <tr>
                    <td>${r.reporter_id}</td>

                    <!-- 신고 대상 -->
                    <td>
                        <c:choose>
                            <c:when test="${r.post_id ne null}">게시글 #${r.post_id}</c:when>
                            <c:when test="${r.comment_id ne null}">댓글 #${r.comment_id}</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>

                    <!-- 유형 -->
                    <td>
                        <c:choose>
                            <c:when test="${r.post_id ne null}">게시글</c:when>
                            <c:when test="${r.comment_id ne null}">댓글</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>

                    <!-- 신고 내용 -->
                    <td>${r.reason}</td>

                    <td>${r.created_at}</td>

                    <!-- 상태 -->
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

                    <!-- 상세 -->
                    <td>
                        <button class="btn-blue"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminReportDetail?report_id=${r.report_id}'">
                            상세
                        </button>
                    </td>

                    <!-- 처리 -->
                    <td>
                        <c:choose>
                            <c:when test="${r.is_done == 1}">
                                <button class="btn-gray" disabled>완료</button>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/admin/adminReportDone"
                                      method="post"
                                      onsubmit="return confirm('해당 신고를 처리 완료로 변경하시겠습니까?');">
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

    </div>

</main>
</body>
</html>
