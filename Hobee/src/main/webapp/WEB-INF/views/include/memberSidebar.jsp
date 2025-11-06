<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<aside class="sidebar">
  <h2></h2>
  <div class="menu">
    <div class="menu-item ${page eq 'mypageHome' ? 'active' : ''}" 
         onclick="location.href='${pageContext.request.contextPath}/member/mypage'">🏠 <span>MY 홈</span></div>
    <div class="menu-item ${page eq 'lecture' ? 'active' : ''}" 
         onclick="location.href='${pageContext.request.contextPath}/member/my_classroom'">📄 <span>내 강의실</span></div>
    <div class="menu-item ${page eq 'scrap' ? 'active' : ''}" 
         onclick="location.href='${pageContext.request.contextPath}/member/scrap'">⭐ <span>스크랩 / 관심</span></div>
    <div class="menu-item ${page eq 'review' ? 'active' : ''}" 
         onclick="location.href='${pageContext.request.contextPath}/member/review'">💌 <span>내가 쓴 리뷰</span></div>
    <div class="menu-item ${page eq 'payment' ? 'active' : ''}" 
         onclick="location.href='${pageContext.request.contextPath}/member/payment'">💳 <span>결제 내역</span></div>
    <div class="menu-item ${page eq 'edit' ? 'active' : ''}" 
         onclick="location.href='${pageContext.request.contextPath}/member/editInfo'">👤 <span>회원정보 수정</span></div>
  </div>

  <button class="logout-btn" onclick="logout()">로그아웃</button>
</aside>
