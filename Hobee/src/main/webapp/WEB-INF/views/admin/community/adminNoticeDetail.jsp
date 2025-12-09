<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 통일된 상세 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeDetail.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <!-- 📌 1400px 중앙 고정 컨테이너 -->
    <div class="center-wrapper">

        <!-- 📌 상세 카드 -->
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

            <!-- 공개 여부 -->
            <div class="detail-row">
                <span class="detail-label">공개 여부</span>
                <span class="detail-value">
                    <span class="${notice.is_visible == 1 ? 'visible-on' : 'visible-off'}">
                        ${notice.is_visible == 1 ? '공개' : '숨김'}
                    </span>
                </span>
            </div>

            <!-- 중요도 -->
            <div class="detail-row">
                <span class="detail-label">중요도</span>
                <span class="detail-value">
                    <span class="priority-badge 
                        ${notice.priority == 4 ? 'p-4' :
                          notice.priority == 3 ? 'p-3' :
                          notice.priority == 2 ? 'p-2' : 'p-1'}">

                        <c:choose>
                            <c:when test="${notice.priority == 4}">긴급</c:when>
                            <c:when test="${notice.priority == 3}">매우 중요</c:when>
                            <c:when test="${notice.priority == 2}">중요</c:when>
                            <c:otherwise>일반</c:otherwise>
                        </c:choose>

                    </span>
                </span>
            </div>

            <!-- 게시일 -->
            <div class="detail-row">
                <span class="detail-label">게시 시작일</span>
                <span class="detail-value">${notice.start_date}</span>
            </div>

            <div class="detail-row">
                <span class="detail-label">게시 종료일</span>
                <span class="detail-value">
                    ${notice.end_date == null ? '제한 없음' : notice.end_date}
                </span>
            </div>

            <!-- 내용 -->
            <div class="detail-row content-full">
                <span class="detail-label" style="vertical-align:top;">내용</span>
                <div class="detail-content-area">${notice.content}</div>
            </div>

            <!-- 첨부파일 -->
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

            <!-- 버튼 영역 -->
            <div class="btn-area">

                <!-- 공개/숨김 -->
                <form action="${pageContext.request.contextPath}/admin/adminNoticeVisibleDetail"
                      method="post" style="display:inline-block">
                    <input type="hidden" name="notice_id" value="${notice.notice_id}">
                    <input type="hidden" name="is_visible" value="${notice.is_visible == 1 ? 0 : 1}">
                    <button class="${notice.is_visible == 1 ? 'btn-gray' : 'btn-blue'}">
                        ${notice.is_visible == 1 ? '숨김으로 변경' : '공개로 변경'}
                    </button>
                </form>

                <!-- PIN -->
                <form action="${pageContext.request.contextPath}/admin/adminNoticePinnedDetail"
                      method="post" style="display:inline-block">
                    <input type="hidden" name="notice_id" value="${notice.notice_id}">
                    <input type="hidden" name="is_pinned" value="${notice.is_pinned == 1 ? 0 : 1}">
                    <button class="${notice.is_pinned == 1 ? 'btn-orange' : 'btn-gray'}">
                        ${notice.is_pinned == 1 ? '고정 해제' : '상단 고정'}
                    </button>
                </form>

                <!-- 수정 -->
                <button class="btn-edit"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeEdit?notice_id=${notice.notice_id}'">
                    수정
                </button>

                <!-- 삭제 -->
                <form action="${pageContext.request.contextPath}/admin/adminNoticeDelete"
                      method="post" style="display:inline-block"
                      onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="notice_id" value="${notice.notice_id}">
                    <button class="btn-red">삭제</button>
                </form>

                <!-- 목록 -->
                <button class="btn-list"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeList'">
                    목록으로
                </button>

            </div>

        </div>

    </div>

</main>

</body>
</html>
