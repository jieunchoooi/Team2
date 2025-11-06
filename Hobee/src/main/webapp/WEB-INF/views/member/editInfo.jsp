<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정 | Hobee</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/editInfo.css">

<script type="text/javascript">
	$(function(){
		$('#submitBtn').click(function(){
			
		}
		
		

</script>



</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<!-- 메인 콘텐츠 -->
<main>


  <!-- 오른쪽 정보 수정 폼 -->
  <form action="${pageContext.request.contextPath}/member/update" method="post">
  <section class="main-content">
    <div class="main-header">
      <div class="profile-box">
        <div class="profile-pic">🐵</div>
        <div class="profile-info">
          <p>홍길동</p>
          <p>hong123</p>
        </div>
      </div>
      <h1>회원정보 수정</h1>
    </div>

    <div class="form-container">
      <div class="profile-edit">
        <div class="profile-pic">🐵</div>
        <label class="file-input-label" for="profilePic">사진 변경</label>
        <input type="file" id="profilePic" class="file-input">
      </div>

      <div class="form-group">
        <label for="userId">아이디</label>
        <input type="text" name="user_id" id="user_id" value="${memberVO.user_id}" readonly>
      </div>

      <div class="form-group">
        <label for="password">비밀번호</label>
        <input type="password" id="user_password" placeholder="새 비밀번호 입력">
      </div>

      <div class="form-group">
        <label for="nickname">닉네임</label>
        <input type="text" id="user_name" name="user_name" value="${memberVO.user_name}">
      </div>

      <div class="form-group">
        <label for="phone">휴대폰 번호</label>
        <input type="tel" id="user_phone" placeholder="010-1234-5678">
      </div>

      <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="user_email" value="hong@hobbyprep.com">
      </div>

      <button class="btn" id="submitBtn">정보 수정</button>
      
      <button class="btn btn-delete">회원 탈퇴</button>
    </div>
  </section>
    </form>
</main>

<script>
function logout() {
  alert("로그아웃되었습니다.");
  location.href = "login.html";
}
</script>
</body>
</html>
