<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- tagSelectionModal.jsp -->
<div id="tagSelectionModal" class="modal" style="display:none;">
    <div class="modal-overlay"></div>

    <div class="tag-modal-content">
        <div style="text-align: right;">
            <span class="tag-close">×</span>	
        </div>
        <h2 class="tag-title">관심 분야 선택</h2>
        <p class="tag-subtitle">관심있는 분야를 선택해주세요 (최대 5개)</p>

        <form id="tagForm" action="${pageContext.request.contextPath}/user/saveTags">
            <input type="hidden" id="tag_user_id" name="user_id">
            
            <!-- 🔥 동적으로 로드될 영역 -->
            <div class="tag-grid" id="interestTagGrid">
                <div class="loading-spinner">
					<c:forEach var="interest" items="${interestList}">
						${interest}
					</c:forEach>
				</div>
            </div>

            <div id="tagError" class="error-msg"></div>

            <div class="tag-btn-group">
                <button type="button" id="skipTagBtn" class="tag-btn-secondary">건너뛰기</button>
                <button type="button" id="saveTagBtn" class="tag-btn-primary">완료</button>
            </div>
        </form>
    </div>
</div>

<style>
.tag-close {
    font-size: 30px;
    cursor: pointer;
    color: #666;
    transition: color 0.2s;
}

.tag-close:hover { color: #2573ff; }

.tag-modal-content {
    background: white;
    padding: 40px;
    border-radius: 16px;
    max-width: 600px;
    width: 90%;
    max-height: 90vh;
    overflow-y: auto;
}

.tag-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
}

.tag-subtitle {
    color: #666;
    font-size: 14px;
    margin-bottom: 20px;
}

.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: none;
    justify-content: center;
    align-items: center;
    backdrop-filter: blur(5px);
    background: rgba(0, 0, 0, 0.3);
    z-index: 999;
}

.tag-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    gap: 15px;
    margin: 30px 0;
    min-height: 200px;
}

.loading-spinner {
    grid-column: 1 / -1;
    text-align: center;
    color: #999;
    padding: 40px;
}

.tag-item {
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s;
    position: relative;
}

.tag-item:hover {
    border-color: #2573ff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(37, 115, 255, 0.15);
}

.tag-item input[type="checkbox"] { display: none; }

.tag-item span {
    display: block;
    font-size: 15px;
    color: #333;
    font-weight: 500;
}

.tag-item input[type="checkbox"]:checked + span {
    color: #2573ff;
    font-weight: bold;
}

.tag-item:has(input:checked) {
    border-color: #2573ff;
    background: #f0f7ff;
}

.tag-item:has(input:checked)::after {
    content: "✓";
    position: absolute;
    top: 8px;
    right: 8px;
    color: #2573ff;
    font-weight: bold;
    font-size: 18px;
}

.tag-btn-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.tag-btn-primary, .tag-btn-secondary {
    padding: 12px 30px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    transition: all 0.3s;
}

.tag-btn-primary {
    background: #2573ff;
    color: white;
}

.tag-btn-primary:hover {
    background: #1a5ce6;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(37, 115, 255, 0.3);
}

.tag-btn-secondary {
    background: #e5e7eb;
    color: #666;
}

.tag-btn-secondary:hover {
    background: #d1d5db;
}

.error-msg {
    color: #e74c3c;
    font-size: 14px;
    text-align: center;
    margin: 10px 0;
}
</style>

<script>
const contextPath = "${pageContext.request.contextPath}";

// 🔥 태그 모달을 여는 전역 함수
window.openTagModal = function(userId) {
    $("#tag_user_id").val(userId);
    $("#tagSelectionModal").fadeIn().css("display", "flex");
    loadInterests();
};

// Interest 데이터 로드 함수
function loadInterests() {
    $.ajax({
        url: contextPath + "/user/getInterests",
        type: "GET",
        dataType: "json",
        success: function(interests) {
            const grid = $("#interestTagGrid");
            grid.empty();
            if (!interests || interests.length === 0) {
                grid.html('<div class="loading-spinner">등록된 관심 분야가 없습니다.</div>');
                return;
            }
            // 동적 태그 생성 (String 기준)
            interests.forEach(function(interestName) {
                const tagHtml = 
                    '<label class="tag-item">' +
                        '<input type="checkbox" name="tags" value="' + interestName + '">' +
                        '<span>' + interestName + '</span>' +
                    '</label>';
                grid.append(tagHtml);
            });
        },
        error: function(xhr, status, error) {
            $("#interestTagGrid").html(
                '<div class="loading-spinner" style="color: #e74c3c;">' +
                '데이터를 불러오는데 실패했습니다.<br>(에러: ' + xhr.status + ')</div>'
            );
        }
    });
}

$(document).ready(function() {
    // 최대 5개 선택 제한
    $(document).on("change", "input[name='tags']", function() {
        const checkedCount = $("input[name='tags']:checked").length;
        if (checkedCount > 5) {
            $(this).prop("checked", false);
            $("#tagError").text("최대 5개까지 선택 가능합니다.");
            setTimeout(() => { $("#tagError").text(""); }, 2000);
        } else {
            $("#tagError").text("");
        }
    });

    // 태그 모달 닫기
    $(".tag-close, #skipTagBtn").click(() => { $("#tagSelectionModal").fadeOut(); });

    // 태그 저장
    $("#saveTagBtn").click(function() {
        const userId = $("#tag_user_id").val();
        if (!userId) { $("#tagError").text("사용자 정보가 없습니다."); return; }

        const selectedTags = $("input[name='tags']:checked").map(function() { return $(this).val(); }).get();
        if (selectedTags.length === 0) { $("#tagError").text("최소 1개 이상 선택해주세요."); return; }

        $.ajax({
            url: contextPath + "/user/saveTags",
            type: "POST",
            data: { user_id: userId, tags: selectedTags },
            traditional: true,
            success: function(response) {
                $("#tagSelectionModal").fadeOut();
                if (typeof Swal !== 'undefined') {
                    Swal.fire({
                        icon: "success",
                        title: "관심 분야 등록 완료!",
                        text: "맞춤 추천 강의를 확인해보세요.",
                        confirmButtonColor: "#2573ff",
                        timer: 2000
                    }).then(() => { location.href = contextPath + "/main/main"; });
                } else {
                    alert("관심 분야가 등록되었습니다!");
                    location.href = contextPath + "/main/main";
                }
            },
            error: function(xhr, status, error) {
                $("#tagError").text("저장 중 오류가 발생했습니다.");
            }
        });
    });
});
</script>
