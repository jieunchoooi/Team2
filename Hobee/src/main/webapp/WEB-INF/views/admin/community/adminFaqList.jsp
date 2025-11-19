<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 관리</title>

    <!-- 공통 관리자 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLayout.css">

    <!-- FAQ 리스트 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminFaqList.css">
</head>

<body>

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp">
    <jsp:param name="page" value="faqList"/>
</jsp:include>

<div class="admin-main">
<div class="admin-card">

    <h2>❓ FAQ 관리</h2>

    <!-- 작성 버튼 -->
    <div style="text-align:right; margin-bottom:15px;">
        <button class="btn-blue"
            onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqWrite'">
            + FAQ 작성
        </button>
    </div>

    <table class="faq-table">
        <thead>
            <tr>
                <th width="60">No</th>
                <th width="140">카테고리</th>
                <th>질문</th>
                <th width="100">공개</th>
                <th width="80">상세</th>
                <th width="80">수정</th>
                <th width="80">삭제</th>
            </tr>
        </thead>

        <tbody>

        <!-- 목록이 없을 때 -->
        <c:if test="${empty faqList}">
            <tr>
                <td colspan="7" style="text-align:center; padding:20px;">
                    등록된 FAQ가 없습니다.
                </td>
            </tr>
        </c:if>

        <!-- FAQ 목록 -->
        <c:forEach var="f" items="${faqList}">
            <tr>
                <td>${f.faq_id}</td>

                <td>${f.category}</td>

                <!-- 질문 클릭 -> 상세 이동 -->
                <td style="text-align:left; padding-left:12px;">
                    <a href="${pageContext.request.contextPath}/admin/adminFaqDetail?faq_id=${f.faq_id}"
                       style="color:#2f6bff; font-weight:600; text-decoration:none;">
                       ${f.question}
                    </a>
                </td>

                <!-- 공개/숨김 -->
                <td>
                    <form action="${pageContext.request.contextPath}/admin/adminFaqVisible" method="post">
                        <input type="hidden" name="faq_id" value="${f.faq_id}">
                        <input type="hidden" name="is_visible" value="${f.is_visible == 1 ? 0 : 1}">

                        <button class="${f.is_visible == 1 ? 'btn-blue' : 'btn-gray'}">
                            ${f.is_visible == 1 ? '공개' : '숨김'}
                        </button>
                    </form>
                </td>

                <!-- 상세 -->
                <td>
                    <button class="btn-blue"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqDetail?faq_id=${f.faq_id}'">
                        상세
                    </button>
                </td>

                <!-- 수정 -->
                <td>
                    <button class="btn-blue"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqEdit?faq_id=${f.faq_id}'">
                        수정
                    </button>
                </td>

                <!-- 삭제 -->
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
</div>

</body>
</html>
