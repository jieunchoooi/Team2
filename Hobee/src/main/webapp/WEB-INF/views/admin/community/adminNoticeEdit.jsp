<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지 수정 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminNoticeEdit.css">

   
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header">
        <h1>공지사항 수정</h1>
    </div>

    <div class="form-card">

        <form action="${pageContext.request.contextPath}/admin/adminNoticeEditPro"
              method="post"
              enctype="multipart/form-data">

            <input type="hidden" name="notice_id" value="${notice.notice_id}">

            <!-- 제목 -->
            <div class="form-group">
                <label>제목</label>
                <input type="text" name="title" value="${notice.title}" required>
            </div>

            <!-- 작성자 -->
            <div class="form-group">
                <label>작성자</label>
                <input type="text" value="${notice.admin_id}" readonly>
            </div>

            <!-- 공개 여부 -->
            <div class="form-group">
                <label>공개 여부</label>
                <select name="is_visible">
                    <option value="1" ${notice.is_visible == 1 ? "selected" : ""}>공개</option>
                    <option value="0" ${notice.is_visible == 0 ? "selected" : ""}>숨김</option>
                </select>
            </div>

            <!-- ⭐ 기존 첨부파일 목록 -->
            <c:if test="${!empty files}">
                <div class="form-group">
                    <label>기존 첨부파일</label>

                    <div class="old-files-box">

                        <c:forEach var="f" items="${files}">
                            <div class="file-item">

                                <!-- 이미지 파일 -->
                                <c:if test="${fn:endsWith(f.file_name, 'jpg')
                                            or fn:endsWith(f.file_name, 'png')
                                            or fn:endsWith(f.file_name, 'jpeg')
                                            or fn:endsWith(f.file_name, 'gif')}">
                                    <img src="${pageContext.request.contextPath}/upload/notice/${f.file_name}"
                                         class="file-thumb">
                                </c:if>

                                <!-- 이미지가 아닐 때 -->
                                <c:if test="${not (fn:endsWith(f.file_name, 'jpg')
                                                or fn:endsWith(f.file_name, 'png')
                                                or fn:endsWith(f.file_name, 'jpeg')
                                                or fn:endsWith(f.file_name, 'gif'))}">
                                    <div class="file-icon">📄</div>
                                </c:if>

                                <!-- 파일명 + 삭제버튼 -->
                                <div class="file-detail">
                                    <span class="file-name">${f.file_name}</span>

                                    <!-- 삭제 버튼 (hidden으로 실제 삭제값 전달) -->
                                    <button type="button"
                                            class="delete-btn"
                                            onclick="toggleDelete(${f.file_id}, this)">
                                        삭제
                                    </button>

                                    <input type="hidden" name="deleteFiles"
                                           value="" id="del-${f.file_id}">
                                </div>

                            </div>
                        </c:forEach>

                    </div>
                </div>
            </c:if>

            <!-- 새 파일 추가 -->
            <div class="form-group">
                <label>새 파일 추가</label>
                <input type="file" name="uploadFiles" multiple>
            </div>

            <!-- 이미지 미리보기 -->
            <div id="preview-area"
                 style="margin-top:15px; display:flex; gap:10px; flex-wrap:wrap;"></div>


            <!-- 중요도 -->
            <div class="form-group">
                <label>중요도</label>
                <select name="priority">
                    <option value="1" ${notice.priority == 1 ? "selected" : ""}>일반</option>
                    <option value="2" ${notice.priority == 2 ? "selected" : ""}>중요</option>
                    <option value="3" ${notice.priority == 3 ? "selected" : ""}>매우 중요</option>
                    <option value="4" ${notice.priority == 4 ? "selected" : ""}>긴급 🔥</option>
                </select>
            </div>

            <!-- 게시 시작일 -->
            <div class="form-group">
                <label>게시 시작일</label>
                <input type="date" name="start_date" value="${notice.start_date}">
            </div>

            <!-- 게시 종료일 -->
            <div class="form-group">
                <label>게시 종료일</label>
                <input type="date" name="end_date" value="${notice.end_date}">
            </div>

            <!-- 내용 -->
            <div class="form-group">
                <label>내용</label>
                <textarea name="content" required>${notice.content}</textarea>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn-blue">수정 완료</button>
                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeDetail?notice_id=${notice.notice_id}'">
                    상세로
                </button>
            </div>

        </form>


        <!-- 기존 파일 삭제 버튼 스크립트 -->
        <script>
            function toggleDelete(fileId, btn) {
                const hidden = document.getElementById("del-" + fileId);
                
                if (!hidden) {
                    console.error("hidden input 찾을 수 없음:", fileId);
                    return;
                }

                if (hidden.value === "") {
                    hidden.value = fileId;          // 삭제 표시
                    btn.style.color = "#ff3b3b";
                    btn.style.fontWeight = "700";
                    btn.innerText = "삭제 취소";
                } else {
                    hidden.value = "";               // 취소
                    btn.style.color = "";
                    btn.style.fontWeight = "";
                    btn.innerText = "삭제";
                }
            }
        </script>

        <!-- 새 파일 미리보기 -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                const fileInput = document.querySelector("input[name='uploadFiles']");
                const previewArea = document.getElementById("preview-area");

                fileInput.addEventListener("change", function () {

                    previewArea.innerHTML = "";

                    Array.from(fileInput.files).forEach(file => {

                        const ext = file.name.toLowerCase().split('.').pop();

                        if (["jpg","jpeg","png","gif"].includes(ext)) {

                            const reader = new FileReader();
                            reader.onload = function (e) {

                                const img = document.createElement("img");
                                img.src = e.target.result;
                                img.style.width = "120px";
                                img.style.height = "120px";
                                img.style.objectFit = "cover";
                                img.style.borderRadius = "10px";
                                img.style.border = "1px solid #ddd";

                                previewArea.appendChild(img);
                            };
                            reader.readAsDataURL(file);
                        }
                    });
                });
            });
        </script>

    </div>

</main>

</body>
</html>
