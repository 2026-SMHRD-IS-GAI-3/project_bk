<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>

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

    .login-card.setup-mode {
      padding-top: 26px;
    }

    .login-form {
      width: 100%;
    }

    .login-form.hidden,
    .forgot-link.hidden,
    .signup-area.hidden {
      display: none;
    }

    .setup-form {
      display: none;
      width: 100%;
    }

    .setup-form.active {
      display: block;
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

    select.form-input {
      appearance: none;
      background-image: linear-gradient(45deg, transparent 50%, #44676b 50%), linear-gradient(135deg, #44676b 50%, transparent 50%);
      background-position: calc(100% - 20px) 22px, calc(100% - 14px) 22px;
      background-size: 6px 6px, 6px 6px;
      background-repeat: no-repeat;
      cursor: pointer;
    }

    select.form-input option {
      color: #213638;
      background-color: #ffffff;
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

    <div class="login-page">

      <div class="login-header">
        <div class="title">로그인</div>
        <div class="subtitle">수련을 시작하려면 로그인하세요</div>
      </div>

      <div class="login-card">

       <form class="login-form" id="loginForm" action="LoginService" method="post">

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

        <form class="setup-form" id="initialSetupForm" onsubmit="return saveInitialSetup(event)">
          <div class="form-group">
            <label class="form-label" for="initialTrainingDivision">훈련 종목</label>
            <select class="form-input" id="initialTrainingDivision" name="initialTrainingDivision">
              <option value="1">대한검도</option>
              <option value="2">리히테나워</option>
            </select>
          </div>

          <div class="form-group">
            <label class="form-label" for="initialDifficulty">현재 나의 난이도</label>
            <select class="form-input" id="initialDifficulty" name="initialDifficulty"></select>
          </div>

          <button type="submit" class="login-btn">
           설정 저장하기
          </button>
        </form>

       <a href="findPassword.jsp" class="forgot-link" id="forgotLink">
          비밀번호를 잊으셨나요?
        </a>

      </div>

      <div class="signup-area" id="signupArea">
        <span class="signup-text">아직 계정이 없으신가요? </span>
       <a href="join.jsp"  class="signup-link">회원가입</a>
      </div>

      <div class="version">v1.0.0</div>

    </div>

  </div>

  <script>
    const APP_SETTING_KEY = "BGS_APP_SETTING_1";
    const INITIAL_SETUP_VERSION = 1;
    const DEFAULT_APP_SETTING = {
      DARK_MODE: false,
      TRAIN_NOTICE: false,
      TRAIN_DIVISION: "1",
      DIFFICULTY: "k2",
      INITIAL_SETUP_DONE: false,
      INITIAL_SETUP_VERSION: 0
    };

    const DIFFICULTY_OPTIONS = {
      "1": [
        { value: "k1", label: "1급" },
        { value: "k2", label: "2급" },
        { value: "k3", label: "3급" },
        { value: "k4", label: "4급" },
        { value: "k5", label: "5급" },
        { value: "k6", label: "6급" },
        { value: "k7", label: "7급" },
        { value: "k8", label: "8급" },
        { value: "k9", label: "9급" },
        { value: "k10", label: "10급" }
      ],
      "2": [
        { value: "l_beginner", label: "초급" },
        { value: "l_middle", label: "중급" },
        { value: "l_advanced", label: "고급" }
      ]
    };

    function loadAppSetting() {
      const savedValue = localStorage.getItem(APP_SETTING_KEY);

      if (!savedValue) {
        return { ...DEFAULT_APP_SETTING };
      }

      try {
        return { ...DEFAULT_APP_SETTING, ...JSON.parse(savedValue) };
      } catch (error) {
        return { ...DEFAULT_APP_SETTING };
      }
    }

    function saveAppSetting(appSetting) {
      localStorage.setItem(APP_SETTING_KEY, JSON.stringify(appSetting));
    }

    function renderInitialDifficulty() {
      const trainingDivision = document.getElementById("initialTrainingDivision").value;
      const difficultySelect = document.getElementById("initialDifficulty");
      const options = DIFFICULTY_OPTIONS[trainingDivision] || DIFFICULTY_OPTIONS["1"];
      const appSetting = loadAppSetting();

      difficultySelect.innerHTML = options.map((item) =>
      '<option value="' + item.value + '" ' +
      (appSetting.DIFFICULTY === item.value ? 'selected' : '') +
      '>' + item.label + '</option>'
    ).join('');
    function showInitialSetup() {
      const appSetting = loadAppSetting();
      const trainingDivisionSelect = document.getElementById("initialTrainingDivision");
      const params = new URLSearchParams(location.search);

      document.getElementById("loginForm").classList.add("hidden");
      document.getElementById("forgotLink").classList.add("hidden");
      document.getElementById("signupArea").classList.add("hidden");
      document.getElementById("initialSetupForm").classList.add("active");
      document.querySelector(".login-card").classList.add("setup-mode");
      document.querySelector(".title").innerText = "수련 설정";
      document.querySelector(".subtitle").innerText = params.get("setup") === "training"
        ? "훈련 종목과 난이도를 선택하세요"
        : "처음 시작할 훈련 종목과 난이도를 선택하세요";
      trainingDivisionSelect.value = appSetting.TRAIN_DIVISION || "1";
      renderInitialDifficulty();
    }

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



    function saveInitialSetup(event) {
      event.preventDefault();

      const trainingDivision = document.getElementById("initialTrainingDivision").value;
      const difficulty = document.getElementById("initialDifficulty").value;
      const appSetting = loadAppSetting();

      appSetting.TRAIN_DIVISION = trainingDivision;
      appSetting.DIFFICULTY = difficulty;
      appSetting.INITIAL_SETUP_DONE = true;
      appSetting.INITIAL_SETUP_VERSION = INITIAL_SETUP_VERSION;
      saveAppSetting(appSetting);

      const params = new URLSearchParams(location.search);
      location.href = params.get("redirect") || "main.html";
      return false;
    }

    document.getElementById("initialTrainingDivision").addEventListener("change", renderInitialDifficulty);

    (function openSetupFromQuery() {
      const params = new URLSearchParams(location.search);

      if (params.get("setup") === "training") {
        showInitialSetup();
      }
    })();
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