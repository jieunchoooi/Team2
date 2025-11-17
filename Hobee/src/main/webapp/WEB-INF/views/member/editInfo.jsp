<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정 | Hobee</title>
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/member/memberSidebar.css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/member/editlnfo.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!-- 좌측 사이드바 -->
	<jsp:include page="../include/memberSidebar.jsp"></jsp:include>
	<!-- 메인 콘텐츠 -->
	<main>
		<!-- 오른쪽 정보 수정 폼 -->
		<form id="updateForm"
			action="${pageContext.request.contextPath}/member/updatePro"
			method="post" enctype="multipart/form-data">
			<section class="main-content">
				<h1>회원정보 수정</h1>
				<div class="main-header">
					<div class="profile-box">
						<div class="profile-pic">
							<c:choose>
								<c:when test="${empty user.user_file}">
									<span>🐵</span>
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/resources/img/user_picture/${user.user_file}"
										alt="프로필 사진">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="profile-info">
							<p>
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
								${user.user_name}
							</p>
							<p>${user.user_email}</p>
							<p>🪙 &nbsp;${user.points} P</p>
						</div>
					</div>
				</div>
				<div class="form-container">
					<div class="profile-edit">
						<div class="profile-pic">
							<c:choose>
								<c:when test="${empty user.user_file}">
									<span>🐵</span>
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/resources/img/user_picture/${user.user_file}"
										alt="프로필 사진">
								</c:otherwise>
							</c:choose>


						</div>
						<label class="file-input-label" for="profilePic">사진 변경</label> <input
							type="file" id="profilePic" class="file-input"
							name="user_picture" accept="image/*">
					</div>
					<div class="form-group">
						<label for="userId">아이디</label> <input type="text" name="User_id"
							id="user_id" value="${user.user_id}" readonly>
					</div>
					<div class="form-group">
						<label for="password">비밀번호</label> <input type="password"
							name="user_password" id="user_password"
							value="${user.user_password}"> <span id="checkPassword"></span>
					</div>
					<div class="form-group">
						<label for="adress">주소</label> <input type="text"
							id="user_address" name="user_address"
							value="${user.user_address}">
					</div>
					<div class="form-group">
						<label for="tel">휴대폰 번호</label> <input type="tel" id="user_phone"
							name="user_phone" value="${user.user_phone}"> <span
							id="checkPhone"></span>
					</div>
					<div class="form-group">
						<label for="email">이메일</label> <input type="email" id="user_email"
							name="user_email" value="${user.user_email}"> <span
							id="checkemail"></span>
					</div>
					<button type="submit" class="btn" id="submitBtn">정보 수정</button>

					<button type="button" class="btn btn-delete"
						onclick="location.href='${pageContext.request.contextPath }/member/memberdeletePro'">회원
						탈퇴</button>
				</div>
			</section>
		</form>
	</main>

	<script>

// ✅ Controller에서 돌아온 후 성공 메시지 (JSTL 사용)
<c:if test="${not empty updateSuccess}">
    alert('회원정보가 수정되었습니다.');

</c:if>
//✅ 파일 선택 시 미리보기 
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
            // 모든 .profile-pic 요소 선택
            const profilePics = document.querySelectorAll('.profile-pic');
            
            profilePics.forEach(pic => {
                // 기존 내용(span 또는 img) 제거
                pic.innerHTML = '';
                
                // 새로운 img 태그 생성
                const img = document.createElement('img');
                img.src = event.target.result;
                img.alt = '프로필 사진';
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                
                // profile-pic에 추가
                pic.appendChild(img);
            });
            
            console.log('✅ 이미지 미리보기 완료');
        };
        
        reader.readAsDataURL(file);
    }
});

// ✅ 폼 제출 전 확인

    let user_phone = document.querySelector('#user_phone');
    let user_email = document.querySelector('#user_email');
    let user_password = document.querySelector("#user_password");
    let checkPassword = document.querySelector("#checkPassword");
    let checkPhone = document.querySelector("#checkPhone");
    let checkemail = document.querySelector("#checkemail");
    let submitBtn = document.querySelector("#submitBtn");
    

// 유효성검사
function testPassword() {
    let passwordRegEx = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*]).{8,12}$/;
    return passwordRegEx.test(user_password.value);
}

function testPhone() {
	let PhoneRegEx = /^(01[016789])-\d{3,4}-\d{4}$/;
	return PhoneRegEx.test(user_phone.value);
}

function testEmail() {
	let EmailRegEx = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	return EmailRegEx.test(user_email.value);
}

user_password.onkeyup = function(){
    if(!testPassword()){
        checkPassword.innerHTML = "글자수 : 8~12자, 영어 대소문자, 숫자, 특수문자(!@#$%^*)를 모두 포함해야 합니다.";
        checkPassword.style.color = "red";
    } else {
        checkPassword.innerHTML = "사용가능한 비밀번호입니다.";
        checkPassword.style.color = "green";
    }
}

user_phone.onkeyup = function(){
	if(!testPhone()){
		checkPhone.innerHTML = "'-' 넣어서 작성해주세요"
		checkPhone.style.color = "red";
	}else{
		checkPhone.innerHTML = "사용가능한 전화번호 입니다."
		checkPhone.style.color = "green";
	}
}

user_email.onkeyup = function(){
	if(!testEmail()){
		checkemail.innerHTML = "이메일을 다시 작성해 주세요."
		checkemail.style.color = "red";
	}else{
		checkemail.innerHTML = "사용가능한 이메일 입니다."
		checkemail.style.color = "green";
	}
}

updateForm.onsubmit = function(e){
    if(user_password.value && !testPassword()){
        e.preventDefault();  
        alert('비밀번호 형식이 올바르지 않습니다.');
        user_password.focus();
        return false;
    }
    
    if(user_phone.value && !testPhone()){
        e.preventDefault();  
        alert('전화번호 형식이 올바르지 않습니다.');
        user_phone.focus();
        return false;
    }
    
    if(user_email.value && !testEmail()){
        e.preventDefault();  
        alert('이메일 형식이 올바르지 않습니다.');
        user_email.focus();
        return false;
    }
    
    return true;  
}


</script>
</body>
</html>