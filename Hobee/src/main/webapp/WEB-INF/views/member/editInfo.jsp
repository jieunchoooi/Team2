<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member/editlnfo.css">
</head>
<body>
<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>
<!-- 메인 콘텐츠 -->
<main>
  <!-- 오른쪽 정보 수정 폼 -->
  <form id="updateForm" action="${pageContext.request.contextPath}/member/updatePro" method="post" enctype="multipart/form-data">
  <section class="main-content">
    <div class="main-header">
      <div class="profile-box">
        <div class="profile-pic" style="width: 100px; height: 100px; border-radius: 50%; overflow: hidden;"> 
        	<img src="${pageContext.request.contextPath}/resources/img/user_picture/${user.user_file}" alt="프로필 사진" style="width: 100%; height: 100%; object-fit: cover;">
        </div>
        <div class="profile-info">
          <p>${user.user_name}</p>
          <p>${user.user_email}</p>
        </div>
      </div>
      <h1>회원정보 수정</h1>
    </div>
    <div class="form-container">
      <div class="profile-edit">
        <div class="profile-pic" style="width: 130px; height: 130px; border-radius: 50%; overflow: hidden;"> 
        	<img src="${pageContext.request.contextPath}/resources/img/user_picture/${user.user_file}" alt="프로필 사진" style="width: 100%; height: 100%; object-fit: cover;">
        </div>
        <label class="file-input-label" for="profilePic">사진 변경</label>
        <input type="file" id="profilePic" class="file-input" name="user_picture" accept="image/*">
      </div>
      <div class="form-group">
        <label for="userId">아이디</label>
        <input type="text" name="User_id" id="user_id" value="${user.user_id}" readonly>
      </div>
      <div class="form-group">
        <label for="password">비밀번호</label>
        <input type="password" name="user_password" id="user_password" placeholder="새 비밀번호 입력">
      </div>
      <div class="form-group">
        <label for="adress">주소</label>
        <input type="text" id="user_address" name="user_address" value="${user.user_address}">
      </div>
      <div class="form-group">
        <label for="phone">휴대폰 번호</label>
        <input type="tel" id="user_phone" name="user_phone" value="${user.user_phone}">
      </div>
      <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="user_email" name="user_email" value="${user.user_email}">
      </div>
      <button type="submit" class="btn" id="submitBtn">정보 수정</button>
      
      <button type="button" class="btn btn-delete">회원 탈퇴</button>
    </div>
  </section>
  </form>
</main>

<script>
// ✅ 파일 선택 시 미리보기 (이 부분이 빠져있었음!)
document.getElementById('profilePic').addEventListener('change', function(e) {
    const file = e.target.files[0];
    
    if (file) {
        // 이미지 파일인지 확인
        if (!file.type.startsWith('image/')) {
            alert('이미지 파일만 선택해주세요.');
            this.value = '';
            return;
        }
        
        const reader = new FileReader();
        
        reader.onload = function(event) {
            // 모든 프로필 이미지를 선택한 파일로 변경
            const images = document.querySelectorAll('.profile-pic img');
            images.forEach(img => {
                img.src = event.target.result;
            });
            
            console.log('✅ 이미지 미리보기 완료');
        };
        
        reader.readAsDataURL(file);
    }

// ✅ Controller에서 돌아온 후 성공 메시지 (JSTL 사용)
<c:if test="${not empty updateSuccess}">
    alert('회원정보가 수정되었습니다.');
    // 새로고침
    location.href = '${pageContext.request.contextPath}/member/editInfo';
</c:if>

// ✅ 폼 제출 전 확인
document.getElementById('updateForm').addEventListener('submit', function(e) {
    const phone = document.getElementById('user_phone').value.trim();
    const email = document.getElementById('user_email').value.trim();
    
    if (!phone) {
        e.preventDefault();
        alert('휴대폰 번호를 입력해주세요.');
        document.getElementById('user_phone').focus();
        return false;
    }
    
    if (!email) {
        e.preventDefault();
        alert('이메일을 입력해주세요.');
        document.getElementById('user_email').focus();
        return false;
    }
    
    // 확인 메시지
    if (!confirm('회원정보를 수정하시겠습니까?')) {
        e.preventDefault();
        return false;
    }
});

function logout() {
    alert("로그아웃되었습니다.");
    location.href = "login.html";
}
</script>
</body>
</html>