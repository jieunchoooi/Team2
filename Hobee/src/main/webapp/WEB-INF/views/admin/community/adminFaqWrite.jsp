<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>FAQ 작성 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- 공통 FAQ 작성/수정 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqWrite.css">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header"><h1>FAQ 작성</h1></div>

    <div class="write-card">

        <form action="${pageContext.request.contextPath}/admin/adminFaqWritePro" method="post">

            <!-- 카테고리 -->
            <label>카테고리</label>
            <select name="category" class="select-box">
                <option value="계정">계정</option>
                <option value="결제">결제</option>
                <option value="커뮤니티">커뮤니티</option>
                <option value="수업">수업</option>
                <option value="기타">기타</option>
            </select>

            <!-- 질문 -->
            <label>질문</label>
            <input type="text" id="question" name="question" class="input-box" maxlength="100">
            <div class="count-box">글자수: <span id="q-count">0</span> / 100</div>

            <!-- 답변 -->
            <label>답변</label>
            <textarea id="answer" name="answer" class="textarea-box" rows="6" maxlength="1000"></textarea>
            <div class="count-box">글자수: <span id="a-count">0</span> / 1000</div>

            <!-- 미리보기 -->
            <div class="preview-title">미리보기</div>
            <div id="answerPreview" class="preview-box"></div>

            <!-- 공개 여부 -->
            <label>공개 여부</label>
            <select name="is_visible" class="select-box">
                <option value="1">공개</option>
                <option value="0">숨김</option>
            </select>

            <div class="btn-area">
                <button type="button" class="btn-green" onclick="previewFaq()">미리보기</button>
                <button type="submit" class="btn-blue">등록</button>
                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                    목록
                </button>
            </div>

        </form>

    </div>

    <!-- ★ FAQ 미리보기 모달 -->
    <div id="faqPreviewModal" class="preview-modal" style="display:none;">
        <div class="preview-content">
            <h2>FAQ 미리보기</h2>

            <div class="preview-box">
                <h3 id="pvQuestion"></h3>
                <div id="pvAnswer"></div>
            </div>

            <button class="btn-gray" onclick="closePreview()">닫기</button>
        </div>
    </div>

</main>

<!-- 글자수 + 미리보기 JS -->
<script>
$(document).ready(function() {
    $("#question").on("input", function() {
        let len = $(this).val().length;
        $("#q-count").text(len);
        len > 100 ? $("#q-count").parent().addClass("red")
                  : $("#q-count").parent().removeClass("red");
    });

    $("#answer").on("input", function() {
        let len = $(this).val().length;
        $("#a-count").text(len);

        len > 1000 ? $("#a-count").parent().addClass("red")
                   : $("#a-count").parent().removeClass("red");

        $("#answerPreview").html($(this).val().replace(/\\n/g, "<br>"));
    });
});
</script>

<script>
function previewFaq() {
    let q = document.querySelector('input[name="question"]').value.trim();
    let a = document.querySelector('textarea[name="answer"]').value.trim();

    if (q === "") {
        alert("질문을 입력하세요.");
        return;
    }

    if (a === "") {
        alert("답변을 입력하세요.");
        return;
    }

    // 미리보기에 값 넣기
    document.getElementById("pvQuestion").innerText = q;
    document.getElementById("pvAnswer").innerText = a;

    // 모달 열기
    document.getElementById("faqPreviewModal").style.display = "flex";
}

function closePreview() {
    document.getElementById("faqPreviewModal").style.display = "none";
}
</script>

</body>
</html>
