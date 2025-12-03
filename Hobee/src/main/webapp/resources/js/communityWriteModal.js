function openWriteModal() {
    document.getElementById("writeModal").style.display = "flex";
}

function closeWriteModal() {
    document.getElementById("writeModal").style.display = "none";
}

/* 오버레이 클릭 시 닫기 */
document.addEventListener("DOMContentLoaded", () => {
    const modal = document.getElementById("writeModal");
    modal.addEventListener("click", function(e) {
        if (e.target === modal) closeWriteModal();
    });
});
