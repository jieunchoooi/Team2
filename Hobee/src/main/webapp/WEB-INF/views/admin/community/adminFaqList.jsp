<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FAQ 관리 | Hobee Admin</title>

    <!-- 공통 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">

    <!-- FAQ List CSS (캐시 방지) -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/admin/adminFaqList.css?v=9999">

    <!-- jQuery + jQuery UI (FAQ 전용) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link rel="stylesheet"
          href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

    <!-- jQuery 충돌 방지 -->
    <script>
        var jqFaq = jQuery.noConflict(true);
    </script>
</head>

<body>

<!-- 공통 header / sidebar -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/adminSidebar.jsp"/>

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

        <!-- 필터 -->
        <div class="filter-box">
            <form method="get" action="${pageContext.request.contextPath}/admin/adminFaqList">

                <select name="category">
                    <option value="">전체</option>
                    <option value="계정" ${category=='계정'?'selected':''}>계정</option>
                    <option value="결제" ${category=='결제'?'selected':''}>결제</option>
                    <option value="커뮤니티" ${category=='커뮤니티'?'selected':''}>커뮤니티</option>
                    <option value="수업" ${category=='수업'?'selected':''}>수업</option>
                    <option value="기타" ${category=='기타'?'selected':''}>기타</option>
                </select>

                <input type="text" name="keyword" placeholder="질문 검색" value="${keyword}">

                <select name="sort">
                    <option value="order" ${sort=='order'?'selected':''}>정렬순</option>
                    <option value="new" ${sort=='new'?'selected':''}>최신순</option>
                    <option value="old" ${sort=='old'?'selected':''}>오래된순</option>
                    <option value="category" ${sort=='category'?'selected':''}>카테고리순</option>
                </select>

                <button class="btn-blue">검색</button>

                <button type="button" class="btn-gray"
                        onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                    초기화
                </button>
            </form>
        </div>

        <!-- FAQ TABLE -->
        <table class="admin-table">
            <thead>
            <tr>
                <th>정렬</th>
                <th>No</th>
                <th>카테고리</th>
                <th>질문</th>
                <th>공개</th>
                <th>상세</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
            </thead>

            <!-- 정렬 + FAQ 목록 -->
            <tbody id="faqSortable">

            <c:if test="${empty faqList}">
                <tr>
                    <td colspan="8" class="empty-text">등록된 FAQ가 없습니다.</td>
                </tr>
            </c:if>

            <c:forEach var="f" items="${faqList}">
                <!-- 🔵 질문 행 -->
                <tr class="faq-row" data-id="${f.faq_id}">

                    <td class="drag-handle">≡</td>
                    <td>${f.faq_id}</td>

                    <td>
                        <span class="faq-badge
                            ${f.category=='계정'?'badge-account':
                              f.category=='결제'?'badge-payment':
                              f.category=='커뮤니티'?'badge-community':
                              f.category=='수업'?'badge-class':'badge-etc'}">
                            ${f.category}
                        </span>
                    </td>

                    <td class="faq-question" data-id="${f.faq_id}">
                        ${f.question}
                    </td>

                   <td>
    					<button class="toggle-visible ${f.is_visible==1?'btn-green':'btn-gray'}"
           						data-id="${f.faq_id}" data-visible="${f.is_visible}">
        					${f.is_visible==1?'공개':'숨김'}
    					</button>
				    </td>


                    <td>
                        <button class="btn-blue"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqDetail?faq_id=${f.faq_id}'">
                            상세
                        </button>
                    </td>

                    <td>
                        <button class="btn-purple"
                                onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqEdit?faq_id=${f.faq_id}'">
                            수정
                        </button>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/admin/adminFaqDelete"
                              method="post" onsubmit="return confirm('삭제하시겠습니까?');">
                            <input type="hidden" name="faq_id" value="${f.faq_id}">
                            <button class="btn-red">삭제</button>
                        </form>
                    </td>
                </tr>

                <!-- 🔴 접기/펼치기 답변 행 -->
                <tr class="faq-answer-row" data-id="${f.faq_id}" style="display:none;">
                    <td colspan="8">
                        <div class="faq-answer-box">
                            ${f.answer}
                        </div>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>

        <!-- 페이징 -->
        <div class="paging">
            <c:if test="${pageNum > 1}">
                <a href="?pageNum=${pageNum - 1}&category=${category}&keyword=${keyword}&sort=${sort}"
                   class="page-btn">이전</a>
            </c:if>

            <c:forEach begin="1" end="${totalPage}" var="i">
                <a href="?pageNum=${i}&category=${category}&keyword=${keyword}&sort=${sort}"
                   class="page-num ${i == pageNum ? 'active' : ''}">
                    ${i}
                </a>
            </c:forEach>

            <c:if test="${pageNum < totalPage}">
                <a href="?pageNum=${pageNum + 1}&category=${category}&keyword=${keyword}&sort=${sort}"
                   class="page-btn">다음</a>
            </c:if>
        </div>

    </div>
</main>

<!-- FAQ JS -->
<script>
jqFaq(function () {

    /* -----------------------------------------
       ⭐ 드래그 정렬
    ----------------------------------------- */
    jqFaq("#faqSortable").sortable({
        handle: ".drag-handle",
        placeholder: "drag-row-highlight",
        axis: "y",
        containment: "parent",

        update: function () {
            let orderList = [];

            jqFaq("#faqSortable tr.faq-row").each(function(index){
                orderList.push({
                    faq_id: jqFaq(this).data("id"),
                    faq_order: index + 1
                });
            });

            jqFaq.ajax({
                url: "${pageContext.request.contextPath}/admin/adminFaqUpdateOrder",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(orderList),
                success: function(){
                    console.log("FAQ 순서 저장 완료");
                }
            });
        }
    });

    /* -----------------------------------------
       ⭐ 접기/펼치기
    ----------------------------------------- */
    jqFaq(".faq-question").click(function () {

        const id = jqFaq(this).data("id");
        const answerRow = jqFaq(".faq-answer-row[data-id='" + id + "']");

        if (answerRow.is(":visible")) {
            answerRow.slideUp(200);
            return;
        }

        jqFaq(".faq-answer-row:visible").slideUp(200);
        answerRow.slideDown(200);
    });

    /* -----------------------------------------
       ⭐ 공개 / 숨김 토글
    ----------------------------------------- */
    jqFaq(".toggle-visible").click(function() {

        const btn = jqFaq(this);
        const id = btn.data("id");
        const now = btn.data("visible");
        const next = now === 1 ? 0 : 1;

        jqFaq.ajax({
            url: "${pageContext.request.contextPath}/admin/adminFaqVisibleAjax",
            type: "POST",
            data: { faq_id: id, is_visible: next },
            success: function(){
                btn.text(next === 1 ? "공개" : "숨김")
                   .toggleClass("btn-blue", next === 1)
                   .toggleClass("btn-gray", next === 0)
                   .data("visible", next);
            }
        });
    });

});
</script>

</body>
</html>
