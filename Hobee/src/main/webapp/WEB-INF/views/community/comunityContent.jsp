<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Hobee 커뮤니티 - 게시글 상세</title>
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet">
<style>
:root {
  --primary: #2573ff;
  --hover-bg: #eef5ff;
  --gray: #888;
  --text: #222;
  --bg: #f9fafc;
  --border: #e5e8eb;
}
* {margin:0; padding:0; box-sizing:border-box; font-family:'Pretendard',sans-serif;}
body {background:var(--bg); color:var(--text); min-height:100vh; display:flex; flex-direction:column;}
header {background:#fff; box-shadow:0 2px 6px rgba(0,0,0,0.05); padding:12px 28px; display:flex; align-items:center; justify-content:space-between;}
header h1 {color:var(--primary); font-size:1.3rem; cursor:pointer;}
nav a {margin-left:15px; text-decoration:none; color:#333; font-weight:500; font-size:0.9rem; padding:5px 8px; border-radius:6px;}
nav a:hover {background:var(--hover-bg); color:var(--primary);}
main {flex:1; max-width:820px; width:100%; margin:40px auto; background:#fff; border-radius:16px; box-shadow:0 2px 10px rgba(0,0,0,0.05); overflow:hidden;}
.post-header, .post-body, .comment-section {border-bottom:1px solid var(--border);}
.post-header, .post-body {padding:32px 40px;}
.post-header {background:#fdfdfe;}
.post-header h2 {font-size:1.5rem; margin-bottom:8px;}
.post-meta {font-size:0.9rem; color:var(--gray);}
.post-meta span {margin-right:14px;}
.post-body {background:#fff; font-size:1rem; line-height:1.8; color:#333; min-height:380px; padding-bottom:20px;}
.post-actions {background:#fafbff; padding:20px 40px; display:flex; justify-content:space-between; align-items:center; border-top:1px solid var(--border);}
.like-btn {background:none; border:none; font-size:1rem; cursor:pointer; color:#f66; display:flex; align-items:center; gap:6px;}
.like-btn span.count {font-size:1rem; color:#444;}
.like-btn:hover {transform:scale(1.05);}
.btn-box {display:flex; gap:10px;}
.btn {background:var(--primary); color:white; border:none; padding:6px 12px; border-radius:6px; cursor:pointer; font-size:0.9rem;}
.btn.delete {background:#ff4d4d;}
.btn:hover {opacity:0.9;}
.comment-section {background:#fcfcfd; padding:28px 32px; border-top:2px solid var(--border); border-bottom-left-radius:16px; border-bottom-right-radius:16px;}
.comment-section h3 {font-size:1.05rem; color:var(--primary); margin-bottom:15px;}
.comment {border-bottom:1px solid #eee; padding:10px 0; font-size:0.92rem;}
.comment .meta {font-size:0.82rem; color:var(--gray); margin-bottom:4px;}
.comment .content {margin-bottom:4px; line-height:1.5;}
.reply-btn {font-size:0.8rem; color:var(--primary); cursor:pointer;}
.reply-box {margin-left:20px; margin-top:6px; font-size:0.85rem;}
.reply-input {display:flex; gap:6px; margin-top:6px;}
.reply-input input {flex:1; padding:6px 8px; border-radius:6px; border:1px solid #ccc; font-size:0.85rem;}
.reply-input button {background:var(--primary); color:#fff; border:none; border-radius:6px; padding:6px 10px; cursor:pointer; font-size:0.85rem;}
.new-comment {display:flex; gap:8px; margin-top:14px;}
.new-comment input {flex:1; padding:8px; border-radius:6px; border:1px solid #ccc; font-size:0.9rem;}
.new-comment button {background:var(--primary); color:#fff; border:none; border-radius:6px; padding:8px 12px; cursor:pointer; font-size:0.9rem;}
footer {background:#fff; text-align:center; padding:15px; font-size:0.8rem; color:#777; border-radius:15px 15px 0 0; box-shadow:0 -2px 6px rgba(0,0,0,0.05); margin-top:20px;}
</style>
</head>
<body>

<header>
  <h1 onclick="location.href='index.html'">Hobee</h1>
  <nav>
    <a href="index.html">홈</a>
    <a href="#">강의</a>
    <a href="community.html" style="color: var(--primary); font-weight:600;">커뮤니티</a>
    <a href="#">로그인</a>
  </nav>
</header>

<main>
  <section class="post-header">
    <h2>${post.title}</h2>
    <div class="post-meta">
      <span>작성자: ${post.author}</span>
      <span>작성일: <fmt:formatDate value="${post.createDate}" pattern="yyyy-MM-dd"/></span>
      <span>조회수: ${post.views}</span>
    </div>
  </section>

  <section class="post-body">
    ${post.content}
  </section>

  <div class="post-actions">
    <button class="like-btn" onclick="increaseLike()">
      ❤️ <span class="count" id="likeCount">${post.likes}</span>
    </button>
    <div class="btn-box" id="editButtons" style="display:none;">
      <button class="btn edit" onclick="editPost()">수정</button>
      <button class="btn delete" onclick="deletePost()">삭제</button>
    </div>
  </div>

  <section class="comment-section">
    <h3>댓글 💬</h3>
    <c:choose>
      <c:when test="${not empty commentList}">
        <c:forEach var="c" items="${commentList}" varStatus="status">
          <div class="comment">
            <div class="meta">${c.author}</div>
            <div class="content">${c.content}</div>
            <c:if test="${not empty c.replies}">
              <c:forEach var="r" items="${c.replies}">
                <div class="reply-box">
                  <div class="meta">${r.author}</div>
                  <div class="content">${r.content}</div>
                </div>
              </c:forEach>
            </c:if>
            <div id="replyBox${status.index}" class="reply-input" style="display:none;">
              <form action="${pageContext.request.contextPath}/board/addReply" method="post">
                <input type="hidden" name="commentId" value="${c.id}">
                <input type="text" name="content" placeholder="답글을 입력하세요">
                <button type="submit">등록</button>
              </form>
            </div>
            <div class="reply-btn" onclick="toggleReplyBox(${status.index})">답글 달기</div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="no-data">등록된 댓글이 없습니다.</div>
      </c:otherwise>
    </c:choose>
    <div class="new-comment">
      <form action="${pageContext.request.contextPath}/board/addComment" method="post">
        <input type="text" name="content" placeholder="댓글을 입력하세요">
        <button type="submit">등록</button>
      </form>
    </div>
  </section>
</main>



<script>
const currentUser = "${sessionScope.loginUser}"; // 로그인 유저
const postAuthor = "${post.author}";
document.addEventListener("DOMContentLoaded", () => {
  if(currentUser === postAuthor)
    document.getElementById("editButtons").style.display="flex";
});
function increaseLike(){
  const countEl = document.getElementById("likeCount");
  countEl.innerText = parseInt(countEl.innerText)+1;
}
function editPost(){alert("게시글 수정 페이지로 이동합니다.");}
function deletePost(){
  if(confirm("정말 삭제하시겠습니까?")){
    alert("게시글이 삭제되었습니다.");
    location.href="community.html";
  }
}
function toggleReplyBox(i){
  const box = document.getElementById(`replyBox${i}`);
  box.style.display = box.style.display==="none"?"flex":"none";
}
</script>
</body>
</html>
