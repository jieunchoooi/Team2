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

.footer-container {
    max-width: 1200px;
    padding: 0 20px;
    margin-left: auto;  /* 사이드바 공간 확보 */
    margin-right: auto;
    /* width 고정 제거 */
    /* width: 1200px; 제거 */
}
/* 상단 영역 */
.footer-top {
    display: grid;
    grid-template-columns: 220px 1fr;
    gap: 60px;
    padding-bottom: 30px;
    border-bottom: 1px solid #e9ecef;
}

.footer-cs-title {
    font-size: 0.9rem;
    font-weight: 700;
    color: #222;
    margin-bottom: 8px;
}

.footer-cs-time {
    color: #999;
    font-size: 0.7rem;
    margin-bottom: 12px;
    line-height: 1.5;
}

.footer-inquiry-btn {
    display: inline-block;
    padding: 8px 20px;
    border: 1px solid #ddd;
    border-radius: 4px;
    color: #333;
    text-decoration: none;
    font-size: 0.75rem;
    font-weight: 500;
    transition: all 0.2s;
    margin-bottom: 16px;
}

.footer-inquiry-btn:hover {
    border-color: #2573ff;
    color: #2573ff;
}

/* .footer-social { */
/*     display: flex; */
/*     gap: 10px; */
/* } */

/* .footer-social a { */
/*     width: 28px; */
/*     height: 28px; */
/*     display: flex; */
/*     align-items: center; */
/*     justify-content: center; */
/*     color: #999; */
/*     font-size: 1rem; */
/*     transition: color 0.2s; */
/* } */

/* .footer-social a:hover { */
/*     color: #2573ff; */
/* } */

.footer-links-wrapper {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 30px;
}

.footer-links-column {
    display: flex;
    flex-direction: column;
}

.footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-links li {
    margin-bottom: 8px;
}

.footer-links a {
    color: #666;
    text-decoration: none;
    font-size: 0.75rem;
    transition: color 0.2s;
    white-space: nowrap;
}

.footer-links a:hover {
    color: #2573ff;
}

.footer-links a.highlight {
    font-weight: 600;
    color: #333;
}

.footer-bottom {
    padding-top: 20px;
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
        <div class="footer-top">
            <div class="footer-left">
                <div class="footer-cs-title">고객센터</div>
                <div class="footer-cs-time">오전 10시 ~ 오후 6시 (주말, 공휴일 제외)</div>
                <a href="#" class="footer-inquiry-btn">문의하기</a>
<!--                 <div class="footer-social"> -->
<!--                     <a href="#" aria-label="YouTube"><i class="fab fa-youtube"></i></a> -->
<!--                     <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a> -->
<!--                     <a href="#" aria-label="Facebook"><i class="fab fa-facebook"></i></a> -->
<!--                     <a href="#" aria-label="Blog"><i class="fab fa-blogger"></i></a> -->
<!--                 </div> -->
            </div>
            <div class="footer-links-wrapper">
                <div class="footer-links-column">
                    <ul class="footer-links">
                        <li><a href="#">공지사항</a></li>
                        <li><a href="#">전체 카테고리</a></li>
                        <li><a href="#">월간 세레나</a></li>
                        <li><a href="#">자원 거래 및 이용권한</a></li>
                    </ul>
                </div>
                <div class="footer-links-column">
                    <ul class="footer-links">
                        <li><a href="#">크리에이터 지원</a></li>
                        <li><a href="#">지식재산권 침해 신고</a></li>
                        <li><a href="#">고비 지원</a></li>
                        <li><a href="#">기업교육 분석</a></li>
                        <li><a href="#">클래스 개설 안내</a></li>
                    </ul>
                </div>
                <div class="footer-links-column">
                    <ul class="footer-links">
                        <li><a href="#" class="highlight">개인정보 취급방침</a></li>
                        <li><a href="#">이용약관</a></li>
                        <li><a href="#">카드프로모션 제외</a></li>
                        <li><a href="#">환불 정책</a></li>
                        <li><a href="#">청소년 보호 정책</a></li>
                    </ul>
                </div>
                <div class="footer-links-column">
                    <ul class="footer-links">
                        <li><a href="#">사업자 정보 확인</a></li>
                        <li><a href="#">제휴 및 대외문의</a></li>
                        <li><a href="#">채용</a></li>
                    </ul>
                </div>
            </div>
        </div>
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