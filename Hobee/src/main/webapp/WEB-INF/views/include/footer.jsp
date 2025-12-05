<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
/* Footer 전체 - 사이드바 위로 완전히 덮기 */
.site-footer {
    background: #f8f9fa;
    border-top: 1px solid #e9ecef;
    padding: 40px 0 30px;
/*     margin-top: 60px; */
    font-size: 0.75rem;
    color: #666;
    
    /* ✅ 사이드바 위로 올리기 */
    position: relative;
    width: 100vw;
    left: 0%; 
    z-index: 90;
}
.footer-bottm{
	text-align = left;
}

.footer-container {
    max-width: 1200px;
    padding: 0 20px;
    margin-left: auto;  /* 사이드바 공간 확보 */
    margin-right: auto;
}

.footer-company-name {
    font-weight: 700;
    color: #333;
    margin-bottom: 8px;
    font-size: 0.8rem;
}

.footer-info-text {
    color: #999;
    font-size: 0.7rem;
    line-height: 1.6;
    margin-bottom: 6px;
}

.footer-info-text a {
    color: #999;
    text-decoration: underline;
    margin-left: 6px;
}

.footer-info-text a:hover {
    color: #2573ff;
}

.footer-notice {
    color: #aaa;
    font-size: 0.68rem;
    line-height: 1.5;
    margin-top: 12px;
}

/* 반응형 */
@media (max-width: 992px) {
    .footer-top {
        grid-template-columns: 1fr;
        gap: 30px;
    }
    
    .footer-links-wrapper {
        grid-template-columns: repeat(2, 1fr);
        gap: 30px 20px;
    }
}

@media (max-width: 768px) {
    .site-footer {
        left: -200px;
    }
    
    .footer-container {
        margin-left: calc(200px + (100vw - 1200px - 200px) / 2);
    }
}

@media (max-width: 480px) {
    .site-footer {
        left: -180px;
    }
    
    .footer-container {
        margin-left: calc(180px + (100vw - 1200px - 180px) / 2);
    }
    
    .footer-links-wrapper {
        grid-template-columns: 1fr;
        gap: 20px;
    }
}
</style>

<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-bottom">
            <div class="footer-company-name">(주)Hobee</div>
            <div class="footer-info-text">
                대표 : 홍길동 | 부산 부산진구 동천로 109 삼한골든게이트, 7층 | 사업자등록번호 : 123-45-67890
                <a href="#" target="_blank">사업자 정보 확인 ></a>
            </div>
            <div class="footer-info-text">
                통신판매업신고번호 : 2022-서울강남-02625 | 클라우드 호스팅 : Amazon Web Services Korea LLC
            </div>
            <div class="footer-info-text">
                대표전화 : 1375-1375 | 이메일 : ask@hobee.co.kr
            </div>
            <div class="footer-notice">
                Hobee는 통신판매중개자로서 중개하는 크리에이터가 제공하는 상품정보 및 거래 등에 대해서는 책임을 부담하지 않습니다.
            </div>
        </div>
    </div>
</footer>