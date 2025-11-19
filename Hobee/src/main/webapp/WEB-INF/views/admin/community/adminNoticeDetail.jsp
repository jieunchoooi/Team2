<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 상세</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- 공지 상세 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeDetail.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="noticeList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>📢 공지 상세</h2>

    <!-- 상단 정보 카드 (댓글/신고 상세 디자인과 동일) -->
    <div class="post-info-card">
        <div class="post-info-title">📌 공지 정보</div>
        <div style="margin-top:8px; color:#556;">
            작성자: <b>${notice.admin_id}</b>
        </div>
    </div>

    <table style="width:100%; border-collapse:collapse;">
        <tbody>

            <tr>
                <td class="info-label">공지 번호</td>
                <td>${notice.notice_id}</td>
            </tr>

            <tr>
                <td class="info-label">제목</td>
                <td>${notice.title}</td>
            </tr>

            <tr>
                <td class="info-label">작성자</td>
                <td>${notice.admin_id}</td>
            </tr>

            <tr>
                <td class="info-label">작성일</td>
                <td>${notice.created_at}</td>
            </tr>

            <tr>
                <td class="info-label">조회수</td>
                <td>${notice.view_count}</td>
            </tr>

            <tr>
                <td class="info-label">공개 여부</td>
                <td>
                    <span class="${notice.is_visible == 1 ? 'visible-on' : 'visible-off'}">
                        ${notice.is_visible == 1 ? '공개' : '숨김'}
                    </span>
                </td>
            </tr>

            <tr>
                <td class="info-label" style="vertical-align:top;">내용</td>
                <td>
                    <div class="notice-box">${notice.content}</div>
                </td>
            </tr>

        </tbody>
    </table>

    <!-- 버튼들 -->
    <div style="text-align:right; margin-top:30px;">

        <!-- 수정 -->
        <button class="btn-blue"
            onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeEdit?notice_id=${notice.notice_id}'">
            수정
        </button>

        <!-- 삭제 -->
        <form action="${pageContext.request.contextPath}/admin/adminNoticeDelete"
              method="post"
              style="display:inline-block;"
              onsubmit="return confirm('정말 삭제하시겠습니까?');">

            <input type="hidden" name="notice_id" value="${notice.notice_id}">
            <button class="btn-red">삭제</button>
        </form>

        <!-- 목록 -->
        <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeList'">
            목록으로
        </button>

    </div>

</div>
</div>

</body>
</html>
