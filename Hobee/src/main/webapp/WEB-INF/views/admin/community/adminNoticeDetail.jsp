<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 상세 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeDetail.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header">
        <h1>공지 상세</h1>
    </div>

    <div class="detail-card">

        <div class="detail-row">
            <span class="detail-label">공지 번호</span>
            <span class="detail-value">${notice.notice_id}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">제목</span>
            <span class="detail-value">${notice.title}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">작성자</span>
            <span class="detail-value">${notice.admin_id}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">작성일</span>
            <span class="detail-value">${notice.created_at}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">조회수</span>
            <span class="detail-value">${notice.view_count}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">공개 여부</span>
            <span class="detail-value">
                <span class="${notice.is_visible == 1 ? 'visible-on' : 'visible-off'}">
                    ${notice.is_visible == 1 ? '공개' : '숨김'}
                </span>
            </span>
        </div>

        <div class="detail-row">
            <span class="detail-label" style="vertical-align:top;">내용</span>
            <div class="detail-content-area">${notice.content}</div>
        </div>

        <c:if test="${!empty files}">
            <div class="detail-row">
                <span class="detail-label">첨부파일</span>
                <div class="detail-value">
                    <c:forEach var="f" items="${files}">
                        <a href="${pageContext.request.contextPath}/admin/fileDownload?file=${f.file_name}">
                            📎 ${f.file_name}
                        </a><br>
                    </c:forEach>
                </div>
            </div>
        </c:if>


        <div class="btn-area">

            <!-- ⭐ 상세에서 공개/숨김 토글 -->
            <form action="${pageContext.request.contextPath}/admin/adminNoticeVisibleDetail"
                  method="post"
                  style="display:inline-block">
                <input type="hidden" name="notice_id" value="${notice.notice_id}">
                <input type="hidden" name="is_visible" value="${notice.is_visible == 1 ? 0 : 1}">
                <button class="${notice.is_visible == 1 ? 'btn-gray' : 'btn-blue'}">
                    ${notice.is_visible == 1 ? '숨김으로 변경' : '공개로 변경'}
                </button>
            </form>

            <!-- ⭐ 상세에서 PIN 고정 / 해제 -->
            <form action="${pageContext.request.contextPath}/admin/adminNoticePinnedDetail"
                  method="post" style="display:inline-block">
                <input type="hidden" name="notice_id" value="${notice.notice_id}">
                <input type="hidden" name="is_pinned" value="${notice.is_pinned == 1 ? 0 : 1}">
                <button class="${notice.is_pinned == 1 ? 'btn-orange' : 'btn-gray'}">
                    ${notice.is_pinned == 1 ? '고정 해제' : '상단 고정'}
                </button>
            </form>

            <!-- 수정 -->
            <button class="btn-blue"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeEdit?notice_id=${notice.notice_id}'">
                수정
            </button>

            <!-- 삭제 -->
            <form action="${pageContext.request.contextPath}/admin/adminNoticeDelete"
                  method="post"
                  style="display:inline-block"
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

</main>

</body>
</html>
