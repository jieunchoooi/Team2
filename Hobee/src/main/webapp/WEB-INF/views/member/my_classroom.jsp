<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

<!-- ✅ header / sidebar -->
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/memberSidebar.jsp" />

<!-- ✅ main content -->
<main class="main-content">
  <div class="main-header">
    <h1>내 강의실</h1>
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>강의명</th>
          <th>강사명</th>
          <th>리뷰 작성</th>
          <th>클래스 입장</th>
        </tr>
      </thead>

      <tbody>
        <c:choose>
          <c:when test="${empty enrollList}">
            <tr>
              <td colspan="4" style="text-align:center; padding:20px;">수강 중인 강의가 없습니다.</td>
            </tr>
          </c:when>

          <c:otherwise>
            <c:forEach var="enroll" items="${enrollList}">
              <tr>
                <!-- 강의명 + 썸네일 -->
                <td>
                  <div class="lecture-info">
                    <img src="${pageContext.request.contextPath}/resources/upload/${enroll.lecture_img}"
                         alt="썸네일"
                         class="thumb">
                    <span class="lecture-title">${enroll.lecture_title}</span>
                  </div>
                </td>

                <!-- 강사명 -->
                <td>${enroll.lecture_author}</td>

                <!-- 리뷰 작성 버튼 -->
                <td><button class="btn btn-gray">리뷰 작성</button></td>

                <!-- 클래스 입장 버튼 -->
                <td><button class="btn">클래스 입장</button></td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</main>

</body>
</html>
