<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>신고 관리</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminReportList.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<div class="admin-container">

    <div class="admin-card">

        <h2>🚨 신고 관리</h2>

        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>신고자</th>
                    <th>대상자</th>
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
                    <td colspan="9" style="padding:20px; text-align:center;">
                        등록된 신고가 없습니다.
                    </td>
                </tr>
            </c:if>

            <c:forEach var="r" items="${reportList}">
                <tr>
                    <td>${r.report_id}</td>
                    <td>${r.reporter_id}</td>
                    <td>
   						 <c:choose>
       						 <c:when test="${r.post_id != null}">
           						 게시글 #${r.post_id}
        					</c:when>
       					    <c:when test="${r.comment_id != null}">
            					댓글 #${r.comment_id}
        				</c:when>
        				<c:otherwise>
           						 -
        				</c:otherwise>
    				</c:choose>
				  </td>

                    <td>${r.reason}</td>
                    <td>${r.created_at}</td>

                    <td>
                        <span class="badge ${r.is_done == 1 ? 'badge-green' : 'badge-red'}">
                            ${r.is_done == 1 ? '완료' : '대기'}
                        </span>
                    </td>

                    <td>
                        <button class="btn-blue"
                            onclick="location.href='${pageContext.request.contextPath}/admin/adminReportDetail?report_id=${r.report_id}'">
                            상세
                        </button>
                    </td>

                    <td>
                        <c:if test="${r.is_done == 0}">
                            <form action="${pageContext.request.contextPath}/admin/adminReportDone" method="post" style="display:inline;">
                                <input type="hidden" name="report_id" value="${r.report_id}">
                                <button class="btn-gray">처리</button>
                            </form>
                        </c:if>

                        <c:if test="${r.is_done == 1}">
                            <button class="btn-gray" disabled>완료됨</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>

    </div>
</div>

</body>
</html>
