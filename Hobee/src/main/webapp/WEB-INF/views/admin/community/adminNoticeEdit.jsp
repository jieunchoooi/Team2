<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 수정</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- 공지 수정 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeEdit.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="noticeList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>✏️ 공지사항 수정</h2>

    <form action="${pageContext.request.contextPath}/admin/adminNoticeEditPro" method="post">

        <!-- 수정 시 반드시 notice_id 필요 -->
        <input type="hidden" name="notice_id" value="${notice.notice_id}">

        <table class="edit-table">
            <tbody>

                <!-- 제목 -->
                <tr>
                    <td class="edit-label">제목</td>
                    <td>
                        <input type="text" name="title"
                               class="edit-input"
                               value="${notice.title}" required>
                    </td>
                </tr>

                <!-- 작성자 -->
                <tr>
                    <td class="edit-label">작성자</td>
                    <td>
                        <input type="text" name="admin_id"
                               value="${notice.admin_id}"
                               class="edit-input" readonly>
                    </td>
                </tr>

                <!-- 공개 여부 -->
                <tr>
                    <td class="edit-label">공개 여부</td>
                    <td>
                        <select name="is_visible" class="edit-select">
                            <option value="1" ${notice.is_visible == 1 ? "selected" : ""}>공개</option>
                            <option value="0" ${notice.is_visible == 0 ? "selected" : ""}>숨김</option>
                        </select>
                    </td>
                </tr>

                <!-- 내용 -->
                <tr>
                    <td class="edit-label" style="vertical-align:top;">내용</td>
                    <td>
                        <textarea name="content" class="edit-textarea" required>
${notice.content}</textarea>
                    </td>
                </tr>

            </tbody>
        </table>

        <!-- 버튼 영역 -->
        <div class="edit-btn-area">
            <button type="submit" class="btn-blue">수정 완료</button>

            <button type="button" class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeDetail?notice_id=${notice.notice_id}'">
                상세로
            </button>
        </div>

    </form>

</div>
</div>

</body>
</html>
