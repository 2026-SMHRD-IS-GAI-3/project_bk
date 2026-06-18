﻿<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>회원가입</title>

  <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Pretendard:wght@400;600;700;800&display=swap" rel="stylesheet">

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    html,
    body {
      width: 100%;
      height: 100%;
      font-family: 'Gowun Batang', serif;
      background-color: #a7bcbb;
    }

    body {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .mobile-frame {
      width: 100%;
      max-width: 430px;
      height: 100vh;
      min-height: 720px;
      overflow: hidden;
      position: relative;
      background: linear-gradient(145deg, #dce8e5 0%, #bfd1cf 50%, #96aeb0 100%);
      color: #213638;
    }

    .signup-page {
      width: 100%;
      height: 100%;
      padding: 42px 28px 32px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }

    .signup-box {
      width: 100%;
      background-color: rgba(255, 255, 255, 0.50);
      border: 1px solid rgba(255, 255, 255, 0.72);
      border-radius: 28px;
      padding: 30px 24px 26px;
      box-shadow: 0 24px 48px rgba(40, 70, 72, 0.18);
      backdrop-filter: blur(8px);
      color: #213638;
    }

    .title {
      font-size: 30px;
      font-weight: 700;
      text-align: center;
      margin-bottom: 10px;
      color: #213638;
      letter-spacing: -1px;
    }

    .desc {
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 600;
      color: rgba(33, 54, 56, 0.62);
      text-align: center;
      line-height: 1.55;
      margin-bottom: 26px;
    }

    .input-group {
      margin-bottom: 15px;
    }

    .input-group label {
      display: block;
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 800;
      margin-bottom: 8px;
      color: #213638;
      letter-spacing: 0.2px;
    }

    .input-group input,
    .input-group select {
      width: 100%;
      height: 50px;
      border: 1px solid rgba(255, 255, 255, 0.86);
      border-radius: 16px;
      padding: 0 16px;
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      outline: none;
      background-color: rgba(255, 255, 255, 0.78);
      color: #213638;
      transition: 0.2s;
    }

    .input-group input::placeholder {
      color: rgba(33, 54, 56, 0.38);
    }

    .input-group input:focus,
    .input-group select:focus {
      border-color: #d8e87f;
      background-color: #ffffff;
      box-shadow: 0 0 0 4px rgba(216, 232, 127, 0.24);
    }

    .id-check-row {
      display: flex;
      gap: 8px;
    }

    .id-check-row input {
      flex: 1;
      min-width: 0;
    }

    .check-btn {
      width: 92px;
      height: 50px;
      border: none;
      border-radius: 16px;
      background-color: #213638;
      color: #ffffff;
      font-family: 'Pretendard', sans-serif;
      font-size: 12px;
      font-weight: 800;
      cursor: pointer;
      transition: 0.2s;
      flex-shrink: 0;
    }

    .check-btn:hover {
      background-color: #35595c;
    }

    .message {
      display: none;
      margin-top: 8px;
      font-family: 'Pretendard', sans-serif;
      font-size: 12px;
      font-weight: 800;
    }

    .message.error {
      display: block;
      color: #9c2b2b;
    }

    .message.success {
      display: block;
      color: #315b5d;
    }

    .signup-btn {
      width: 100%;
      height: 56px;
      border: none;
      border-radius: 18px;
      background: linear-gradient(135deg, rgb(7, 11, 29));
      color: #f2feff;
      font-family: 'Gowun Batang', serif;
      font-size: 17px;
      font-weight: 700;
      cursor: pointer;
      margin-top: 12px;
      box-shadow: 0 14px 28px rgba(126, 132, 73, 0.24);
      transition: 0.2s;

      display: flex;
      justify-content: center;
      align-items: center;
      text-decoration: none;
    }

    .signup-btn:hover {
        background: linear-gradient(135deg,rgb(60, 80, 94) 100%);
      transform: translateY(-1px);
    }

    .back-login {
      margin-top: 24px;
      text-align: center;
    }

    .back-login a {
      color: rgba(33, 54, 56, 0.68);
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 800;
      text-decoration: none;
      transition: 0.2s;
    }

    .back-login a:hover {
      color: #213638;
      text-decoration: underline;
    }

    .version {
      margin-top: 24px;
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 0.6px;
      color: rgba(33, 54, 56, 0.38);
      text-align: center;
    }

    @media (max-width: 390px) {
      .signup-page {
        padding: 32px 24px 28px;
      }

      .signup-box {
        padding: 28px 22px 24px;
        border-radius: 26px;
      }

      .title {
        font-size: 28px;
      }

      .desc {
        margin-bottom: 22px;
      }

      .input-group {
        margin-bottom: 13px;
      }

      .input-group input,
      .input-group select,
      .check-btn {
        height: 48px;
      }

      .signup-btn {
        height: 54px;
      }
    }

    @media (min-width: 431px) {
      .mobile-frame {
        height: 860px;
        max-height: 94vh;
        min-height: 720px;
        border-radius: 32px;
        box-shadow: 0 30px 80px rgba(28, 55, 58, 0.24);
      }
    }
    .mobile-frame.dark-mode {
      background: linear-gradient(145deg, #182527 0%, #243638 52%, #11191d 100%);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .section-title,
    .mobile-frame.dark-mode .title,
    .mobile-frame.dark-mode .page-title,
    .mobile-frame.dark-mode .card-title,
    .mobile-frame.dark-mode .posture-name,
    .mobile-frame.dark-mode .challenge-title,
    .mobile-frame.dark-mode .item-name,
    .mobile-frame.dark-mode .form-label,
    .mobile-frame.dark-mode label {
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .subtitle,
    .mobile-frame.dark-mode .desc,
    .mobile-frame.dark-mode .visual-desc,
    .mobile-frame.dark-mode .visual-quote,
    .mobile-frame.dark-mode .challenge-desc,
    .mobile-frame.dark-mode .item-desc,
    .mobile-frame.dark-mode .summary-label,
    .mobile-frame.dark-mode .status-text,
    .mobile-frame.dark-mode .section-caption,
    .mobile-frame.dark-mode .version,
    .mobile-frame.dark-mode .forgot-link,
    .mobile-frame.dark-mode .signup-text,
    .mobile-frame.dark-mode .signup-link,
    .mobile-frame.dark-mode .back-login a {
      color: rgba(238, 247, 242, 0.64);
    }

    .mobile-frame.dark-mode .login-card,
    .mobile-frame.dark-mode .signup-box,
    .mobile-frame.dark-mode .summary-item,
    .mobile-frame.dark-mode .challenge-card,
    .mobile-frame.dark-mode .training-card,
    .mobile-frame.dark-mode .training-panel,
    .mobile-frame.dark-mode .bottom-nav,
    .mobile-frame.dark-mode .form-input,
    .mobile-frame.dark-mode .input-group input,
    .mobile-frame.dark-mode .input-group select {
      background-color: rgba(255, 255, 255, 0.10);
      border-color: rgba(255, 255, 255, 0.18);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .nav-item {
      color: rgba(238, 247, 242, 0.58);
    }

    .mobile-frame.dark-mode .nav-icon {
      stroke: rgba(238, 247, 242, 0.58);
    }

    .mobile-frame.dark-mode .nav-item.active {
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .nav-item.active .nav-icon {
      stroke: #eef7f2;
    }

  </style>
</head>

<body>

  <div class="mobile-frame">

    <div class="signup-page">

      <div class="signup-box">
        <h1 class="title">회원가입</h1>

        <p class="desc">
          방구석 검도에 오신 것을 환영합니다.<br>
          회원 정보를 입력해주세요.
        </p>

<form action="${pageContext.request.contextPath}/JoinService" method="post">
          <div class="input-group">
            <label for="NAME">이름</label>
            <input type="text" id="NAME" name="name" placeholder="이름을 입력하세요" required>
          </div>

         <div class="input-group">
  <label for="AGE">나이</label>
  <input type="number" id="AGE" name="age" placeholder="나이를 입력하세요" required>
</div>
          <div class="input-group">
            <label for="GENDER">성별</label>
            <select id="GENDER" name="gender" required>
              <option value="">성별을 선택하세요</option>
              <option value="남성">남성</option>
              <option value="여성">여성</option>
            </select>
          </div>

          <div class="input-group">
            <label for="ID">아이디</label>

            <div class="id-check-row">
              <input type="text" id="ID" name="id" placeholder="아이디를 입력하세요" required>
              <button type="button" class="check-btn" onclick="checkId()">중복확인</button>
            </div>

            <p id="idMessage" class="message"></p>
          </div>

          <div class="input-group">
            <label for="PW">비밀번호</label>
            <input type="password" id="PW" name="pw" placeholder="비밀번호를 입력하세요" required>
          </div>

          <button type="submit" class="signup-btn">
            회원가입
          </button>
        </form>

        <div class="back-login">
          <a href="login.jsp">이미 계정이 있으신가요? 로그인</a>
        </div>
      </div>

      <div class="version">v1.0.0</div>

    </div>

  </div>

  <script>
    const usedIds = ["admin", "test", "mindongoori", "gimminjeong"];

    function checkId() {
      const ID = document.getElementById("ID").value.trim();
      const idMessage = document.getElementById("idMessage");
      idMessage.style.display = "";

      if (ID === "") {
        idMessage.className = "message error";
        idMessage.innerText = "아이디를 입력해주세요.";
        return;
      }

      if (usedIds.includes(ID)) {
        idMessage.className = "message error";
        idMessage.innerText = "이 아이디는 사용할 수 없습니다.";
      } else {
        idMessage.className = "message success";
        idMessage.innerText = "사용 가능한 아이디입니다.";
      }
    }


    document.getElementById("ID").addEventListener("input", function() {
      const idMessage = document.getElementById("idMessage");
      idMessage.style.display = "";
      idMessage.className = "message";
      idMessage.innerText = "";
    });
  </script>
  <script>
    (function applyDarkMode() {
      try {
        const appSetting = JSON.parse(localStorage.getItem("BGS_APP_SETTING_1") || "{}");
        if (appSetting.DARK_MODE) {
          document.querySelector(".mobile-frame")?.classList.add("dark-mode");
        }
      } catch (error) {}
    })();
  </script>
</body>
</html>