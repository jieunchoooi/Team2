<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<aside class="sidebar">
  <h2>관리 메뉴</h2>

  <!-- 클래스 관리 -->
  <div class="menu-section">
    <h3>📚 클래스 관리</h3>
    <div class="menu">
      <div class="menu-item ${page eq 'category' ? 'active' : ''}" 
           onclick="location.href='${pageContext.request.contextPath}/admin/adminCategory'">📂 <span>카테고리 편집</span></div>
      <div class="menu-item ${page eq 'classAdd' ? 'active' : ''}" 
           onclick="location.href='${pageContext.request.contextPath}/admin/adminClassAdd'">➕ <span>클래스 등록</span></div>
      <div class="menu-item ${page eq 'classList' ? 'active' : ''}" 
           onclick="location.href='${pageContext.request.contextPath}/admin/adminClassList'">📋 <span>클래스 목록</span></div>
    </div>
  </div>

  <!-- 회원 관리 -->
  <div class="menu-section" style="margin-top:30px;">
    <h3>👥 회원 관리</h3>
    <div class="menu">
      <div class="menu-item ${page eq 'memberList' ? 'active' : ''}" 
           onclick="location.href='${pageContext.request.contextPath}/admin/adminMemberList'">👥 <span>회원 목록</span></div>
      <div class="menu-item ${page eq 'teacherList' ? 'active' : ''}" 
           onclick="location.href='${pageContext.request.contextPath}/admin/adminTeacherList'">🎓 <span>강사 목록</span></div>
      <div class="menu-item ${page eq 'withdrawList' ? 'active' : ''}" 
           onclick="location.href='${pageContext.request.contextPath}/admin/adminWithdrawList'">🚫 <span>탈퇴 회원</span></div>
    </div>
  </div>

  <button class="logout-btn" onclick="logout()">로그아웃</button>
</aside>
