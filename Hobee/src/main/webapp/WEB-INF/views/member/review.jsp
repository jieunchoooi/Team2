<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내가 쓴 리뷰 | Hobee</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/review.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/include/profileCard.css">

<!-- jQuery 로드 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>

<!-- header -->
<jsp:include page="../include/header.jsp"></jsp:include>

<!-- 좌측 사이드바 -->
<jsp:include page="../include/memberSidebar.jsp"></jsp:include>

<main class="main-content">
	
	<!-- 중앙 고정 레이아웃 wrapper -->
	<div class="content-wrapper">
		
		<!-- 프로필카드 -->
		<jsp:include page="../include/profileCard.jsp"></jsp:include>
	
		  <div class="table-container">
		    <table>
		      <thead>
		        <tr>
		          <th>강의명</th>
		          <th>평점</th>
		          <th>내용</th>
		          <th>관리</th>
		        </tr>
		      </thead>
		      <tbody>
		      	<c:forEach var="rev" items="${personalReview}">
			        <tr>
			          <td>${rev.lecture_title}</td>
			          <td>
						<div class="star-rating">
						    <span class="stars" style="--rating: ${rev.review_score};">
						      <span class="empty">
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						      </span>
						      <span class="filled">
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						        <i class="fas fa-star"></i>
						      </span>
						    </span>
						    <span class="score-text">${rev.review_score}</span>
						  </div>	
			          </td>
			          <td>${rev.review_content}</td>
			          <td>
			            <button class="btn" onclick="editReview(${rev.review_num}, this)">수정</button>
			            <button class="btn btn-delete" onclick="deleteReview(${rev.review_num}, this)">삭제</button>
			          </td>
			        </tr>
		        </c:forEach>
		        <c:if test="${empty personalReview}">
		        	<tr>
			            <td id="no-review" colspan="4">작성된 리뷰가 없습니다.</td>
			        </tr>
		        </c:if>
		      </tbody>
		    </table>
		  </div>
  </div>
</main>

<jsp:include page="../include/footer.jsp"></jsp:include>

<!-- 수정 모달 -->
<div id="editModal" class="modal">
  <div class="modal-content">
    <h3>리뷰 수정</h3>

    <!-- ⭐ 별점 선택 -->
    <div class="edit-stars">
	  <span class="edit-star" data-value="1"><i class="fas fa-star"></i></span>
	  <span class="edit-star" data-value="2"><i class="fas fa-star"></i></span>
	  <span class="edit-star" data-value="3"><i class="fas fa-star"></i></span>
	  <span class="edit-star" data-value="4"><i class="fas fa-star"></i></span>
	  <span class="edit-star" data-value="5"><i class="fas fa-star"></i></span>
	</div>

    <!-- 리뷰 내용 -->
    <textarea id="editContent" rows="6"></textarea>

    <div class="modal-buttons">
      <button class="btn" onclick="closeModal()">취소</button>
      <button class="btn btn-edit-confirm" onclick="saveEdit()">수정하기</button>
    </div>
  </div>
</div>

<script type="text/javascript">
let currentReviewNum = null;
let currentBtn = null;
let selectedScore = 0;

// 리뷰 모달 열기
function editReview(review_num, btn) {
    currentReviewNum = review_num;
    currentBtn = btn;

    let tr = $(btn).closest("tr");
    let content = tr.find("td").eq(2).text().trim();
    let score = parseFloat(tr.find(".score-text").text().trim());

    $("#editContent").val(content);
    selectedScore = score;

    updateStarUI(selectedScore);
    $("#editModal").show();
}

// 별 UI 업데이트 함수
function updateStarUI(score) {
    $(".edit-star").each(function(){
        let value = $(this).data("value");
        $(this).removeClass("selected half-selected");
        
        if (value <= Math.floor(score)) {
            $(this).addClass("selected");
        } else if (value === Math.ceil(score) && score % 1 !== 0) {
            $(this).addClass("half-selected");
        }
    });
}

// 별 클릭 이벤트 (0.5 단위)
$(document).on("click", ".edit-star", function(e) {
    let star = $(this);
    let value = star.data("value");
    let rect = star[0].getBoundingClientRect();
    let clickX = e.clientX - rect.left;
    let starWidth = rect.width;
    
    // 별의 왼쪽 절반 클릭 시 0.5, 오른쪽 절반 클릭 시 1.0
    if (clickX < starWidth / 2) {
        selectedScore = value - 0.5;
    } else {
        selectedScore = value;
    }
    
    updateStarUI(selectedScore);
});

// 별 hover 효과 (0.5 단위)
$(document).on("mousemove", ".edit-star", function(e) {
    let star = $(this);
    let value = star.data("value");
    let rect = star[0].getBoundingClientRect();
    let mouseX = e.clientX - rect.left;
    let starWidth = rect.width;
    
    $(".edit-star").removeClass("hover half-hover");
    
    $(".edit-star").each(function(){
        let currentValue = $(this).data("value");
        
        if (currentValue < value) {
            $(this).addClass("hover");
        } else if (currentValue === value) {
            if (mouseX < starWidth / 2) {
                $(this).addClass("half-hover");
            } else {
                $(this).addClass("hover");
            }
        }
    });
});

// hover 빠져나가면 원래대로
$(document).on("mouseleave", ".edit-stars", function() {
    $(".edit-star").removeClass("hover half-hover");
    updateStarUI(selectedScore);
});

// 리뷰 모달 닫기
function closeModal() {
    $("#editModal").hide();
}

// 리뷰 수정 
function saveEdit() {
    let newContent = $("#editContent").val().trim();

    if(selectedScore === 0) {
        alert("별점을 선택해주세요.");
        return;
    }

    if(newContent === "") {
        alert("내용을 입력해주세요.");
        return;
    }

    $.ajax({
        url: '${pageContext.request.contextPath}/member/updateReview',
        method: 'POST',
        data: { 
            review_num: currentReviewNum,
            review_content: newContent,
            review_score: selectedScore.toFixed(1)
        },
        success: function(result){
            if(result.success){
                let tr = $(currentBtn).closest("tr");
                tr.find("td").eq(2).text(newContent);
                tr.find(".score-text").text(selectedScore.toFixed(1));
                tr.find(".stars").css("--rating", selectedScore);
                
                closeModal();
                alert("리뷰가 수정되었습니다.");
            } else {
                alert("리뷰 수정 실패");
            }
        },
        error: function(){
            alert("서버 오류");
        }
    });
}

// 리뷰 삭제
function deleteReview(review_num, btn){
    if(!confirm("정말 삭제하시겠습니까?")) {
        return; 
    }
 
    $.ajax({
        url: '${pageContext.request.contextPath}/member/deleteReview',
        method: 'POST',
        data: { review_num: review_num },
        success: function(result){
            if(result.success){
                $(btn).closest("tr").remove();
            } else {
                alert("리뷰 삭제에 실패했습니다.");
            }
        },
        error: function(){
            alert("서버 오류가 발생했습니다.");
        }
    });
}

</script>


</body>
</html>













