<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- ======================= 프로필 카드 (Include) ======================= --%>
<div class="profile-card-wrap">

    <div class="profile-pic">
        <c:choose>
            <c:when test="${empty userVO.user_file}">
                <span>🐵</span>
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/resources/img/user_picture/${userVO.user_file}"
                     alt="프로필 사진">
            </c:otherwise>
        </c:choose>
    </div>

    <div class="profile-info">

        <!-- 이름 + 배지 -->
        <p class="name">
            <c:choose>
                <c:when test="${empty userVO.grade_id or userVO.grade_id == 1}">
                    <span class="badge bronze">🥉</span>
                </c:when>
                <c:when test="${userVO.grade_id == 2}">
                    <span class="badge silver">🥈</span>
                </c:when>
                <c:when test="${userVO.grade_id == 3}">
                    <span class="badge gold">🥇</span>
                </c:when>
            </c:choose>
            ${userVO.user_name}
        </p>

        <!-- 이메일 -->
        <p class="email">${userVO.user_email}</p>

        <!-- 포인트 -->
        <p class="mpc-points">
            <span class="points-icon">🪙</span>

            <span class="points-inner"
                onclick="location.href='${pageContext.request.contextPath}/member/pointHistory'">
                <fmt:formatNumber value="${userVO.points != null ? userVO.points : 0}" /> P
            </span>
        </p>

    </div>

</div>

<%-- ============================================================== --%>
