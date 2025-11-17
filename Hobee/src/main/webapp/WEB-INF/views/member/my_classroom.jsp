<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 강의실 | Hobee</title>

<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/my_classroom.css">
</head>
<body>

<!-- header / sidebar -->
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<main class="main-content">
<h1>내 강의실</h1>
    <!-- 🔥 미니 프로필 카드 -->
    <div class="main-header">
				<div class="profile-box">
					<div class="profile-pic">
						<c:choose>
							<c:when test="${empty userVO.user_file}">
								<span>🐵</span>
							</c:when>
							<c:otherwise>
								<img
									src="${pageContext.request.contextPath}/resources/img/user_picture/${userVO.user_file}"
									alt="프로필 사진">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="profile-info">

						<p><c:choose>
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
						<p>${userVO.user_email}</p>
					<p>
					  🪙 &nbsp;
					  <fmt:formatNumber value="${userVO.points != null ? userVO.points : 0}" type="number" /> P
					</p>
					</div>
				</div>
			</div>

    

    <!-- 🔥 강의 리스트 -->
    <div class="classroom-list">
        <c:choose>
            <c:when test="${empty enrollList}">
                <p class="empty-text">수강 중인 강의가 없습니다.</p>
            </c:when>

            <c:otherwise>
                <c:forEach var="enroll" items="${enrollList}">
                    <div class="class-card">

                        <!-- 썸네일 -->
                        <div class="thumb-wrap">
                            <img class="thumb"
                                 src="${pageContext.request.contextPath}/resources/img/lecture_picture/${enroll.lecture_img}">
                        </div>

                        <!-- 강의 정보 -->
                        <div class="info-wrap">

                            <!-- 강의명 + 카테고리 -->
                            <a href="#" class="lecture-title">
                                ${enroll.lecture_title}
                                <span class="lecture-category">· ${enroll.category_detail}</span>
                            </a>

                            <!-- 강사명 + 간략 설명 -->
                            <p class="lecture-author">
                                ${enroll.lecture_author}
                                <span class="lecture-detail"> - ${enroll.lecture_detail}</span>
                            </p>
                        </div>

                        <!-- 리뷰 작성 -->
                        <div class="action-wrap">
                            <a href="#" class="review-link">리뷰 작성</a>
                        </div>

                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</main>

</body>
</html>
