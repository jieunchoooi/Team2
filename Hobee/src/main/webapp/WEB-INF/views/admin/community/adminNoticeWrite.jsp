<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 작성 | Hobee Admin</title>

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

    <div class="main-header">
        <h1>공지사항 작성</h1>
    </div>

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
        document.addEventListener("DOMContentLoaded", function(){

            /* ============================
               파일 제한 설정
            ============================ */
            const fileInput = document.querySelector("input[name='uploadFiles']");

            // 허용 확장자
            const allowedExt = ["jpg", "jpeg", "png", "gif", "pdf", "docx", "xlsx", "pptx"];

            // 금지 확장자
            const blockedExt = ["exe", "js", "bat", "sh", "php", "html"];

            const maxFileSize = 10 * 1024 * 1024;  // 10MB
            const maxTotalSize = 30 * 1024 * 1024; // 전체 30MB

            fileInput.addEventListener("change", function(){

                let files = fileInput.files;
                let totalSize = 0;

                for(let f of files){

                    let fileName = f.name.toLowerCase();
                    let fileSize = f.size;
                    let ext = fileName.substring(fileName.lastIndexOf('.') + 1);

                    // 1) 금지 확장자
                    if(blockedExt.includes(ext)){
                        alert("❌ [" + fileName + "] 은(는) 업로드할 수 없는 파일입니다.");
                        fileInput.value = ""; // 선택 초기화
                        return;
                    }

                    // 2) 허용되지 않은 확장자
                    if(!allowedExt.includes(ext)){
                        alert("❌ [" + ext + "] 파일은 업로드할 수 없습니다.");
                        fileInput.value = "";
                        return;
                    }

                    // 3) 파일 크기 제한 (10MB)
                    if(fileSize > maxFileSize){
                        alert("❌ [" + fileName + "] 파일 크기가 10MB를 초과합니다!");
                        fileInput.value = "";
                        return;
                    }

                    totalSize += fileSize;
                }

                // 4) 전체 파일 크기 제한 (30MB)
                if(totalSize > maxTotalSize){
                    alert("❌ 전체 파일 용량은 30MB 이하만 가능합니다.");
                    fileInput.value = "";
                    return;
                }

                console.log("파일 검증 완료!");
            });
        });
        </script>

       <script>
       document.addEventListener("DOMContentLoaded", function(){

           const fileInput = document.querySelector("input[name='uploadFiles']");
           const previewArea = document.getElementById("preview-area");

           // 내부에서 사용할 파일 리스트(실제 input.files는 읽기 전용이라 수정 불가)
           let fileList = [];

           // 파일 선택
           fileInput.addEventListener("change", function(){

               // 선택한 파일들을 fileList에 병합
               fileList = Array.from(fileInput.files);

               // UI 업데이트
               updatePreview();
           });

           // ============================
           //  이미지/파일 미리보기 + X 삭제버튼
           // ============================
           function updatePreview() {

               previewArea.innerHTML = "";  // 기존 초기화

               fileList.forEach((file, index) => {

                   const fileName = file.name.toLowerCase();
                   const ext = fileName.substring(fileName.lastIndexOf('.') + 1);

                   const container = document.createElement("div");
                   container.style.position = "relative";
                   container.style.display = "inline-block";

                   // 삭제 버튼
                   const delBtn = document.createElement("span");
                   delBtn.innerText = "✖";
                   delBtn.style.position = "absolute";
                   delBtn.style.top = "-8px";
                   delBtn.style.right = "-8px";
                   delBtn.style.cursor = "pointer";
                   delBtn.style.background = "rgba(0,0,0,0.6)";
                   delBtn.style.color = "#fff";
                   delBtn.style.fontSize = "14px";
                   delBtn.style.padding = "2px 5px";
                   delBtn.style.borderRadius = "50%";

                   delBtn.onclick = function() {
                       fileList.splice(index, 1);  // 해당 파일 제거
                       updatePreview();
                       updateFileInput();
                   };

                   // 이미지 파일
                   if (["jpg","jpeg","png","gif"].includes(ext)) {

                       const reader = new FileReader();
                       reader.onload = function(e) {
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

                       // 이미지가 아닌 파일(PDF/docx 등)
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
                       box.style.padding = "5px";

                       box.innerHTML = "📄<br>" + file.name;

                       container.appendChild(box);
                       container.appendChild(delBtn);
                       previewArea.appendChild(container);
                   }
               });
           }

           // ============================
           // input.files 값을 갱신 (삭제를 반영)
           // ============================
           function updateFileInput() {
               const dataTransfer = new DataTransfer();
               fileList.forEach(file => dataTransfer.items.add(file));
               fileInput.files = dataTransfer.files;
           }

       });
       </script>
    </div>
</main>

</body>
</html>
