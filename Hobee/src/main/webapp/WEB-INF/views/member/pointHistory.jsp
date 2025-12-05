<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>포인트 내역 | Hobee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/pointHistory.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/profileCard.css">

<script>
/* ===========================
   텍스트 라인 필터
=========================== */
function filterType(type) {

    const rows = document.querySelectorAll("#pointTable tbody tr");
    const items = document.querySelectorAll(".filter-item");

    items.forEach(item => item.classList.remove("active"));

    const target = document.getElementById("filter-" + type);
    if (target) target.classList.add("active");

    rows.forEach(row => {
        const rowType = row.dataset.type;
        if (type === "all" || rowType === type) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}
</script>

</head>

<body>

<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="main-content">
    <div class="content-wrapper">

        <%-- 프로필 카드 --%>
        <jsp:include page="../include/profileCard.jsp" />

        <%-- 포인트 내역 --%>
        <div class="point-container">

            <p class="point-title">포인트 내역</p>

            <%-- ===============================
                라인형 필터 메뉴
            =============================== --%>
            <div class="filter-line">

                <span id="filter-all" class="filter-item active" onclick="filterType('all')">전체</span>
                <span class="divider">|</span>

                <span id="filter-save" class="filter-item" onclick="filterType('save')">적립</span>
                <span class="divider">|</span>

                <span id="filter-use" class="filter-item" onclick="filterType('use')">사용</span>
                <span class="divider">|</span>

                <span id="filter-restore" class="filter-item" onclick="filterType('restore')">복구</span>
                <span class="divider">|</span>

                <span id="filter-remove" class="filter-item" onclick="filterType('remove')">회수</span>

            </div>

            <table class="point-table" id="pointTable">
                <thead>
                    <tr>
                        <th>일시</th>
                        <th>내역</th>
                        <th>클래스</th>
                        <th>포인트</th>
                    </tr>
                </thead>

                <tbody>

                    <c:if test="${empty pointhistoryVOList}">
                        <tr>
                            <td colspan="4" class="point-empty-box">
                                포인트 내역이 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="ph" items="${pointhistoryVOList}">
                        <tr data-type="${ph.type}">

                            <%-- 일시 --%>
                            <td>
                                <fmt:formatDate value="${ph.created_at}" pattern="yyyy-MM-dd HH:mm" />
                            </td>

                            <%-- 타입 텍스트 (save/use/restore/remove) --%>
                            <td>
                                <c:choose>
                                    <c:when test="${ph.type == 'save'}">적립</c:when>
                                    <c:when test="${ph.type == 'use'}">사용</c:when>
                                    <c:when test="${ph.type == 'restore'}">복구</c:when>
                                    <c:when test="${ph.type == 'remove'}">회수</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>

                            <%-- 강의명 (없으면 - 표시) --%>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty ph.lecture_title}">
                                        <span class="lec-title">${ph.lecture_title}</span>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>

                            <%-- 포인트 변화 표시 --%>
                            <td>
                                <c:choose>
                                    <c:when test="${ph.point_change > 0}">
                                        <span class="point-plus">+<fmt:formatNumber value="${ph.point_change}"/></span>
                                    </c:when>
                                    <c:when test="${ph.point_change < 0}">
                                        <span class="point-minus"><fmt:formatNumber value="${ph.point_change}"/></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="point-zero">0</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>
                    </c:forEach>

                </tbody>
            </table>

        </div>

    </div>
</main>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
