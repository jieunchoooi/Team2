<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ | Hobee</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/user/faq.css">

    <style>
        .faq-container { max-width: 900px; margin: 40px auto; }
        .faq-title { font-size: 32px; margin-bottom: 20px; font-weight: 700; }

        .faq-category-box { margin-bottom: 20px; }
        .faq-category-box select { padding: 6px 10px; font-size: 15px; }

        .faq-item { border-bottom: 1px solid #ddd; padding: 14px 0; cursor: pointer; }
        .faq-q { font-size: 18px; font-weight: 600; display: flex; justify-content: space-between; }
        .faq-a { display:none; margin-top:10px; padding:10px; background:#f9f9f9; border-radius:6px; }

        .arrow { transition: 0.2s; }
        .arrow.open { transform: rotate(180deg); }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="faq-container">

    <h1 class="faq-title">FAQ</h1>

    <!-- ⭐ 카테고리 선택 -->
    <form method="get" action="${pageContext.request.contextPath}/faq/list" class="faq-category-box">
        <select name="category" onchange="this.form.submit()">
            <option value="">전체</option>
            <option value="계정" ${param.category == '계정' ? 'selected' : ''}>계정</option>
            <option value="결제" ${param.category == '결제' ? 'selected' : ''}>결제</option>
            <option value="커뮤니티" ${param.category == '커뮤니티' ? 'selected' : ''}>커뮤니티</option>
            <option value="수업" ${param.category == '수업' ? 'selected' : ''}>수업</option>
            <option value="기타" ${param.category == '기타' ? 'selected' : ''}>기타</option>
        </select>
    </form>

    <!-- ⭐ FAQ 목록 -->
    <c:forEach var="f" items="${faqList}">
        <div class="faq-item" onclick="toggleFaq(${f.faq_id})">
            <div class="faq-q">
                ${f.question}
                <span class="arrow" id="arrow-${f.faq_id}">▼</span>
            </div>
            <div class="faq-a" id="answer-${f.faq_id}">
                ${f.answer}
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty faqList}">
        <p style="padding:20px;">등록된 FAQ가 없습니다.</p>
    </c:if>
</div>

<script>
function toggleFaq(id){
    const a = document.getElementById("answer-"+id);
    const arrow = document.getElementById("arrow-"+id);

    const visible = a.style.display === "block";
    document.querySelectorAll(".faq-a").forEach(x => x.style.display = "none");
    document.querySelectorAll(".arrow").forEach(x => x.classList.remove("open"));

    if(!visible){
        a.style.display = "block";
        arrow.classList.add("open");
    }
}
</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

</body>
</html>
