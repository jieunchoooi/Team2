<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqDetail.css">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="detail-card">

        <div class="detail-row">
            <span class="detail-label">번호</span>
            <span class="detail-value">${faq.faq_id}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">카테고리</span>
            <span class="detail-value">${faq.category}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">질문</span>
            <span class="detail-value">${faq.question}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">공개 여부</span>
            <span class="detail-value">
                <button id="toggleVisibleDetail"
                        class="visible-btn ${faq.is_visible == 1 ? 'btn-on' : 'btn-off'}"
                        data-id="${faq.faq_id}"
                        data-visible="${faq.is_visible}">
                    ${faq.is_visible == 1 ? '공개' : '숨김'}
                </button>
            </span>
        </div>


        <div class="detail-row">
            <span class="detail-label">등록일</span>
            <span class="detail-value">${faq.created_at}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">수정일</span>
            <span class="detail-value">${faq.updated_at}</span>
        </div>

        <!-- 답변 -->
<div class="detail-row answer-row">
    <span class="detail-label">답변</span>
    <div class="detail-content-area">
        <div class="answer-title">ANSWER</div>
        ${faq.answer}
    </div>
</div>



        <div class="btn-area">
            <button class="btn-blue"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqEdit?faq_id=${faq.faq_id}'">
                수정
            </button>

            <form action="${pageContext.request.contextPath}/admin/adminFaqDelete"
                  method="post"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');"
                  style="display:inline-block">
                <input type="hidden" name="faq_id" value="${faq.faq_id}">
                <button class="btn-red">삭제</button>
            </form>

            <button class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                목록으로
            </button>
        </div>

    </div>

</main>

<!-- =============================
      공개/숨김 AJAX
============================== -->
<script>
$(document).ready(function(){

    $("#toggleVisibleDetail").click(function(){

        const btn = $(this);
        const faqId = btn.data("id");
        const current = btn.data("visible");
        const newVisible = current === 1 ? 0 : 1;

        $.ajax({
            url: "${pageContext.request.contextPath}/admin/adminFaqVisibleAjax",
            type: "POST",
            data: {
                faq_id: faqId,
                is_visible: newVisible
            },
            success: function(){

                btn.text(newVisible === 1 ? "공개" : "숨김");

                if(newVisible === 1){
                    btn.removeClass("btn-off").addClass("btn-on");
                }else{
                    btn.removeClass("btn-on").addClass("btn-off");
                }

                btn.data("visible", newVisible);
            },
            error: function(){
                alert("상태 변경 중 오류 발생");
            }
        });
    });

});
</script>

</body>
</html>