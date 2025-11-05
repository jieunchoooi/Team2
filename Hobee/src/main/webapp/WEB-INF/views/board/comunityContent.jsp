<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

* {margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif;}

body {
  background: var(--bg);
  color: var(--text);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* header */
header {
  background: #fff;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
  padding: 12px 28px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
header h1 {color: var(--primary); font-size: 1.3rem; cursor: pointer;}
nav a {
  margin-left: 15px;
  text-decoration: none;
  color: #333;
  font-weight: 500;
  font-size: 0.9rem;
  padding: 5px 8px;
  border-radius: 6px;
}
nav a:hover {background: var(--hover-bg); color: var(--primary);}

/* main */
main {
  flex: 1;
  max-width: 820px;
  width: 100%;
  margin: 40px auto;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
  overflow: hidden;
}

/* section 구분 */
.post-header, .post-body, .comment-section {
  border-bottom: 1px solid var(--border);
}
.post-header, .post-body {padding: 32px 40px;}

.post-header {background: #fdfdfe;}
.post-header h2 {font-size: 1.5rem; margin-bottom: 8px;}
.post-meta {font-size: 0.9rem; color: var(--gray);}
.post-meta span {margin-right: 14px;}

/* 본문 */
.post-body {
  background: #fff;
  font-size: 1rem;
  line-height: 1.8;
  color: #333;
  min-height: 380px; /* ✅ 본문 최소 높이 확실히 확보 */
  padding-bottom: 20px;
}


/* 하단 액션 */
.post-actions {
  background: #fafbff;
  padding: 20px 40px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid var(--border);
}
.like-btn {
  background: none;
  border: none;
  font-size: 1rem;
  cursor: pointer;
  color: #f66;
  display: flex;
  align-items: center;
  gap: 6px;
}
.like-btn span.count {font-size: 1rem; color: #444;}
.like-btn:hover {transform: scale(1.05);}
.btn-box {display: flex; gap: 10px;}
.btn {
  background: var(--primary);
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9rem;
}
.btn.delete {background: #ff4d4d;}
.btn:hover {opacity: 0.9;}

/* 댓글 */
.comment-section {
  background: #fcfcfd;
  padding: 28px 32px;
  border-top: 2px solid var(--border);
  border-bottom-left-radius: 16px;
  border-bottom-right-radius: 16px;
}
.comment-section h3 {
  font-size: 1.05rem;
  color: var(--primary);
  margin-bottom: 15px;
}
.comment {
  border-bottom: 1px solid #eee;
  padding: 10px 0;
  font-size: 0.92rem;
}
.comment .meta {
  font-size: 0.82rem;
  color: var(--gray);
  margin-bottom: 4px;
}
.comment .content {margin-bottom: 4px; line-height: 1.5;}
.reply-btn {font-size: 0.8rem; color: var(--primary); cursor: pointer;}
.reply-box {
  margin-left: 20px;
  margin-top: 6px;
  font-size: 0.85rem;
}
.reply-input {display: flex; gap: 6px; margin-top: 6px;}
.reply-input input {
  flex: 1;
  padding: 6px 8px;
  border-radius: 6px;
  border: 1px solid #ccc;
  font-size: 0.85rem;
}
.reply-input button {
  background: var(--primary);
  color: #fff;
  border: none;
  border-radius: 6px;
  padding: 6px 10px;
  cursor: pointer;
  font-size: 0.85rem;
}
.new-comment {
  display: flex;
  gap: 8px;
  margin-top: 14px;
}
.new-comment input {
  flex: 1;
  padding: 8px;
  border-radius: 6px;
  border: 1px solid #ccc;
  font-size: 0.9rem;
}
.new-comment button {
  background: var(--primary);
  color: #fff;
  border: none;
  border-radius: 6px;
  padding: 8px 12px;
  cursor: pointer;
  font-size: 0.9rem;
}

/* footer */
footer {
  background: #fff;
  text-align: center;
  padding: 15px;
  font-size: 0.8rem;
  color: #777;
  border-radius: 15px 15px 0 0;
  box-shadow: 0 -2px 6px rgba(0,0,0,0.05);
  margin-top: 20px;
}
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
    <h2>[후기] 드로잉 클래스 완전 강추!</h2>
    <div class="post-meta">
      <span>작성자: 아트초보</span>
      <span>작성일: 2025-10-29</span>
      <span>조회수: 132</span>
    </div>
  </section>

  <section class="post-body">
    아이패드로 드로잉을 처음 시작했는데 정말 만족스러워요.  
    강사님 설명도 너무 친절하고, 단계별로 따라가다 보니 자신감이 생겼어요 🎨  
    이제 저도 제 캐릭터를 만들 수 있게 되었답니다!
  </section>

  <div class="post-actions">
    <button class="like-btn" onclick="increaseLike()">
      ❤️ <span class="count" id="likeCount">12</span>
    </button>
    <div class="btn-box" id="editButtons" style="display:none;">
      <button class="btn edit" onclick="editPost()">수정</button>
      <button class="btn delete" onclick="deletePost()">삭제</button>
    </div>
  </div>

  <section class="comment-section">
    <h3>댓글 💬</h3>
    <div id="commentList"></div>
    <div class="new-comment">
      <input type="text" id="newComment" placeholder="댓글을 입력하세요">
      <button onclick="addComment()">등록</button>
    </div>
  </section>
</main>

<footer>© 2025 Hobee | 당신의 취미 파트너</footer>

<script>
const currentUser = "아트초보";
const postAuthor = "아트초보";
let likeCount = 12;

document.addEventListener("DOMContentLoaded", () => {
  if (currentUser === postAuthor)
    document.getElementById("editButtons").style.display = "flex";
  renderComments();
});

function increaseLike() {
  likeCount++;
  document.getElementById("likeCount").innerText = likeCount;
}

let comments = [
  {id:1,author:"홍길동",content:"와 정말 재밌어 보이네요!",replies:[{author:"아트초보",content:"감사합니다! 꼭 해보세요 😊"}]},
  {id:2,author:"Jane",content:"혹시 준비물은 어떤 게 필요한가요?",replies:[]}
];

function renderComments(){
  const list=document.getElementById("commentList");
  list.innerHTML=comments.map((c,i)=>`
    <div class="comment">
      <div class="meta">${c.author}</div>
      <div class="content">${c.content}</div>
      <div class="reply-btn" onclick="showReplyBox(${i})">답글 달기</div>
      ${c.replies.map(r=>`
        <div class="reply-box">
          <div class="meta">${r.author}</div>
          <div class="content">${r.content}</div>
        </div>`).join('')}
      <div id="replyBox${i}" class="reply-input" style="display:none;">
        <input type="text" id="replyInput${i}" placeholder="답글을 입력하세요">
        <button onclick="addReply(${i})">등록</button>
      </div>
    </div>`).join('');
}

function showReplyBox(i){
  const box=document.getElementById(`replyBox${i}`);
  box.style.display=box.style.display==="none"?"flex":"none";
}
function addComment(){
  const input=document.getElementById("newComment");
  const content=input.value.trim();
  if(!content)return alert("댓글을 입력해주세요!");
  comments.push({id:Date.now(),author:currentUser,content,replies:[]});
  input.value=""; renderComments();
}
function addReply(i){
  const input=document.getElementById(`replyInput${i}`);
  const content=input.value.trim();
  if(!content)return alert("답글을 입력해주세요!");
  comments[i].replies.push({author:currentUser,content});
  input.value=""; renderComments();
}
function editPost(){alert("게시글 수정 페이지로 이동합니다.");}
function deletePost(){
  if(confirm("정말 삭제하시겠습니까?")){
    alert("게시글이 삭제되었습니다.");
    location.href="community.html";
  }
}
</script>
</body>
</html>

