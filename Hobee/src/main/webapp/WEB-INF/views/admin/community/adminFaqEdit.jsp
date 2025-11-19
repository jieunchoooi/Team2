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
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqEdit.css">
</head>

<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<main class="main-content">

    <div class="main-header">
        <h1>FAQ 수정</h1>
    </div>

    <div class="form-card">

        <form action="${pageContext.request.contextPath}/admin/adminFaqEditPro"
              method="post">

            <input type="hidden" name="faq_id" value="${faq.faq_id}">

            <div class="form-group">
                <label>카테고리</label>
                <select name="category">
                    <option value="계정" ${faq.category=='계정'?'selected':''}>계정</option>
                    <option value="결제" ${faq.category=='결제'?'selected':''}>결제</option>
                    <option value="커뮤니티" ${faq.category=='커뮤니티'?'selected':''}>커뮤니티</option>
                    <option value="수업" ${faq.category=='수업'?'selected':''}>수업</option>
                    <option value="기타" ${faq.category=='기타'?'selected':''}>기타</option>
                </select>
            </div>

            <div class="form-group">
                <label>질문</label>
                <input type="text" name="question"
                       value="${faq.question}" required>
            </div>

            <div class="form-group">
                <label>공개 여부</label>
                <select name="is_visible">
                    <option value="1" ${faq.is_visible==1?"selected":""}>공개</option>
                    <option value="0" ${faq.is_visible==0?"selected":""}>숨김</option>
                </select>
            </div>

            <div class="form-group">
                <label>답변</label>
                <textarea name="answer" required>${faq.answer}</textarea>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn-blue">수정 완료</button>

                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqDetail?faq_id=${faq.faq_id}'">
                    상세
                </button>
            </div>

        </form>

    </div>

</main>

</body>
</html>
