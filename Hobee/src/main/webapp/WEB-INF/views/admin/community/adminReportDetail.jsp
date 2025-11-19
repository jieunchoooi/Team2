<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 상세</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminReportDetail.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="reportList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>📛 신고 상세</h2>

    <!-- 상단 신고 정보 카드 -->
    <div class="post-info-card">
        <div class="post-info-title">📌 신고 대상 정보</div>

        <div style="margin-top:8px;">
            <c:choose>
                <c:when test="${report.post_id ne null}">
                    게시글 신고 (#${report.post_id})
                </c:when>
                <c:otherwise>
                    댓글 신고 (#${report.comment_id})
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 상세 테이블 -->
    <table style="width:100%; border-collapse:collapse;">
        <tbody>

            <tr>
                <td class="info-label">신고 번호</td>
                <td>${report.report_id}</td>
            </tr>

            <tr>
                <td class="info-label">신고자</td>
                <td>${report.reporter_id}</td>
            </tr>

            <tr>
                <td class="info-label">신고일</td>
                <td>${report.created_at}</td>
            </tr>

            <tr>
                <td class="info-label">신고 사유</td>
                <td>
                    <div class="reason-box">${report.reason}</div>
                </td>
            </tr>

           
            <tr>
                <td class="info-label" style="vertical-align:top;">대상 내용</td>
                <td>

                    <c:choose>

                      
                        <c:when test="${report.post_id ne null}">
                            <div class="comment-box">
                                <b style="color:#4a6cf7;">📌 게시글 제목</b><br><br>
                                ${report.post_title}
                            </div>
                        </c:when>

                      
                        <c:otherwise>
                            <div class="comment-box">
                                <b style="color:#4a6cf7;">📌 댓글 내용</b><br><br>
                                ${report.comment_content}
                            </div>
                        </c:otherwise>

                    </c:choose>

                </td>
            </tr>

        </tbody>
    </table>

    <!-- 버튼 구역 -->
    <div style="text-align:right; margin-top:30px;">

        <!-- 처리 완료 여부 -->
        <c:choose>
            <c:when test="${report.is_done == 1}">
                <button class="btn-blue" disabled>처리 완료됨</button>
            </c:when>

            <c:otherwise>
                <form action="${pageContext.request.contextPath}/admin/adminReportDone"
                      method="post" style="display:inline-block;"
                      onsubmit="return confirm('신고를 처리 완료로 변경할까요?');">

                    <input type="hidden" name="report_id" value="${report.report_id}">
                    <button class="btn-blue">처리 완료</button>
                </form>
            </c:otherwise>
        </c:choose>

        <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminReportList'">
            목록
        </button>

    </div>

</div>
</div>

</body>
</html>
