<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 관리</title>

    <!-- 공통 관리자 레이아웃 -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- 신고관리 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminReportList.css">
</head>

<body>

    <!-- 공통 사이드바 -->
    <jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

    <!-- 메인 content -->
    <div class="admin-main">

        <div class="admin-card">

            <h2>🚨 신고 관리</h2>

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

                <!-- 신고 목록 없을 때 -->
                <c:if test="${empty reportList}">
                    <tr>
                        <td colspan="8" style="text-align:center; padding:20px;">
                            등록된 신고가 없습니다.
                        </td>
                    </tr>
                </c:if>

                <!-- 신고 목록 있을 때 -->
                <c:forEach var="r" items="${reportList}">
                    <tr>

                        <!-- 신고자 -->
                        <td>${r.reporter_id}</td>

                        <!-- 신고 대상 -->
                        <td>
                            <c:choose>
                                <c:when test="${r.post_id ne null}">
                                    게시글 #${r.post_id}
                                </c:when>
                                <c:when test="${r.comment_id ne null}">
                                    댓글 #${r.comment_id}
                                </c:when>
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

                        <!-- 날짜 -->
                        <td>${r.created_at}</td>

                        <!-- 상태 배지 -->
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

                        <!-- 상세 버튼 -->
                        <td>
                            <button class="btn-blue"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminReportDetail?report_id=${r.report_id}'">
                                상세
                            </button>
                        </td>

                        <!-- 처리 버튼 -->
                        <td>
                            <c:choose>

                                <%-- 이미 처리된 신고 --%>
                                <c:when test="${r.is_done == 1}">
                                    <button class="btn-gray" disabled>완료</button>
                                </c:when>

                                <%-- 처리되지 않은 신고 --%>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/admin/adminReportDone"
                                          method="post"
                                          onsubmit="return confirm('해당 신고를 처리 완료로 변경하시겠습니까?');">
                                        <input type="hidden" name="report_id" value="${r.report_id}">
                                        <button type="submit" class="btn-red">처리</button>
                                    </form>
                                </c:otherwise>

                            </c:choose>
                        </td>

                    </tr>
                </c:forEach>

                </tbody>
            </table>

        </div>
    </div>

</body>
</html>
