<%@ page contentType="text/html; charset=UTF-8" %>

<!-- tagSelectionModal.jsp -->
<div id="tagSelectionModal" class="modal" style="display:none;">
    <div class="modal-overlay"></div>

    <div class="tag-modal-content">
        <span class="tag-close">×</span>

        <h2 class="tag-title">관심 태그 선택</h2>
        <p class="tag-subtitle">관심있는 분야를 선택해주세요 (최대 5개)</p>

        <form id="tagForm">
            <input type="hidden" id="tag_user_id" name="user_id">
            
            <div class="tag-grid">
                <label class="tag-item">
                    <input type="checkbox" name="tags" value="운동">
                    <span>🏃 운동</span>
                </label>
                <label class="tag-item">
                    <input type="checkbox" name="tags" value="요리">
                    <span>🍳 요리</span>
                </label>
                <label class="tag-item">
                    <input type="checkbox" name="tags" value="음악">
                    <span>🎵 음악</span>
                </label>
                <label class="tag-item">
                    <input type="checkbox" name="tags" value="미술">
                    <span>🎨 미술</span>
                </label>
                <label class="tag-item">
                    <input type="checkbox" name="tags" value="댄스">
                    <span>💃 댄스</span>
                </label>
                <!-- 더 많은 태그 추가 -->
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
.tag-modal-content {
    background: white;
    padding: 40px;
    border-radius: 16px;
    max-width: 600px;
    width: 90%;
}

.tag-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin: 30px 0;
}

.tag-item {
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s;
}

.tag-item input[type="checkbox"] {
    display: none;
}

.tag-item input[type="checkbox"]:checked + span {
    color: #2573ff;
    font-weight: bold;
}

.tag-item:has(input:checked) {
    border-color: #2573ff;
    background: #f0f7ff;
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
}

.tag-btn-primary {
    background: #2573ff;
    color: white;
}

.tag-btn-secondary {
    background: #e5e7eb;
    color: #666;
}
</style>

<script>
// 태그 모달 닫기
$(".tag-close, #skipTagBtn").click(function() {
    $("#tagSelectionModal").fadeOut();
    $("#loginModal").fadeIn().css("display", "flex");
});

// 태그 저장
$("#saveTagBtn").click(function() {
    const selectedTags = [];
    $("input[name='tags']:checked").each(function() {
        selectedTags.push($(this).val());
    });

    if (selectedTags.length === 0) {
        $("#tagError").text("최소 1개 이상 선택해주세요.");
        return;
    }

    if (selectedTags.length > 5) {
        $("#tagError").text("최대 5개까지 선택 가능합니다.");
        return;
    }

    $.ajax({
        url: contextPath + "/user/saveTags",
        type: "POST",
        data: {
            user_id: $("#tag_user_id").val(),
            tags: selectedTags
        },
        traditional: true,
        success: function() {
            $("#tagSelectionModal").fadeOut();
            $("#loginModal").fadeIn().css("display", "flex");
        }
    });
});

// 최대 5개 제한
$("input[name='tags']").change(function() {
    if ($("input[name='tags']:checked").length > 5) {
        $(this).prop("checked", false);
        $("#tagError").text("최대 5개까지 선택 가능합니다.");
    } else {
        $("#tagError").text("");
    }
});
</script>