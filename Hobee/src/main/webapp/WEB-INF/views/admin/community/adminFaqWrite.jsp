<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 작성</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- FAQ 작성 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminFaqWrite.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="faqList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>📝 FAQ 작성</h2>

    <form action="${pageContext.request.contextPath}/admin/adminFaqWritePro" method="post">

        <table class="faq-write-table">
            <tbody>

                <!-- 카테고리 -->
                <tr>
                    <td class="faq-label">카테고리</td>
                    <td>
                        <select name="category" class="faq-select" required>
                            <option value="">카테고리 선택</option>
                            <option value="계정">계정</option>
                            <option value="결제">결제</option>
                            <option value="커뮤니티">커뮤니티</option>
                            <option value="수업">수업</option>
                            <option value="기타">기타</option>
                        </select>
                    </td>
                </tr>

                <!-- 질문 -->
                <tr>
                    <td class="faq-label">질문</td>
                    <td>
                        <input type="text" name="question" class="faq-input" required>
                    </td>
                </tr>

                <!-- 공개 여부 -->
                <tr>
                    <td class="faq-label">공개 여부</td>
                    <td>
                        <select name="is_visible" class="faq-select">
                            <option value="1">공개</option>
                            <option value="0">숨김</option>
                        </select>
                    </td>
                </tr>

                <!-- 답변 -->
                <tr>
                    <td class="faq-label" style="vertical-align:top;">답변</td>
                    <td>
                        <textarea name="answer" class="faq-textarea" required></textarea>
                    </td>
                </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="faq-btn-area">
            <button type="submit" class="btn-blue">등록하기</button>
            <button type="button" class="btn-gray"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                목록
            </button>
        </div>

    </form>

</div>
</div>

</body>
</html>
