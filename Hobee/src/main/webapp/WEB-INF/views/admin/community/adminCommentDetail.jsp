<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCommentDetail.css">

    <style>
        /* 신고 색상 배지 */
        .badge {
            padding: 5px 12px;
            border-radius: 16px;
            font-size: 13px;
            font-weight: 600;
            color: #fff;
        }
        .badge.green { background: #4CAF50; }
        .badge.yellow { background: #FFB300; }
        .badge.red { background: #E53935; }

        /* 내용 박스 줄바꿈 유지 */
        .content-box {
            white-space: pre-line;
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 10px;
            background: #fafafa;
            line-height: 1.6;
            margin-top: 10px;
        }

        /* 버튼 스타일 */
        .btn-area {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }
        .btn-back, .btn-blue, .btn-delete {
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            border: none;
        }
        .btn-back { background: #555; color: #fff; }
        .btn-blue { background: #397dff; color: #fff; }
        .btn-delete { background: #e74a3b; color: #fff; }
        .btn-blue:hover { background: #2f67d4; }
        .btn-delete:hover { background: #cf2f23; }

        .label { width: 140px; font-weight: 700; color: #333; }
        .detail-row {
            display: flex;
            margin-bottom: 15px;
            font-size: 15px;
        }

        .value { color: #444; }
        .title-link { color: #397dff; font-weight: 600; text-decoration: none; }
        .title-link:hover { text-decoration: underline; }

    </style>
</head>

<body>

<!-- 공통 상단 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- 메인 콘텐츠 -->
<main class="main-content">

    <div class="detail-card">

        <div class="detail-row">
            <span class="label">댓글 ID</span>
            <span class="value">${comment.comment_id}</span>
        </div>

        <div class="detail-row">
            <span class="label">게시글 제목</span>
            <span class="value">
                <a class="title-link"
                   href="${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${comment.post_id}">
                    ${comment.post_title}
                </a>
            </span>
        </div>

        <div class="detail-row">
            <span class="label">작성자</span>
            <span class="value">${comment.user_name}</span>
        </div>

        <div class="detail-row">
            <span class="label">등록일</span>
            <span class="value">${comment.created_at}</span>
        </div>

        <!-- 신고 횟수 3단계 색상 -->
        <div class="detail-row">
            <span class="label">신고 횟수</span>
            <span class="value">
                <c:choose>
                    <c:when test="${comment.report_count == 0}">
                        <span class="badge green">${comment.report_count}</span>
                    </c:when>
                    <c:when test="${comment.report_count <= 2}">
                        <span class="badge yellow">${comment.report_count}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge red">${comment.report_count}</span>
                    </c:otherwise>
                </c:choose>
            </span>
        </div>

        <!-- 내용 -->
        <div class="detail-content">
            <h3>내용</h3>
            <div class="content-box">
                ${fn:escapeXml(comment.content)}
            </div>
        </div>

        <!-- 🚨 신고 상세내역 -->
        <div class="detail-content" style="margin-top:30px;">
            <h3>신고 내역</h3>

            <c:if test="${empty reportList}">
                <div class="content-box" style="background:#fff7f7; border:1px solid #ffd1d1;">
                    신고 내역이 없습니다.
                </div>
            </c:if>

            <c:forEach var="r" items="${reportList}">
                <div class="content-box" style="margin-bottom:15px; background:#f7f9ff; border:1px solid #dce3ff;">
                    <p><b>신고자:</b> ${r.reporter_id}</p>
                    <p><b>사유:</b> ${r.reason}</p>
                    <p><b>신고 일시:</b> ${r.created_at}</p>
                </div>
            </c:forEach>
        </div>

        <!-- 🔥 관리자 조치 로그 -->
        <div style="margin-top:30px;">
            <h3>관리자 처리 로그</h3>

            <c:if test="${empty actionLogs}">
                <div class="content-box" style="background:#fff3cd; border:1px solid #ffeeba;">
                    관리자 조치 이력이 없습니다.
                </div>
            </c:if>

            <c:forEach var="log" items="${actionLogs}">
                <div class="content-box" style="margin-bottom:12px;">
                    <p><b>관리자:</b> ${log.admin_id}</p>
                    <p><b>조치:</b> ${log.action}</p>
                    <p><b>사유:</b> ${log.reason}</p>
                    <p><b>일시:</b> ${log.created_at}</p>
                </div>
            </c:forEach>
        </div>


        <!-- 버튼 영역 -->
        <div class="btn-area">

            <button class="btn-back"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList'">
                목록으로
            </button>

            <button class="btn-blue"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminPostDetail?post_id=${comment.post_id}'">
                게시글 보기
            </button>

            <!-- 댓글 삭제 버튼 -->
            <c:if test="${comment.is_deleted == 0}">
                <form action="${pageContext.request.contextPath}/admin/adminCommentDelete"
                      method="post"
                      onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="comment_id" value="${comment.comment_id}">
                    <button class="btn-delete">댓글 삭제</button>
                </form>
            </c:if>

            <!-- ⭐ 삭제된 댓글일 경우 "복구하기" 표시 -->
            <c:if test="${comment.is_deleted == 1}">
                <form action="${pageContext.request.contextPath}/admin/adminCommentRestore" method="post"
                      onsubmit="return confirm('댓글을 복구하시겠습니까?');">
                    <input type="hidden" name="comment_id" value="${comment.comment_id}">
                    <button class="btn-green">복구하기</button>
                </form>
            </c:if>

        </div>

    </div>

</main>

</body>
</html>
