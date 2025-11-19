<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 작성</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- 공지 작성 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeWrite.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="noticeList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>📝 공지사항 작성</h2>

    <form action="${pageContext.request.contextPath}/admin/adminNoticeWritePro" method="post">

        <table class="write-table">
            <tbody>

                <!-- 제목 -->
                <tr>
                    <td class="write-label">제목</td>
                    <td>
                        <input type="text" name="title" class="write-input" required>
                    </td>
                </tr>

                <!-- 작성자: 로그인 연동 시 세션에서 가져오지만 지금은 고정 -->
                <tr>
                    <td class="write-label">작성자</td>
                    <td>
                        <input type="text" name="admin_id" value="admin" class="write-input" readonly>
                    </td>
                </tr>

                <!-- 공개 여부 -->
                <tr>
                    <td class="write-label">공개 여부</td>
                    <td>
                        <select name="is_visible" class="write-select">
                            <option value="1">공개</option>
                            <option value="0">숨김</option>
                        </select>
                    </td>
                </tr>

                <!-- 내용 -->
                <tr>
                    <td class="write-label" style="vertical-align:top;">내용</td>
                    <td>
                        <textarea name="content" class="write-textarea" required></textarea>
                    </td>
                </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="write-btn-area">
            <button type="submit" class="btn-blue">등록하기</button>
            <button type="button" class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeList'">
                목록
            </button>
        </div>

    </form>

</div>
</div>

</body>
</html>
