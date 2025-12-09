<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${faq.question} | Hobee FAQ</title>

    <style>
        .detail-box { max-width: 900px; margin:40px auto; }
        .q { font-size:24px; font-weight:700; margin-bottom:10px; }
        .a { background:#f9f9f9; padding:20px; border-radius:6px; }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="detail-box">
    <div class="q">${faq.question}</div>
    <div class="a">${faq.answer}</div>

    <button onclick="location.href='${pageContext.request.contextPath}/faq/list'">
        목록으로
    </button>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

</body>
</html>
