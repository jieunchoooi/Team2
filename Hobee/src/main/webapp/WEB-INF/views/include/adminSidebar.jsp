<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<aside class="sidebar">
	<h2>관리 메뉴</h2>
	<div class="sidebar-content">
		<!-- 클래스 관리 -->
		<div class="menu-section">
			<h3>📚 강의 관리</h3>
			<div class="menu">
				<div class="menu-item ${page eq 'category' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminCategory'">
					📂 <span>카테고리 편집</span>
				</div>
<%-- 				<div class="menu-item ${page eq 'classAdd' ? 'active' : ''}" --%>
<%-- 					onclick="location.href='${pageContext.request.contextPath}/admin/adminClassAdd'"> --%>
<!-- 					➕ <span>강의 등록</span> -->
<!-- 				</div> -->
				<div class="menu-item ${page eq 'classList' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminClassList'">
					📋 <span>강의 목록</span>
				</div>
			</div>
		</div>

		<!-- 회원 관리 -->
		<div class="menu-section">
			<h3>👥 회원 관리</h3>
			<div class="menu">
				<div class="menu-item ${page eq 'memberList' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminMemberList'">
					👥 <span>회원 목록</span>
				</div>
				<div class="menu-item ${page eq 'teacherList' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminTeacherList'">
					🎓 <span>강사 목록</span>
				</div>
				<div class="menu-item ${page eq 'withdrawList' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminWithdrawList'">
					🚫 <span>탈퇴 회원</span>
				</div>
			</div>
		</div>

		<!-- 결제 관리 -->
		<div class="menu-section">
			<h3>💳 결제 관리</h3>
			<div class="menu">
				<div class="menu-item ${page eq 'paymentList' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminPaymentList'">
					💰 <span>결제 내역 관리</span>
				</div>
			</div>
		</div>

		<!-- 커뮤니티 관리 -->
		<div class="menu-section">
			<h3>🗨️ 커뮤니티 관리</h3>
			<div class="menu">
				 <!-- 기존: 게시판 목록 -->
				<div class="menu-item ${page eq 'boardList' ? 'active' : ''}"
					onclick="location.href='${pageContext.request.contextPath}/admin/adminBoardList'">
					📋 <span>게시판 목록</span>
				</div>
				<!-- ⭐ 필수: 게시글 관리 -->
                <div class="menu-item ${page eq 'postList' ? 'active' : ''}"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminPostList'">
                    📝 <span>게시글 관리</span>
                </div>
                
                <div class="menu-item ${page eq 'deletedPostList' ? 'active' : ''}"
            		onclick="location.href='${pageContext.request.contextPath}/admin/adminPostDeletedList'">
           			 🗑️ <span>삭제된 게시글(휴지통)</span>
        		</div>
                
                <!-- ⭐ 필수: 댓글 관리 -->
                <div class="menu-item ${page eq 'commentList' ? 'active' : ''}"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminCommentList'">
                    💬 <span>댓글 관리</span>
                </div>

                <!-- ⭐ 필수: 신고 관리 -->
                <div class="menu-item ${page eq 'reportList' ? 'active' : ''}"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminReportList'">
                    🚨 <span>신고 관리</span>
                </div>
                
                <div class="menu-item ${page eq 'postStats' ? 'active' : ''}"
            		onclick="location.href='${pageContext.request.contextPath}/admin/adminPostStats'">
        	    	📊 <span>게시글 통계</span>
       		   </div>

                <!-- 옵션: 공지사항 -->
                <div class="menu-item ${page eq 'noticeList' ? 'active' : ''}"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminNoticeList'">
                    📢 <span>공지사항 관리</span>
                </div>

                <!-- 옵션: FAQ -->
                <div class="menu-item ${page eq 'faqList' ? 'active' : ''}"
                    onclick="location.href='${pageContext.request.contextPath}/admin/adminFaqList'">
                    ❓ <span>FAQ 관리</span>
                </div>

            </div>
        </div>
    </div>
			
	<button class="logout-btn" onclick="logout()">로그아웃</button>
	<script type="text/javascript">
		function logout() {
			alert("로그아웃되었습니다.");
			location.href = "${pageContext.request.contextPath}/member/logout";
		}
	</script>

</aside>