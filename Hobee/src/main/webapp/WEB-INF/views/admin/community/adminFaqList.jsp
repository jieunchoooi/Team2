<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 관리 | Hobee Admin</title>

    <!-- 공통 관리자 Sidebar CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- FAQ 리스트 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqList.css">
</head>

<body>

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<!-- 공통 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

<!-- ⭐ 메인 -->
<main class="main-content">

    <div class="main-header">
        <h1>FAQ 관리</h1>
    </div>

    <div class="table-card">

        <!-- 작성 버튼 -->
        <div class="right-area">
            <button class="btn-blue"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqWrite'">
                + FAQ 작성
            </button>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>No</th>
                    <th>카테고리</th>
                    <th>질문</th>
                    <th>공개</th>
                    <th>상세</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>

            <tbody>
            <c:if test="${empty faqList}">
                <tr>
                    <td colspan="7" class="empty-text">등록된 FAQ가 없습니다.</td>
                </tr>
            </c:if>

            <c:forEach var="f" items="${faqList}">
                <tr>
                    <td>${f.faq_id}</td>
                    <td>${f.category}</td>

                    <td class="left">
                        <a href="${pageContext.request.contextPath}/admin/adminFaqDetail?faq_id=${f.faq_id}"
                           class="title-link">
                           ${f.question}
                        </a>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/admin/adminFaqVisible" method="post">
                            <input type="hidden" name="faq_id" value="${f.faq_id}">
                            <input type="hidden" name="is_visible" value="${f.is_visible == 1 ? 0 : 1}">
                            <button class="${f.is_visible == 1 ? 'btn-blue' : 'btn-gray'}">
                                ${f.is_visible == 1 ? '공개' : '숨김'}
                            </button>
                        </form>
                    </td>

                    <td>
                        <button class="btn-blue"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqDetail?faq_id=${f.faq_id}'">
                            상세
                        </button>
                    </td>

                    <td>
                        <button class="btn-blue"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqEdit?faq_id=${f.faq_id}'">
                            수정
                        </button>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/admin/adminFaqDelete"
                              method="post"
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <input type="hidden" name="faq_id" value="${f.faq_id}">
                            <button class="btn-red">삭제</button>
                        </form>
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</main>

</body>
</html>
