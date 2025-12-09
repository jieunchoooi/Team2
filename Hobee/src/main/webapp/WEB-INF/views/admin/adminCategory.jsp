<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리 편집 | Hobee Admin</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSidebar.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body { 
     overflow-y: hidden !important;  
     font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
} 

.main-content {
    margin-left: 240px;
    margin-top: 0;
    padding: 15px 30px 30px 30px;
    width: calc(100% - 240px);
    background-color: #f9fafb;
    min-height: 100vh;
    box-sizing: border-box;
    overflow-x: auto;
}

.category-management {
    max-width: 1400px;
    padding: 25px 35px;
    margin: 0 auto;
    background: #fff;
    border: 1px solid #ddd;
    margin-top: 50px;
}

.category-management h2 {
    font-size: 20px;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #333;
}

/* 카테고리 관리 섹션 */
.category-section {
    margin-bottom: 20px;
}

.category-header {
    display: flex;
    gap: 10px;
    margin-bottom: 15px;
}

.category-header button {
    padding: 6px 15px;
    border: 1px solid #ddd;
    background: #f9f9f9;
    cursor: pointer;
    font-size: 13px;
}

.category-header button:hover {
    background: #e9e9e9;
}

/* 카테고리 트리 */
.category-tree {
    width: 100%;
    border: 1px solid #ddd;
    padding: 10px;
    min-height: 400px;
    max-height: 600px;
    overflow-y: auto;
}

.category-item {
    padding: 8px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 10px;
    border-bottom: 1px solid #f0f0f0;
}

.category-item:hover {
    background: #f9f9f9;
}

.category-item.selected {
    background: #e0e0e0;
}

.category-item input[type="checkbox"] {
    margin-right: 5px;
}

.main-category {
    font-weight: bold;
    background: #f5f5f5;
}

.sub-category {
    padding-left: 30px;
    font-size: 14px;
}

.category-name {
    flex: 1;
}

.category-order {
    display: flex;
    align-items: center;
    gap: 5px;
}

.category-order input {
    width: 50px;
    padding: 4px;
    text-align: center;
    border: 1px solid #ddd;
    border-radius: 3px;
}

/* 대분류 순서 입력 필드 - 진하게 */
.main-category .category-order input {
    font-weight: bold;
    border: 2px solid #999;
}

/* 소분류 순서 입력 필드 - 기본 스타일 유지 */
.sub-category .category-order input {
    border: 1px solid #ddd;
}

.category-order-buttons {
    display: flex;
    flex-direction: column;
    gap: 2px;
}

.category-order-buttons button {
    padding: 2px 8px;
    font-size: 11px;
    border: 1px solid #ddd;
    background: #fff;
    cursor: pointer;
}

.category-order-buttons button:hover {
    background: #f0f0f0;
}

.category-count {
    color: #666;
    font-size: 12px;
    min-width: 40px;
    text-align: right;
}

/* 확인 버튼 */
.submit-section {
    text-align: center;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #e5e5e5;
}

.submit-section button {
    padding: 10px 40px;
    background: #00c73c;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
}

.submit-section button:hover {
    background: #00b136;
}
</style>
</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include>

<div class="admin-container">
    <jsp:include page="../include/adminSidebar.jsp"></jsp:include>
    
    <main class="main-content">
        <div class="category-management">
<!--             <h2>카테고리 관리</h2> -->
            
            <!-- 카테고리 관리 -->
            <div class="category-section">
                <div class="category-header">
                    <button type="button" id="addMainCategory">+ 대분류 추가</button>
                    <button type="button" id="addSubCategory">+ 소분류 추가</button>
                    <button type="button" id="deleteCategory">- 삭제</button>
                    <button type="button" id="saveOrder">순서 저장</button>
                </div>
                
                <!-- 카테고리 트리 -->
                <div class="category-tree">
                    <div class="category-item" data-category-id="0" data-type="all">
                        <span class="category-name">카테고리 전체보기</span>
<!--                         <span class="category-count">(0)</span> -->
                    </div>
                    
                    <c:forEach var="mainCategory" items="${categoMainryList}">
                        <div class="category-item main-category" 
                             data-category-id="${mainCategory.category_main_num}" 
                             data-type="main"
                             data-name="${mainCategory.category_main_name}"
                             data-order="${mainCategory.category_main_order}">
                            <input type="checkbox">
                            <span class="category-name">${mainCategory.category_main_name}</span>
                            <div class="category-order">
                                <input type="number" class="order-input main-order-input" value="${mainCategory.category_main_order}" min="0">
                                <div class="category-order-buttons">
                                    <button type="button" class="order-up">▲</button>
                                    <button type="button" class="order-down">▼</button>
                                </div>
                            </div>
<!--                             <span class="category-count">(0)</span> -->
                        </div>
                        
                        <c:forEach var="category" items="${categoryList}">
                            <c:if test="${category.category_main_name == mainCategory.category_main_name}">
                                <div class="category-item sub-category" 
                                     data-category-id="${category.category_num}" 
                                     data-type="sub"
                                     data-main-name="${category.category_main_name}"
                                     data-name="${category.category_detail}"
                                     data-order="${category.category_order}">
                                    <input type="checkbox">
                                    <span class="category-name">${category.category_detail}</span>
                                    <div class="category-order">
                                        <input type="number" class="order-input sub-order-input" value="${category.category_order}" min="0">
                                        <div class="category-order-buttons">
                                            <button type="button" class="order-up">▲</button>
                                            <button type="button" class="order-down">▼</button>
                                        </div>
                                    </div>
<!--                                     <span class="category-count">(0)</span> -->
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </div>
            </div>
            
            <!-- 확인 버튼 -->
<!--             <div class="submit-section"> -->
<!--                 <button type="button" id="submitBtn">확인</button> -->
<!--             </div> -->
        </div>
    </main>
</div>

<script>
$(document).ready(function() {
    let selectedItem = null;
    
    // 카테고리 선택
    $('.category-item').click(function(e) {
        if ($(e.target).is('input[type="number"]') || 
            $(e.target).is('button')) {
            return;
        }
        
        // 모든 체크박스 해제
        $('.category-item input[type="checkbox"]').prop('checked', false);
        
        $('.category-item').removeClass('selected');
        $(this).addClass('selected');
        selectedItem = $(this);
        
        // 체크박스가 클릭된 경우가 아니면 체크박스 체크
        if (!$(e.target).is('input[type="checkbox"]')) {
            let checkbox = $(this).find('input[type="checkbox"]');
            checkbox.prop('checked', true);
        }
    });
    
    // 체크박스 클릭 시 항목도 선택
    $('.category-item input[type="checkbox"]').click(function(e) {
        e.stopPropagation();
        
        // 모든 체크박스 해제 및 선택 해제
        $('.category-item input[type="checkbox"]').prop('checked', false);
        $('.category-item').removeClass('selected');
        
        // 현재 항목만 체크 및 선택
        $(this).prop('checked', true);
        let item = $(this).closest('.category-item');
        item.addClass('selected');
        selectedItem = item;
    });
    
    // 순서 입력 막기 (클릭 이벤트 전파 방지)
    $('.order-input').click(function(e) {
        e.stopPropagation();
    });
    
    // 위로 이동
    $(document).on('click', '.order-up', function(e) {
        e.stopPropagation();
        let item = $(this).closest('.category-item');
        let itemType = item.data('type');
        let prev;
        
        if (itemType === 'main') {
            // 대분류: 이전 대분류와 그 하위 소분류들 전체를 찾음
            prev = findPrevMainWithSubs(item);
            if (prev) {
                let currentGroup = getMainWithSubs(item);
                currentGroup.insertBefore(prev.first());
                updateMainOrderNumbers();
            }
        } else if (itemType === 'sub') {
            // 소분류: 같은 대분류 내에서만 이동
            prev = item.prev('.sub-category');
            let mainName = item.data('main-name');
            
            if (prev.length && prev.data('main-name') === mainName) {
                item.insertBefore(prev);
                updateSubOrderNumbers(mainName);
            }
        }
    });
    
    // 아래로 이동
    $(document).on('click', '.order-down', function(e) {
        e.stopPropagation();
        let item = $(this).closest('.category-item');
        let itemType = item.data('type');
        let next;
        
        if (itemType === 'main') {
            // 대분류: 다음 대분류와 그 하위 소분류들 전체를 찾음
            next = findNextMainWithSubs(item);
            if (next) {
                let currentGroup = getMainWithSubs(item);
                currentGroup.insertAfter(next.last());
                updateMainOrderNumbers();
            }
        } else if (itemType === 'sub') {
            // 소분류: 같은 대분류 내에서만 이동
            next = item.next('.sub-category');
            let mainName = item.data('main-name');
            
            if (next.length && next.data('main-name') === mainName) {
                item.insertAfter(next);
                updateSubOrderNumbers(mainName);
            }
        }
    });
    
    // 대분류와 그 하위 소분류들을 하나의 그룹으로 가져오기
    function getMainWithSubs(mainItem) {
        let group = mainItem;
        let next = mainItem.next();
        
        while (next.length && next.hasClass('sub-category')) {
            group = group.add(next);
            next = next.next();
        }
        
        return group;
    }
    
    // 이전 대분류 그룹 찾기
    function findPrevMainWithSubs(mainItem) {
        let prev = mainItem.prev();
        
        // 소분류들을 건너뛰고 대분류 찾기
        while (prev.length && prev.hasClass('sub-category')) {
            prev = prev.prev();
        }
        
        if (prev.length && prev.hasClass('main-category')) {
            return getMainWithSubs(prev);
        }
        
        return null;
    }
    
    // 다음 대분류 그룹 찾기
    function findNextMainWithSubs(mainItem) {
        let currentGroup = getMainWithSubs(mainItem);
        let next = currentGroup.last().next();
        
        if (next.length && next.hasClass('main-category')) {
            return getMainWithSubs(next);
        }
        
        return null;
    }
    
    // 대분류 순서 번호 업데이트
    function updateMainOrderNumbers() {
        let order = 1;
        
        $('.main-category').each(function() {
            $(this).find('.main-order-input').val(order);
            $(this).attr('data-order', order);
            order++;
        });
    }
    
    // 소분류 순서 번호 업데이트 (특정 대분류의 소분류만)
    function updateSubOrderNumbers(mainName) {
        let order = 1;
        
        $('.sub-category').each(function() {
            if ($(this).data('main-name') === mainName) {
                $(this).find('.sub-order-input').val(order);
                $(this).attr('data-order', order);
                order++;
            }
        });
    }
    
    // 순서 저장
    $('#saveOrder').click(function() {
        let mainOrderData = [];
        let subOrderData = [];
        
        // 대분류 순서 수집
        $('.main-category').each(function() {
            let categoryId = $(this).data('category-id');
            let order = $(this).find('.main-order-input').val();
            
            mainOrderData.push({
                category_main_num: categoryId,
                category_main_order: parseInt(order)
            });
        });
        
        // 소분류 순서 수집
        $('.sub-category').each(function() {
            let categoryId = $(this).data('category-id');
            let order = $(this).find('.sub-order-input').val();
            
            subOrderData.push({
                category_num: categoryId,
                category_order: parseInt(order)
            });
        });
        
        if (mainOrderData.length === 0 && subOrderData.length === 0) {
            alert('저장할 카테고리가 없습니다.');
            return;
        }
        
        // 대분류와 소분류 순서를 함께 저장
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/updateCategoryOrder',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                mainCategories: mainOrderData,
                subCategories: subOrderData
            }),
            success: function() {
                alert('카테고리 순서가 저장되었습니다.');
                location.reload();
            },
            error: function() {
                alert('순서 저장에 실패했습니다.');
            }
        });
    });
    
    // 대분류 추가
    $('#addMainCategory').click(function() {
        let categoryName = prompt('대분류 카테고리명을 입력하세요:');
        if (categoryName && categoryName.trim()) {
            // 마지막 대분류 순서 번호 찾기
            let maxOrder = 0;
            $('.main-category').each(function() {
                let order = parseInt($(this).find('.main-order-input').val()) || 0;
                if (order > maxOrder) maxOrder = order;
            });
            
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/addCategoryMain',
                type: 'POST',
                data: { 
                    category_main_name: categoryName.trim(),
                    category_main_order: maxOrder + 1
                },
                success: function() {
                    alert('대분류 카테고리가 추가되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('카테고리 추가에 실패했습니다.');
                }
            });
        }
    });
    
    // 소분류 추가
    $('#addSubCategory').click(function() {
        if (!selectedItem || selectedItem.data('type') === 'all') {
            alert('소분류를 추가할 대분류를 선택하세요.');
            return;
        }
        
        let mainCategoryName;
        if (selectedItem.data('type') === 'main') {
            mainCategoryName = selectedItem.data('name');
        } else if (selectedItem.data('type') === 'sub') {
            mainCategoryName = selectedItem.data('main-name');
        }
        
        let categoryName = prompt('소분류 카테고리명을 입력하세요:');
        if (categoryName && categoryName.trim()) {
            // 같은 대분류의 마지막 순서 번호 찾기
            let maxOrder = 0;
            $('.sub-category').each(function() {
                if ($(this).data('main-name') === mainCategoryName) {
                    let order = parseInt($(this).find('.sub-order-input').val()) || 0;
                    if (order > maxOrder) maxOrder = order;
                }
            });
            
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/addCategory',
                type: 'POST',
                data: { 
                    category_main_name: mainCategoryName,
                    category_detail: categoryName.trim(),
                    category_order: maxOrder + 1
                },
                success: function() {
                    alert('소분류 카테고리가 추가되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('카테고리 추가에 실패했습니다.');
                }
            });
        }
    });
    
    // 카테고리 삭제
    $('#deleteCategory').click(function() {
        if (!selectedItem || selectedItem.data('type') === 'all') {
            alert('삭제할 카테고리를 선택하세요.');
            return;
        }
        
        let categoryType = selectedItem.data('type');
        let categoryName = selectedItem.data('name');
        
        if (categoryType === 'main') {
            // 대분류 삭제 시 소분류 존재 여부 확인
            let hasSubCategories = false;
            $('.sub-category').each(function() {
                if ($(this).data('main-name') === categoryName) {
                    hasSubCategories = true;
                    return false; // each 루프 중단
                }
            });
            
            if (hasSubCategories) {
                alert('소분류가 존재하는 대분류는 삭제할 수 없습니다.\n먼저 하위 소분류를 모두 삭제해주세요.');
                return;
            }
            
            if (!confirm(categoryName + '을(를) 삭제하시겠습니까?')) {
                return;
            }
            
            // 대분류 삭제
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/CategoryMainDelete',
                type: 'POST',
                data: { category_main_name: categoryName },
                success: function() {
                    alert('카테고리가 삭제되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('카테고리 삭제에 실패했습니다.');
                }
            });
        } else if (categoryType === 'sub') {
            if (!confirm(categoryName + '을(를) 삭제하시겠습니까?')) {
                return;
            }
            
            // 소분류 삭제
            let categoryId = selectedItem.data('category-id');
            $.ajax({
                url: '${pageContext.request.contextPath}/admin/deleteCategory',
                type: 'GET',
                data: { category_num: categoryId },
                success: function() {
                    alert('카테고리가 삭제되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('카테고리 삭제에 실패했습니다.');
                }
            });
        }
    });
    
    // 확인 버튼
    $('#submitBtn').click(function() {
        alert('변경사항이 저장되었습니다.');
        location.href = '${pageContext.request.contextPath}/admin/adminCategory';
    });
});
</script>

</body>
</html>
