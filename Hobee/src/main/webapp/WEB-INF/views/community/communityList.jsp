<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>

<link rel="stylesheet" 
      href="${pageContext.request.contextPath}/resources/css/community/communityList.css">

<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include>

<main>

  <div class="layout">

    <!-- 왼쪽 본문 -->
    <div>

      <%-- 검색창 --%>
      <div class="search-bar">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" placeholder="게시글 검색...">
      </div>

      <%-- 추천글 영역: 로직 적용 후 사용 예정 --%>
      <div class="recommend-section">
        <h2>이런 글은 어때요? 👀</h2>
        <div class="recommend-cards" id="recommendArea">
          <%-- 서버에서 추천글 주면 여기에 append 예정 --%>
        </div>
      </div>

      <%-- 카테고리 --%>
      <div class="category-topbar">
        <div class="category-tabs">
          <div class="category-tab ${empty categoryMainNum ? 'active' : ''}">
            전체
          </div>
          <div class="category-tab">예체능</div>
          <div class="category-tab">IT</div>
          <div class="category-tab">외국어</div>
        </div>

        <a href="${pageContext.request.contextPath}/community/write" class="write-btn">글쓰기 ✏️</a>
      </div>

      <%-- 게시글 리스트 --%>
      <div class="board-list">
        <c:choose>
          <c:when test="${not empty communityContentList}">
            <c:forEach var="community" items="${communityContentList}">
              <div class="card"
                   onclick="location.href='${pageContext.request.contextPath}/community/detail?post_id=${community.post_id}'">

                <div class="title">${community.title}</div>

                <div class="author">
                  ${community.user_name}
                </div>

                <div class="meta">
                  <span>
                    <fmt:formatDate value="${community.created_at}" pattern="MM-dd" />
                  </span>
                  <span>조회 ${community.views}</span>
                </div>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="no-data">등록된 게시글이 없습니다.</div>
          </c:otherwise>
        </c:choose>
      </div>

      <%-- 페이지네이션 (PageVO 적용 예정) --%>
      <div class="pagination">
        <%-- 추후 PageVO로 변경 예정 --%>
        <a href="#" class="active">1</a>
      </div>
    </div>

    <%-- 오른쪽 인기글 TOP10 --%>
    <div class="popular-section">
      <h3>🔥 인기글 TOP 10</h3>

      <div class="popular-list" id="popularList">
        <%-- 서버에서 인기 글 주면 여기에 append 예정 --%>
      </div>

    </div>

  </div>

</main>

</body>
</html>
