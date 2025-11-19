<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- 공지 목록 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeList.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="noticeList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>📢 공지사항 관리</h2>

    <!-- 글쓰기 버튼 -->
    <div style="text-align:right; margin-bottom:15px;">
        <button class="btn-blue"
            onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeWrite'">
            + 공지 작성
        </button>
    </div>

    <table style="width:100%; border-collapse:collapse;">
        <thead>
            <tr>
                <th width="60">No</th>
                <th>제목</th>
                <th width="120">작성자</th>
                <th width="150">등록일</th>
                <th width="80">조회</th>
                <th width="100">공개</th>
                <th width="80">수정</th>
                <th width="80">삭제</th>
            </tr>
        </thead>

        <tbody>

        <!-- 목록 없을 때 -->
        <c:if test="${empty noticeList}">
            <tr>
                <td colspan="8" style="padding:20px; text-align:center;">
                    등록된 공지사항이 없습니다.
                </td>
            </tr>
        </c:if>

        <c:forEach var="n" items="${noticeList}">
            <tr>
                <td>${n.notice_id}</td>

                <!-- 제목 클릭 → 상세페이지 -->
                <td>
                    <a href="${pageContext.request.contextPath}/admin/adminNoticeDetail?notice_id=${n.notice_id}"
                       style="color:#2f6bff; font-weight:600; text-decoration:none;">
                       ${n.title}
                    </a>
                </td>

                <td>${n.admin_id}</td>
                <td>${n.created_at}</td>
                <td>${n.view_count}</td>

                <!-- 공개/숨김 -->
                <td>
                    <form action="${pageContext.request.contextPath}/admin/adminNoticeVisible" method="post">
                        <input type="hidden" name="notice_id" value="${n.notice_id}">
                        <input type="hidden" name="is_visible" value="${n.is_visible == 1 ? 0 : 1}">

                        <button class="${n.is_visible == 1 ? 'btn-blue' : 'btn-gray'}">
                            ${n.is_visible == 1 ? '공개' : '숨김'}
                        </button>
                    </form>
                </td>

                <!-- 수정 -->
                <td>
                    <button class="btn-blue"
                            onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeEdit?notice_id=${n.notice_id}'">
                        수정
                    </button>
                </td>

                <!-- 삭제 -->
                <td>
                    <form action="${pageContext.request.contextPath}/admin/adminNoticeDelete"
                          method="post"
                          onsubmit="return confirm('정말 삭제하시겠습니까?');">
                        <input type="hidden" name="notice_id" value="${n.notice_id}">
                        <button class="btn-red">삭제</button>
                    </form>
                </td>

            </tr>
        </c:forEach>

        </tbody>
    </table>

</div>
</div>

</body>
</html>
