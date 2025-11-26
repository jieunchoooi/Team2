<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 강의실 | Hobee</title>

<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/my_classroom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/include/profileCard.css">

</head>
<body>

	<%-- header / sidebar --%>
	<jsp:include page="../include/header.jsp" />
	<jsp:include page="../include/memberSidebar.jsp" />

	<main class="main-content">

		<%-- 중앙 고정 레이아웃 wrapper --%>
		<div class="content-wrapper">

			<%-- 프로필 카드 include --%>
				<jsp:include page="../include/profileCard.jsp" />

			<%-- 강의 리스트 영역 --%>
			<div class="classroom-list">

				<c:choose>

					<%-- 강의 없음 --%>
					<c:when test="${empty enrollList}">
						<div class="empty-wrap">
							<div class="empty-card">
								<div class="empty-icon">🧸</div>
								<div class="empty-title">아직 수강중인 강의가 없어요</div>
								<div class="empty-sub">관심 가는 클래스를 찾아보세요 ✨</div>

								<button class="empty-btn"
									onclick="location.href='${pageContext.request.contextPath}/category/lectureList?category_detail=전체'">
									클래스 둘러보기</button>
							</div>
						</div>
					</c:when>

					<%-- 강의 목록 출력 --%>
					<c:otherwise>
						<c:forEach var="enroll" items="${enrollList}">
							<div class="class-card">

								<%-- 썸네일 --%>
								<div class="thumb-wrap">
									<img class="thumb"
										src="${pageContext.request.contextPath}/resources/img/lecture_picture/${enroll.lecture_img}">
								</div>

								<%-- 강의 정보 --%>
								<div class="info-wrap">

									<%-- 제목 + 카테고리 --%>
									<a href="#" class="lecture-title"> ${enroll.lecture_title}
										<span class="lecture-category">·
											${enroll.category_detail}</span>
									</a>

									<%-- 강사 + 설명 --%>
									<p class="lecture-author">
										${enroll.lecture_author} <span class="lecture-detail">
											- ${enroll.lecture_detail}</span>
									</p>
								</div>

								<%-- 리뷰 작성 버튼 --%>
								<div class="action-wrap">
									<a href="#" class="review-link">리뷰 작성</a>
								</div>

							</div>
						</c:forEach>
					</c:otherwise>

				</c:choose>

			</div>
			<%-- classroom-list --%>

		</div>
		<%-- content-wrapper --%>

	</main>
		<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>
