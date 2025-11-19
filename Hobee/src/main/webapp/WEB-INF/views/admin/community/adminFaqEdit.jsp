<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 수정</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- FAQ 수정 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminFaqEdit.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="faqList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>✏️ FAQ 수정</h2>

    <form action="${pageContext.request.contextPath}/admin/adminFaqEditPro" method="post">

        <!-- 변경 시 반드시 필요 -->
        <input type="hidden" name="faq_id" value="${faq.faq_id}">

        <table class="faq-edit-table">
            <tbody>

                <!-- 카테고리 -->
                <tr>
                    <td class="faq-label">카테고리</td>
                    <td>
                        <select name="category" class="faq-select" required>
                            <option value="계정" ${faq.category == '계정' ? 'selected' : ''}>계정</option>
                            <option value="결제" ${faq.category == '결제' ? 'selected' : ''}>결제</option>
                            <option value="커뮤니티" ${faq.category == '커뮤니티' ? 'selected' : ''}>커뮤니티</option>
                            <option value="수업" ${faq.category == '수업' ? 'selected' : ''}>수업</option>
                            <option value="기타" ${faq.category == '기타' ? 'selected' : ''}>기타</option>
                        </select>
                    </td>
                </tr>

                <!-- 질문 -->
                <tr>
                    <td class="faq-label">질문</td>
                    <td>
                        <input type="text" name="question"
                               class="faq-input"
                               value="${faq.question}" required>
                    </td>
                </tr>

                <!-- 공개 여부 -->
                <tr>
                    <td class="faq-label">공개 여부</td>
                    <td>
                        <select name="is_visible" class="faq-select">
                            <option value="1" ${faq.is_visible == 1 ? 'selected' : ''}>공개</option>
                            <option value="0" ${faq.is_visible == 0 ? 'selected' : ''}>숨김</option>
                        </select>
                    </td>
                </tr>

                <!-- 답변 -->
                <tr>
                    <td class="faq-label" style="vertical-align:top;">답변</td>
                    <td>
                        <textarea name="answer" class="faq-textarea" required>${faq.answer}</textarea>
                    </td>
                </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="faq-btn-area">
            <button type="submit" class="btn-blue">수정 완료</button>

            <button type="button" class="btn-gray"
                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqDetail?faq_id=${faq.faq_id}'">
                상세로
            </button>
        </div>

    </form>

</div>
</div>

</body>
</html>
