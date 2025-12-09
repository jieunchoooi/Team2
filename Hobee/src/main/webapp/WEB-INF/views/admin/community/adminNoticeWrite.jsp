<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 공지 작성 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeWrite.css">
</head>

<body>

<!-- 상단 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 -->
<main class="main-content">

    <div class="form-card">

        <form action="${pageContext.request.contextPath}/admin/adminNoticeWritePro"
              method="post"
              enctype="multipart/form-data">

            <!-- 제목 -->
            <div class="form-group">
                <label>제목</label>
                <input type="text" name="title" required>
            </div>

            <!-- 작성자 -->
            <div class="form-group">
                <label>작성자</label>
                <input type="text" name="admin_id" value="admin" readonly>
            </div>

            <!-- 공개 여부 -->
            <div class="form-group">
                <label>공개 여부</label>
                <select name="is_visible" required>
                    <option value="1">공개</option>
                    <option value="0">숨김</option>
                </select>
            </div>

            <!-- ⭐ 첨부파일 추가 -->
            <div class="form-group">
                <label>첨부파일</label>
                <input type="file" name="uploadFiles" multiple>
            </div>

            <!-- 이미지 미리보기 -->
            <div id="preview-area"
                 style="margin-top:15px; display:flex; gap:10px; flex-wrap:wrap;">
            </div>
            
            <div class="form-group">
   				<label>중요도</label>
    			<select name="priority">
        			<option value="1">일반</option>
        			<option value="2">중요</option>
        			<option value="3">매우 중요</option>
       				<option value="4">긴급 🔥</option>
    			</select>
			</div>
            
            <!-- ⭐ 게시 시작일 -->
			<div class="form-group" style="margin-top:20px;">
    			<label>게시 시작일</label>
    			<input type="date" name="start_date" required>
			</div>

			<!-- ⭐ 게시 종료일 -->
			<div class="form-group">
    			<label>게시 종료일</label>
    			<input type="date" name="end_date">
			</div>

            <!-- 내용 -->
            <div class="form-group">
                <label>내용</label>
                <textarea name="content" required></textarea>
            </div>

            <div class="btn-area">
                <button class="btn-blue" type="submit">등록하기</button>
                <button class="btn-gray" type="button"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeList'">
                    목록
                </button>
            </div>

        </form>

        <script>
document.addEventListener("DOMContentLoaded", function () {

    const fileInput = document.querySelector("input[name='uploadFiles']");
    const previewArea = document.getElementById("preview-area");

    // 파일 목록을 저장 (실제 input.files를 건드리지 않음)
    let fileList = [];

    // 파일 선택 시
    fileInput.addEventListener("change", function (e) {

        // 새로 선택한 파일들 추가
        for(let f of e.target.files){
            fileList.push(f);
        }

        updatePreview();
    });

    // 미리보기 갱신
    function updatePreview() {
        previewArea.innerHTML = "";

        fileList.forEach((file, index) => {

            const container = document.createElement("div");
            container.style.position = "relative";
            container.style.display = "inline-block";

            const delBtn = document.createElement("span");
            delBtn.innerText = "✖";
            delBtn.style.position = "absolute";
            delBtn.style.top = "-8px";
            delBtn.style.right = "-8px";
            delBtn.style.cursor = "pointer";
            delBtn.style.background = "rgba(0,0,0,0.6)";
            delBtn.style.color = "#fff";
            delBtn.style.padding = "2px 5px";
            delBtn.style.borderRadius = "50%";

            delBtn.onclick = function () {
                fileList.splice(index, 1);
                updatePreview();
                refreshInputFiles();
            };

            const ext = file.name.toLowerCase().split('.').pop();

            if (["jpg", "jpeg", "png", "gif"].includes(ext)) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const img = document.createElement("img");
                    img.src = e.target.result;
                    img.style.width = "120px";
                    img.style.height = "120px";
                    img.style.objectFit = "cover";
                    img.style.border = "1px solid #ddd";
                    img.style.borderRadius = "10px";

                    container.appendChild(img);
                    container.appendChild(delBtn);
                    previewArea.appendChild(container);
                };
                reader.readAsDataURL(file);
            } else {
                const box = document.createElement("div");
                box.style.width = "120px";
                box.style.height = "120px";
                box.style.border = "1px solid #ddd";
                box.style.borderRadius = "10px";
                box.style.display = "flex";
                box.style.alignItems = "center";
                box.style.justifyContent = "center";
                box.style.fontSize = "13px";
                box.style.background = "#f8f8f8";
                box.style.textAlign = "center";
                box.innerHTML = "📄<br>" + file.name;

                container.appendChild(box);
                container.appendChild(delBtn);
                previewArea.appendChild(container);
            }
        });
    }

    // input.files 재구성
    function refreshInputFiles(){
        const dataTransfer = new DataTransfer();
        fileList.forEach(f => dataTransfer.items.add(f));
        fileInput.files = dataTransfer.files;
    }

});
</script>

    </div>
</main>

</body>
</html>
