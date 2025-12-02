<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="sidebar">

  <div class="menu">

    <div class="menu-item ${page eq 'mypageHome' ? 'active' : ''}"
         onclick="location.href='${pageContext.request.contextPath}/member/mypage'">
        🏠 <span>MY 홈</span>
    </div>

    <div class="menu-item ${page eq 'lecture' ? 'active' : ''}"
         onclick="location.href='${pageContext.request.contextPath}/member/my_classroom'">
        📄 <span>내 강의실</span>
    </div>

    <div class="menu-item ${page eq 'scrap' ? 'active' : ''}"
         onclick="location.href='${pageContext.request.contextPath}/member/scrap'">
        ⭐ <span>스크랩</span>
    </div>

    <div class="menu-item ${page eq 'review' ? 'active' : ''}"
         onclick="location.href='${pageContext.request.contextPath}/member/review'">
        💌 <span>내가 쓴 리뷰</span>
    </div>

    <div class="menu-item ${page eq 'paymentList' ? 'active' : ''}"
         onclick="location.href='${pageContext.request.contextPath}/member/paymentList'">
        💳 <span>결제 내역</span>
    </div>

    <div class="menu-item ${page eq 'edit' ? 'active' : ''}"
         onclick="location.href='${pageContext.request.contextPath}/member/updatePassWord'">
        👤 <span>회원정보 수정</span>
    </div>
	<div class="menu-item ${page eq 'pointHistory' ? 'active' : ''}"
         onclick="location.href='${pageContext.request.contextPath}/member/pointHistory'">
        🪙 <span>포인트 내역</span>
    </div>
<%--     <div class="menu-item ${page eq 'classAdd' ? 'active' : ''}" --%>
<%-- 					onclick="location.href='${pageContext.request.contextPath}/admin/adminClassAdd'"> --%>
<!-- 					➕ <span>강의 등록</span> -->
<!-- 	</div> -->
    <div class="menu-item ${page eq 'teacherMP' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/member/teacherMyPage'">
					➕ <span>강의 관리</span>
	</div>
  </div>


</aside>
