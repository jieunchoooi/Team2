<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>FAQ 수정 | Hobee Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqEdit.css?v=15">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header"><h1>FAQ 수정</h1></div>

    <div class="write-card">

        <form action="${pageContext.request.contextPath}/admin/adminFaqEditPro" method="post">

            <input type="hidden" name="faq_id" value="${faq.faq_id}">

            <!-- 카테고리 -->
            <label>카테고리</label>
            <select name="category" class="select-box">
                <option value="계정" ${faq.category=='계정'?'selected':''}>계정</option>
                <option value="결제" ${faq.category=='결제'?'selected':''}>결제</option>
                <option value="커뮤니티" ${faq.category=='커뮤니티'?'selected':''}>커뮤니티</option>
                <option value="수업" ${faq.category=='수업'?'selected':''}>수업</option>
                <option value="기타" ${faq.category=='기타'?'selected':''}>기타</option>
            </select>

            <!-- 질문 -->
            <label>질문</label>
            <input type="text" id="question" name="question" class="input-box"
                   maxlength="100" value="${faq.question}">
            <div class="count-box">글자수: <span id="q-count">0</span> / 100</div>

            <!-- 답변 -->
            <label>답변</label>
            <textarea id="answer" name="answer" class="textarea-box"
                      rows="6" maxlength="1000">${faq.answer}</textarea>
            <div class="count-box">글자수: <span id="a-count">0</span> / 1000</div>

            <!-- 실시간 미리보기 -->
            <div class="preview-title">미리보기</div>
            <div id="answerPreview" class="preview-box"></div>

            <!-- 공개 여부 -->
            <label>공개 여부</label>
            <select name="is_visible" class="select-box">
                <option value="1" ${faq.is_visible==1?'selected':''}>공개</option>
                <option value="0" ${faq.is_visible==0?'selected':''}>숨김</option>
            </select>

            <!-- 버튼 영역 -->
            <div class="btn-area">
                <button type="button" class="btn-green" onclick="previewFaq()">미리보기</button>
                <button type="submit" class="btn-blue">수정 완료</button>
                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                    목록
                </button>
            </div>

        </form>

    </div>

    <!-- 팝업 미리보기 모달 -->
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

<!-- JS: 글자수 + 실시간 미리보기 -->
<script>
$(document).ready(function() {

    // 초기 글자수
    $("#q-count").text($("#question").val().length);
    $("#a-count").text($("#answer").val().length);

    // 초기 실시간 미리보기
    $("#answerPreview").html(
        $("#answer").val().replace(/\n/g, "<br>")
    );

    // 질문 글자수
    $("#question").on("input", function() {
        let len = $(this).val().length;
        $("#q-count").text(len);
        len > 100 ? $("#q-count").parent().addClass("red")
                  : $("#q-count").parent().removeClass("red");
    });

    // 답변 글자수 + 실시간 미리보기
    $("#answer").on("input", function() {
        let len = $(this).val().length;
        $("#a-count").text(len);
        len > 1000 ? $("#a-count").parent().addClass("red")
                   : $("#a-count").parent().removeClass("red");

        $("#answerPreview").html(
            $(this).val().replace(/\n/g, "<br>")
        );
    });

});
</script>

<!-- JS: 팝업 미리보기 -->
<script>
function previewFaq() {
    let q = document.getElementById("question").value.trim();
    let a = document.getElementById("answer").value.trim();

    if (q === "") {
        alert("질문을 입력하세요.");
        return;
    }
    if (a === "") {
        alert("답변을 입력하세요.");
        return;
    }

    document.getElementById("pvQuestion").innerText = q;
    document.getElementById("pvAnswer").innerHTML = a.replace(/\n/g, "<br>");

    document.getElementById("faqPreviewModal").style.display = "flex";
}

function closePreview() {
    document.getElementById("faqPreviewModal").style.display = "none";
}
</script>

</body>
</html>
