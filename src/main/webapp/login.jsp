<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%
    /*
    로그인한 회원 정보가 있으면 세션에서 가져온다.

    일반 로그인 화면에서는 loginUser가 null일 수 있다.
    하지만 마이페이지에서 "수련 난이도 재설정"으로 들어온 경우에는
    세션에 저장된 회원 정보를 이용해서 기존 급수를 화면에 표시한다.
    */
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
%>
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

    .setup-card-list {
      display: grid;
      gap: 12px;
    }

    .setup-card {
      border: 1px solid rgba(255, 255, 255, 0.76);
      border-radius: 8px;
      background-color: rgba(255, 255, 255, 0.54);
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.10);
      padding: 15px 14px;
    }

    .setup-card-title {
      display: block;
      margin-bottom: 9px;
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 800;
      color: #213638;
    }

    .setup-save-card {
      width: 100%;
      min-height: 56px;
      border: none;
      border-radius: 8px;
      background-color: rgb(7, 11, 29);
      color: #f2feff;
      font-family: 'Gowun Batang', serif;
      font-size: 17px;
      font-weight: 700;
      cursor: pointer;
      box-shadow: 0 14px 28px rgba(126, 132, 73, 0.24);
      transition: 0.2s;
    }

    .setup-save-card:hover {
      background-color: rgb(60, 80, 94);
      transform: translateY(-1px);
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

    .mobile-frame.dark-mode .setup-card {
      background-color: rgba(255, 255, 255, 0.10);
      border-color: rgba(255, 255, 255, 0.18);
    }

    .mobile-frame.dark-mode .setup-save-card {
      background-color: #d8e87f;
      color: #213638;
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

    .mobile-alert-overlay {
      position: absolute;
      inset: 0;
      z-index: 80;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 24px;
      background-color: rgba(15, 25, 27, 0.42);
      opacity: 0;
      pointer-events: none;
      transition: 0.18s ease;
    }

    .mobile-alert-overlay.show {
      opacity: 1;
      pointer-events: auto;
    }

    .mobile-alert-box {
      width: 100%;
      max-width: 310px;
      border-radius: 8px;
      border: 1px solid rgba(255, 255, 255, 0.78);
      background-color: rgba(246, 251, 248, 0.96);
      box-shadow: 0 22px 44px rgba(20, 38, 40, 0.26);
      padding: 22px 20px 18px;
      font-family: 'Pretendard', sans-serif;
      text-align: center;
      color: #213638;
      transform: translateY(8px);
      transition: 0.18s ease;
    }

    .mobile-alert-overlay.show .mobile-alert-box {
      transform: translateY(0);
    }

    .mobile-alert-icon {
      width: 40px;
      height: 40px;
      border-radius: 8px;
      margin: 0 auto 13px;
      background-color: #d8e87f;
      color: #213638;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 21px;
      font-weight: 800;
    }

    .mobile-alert-message {
      margin: 0 0 18px;
      font-size: 13px;
      font-weight: 800;
      line-height: 1.5;
      word-break: keep-all;
    }

    .mobile-alert-btn {
      width: 100%;
      height: 42px;
      border: none;
      border-radius: 8px;
      background-color: #111111;
      color: #ffffff;
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 800;
      cursor: pointer;
    }

    .mobile-frame.dark-mode .mobile-alert-box {
      border-color: rgba(238, 247, 242, 0.22);
      background-color: #243638;
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .mobile-alert-btn {
      background-color: #d8e87f;
      color: #213638;
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

        <!--
로그인 폼

사용자가 입력한 아이디와 비밀번호를 LoginService로 전송한다.
LoginService에서는 MEMBER 테이블에서 회원 정보를 조회한다.
-->
<form class="login-form"
      id="loginForm"
      action="LoginService"
      method="post">

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

        <!--
수련 난이도 설정 폼

대한검도 급수와 리히테나워 난이도를 ProfileSetService로 전송한다.
전송된 값은 MEMBER 테이블의 K_GRADE, L_GRADE 컬럼에 저장된다.
-->
<form class="setup-form"
      id="initialSetupForm"
      action="ProfileSetService"
      method="post">
          <div class="setup-card-list">
            <article class="setup-card">
              <label class="setup-card-title" for="kendoDifficultySelect">대한검도 현재 난이도</label>
              <!--
대한검도 급수 선택

선택한 값은 kGrade라는 이름으로 Servlet에 전달된다.
-->
<select class="form-input" id="kendoDifficultySelect" name="kGrade"></select>
            </article>

            <article class="setup-card">
              <label class="setup-card-title" for="liechtenauerDifficultySelect">리히테나워 현재 난이도</label>
              <!--
리히테나워 난이도 선택

선택한 값은 lGrade라는 이름으로 Servlet에 전달된다.
-->
<select class="form-input" id="liechtenauerDifficultySelect" name="lGrade"></select>
            </article>

            <!--
            두 종목을 한 번에 저장한다는 표시값이다.
            현재 ProfileSetService는 kGrade와 lGrade를 각각 받아서 처리한다.
            -->
            <input type="hidden"
                   id="initialTrainingDivision"
                   name="initialTrainingDivision"
                   value="both">

            <button type="submit" class="setup-save-card">
             설정 저장하기
            </button>
          </div>
        </form>

        <a href="findPassword.jsp" class="forgot-link" id="forgotLink">
          비밀번호를 잊으셨나요?
        </a>

      </div>

      <div class="signup-area" id="signupArea">
        <span class="signup-text">아직 계정이 없으신가요? </span>
        <a href="join.jsp" class="signup-link">회원가입</a>
      </div>

      <div class="version">v1.0.0</div>

    </div>

    <div class="mobile-alert-overlay" id="mobileAlert" aria-hidden="true">
      <section class="mobile-alert-box" role="dialog" aria-modal="true" aria-labelledby="mobileAlertMessage">
        <div class="mobile-alert-icon" aria-hidden="true">!</div>
        <p class="mobile-alert-message" id="mobileAlertMessage"></p>
        <button type="button" class="mobile-alert-btn" id="mobileAlertOk">확인</button>
      </section>
    </div>

  </div>

  <script>
    /*
    모바일 알림창 콜백 함수 저장 변수

    alert() 대신 직접 만든 알림창을 사용하기 위해 만든 변수이다.
    */
    let mobileAlertCallback = null;

    /*
    모바일 알림창을 보여주는 함수

    message에는 사용자에게 보여줄 문구가 들어간다.
    onClose는 알림창을 닫은 뒤 실행할 함수이다.
    */
    function showMobileAlert(message, onClose) {
      const mobileAlert = document.getElementById("mobileAlert");
      const mobileAlertMessage = document.getElementById("mobileAlertMessage");
      const mobileAlertOk = document.getElementById("mobileAlertOk");

      mobileAlertCallback = typeof onClose === "function" ? onClose : null;
      mobileAlertMessage.innerText = message;
      mobileAlert.classList.add("show");
      mobileAlert.setAttribute("aria-hidden", "false");
      mobileAlertOk.focus();
    }

    /*
    모바일 알림창을 닫는 함수
    닫은 뒤 실행할 함수가 있으면 같이 실행한다.
    */
    function closeMobileAlert() {
      const mobileAlert = document.getElementById("mobileAlert");
      const callback = mobileAlertCallback;

      mobileAlertCallback = null;
      mobileAlert.classList.remove("show");
      mobileAlert.setAttribute("aria-hidden", "true");

      if (callback) {
        callback();
      }
    }

    /*
    알림창 확인 버튼을 누르면 알림창을 닫는다.
    */
    document.getElementById("mobileAlertOk").addEventListener("click", closeMobileAlert);

    /*
    알림창 바깥쪽을 클릭해도 알림창이 닫히도록 한다.
    */
    document.getElementById("mobileAlert").addEventListener("click", (event) => {
      if (event.target === event.currentTarget) {
        closeMobileAlert();
      }
    });

    /*
    키보드 ESC를 눌러도 알림창이 닫히도록 한다.
    */
    document.addEventListener("keydown", (event) => {
      if (event.key === "Escape" && document.getElementById("mobileAlert").classList.contains("show")) {
        closeMobileAlert();
      }
    });

    /*
    난이도 목록 데이터

    대한검도는 1급부터 10급까지 숫자로 저장한다.
    리히테나워는 초급, 중급, 고급을 1, 2, 3으로 저장한다.

    ProfileSetService에서 Integer.parseInt()로 숫자를 처리하기 때문에
    value 값을 반드시 숫자로 설정한다.
    */
    const DIFFICULTY_OPTIONS = {
      "1": [
        { value: "1", label: "1급" },
        { value: "2", label: "2급" },
        { value: "3", label: "3급" },
        { value: "4", label: "4급" },
        { value: "5", label: "5급" },
        { value: "6", label: "6급" },
        { value: "7", label: "7급" },
        { value: "8", label: "8급" },
        { value: "9", label: "9급" },
        { value: "10", label: "10급" }
      ],
      "2": [
        { value: "1", label: "초급" },
        { value: "2", label: "중급" },
        { value: "3", label: "고급" }
      ]
    };

    /*
    난이도 select 박스에 option을 넣어주는 함수

    selectId는 option을 넣을 select 태그의 id이다.
    division은 1이면 대한검도, 2이면 리히테나워를 의미한다.
    */
    function renderDifficultySelect(selectId, division) {
      const difficultySelect = document.getElementById(selectId);
      const options = DIFFICULTY_OPTIONS[division];

      difficultySelect.innerHTML = options.map(function(item) {
        return '<option value="' + item.value + '">' + item.label + '</option>';
      }).join("");
    }

    /*
    수련 설정 화면에 필요한 두 개의 select 박스를 만든다.

    대한검도 select에는 1급~10급,
    리히테나워 select에는 초급~고급을 넣는다.
    */
    function renderInitialSetupOptions() {
      renderDifficultySelect("kendoDifficultySelect", "1");
      renderDifficultySelect("liechtenauerDifficultySelect", "2");
    }

    /*
    수련 설정 화면을 보여주는 함수

    로그인 폼은 숨기고,
    수련 난이도 설정 폼만 화면에 보이도록 바꾼다.
    */
    function showInitialSetup() {
      const params = new URLSearchParams(location.search);

      document.getElementById("loginForm").classList.add("hidden");
      document.getElementById("forgotLink").classList.add("hidden");
      document.getElementById("signupArea").classList.add("hidden");
      document.getElementById("initialSetupForm").classList.add("active");
      document.querySelector(".login-card").classList.add("setup-mode");
      document.querySelector(".title").innerText = "수련 설정";
      document.querySelector(".subtitle").innerText =
        params.get("setup") === "training"
          ? "종목별 현재 난이도를 선택하세요"
          : "처음 시작할 종목별 난이도를 선택하세요";

      renderInitialSetupOptions();

      /*
      기존에 DB에 저장된 회원의 급수를 기본 선택값으로 보여준다.

      이렇게 하지 않으면 재설정 화면에 들어갈 때마다
      항상 1급, 초급으로 보이는 문제가 생긴다.
      */
      document.getElementById("kendoDifficultySelect").value =
        "<%= loginUser != null ? loginUser.getkGrade() : 1 %>";

      document.getElementById("liechtenauerDifficultySelect").value =
        "<%= loginUser != null ? loginUser.getlGrade() : 1 %>";
    }

    /*
    비밀번호 보이기/숨기기 함수

    사용자가 눈 아이콘을 누르면
    password 타입을 text로 바꾸어 비밀번호를 볼 수 있게 한다.
    다시 누르면 password 타입으로 돌려서 숨긴다.
    */
    function togglePassword() {
      const PWInput = document.getElementById("PW");
      const eyeIcon = document.getElementById("eye-icon");

      if (PWInput.type === "password") {
        PWInput.type = "text";

        eyeIcon.innerHTML = '<path d="M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.43-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46C3.08 8.3 1.78 10.02 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78l3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z"/>';

      } else {
        PWInput.type = "password";

        eyeIcon.innerHTML = '<path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>';
      }
    }

    /*
    주소에 setup=training이 붙어 있으면 수련 설정 화면을 바로 연다.

    예)
    login.jsp?setup=training

    마이페이지에서 수련 난이도 재설정을 눌렀을 때 이 방식으로 들어온다.
    */
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
<script>
  const loginParams = new URLSearchParams(location.search);

  if (loginParams.get("login") === "fail") {
    alert("아이디 또는 비밀번호가 일치하지 않습니다.");
    history.replaceState(null, "", "login.jsp");
  }

  if (loginParams.get("login") === "required") {
    alert("로그인이 필요합니다.");
    history.replaceState(null, "", "login.jsp");
  }
</script>
</body>
</html>