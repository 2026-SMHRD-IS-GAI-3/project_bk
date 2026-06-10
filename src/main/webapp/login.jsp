<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>방구석 검도 - 로그인</title>

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

    .login-page {
      width: 100%;
      height: 100%;
      padding: 70px 28px 36px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }

    .login-header {
      width: 100%;
      text-align: center;
      margin-bottom: 42px;
    }

    .title {
      font-size: 38px;
      font-weight: 700;
      letter-spacing: -1px;
      color: #213638;
      margin-bottom: 10px;
    }

    .subtitle {
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 700;
      color: rgba(33, 54, 56, 0.68);
      letter-spacing: 0.5px;
    }

    .login-card {
      width: 100%;
      background-color: rgba(255, 255, 255, 0.48);
      border: 1px solid rgba(255, 255, 255, 0.68);
      border-radius: 28px;
      padding: 28px 22px 24px;
      box-shadow: 0 24px 48px rgba(40, 70, 72, 0.18);
      backdrop-filter: blur(8px);
    }

    .login-form {
      width: 100%;
    }

    .form-group {
      margin-bottom: 18px;
    }

    .form-label {
      display: block;
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 800;
      color: #213638;
      margin-bottom: 8px;
      letter-spacing: 0.2px;
    }

    .form-input {
      width: 100%;
      height: 52px;
      background-color: rgba(255, 255, 255, 0.78);
      border: 1px solid rgba(255, 255, 255, 0.86);
      border-radius: 16px;
      padding: 0 16px;
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      color: #213638;
      outline: none;
      transition: 0.2s;
    }

    .form-input::placeholder {
      color: rgba(33, 54, 56, 0.38);
    }

    .form-input:focus {
      border-color: #d8e87f;
      background-color: #ffffff;
      box-shadow: 0 0 0 4px rgba(216, 232, 127, 0.24);
    }

    .password-wrapper {
      position: relative;
    }

    .password-wrapper .form-input {
      padding-right: 48px;
    }

    .password-toggle {
      position: absolute;
      right: 16px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      cursor: pointer;
      padding: 0;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .password-toggle svg {
      width: 21px;
      height: 21px;
      fill: rgba(33, 54, 56, 0.48);
      transition: 0.2s;
    }

    .password-toggle:hover svg {
      fill: rgba(33, 54, 56, 0.78);
    }

    .login-btn {
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
      margin-top: 10px;
      box-shadow: 0 14px 28px rgba(126, 132, 73, 0.24);
      transition: 0.2s;
    }

    .login-btn:hover {
       background: linear-gradient(135deg,rgb(60, 80, 94) 100%);
      transform: translateY(-1px);
    }

    .forgot-link {
      display: block;
      text-align: center;
      margin-top: 18px;
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 700;
      color: rgba(33, 54, 56, 0.58);
      text-decoration: none;
      transition: 0.2s;
    }

    .forgot-link:hover {
      color: #213638;
      text-decoration: underline;
    }

    .signup-area {
      margin-top: 34px;
      text-align: center;
      font-family: 'Pretendard', sans-serif;
    }

    .signup-text {
      font-size: 13px;
      font-weight: 600;
      color: rgba(33, 54, 56, 0.58);
    }

    .signup-link {
      font-size: 13px;
      color: #213638;
      text-decoration: none;
      font-weight: 800;
      transition: 0.2s;
    }

    .signup-link:hover {
      color: #4f686b;
      text-decoration: underline;
    }

    .version {
      margin-top: 30px;
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 0.6px;
      color: rgba(33, 54, 56, 0.38);
      text-align: center;
    }

    @media (max-width: 390px) {
      .login-page {
        padding: 60px 24px 30px;
      }

      .title {
        font-size: 34px;
      }

      .login-card {
        padding: 26px 20px 22px;
        border-radius: 26px;
      }

      .form-input {
        height: 50px;
      }

      .login-btn {
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
  </style>
</head>

<body>

  <div class="mobile-frame">

    <div class="login-page">

      <div class="login-header">
        <div class="title">로그인</div>
        <div class="subtitle">수련을 시작하려면 로그인하세요</div>
      </div>

      <div class="login-card">

        <form class="login-form" action="LoginService" method="post">

          <div class="form-group">
            <label class="form-label" for="ID">아이디</label>
            <input 
              type="text" 
              class="form-input" 
              placeholder="아이디를 입력하세요"
              id="ID"
              name="id"
              required
            >
          </div>

          <div class="form-group">
            <label class="form-label" for="PW">비밀번호</label>

            <div class="password-wrapper">
              <input 
                type="password" 
                class="form-input" 
                placeholder="비밀번호를 입력하세요"
                id="PW"
                name="pw"
                required
              >

              <button type="button" class="password-toggle" onclick="togglePassword()">
                <svg viewBox="0 0 24 24" id="eye-icon">
                  <path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>
                </svg>
              </button>
            </div>
          </div>

          <button type="submit" class="login-btn">
           로그인
          </button>

        </form>

        <a href="findPassword.jsp" class="forgot-link">
          비밀번호를 잊으셨나요?
        </a>

      </div>

      <div class="signup-area">
        <span class="signup-text">아직 계정이 없으신가요? </span>
     <a href="join.jsp" class="signup-link">회원가입</a>
      </div>

      <div class="version">v1.0.0</div>

    </div>

  </div>

  <script>
    function togglePassword() {
      const PWInput = document.getElementById('PW');
      const eyeIcon = document.getElementById('eye-icon');
      
      if (PWInput.type === 'password') {
        PWInput.type = 'text';

        eyeIcon.innerHTML = '<path d="M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.43-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46C3.08 8.3 1.78 10.02 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78l3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z"/>';

      } else {
        PWInput.type = 'password';

        eyeIcon.innerHTML = '<path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>';
      }
    }

 
  </script>

</body>
</html>