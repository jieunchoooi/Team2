<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 | Hobee</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/notice.css">

    <style>
        /* ---- 기본 카드 스타일 ---- */
        .notice-container {
            max-width: 1050px;
            margin: 40px auto;
            padding: 20px;
        }

        .notice-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .notice-card {
            background: #fff;
            border-radius: 14px;
            padding: 22px 28px;
            margin-bottom: 16px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.07);
            transition: 0.2s ease;
        }

        .notice-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 14px rgba(0,0,0,0.12);
        }

        .notice-link {
            font-size: 18px;
            font-weight: 600;
            color: #222;
            text-decoration: none;
        }

        /* 중요도 배지 */
        .badge-important {
            background: #ff3b3b;
            color: #fff;
            font-size: 12px;
            font-weight: 600;
            padding: 3px 7px;
            border-radius: 6px;
            margin-left: 6px;
        }

        .notice-info {
            font-size: 14px;
            color: #777;
            margin-top: 8px;
        }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="notice-container">

    <div class="notice-title">📢 공지사항</div>

    <c:choose>


        <c:when test="${empty noticeList}">
            <p>등록된 공지사항이 없습니다.</p>
        </c:when>


        <c:otherwise>

            <c:forEach var="n" items="${noticeList}">
                <div class="notice-card">

                    <a class="notice-link"
                       href="${pageContext.request.contextPath}/notice/detail?notice_id=${n.notice_id}">

                        ${n.title}

                        <!-- priority: 1=일반, 2=중요, 3=긴급 -->
                        <c:choose>
                            <c:when test="${n.priority == 3}">
                                <span class="badge-important">긴급</span>
                            </c:when>
                            <c:when test="${n.priority == 2}">
                                <span class="badge-important">중요</span>
                            </c:when>
                        </c:choose>
                    </a>


                    <div class="notice-info">
                        등록일 :
                        <c:out value="${fn:substring(n.created_at, 0, 10)}"/>
                        · 조회수 : ${n.view_count}
                    </div>

                </div>
            </c:forEach>

        </c:otherwise>

    </c:choose>

</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

</body>
</html>
