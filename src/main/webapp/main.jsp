<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%
    /*
    로그인한 회원 정보를 세션에서 가져온다.
    로그인하지 않은 사용자가 main.jsp에 직접 들어오면
    로그인 페이지로 돌려보낸다.
    */
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>방구석 검도 - 훈련</title>

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

    button {
      font: inherit;
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

    .training-page {
      height: 100%;
      padding: 28px 22px 116px;
      overflow-y: auto;
      scrollbar-width: none;
      -ms-overflow-style: none;
    }

    .training-page::-webkit-scrollbar {
      display: none;
    }

    .training-visual {
      min-height: 132px;
      border-radius: 8px;
      background:
        linear-gradient(135deg, rgba(23, 35, 42, 0.88), rgba(45, 77, 78, 0.82)),
      url("Project_Logo/logo_02.png") center/cover;
      overflow: hidden;
      position: relative;
      padding: 18px 20px;
      color: #f6fbf8;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 22px;
      box-shadow: 0 22px 42px rgba(34, 58, 60, 0.20);
    }

    .training-visual::after {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(90deg, rgba(10, 18, 24, 0.78), rgba(10, 18, 24, 0.18));
    }

    .visual-copy {
      position: relative;
      z-index: 1;
      text-align: center;
    }

    .visual-title {
      font-size: 25px;
      line-height: 1.2;
      margin-bottom: 0;
    }

    .visual-quote {
      margin-top: 10px;
      font-family: 'Pretendard', sans-serif;
      font-size: 12px;
      font-weight: 700;
      line-height: 1.45;
      color: rgba(246, 251, 248, 0.78);
    }

    .visual-level {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      max-width: 100%;
      min-height: 24px;
      margin-top: 10px;
      padding: 0 10px;
      border-radius: 999px;
      background-color: rgba(246, 251, 248, 0.16);
      border: 1px solid rgba(246, 251, 248, 0.22);
      font-family: 'Pretendard', sans-serif;
      font-size: 10px;
      font-weight: 800;
      line-height: 1.35;
      color: rgba(246, 251, 248, 0.88);
      word-break: keep-all;
    }

    .section-title {
      font-family: 'Pretendard', sans-serif;
      font-size: 17px;
      line-height: 1.25;
      font-weight: 800;
      color: #213638;
      margin: 22px 0 10px;
    }

    .training-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px;
    }

    .training-card {
      min-height: 136px;
      border: 1px solid rgba(255, 255, 255, 0.76);
      border-radius: 8px;
      background-color: rgba(255, 255, 255, 0.54);
      padding: 13px 13px 12px;
      text-align: left;
      color: #213638;
      cursor: pointer;
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.10);
      transition: 0.18s;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      gap: 8px;
    }

    .training-card.active {
      border-color: #d8e87f;
      background-color: rgba(255, 255, 255, 0.82);
      box-shadow: 0 0 0 4px rgba(216, 232, 127, 0.22);
    }

    .card-icon {
      width: 76px;
      height: 76px;
      border-radius: 8px;
      background-color: transparent;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 2px auto 0;
      overflow: hidden;
    }

    .card-icon img {
      width: 100%;
      height: 100%;
      object-fit: contain;
      display: block;
      mix-blend-mode: multiply;
    }

    .card-title {
      display: block;
      width: 100%;
      min-height: 30px;
      padding: 8px 2px 0;
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      line-height: 1.25;
      font-weight: 800;
      text-align: center;
      margin-bottom: 0;
    }

    .posture-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 16px 14px;
      margin-top: 10px;
    }

    .posture-item {
      min-width: 0;
      border: none;
      background: transparent;
      color: #213638;
      font-family: 'Pretendard', sans-serif;
      cursor: pointer;
      text-align: center;
    }

    .posture-icon {
      width: 78px;
      height: 78px;
      margin: 0 auto 8px;
      border-radius: 14px;
      border: 3px solid #111111;
      background-color: #111111;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      box-shadow: 0 12px 24px rgba(33, 54, 56, 0.16);
      transition: 0.18s;
    }

    .posture-item:hover .posture-icon {
      transform: translateY(-2px);
    }

    .posture-icon svg {
      width: 34px;
      height: 34px;
      stroke: #ffffff;
      stroke-width: 2.2;
      fill: none;
    }

    .posture-item.current .posture-icon {
      border-color: #111111;
      background-color: #111111;
    }

    .posture-item.done .posture-icon {
      border-color: rgba(246, 251, 248, 0.92);
      background-color: rgba(246, 251, 248, 0.92);
      color: #213638;
    }

    .posture-item.done .posture-icon svg {
      stroke: #213638;
    }

    .posture-item.locked {
      cursor: default;
      opacity: 1;
    }

    .posture-item.locked .posture-icon {
      border-color: rgba(33, 54, 56, 0.12);
      background-color: rgba(255, 255, 255, 0.48);
      box-shadow: 0 10px 20px rgba(33, 54, 56, 0.08);
    }

    .posture-item.locked .posture-icon svg {
      stroke: rgba(33, 54, 56, 0.56);
    }

    .posture-name {
      display: block;
      font-size: 11px;
      font-weight: 800;
      line-height: 1.35;
      word-break: keep-all;
    }

    .bottom-nav {
      position: absolute;
      left: 18px;
      right: 18px;
      bottom: 18px;
      height: 78px;
      background: rgba(255, 255, 255, 0.72);
      border: 1px solid rgba(255, 255, 255, 0.82);
      border-radius: 26px;
      display: flex;
      justify-content: space-around;
      align-items: center;
      z-index: 100;
      box-shadow: 0 18px 36px rgba(40, 70, 72, 0.18);
      backdrop-filter: blur(10px);
    }

    .nav-item {
      width: 25%;
      height: 100%;
      text-decoration: none;
      color: rgba(33, 54, 56, 0.52);
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      gap: 4px;
      font-family: 'Pretendard', sans-serif;
      font-size: 10px;
      font-weight: 800;
      letter-spacing: 0;
    }

    .icon-box {
      height: 34px;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .nav-icon {
      width: 27px;
      height: 27px;
      stroke: rgba(33, 54, 56, 0.52);
      stroke-width: 1.8;
      fill: none;
    }

    .nav-item.active {
      color: #213638;
    }

    .nav-item.active .icon-box {
      width: 46px;
      height: 46px;
      border: 2px solid khaki;
      border-radius: 16px;
      background-color: rgba(255, 255, 255, 0.78);
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 1px;
      box-shadow: 0 8px 18px rgba(177, 197, 77, 0.18);
    }

    .nav-item.active .nav-icon {
      stroke: #213638;
    }

    .retrain-modal {
      position: absolute;
      inset: 0;
      z-index: 999;
      display: none;
      align-items: center;
      justify-content: center;
      padding: 24px;
      background-color: rgba(17, 25, 29, 0.42);
      backdrop-filter: blur(3px);
    }

    .retrain-modal.show {
      display: flex;
    }

    .retrain-modal-box {
      width: 100%;
      max-width: 320px;
      border-radius: 22px;
      padding: 26px 22px 20px;
      background-color: rgba(255, 255, 255, 0.96);
      box-shadow: 0 22px 50px rgba(20, 36, 38, 0.28);
      text-align: center;
      font-family: 'Pretendard', sans-serif;
      color: #213638;
    }

    .retrain-modal-icon {
      width: 52px;
      height: 52px;
      margin: 0 auto 14px;
      border-radius: 16px;
      background-color: rgba(216, 232, 127, 0.35);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .retrain-modal-icon svg {
      width: 30px;
      height: 30px;
      stroke: #213638;
      stroke-width: 2.2;
      fill: none;
    }

    .retrain-modal-title {
      font-size: 17px;
      font-weight: 800;
      line-height: 1.45;
      margin-bottom: 8px;
    }

    .retrain-modal-desc {
      font-size: 13px;
      font-weight: 700;
      line-height: 1.5;
      color: rgba(33, 54, 56, 0.68);
      margin-bottom: 20px;
    }

    .retrain-modal-actions {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px;
    }

    .retrain-modal-btn {
      height: 44px;
      border: none;
      border-radius: 14px;
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      font-weight: 800;
      cursor: pointer;
    }

    .retrain-modal-btn.no {
      background-color: rgba(33, 54, 56, 0.10);
      color: #213638;
    }

    .retrain-modal-btn.yes {
      background-color: #213638;
      color: #ffffff;
    }

    @media (max-width: 390px) {
      .training-page {
        padding: 24px 18px 108px;
      }

      .training-visual {
        min-height: 124px;
        padding: 16px 18px;
      }

      .visual-title {
        font-size: 23px;
      }

      .visual-quote {
        font-size: 11px;
      }

      .posture-grid {
        gap: 15px 10px;
      }

      .posture-icon {
        width: 72px;
        height: 72px;
      }

      .bottom-nav {
        left: 14px;
        right: 14px;
        bottom: 14px;
        height: 76px;
        border-radius: 24px;
      }

      .nav-item {
        font-size: 9px;
      }

      .nav-icon {
        width: 25px;
        height: 25px;
      }

      .nav-item.active .icon-box {
        width: 43px;
        height: 43px;
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

    .mobile-frame.dark-mode .posture-icon,
    .mobile-frame.dark-mode .posture-item.current .posture-icon {
      border-color: rgba(255, 255, 255, 0.86);
      background-color: #111111;
    }

    .mobile-frame.dark-mode .posture-icon svg {
      stroke: #ffffff;
    }

    .mobile-frame.dark-mode .posture-item.done .posture-icon {
      border-color: rgba(246, 251, 248, 0.92);
      background-color: rgba(246, 251, 248, 0.92);
      color: #213638;
    }

    .mobile-frame.dark-mode .posture-item.done .posture-icon svg {
      stroke: #213638;
    }

    .mobile-frame.dark-mode .posture-item.locked .posture-icon {
      border-color: rgba(238, 247, 242, 0.24);
      background-color: rgba(255, 255, 255, 0.10);
    }

    .mobile-frame.dark-mode .posture-item.locked .posture-icon svg {
      stroke: rgba(238, 247, 242, 0.60);
    }

    .mobile-frame.dark-mode .posture-item.locked .posture-name {
      color: rgba(238, 247, 242, 0.72);
    }

    .mobile-frame.dark-mode .retrain-modal-box {
      background-color: #243638;
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .retrain-modal-desc {
      color: rgba(238, 247, 242, 0.68);
    }

    .mobile-frame.dark-mode .retrain-modal-btn.no {
      background-color: rgba(255, 255, 255, 0.14);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .retrain-modal-btn.yes {
      background-color: #eef7f2;
      color: #213638;
    }

    .mobile-frame.dark-mode .retrain-modal-icon {
      background-color: rgba(255, 255, 255, 0.12);
    }

    .mobile-frame.dark-mode .retrain-modal-icon svg {
      stroke: #eef7f2;
    }
  </style>
</head>

<body>

  <div class="mobile-frame">
    <main class="training-page">
      <section class="training-visual" aria-label="훈련 안내">
        <div class="visual-copy">
          <h2 class="visual-title">나의 훈련</h2>
          <p class="visual-quote" id="trainingQuote"></p>
          <p class="visual-level" id="trainingLevelText"></p>
        </div>
      </section>

      <section aria-label="훈련 종류 선택">
        <h2 class="section-title">훈련 선택</h2>
        <div class="training-grid" id="trainingGrid"></div>
      </section>

      <section class="posture-section" aria-label="자세별 훈련 목록">
        <h2 class="section-title" id="postureSectionTitle">자세훈련 목록</h2>
        <div class="posture-grid" id="postureGrid"></div>
      </section>
    </main>

    <nav class="bottom-nav">
      <a href="main.jsp" class="nav-item active">
        <div class="icon-box">
          <svg class="nav-icon" viewBox="0 0 24 24">
            <path d="M4 20L20 4"></path>
            <path d="M14 4L20 10"></path>
            <path d="M4 14L10 20"></path>
            <path d="M8 16L6 18"></path>
            <path d="M16 8L18 6"></path>
          </svg>
        </div>
        <span>훈련</span>
      </a>

      <a href="challenge.jsp" class="nav-item">
        <div class="icon-box">
          <svg class="nav-icon" viewBox="0 0 24 24">
            <path d="M8 4H16V8C16 11 14 13 12 13C10 13 8 11 8 8V4Z"></path>
            <path d="M6 6H4C4 10 6 12 9 12"></path>
            <path d="M18 6H20C20 10 18 12 15 12"></path>
            <path d="M12 13V18"></path>
            <path d="M9 20H15"></path>
          </svg>
        </div>
        <span>도전과제</span>
      </a>

      <a href="purchase.jsp" class="nav-item">
        <div class="icon-box">
          <svg class="nav-icon" viewBox="0 0 24 24">
            <path d="M6 6H21L19 14H8L6 6Z"></path>
            <path d="M6 6L5 3H2"></path>
            <circle cx="9" cy="19" r="1.5"></circle>
            <circle cx="18" cy="19" r="1.5"></circle>
          </svg>
        </div>
        <span>상점</span>
      </a>

      <a href="mypage.jsp" class="nav-item">
        <div class="icon-box">
          <svg class="nav-icon" viewBox="0 0 24 24">
            <circle cx="12" cy="8" r="4"></circle>
            <path d="M5 21C5 17 8 14 12 14C16 14 19 17 19 21"></path>
          </svg>
        </div>
        <span>마이페이지</span>
      </a>
    </nav>

    <div class="retrain-modal" id="retrainModal" aria-hidden="true">
      <div class="retrain-modal-box" role="dialog" aria-modal="true">
        <div class="retrain-modal-icon">
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <circle cx="12" cy="12" r="9"></circle>
            <path d="M8 12L11 15L16 9"></path>
          </svg>
        </div>

        <p class="retrain-modal-title">
          이미 학습한 기록이 있습니다.
        </p>

        <p class="retrain-modal-desc">
          다시 학습하시겠습니까?
        </p>

        <div class="retrain-modal-actions">
          <button type="button" class="retrain-modal-btn no" id="retrainNoBtn">
            아니오
          </button>
          <button type="button" class="retrain-modal-btn yes" id="retrainYesBtn">
            네
          </button>
        </div>
      </div>
    </div>
  </div>

  <script>
  /*
  현재 로그인한 회원 번호를 JSP에서 가져온다.
  회원마다 훈련 기록이 다르기 때문에 M_NUM으로 구분한다.
  */
  	const M_NUM = <%= loginUser.getmNum() %>;

  	/*
  	회원별 훈련 기록 저장 key.
  	예: 회원번호가 3이면 BGS_TRAIN_HISTORY_3 으로 저장된다.
  	*/
    const TRAIN_HISTORY_KEY = `BGS_TRAIN_HISTORY_${M_NUM}`;

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

    function getSavedTrainingSetting() {
      try {
        const appSetting = JSON.parse(localStorage.getItem(`BGS_APP_SETTING_${M_NUM}`) || "{}");
        const division = Number(appSetting.TRAIN_DIVISION) || 1;
        const kendoDifficulty = appSetting.KENDO_DIFFICULTY || (division === 1 ? appSetting.DIFFICULTY : "k2");
        const liechtenauerDifficulty = appSetting.LIECHTENAUER_DIFFICULTY || (division === 2 ? appSetting.DIFFICULTY : "l_middle");

        return {
          DIVISION: division,
          K_GRADE: Number(String(kendoDifficulty).replace("k", "")) || 2,
          L_GRADE: liechtenauerDifficulty
        };
      } catch (error) {
        return {
          DIVISION: 1,
          K_GRADE: 1,
          L_GRADE: null
        };
      }
    }

    const USER_TRAINING_SETTING = getSavedTrainingSetting();

    function getAppSetting() {
      try {
        return {
          TRAIN_DIVISION: "1",
          DIFFICULTY: "k2",
          KENDO_DIFFICULTY: "k2",
          LIECHTENAUER_DIFFICULTY: "l_middle",
          ...JSON.parse(localStorage.getItem(`BGS_APP_SETTING_${M_NUM}`) || "{}")
        };
      } catch (error) {
        return {
          TRAIN_DIVISION: "1",
          DIFFICULTY: "k2",
          KENDO_DIFFICULTY: "k2",
          LIECHTENAUER_DIFFICULTY: "l_middle"
        };
      }
    }

    function getDifficultyLabel(division, value) {
      const options = DIFFICULTY_OPTIONS[division] || DIFFICULTY_OPTIONS["1"];
      const selectedOption = options.find((item) => item.value === value) || options[0];
      return selectedOption.label;
    }
    /*
    DB에 저장된 회원의 실제 난이도를 화면에 표시한다.

    대한검도는 MEMBER 테이블의 K_GRADE,
    리히테나워는 MEMBER 테이블의 L_GRADE 값을 사용한다.
    */
    function renderTrainingLevel() {
    	  document.getElementById("trainingLevelText").innerText =
    	    "대한검도 · <%= loginUser.getkGrade() %>급 / 리히테나워 · <%
    	      if (loginUser.getlGrade() == 1) {
    	          out.print("초급");
    	      } else if (loginUser.getlGrade() == 2) {
    	          out.print("중급");
    	      } else if (loginUser.getlGrade() == 3) {
    	          out.print("고급");
    	      } else {
    	          out.print("-");
    	      }
    	    %>";
    	}
    
    const TRAINING_QUOTES = [
      "오늘의 한 걸음이 내일의 실력을 만든다.",
      "자세는 흔들려도 마음은 흔들리지 않는다.",
      "이기는 것보다 끝까지 겨루는 마음.",
      "반복은 재능을 이긴다.",
      "강함은 빠름보다 꾸준함에서 온다.",
      "검끝보다 먼저 마음을 세운다.",
      "승부는 순간이고, 수련은 오래 남는다.",
      "오늘의 수련이 나를 바로 세운다.",
      "넘어지지 않는 사람이 아니라 다시 서는 사람이 강하다.",
      "한 번 더 버티는 사람이 한 단계 더 오른다."
    ];

    const TRAINING_LIST = [
      {
        DIVISION: 1,
        TRAIN_NUM: 1,
        POSTURE_NUM: 1,
        GRADE: 1,
        G_NAME: "중단세",
        TRAIN_NAME: "자세훈련",
        TRAIN_DESC: "기본 자세를 하나씩 익히는 훈련"
      },
      {
        DIVISION: 1,
        TRAIN_NUM: 2,
        POSTURE_NUM: 7,
        GRADE: 1,
        G_NAME: "머리치기",
        TRAIN_NAME: "행동훈련",
        TRAIN_DESC: "죽도 궤적과 몸의 중심 이동을 확인"
      },
      {
        DIVISION: 2,
        TRAIN_NUM: 1,
        POSTURE_NUM: 11,
        GRADE: 1,
        G_NAME: "Vom Tag",
        TRAIN_NAME: "자세훈련",
        TRAIN_DESC: "리히테나워 기본 가드를 안정적으로 유지"
      },
      {
        DIVISION: 2,
        TRAIN_NUM: 2,
        POSTURE_NUM: 14,
        GRADE: 1,
        G_NAME: "Oberhau",
        TRAIN_NAME: "행동훈련",
        TRAIN_DESC: "상단 베기 동작의 시작과 마무리를 점검"
      }
    ];

    const POSTURE_LIST = [
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 1, G_NAME: "기본 자세 - 중단세" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 2, G_NAME: "기본 베기 - 정면 베기" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 3, G_NAME: "발 동작 - 전진/후진" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 4, G_NAME: "자세 교정 - 중단세 심화", REQUIRED_POSTURE_NUM: 1, IS_REWARD: true },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 5, G_NAME: "연속 베기 - 좌우 베기" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 6, G_NAME: "동작 교정 - 베기 분석", REQUIRED_POSTURE_NUM: 5, IS_REWARD: true },
      { DIVISION: 1, TRAIN_NUM: 2, POSTURE_NUM: 7, G_NAME: "머리치기 - 기본" },
      { DIVISION: 1, TRAIN_NUM: 2, POSTURE_NUM: 8, G_NAME: "머리치기 - 연속", REQUIRED_POSTURE_NUM: 7 },
      { DIVISION: 2, TRAIN_NUM: 1, POSTURE_NUM: 11, G_NAME: "기본 자세 - Vom Tag" },
      { DIVISION: 2, TRAIN_NUM: 1, POSTURE_NUM: 12, G_NAME: "기본 자세 - Pflug" },
      { DIVISION: 2, TRAIN_NUM: 1, POSTURE_NUM: 13, G_NAME: "기본 자세 - Ochs", REQUIRED_POSTURE_NUM: 11 },
      { DIVISION: 2, TRAIN_NUM: 2, POSTURE_NUM: 14, G_NAME: "Oberhau - 기본" },
      { DIVISION: 2, TRAIN_NUM: 2, POSTURE_NUM: 15, G_NAME: "Oberhau - 연결", REQUIRED_POSTURE_NUM: 14 }
    ];

    const DEFAULT_TRAINING = TRAINING_LIST.find((training) => {
      return training.DIVISION === USER_TRAINING_SETTING.DIVISION;
    }) || TRAINING_LIST[0];

    const TRAIN_HIS = {
      HIS_NUM: null,
      M_NUM,
      T_DATE: null,
      DIVISION: DEFAULT_TRAINING.DIVISION,
      TRAIN_NUM: DEFAULT_TRAINING.TRAIN_NUM,
      POSTURE_NUM: DEFAULT_TRAINING.POSTURE_NUM
    };

    let selectedRestartPostureNum = null;

    function setTrainingQuote() {
      const trainingQuote = document.getElementById("trainingQuote");
      const randomIndex = Math.floor(Math.random() * TRAINING_QUOTES.length);
      trainingQuote.innerText = `"${TRAINING_QUOTES[randomIndex]}"`;
    }
    /*
    훈련 종류에 맞는 아이콘 이미지를 반환한다.
    TRAIN_NUM이 1이면 자세훈련 아이콘,
    2이면 행동훈련 아이콘을 보여준다.
    */
    function getTrainingIcon(TRAIN_NUM) {
    	  if (TRAIN_NUM === 1) {
    	    return `
    	      <img src="Project_Logo/main_icon.png" alt="자세훈련 아이콘" class="training-icon posture">
    	    `;
    	  }

    	  return `
    	    <img src="Project_Logo/main_icon2.png" alt="행동훈련 아이콘" class="training-icon action">
    	  `;
    	}

    function renderTrainingList() {
      const trainingGrid = document.getElementById("trainingGrid");
      const selectedList = TRAINING_LIST.filter((training) => training.DIVISION === TRAIN_HIS.DIVISION);

      trainingGrid.innerHTML = selectedList.map((training) => `
        <button
          type="button"
          class="training-card ${training.TRAIN_NUM === TRAIN_HIS.TRAIN_NUM ? "active" : ""}"
          data-train-num="${training.TRAIN_NUM}"
          data-posture-num="${training.POSTURE_NUM}"
        >
          <span class="card-icon">
            ${getTrainingIcon(training.TRAIN_NUM)}
          </span>
          <span class="card-title">${training.TRAIN_NAME}</span>
        </button>
      `).join("");

      document.querySelectorAll(".training-card").forEach((card) => {
        card.addEventListener("click", () => {
          const postures = getPosturesByTraining(Number(card.dataset.trainNum));
          const firstPosture = postures.find((posture) => posture.STATUS !== "locked") || postures[0];

          TRAIN_HIS.TRAIN_NUM = Number(card.dataset.trainNum);
          TRAIN_HIS.POSTURE_NUM = firstPosture ? firstPosture.POSTURE_NUM : Number(card.dataset.postureNum);

          renderPostureList();
          renderTrainingList();
        });
      });
    }

    function getTrainingHistory() {
      const savedHistory = localStorage.getItem(TRAIN_HISTORY_KEY);

      if (!savedHistory) {
        return [];
      }

      try {
        return JSON.parse(savedHistory);
      } catch (error) {
        return [];
      }
    }

    function isPostureCompleted(postureNum) {
      return getTrainingHistory().some((history) => {
        return Number(history.M_NUM) === M_NUM && Number(history.POSTURE_NUM) === Number(postureNum);
      });
    }

    function getPostureStatus(posture) {
      if (isPostureCompleted(posture.POSTURE_NUM)) {
        return "done";
      }

      if (posture.REQUIRED_POSTURE_NUM && !isPostureCompleted(posture.REQUIRED_POSTURE_NUM)) {
        return "locked";
      }

      return "current";
    }

    function getPosturesByTraining(trainNum) {
      return POSTURE_LIST
        .filter((posture) => {
          return posture.DIVISION === TRAIN_HIS.DIVISION && posture.TRAIN_NUM === trainNum;
        })
        .map((posture) => ({
          ...posture,
          STATUS: getPostureStatus(posture)
        }));
    }

    function getPostureIcon(status) {
      if (status === "done") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <circle cx="12" cy="12" r="9"></circle>
            <path d="M8 12L11 15L16 9"></path>
          </svg>
        `;
      }

      if (status === "locked") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <rect x="6" y="10" width="12" height="9" rx="2"></rect>
            <path d="M8 10V7C8 4.8 9.8 3 12 3C14.2 3 16 4.8 16 7V10"></path>
          </svg>
        `;
      }

      return `
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <path d="M4 8H8L10 5H14L16 8H20V19H4V8Z"></path>
          <circle cx="12" cy="13.5" r="3.2"></circle>
        </svg>
      `;
    }

    function renderPostureList() {
      const postureGrid = document.getElementById("postureGrid");
      const postureSectionTitle = document.getElementById("postureSectionTitle");

      const selectedTraining = TRAINING_LIST.find((training) => {
        return training.DIVISION === TRAIN_HIS.DIVISION && training.TRAIN_NUM === TRAIN_HIS.TRAIN_NUM;
      }) || DEFAULT_TRAINING;

      const selectedPostures = getPosturesByTraining(TRAIN_HIS.TRAIN_NUM);

      postureSectionTitle.innerText = `${selectedTraining.TRAIN_NAME} 목록`;

      postureGrid.innerHTML = selectedPostures.map((posture) => `
        <button
          type="button"
          class="posture-item ${posture.STATUS}"
          data-posture-num="${posture.POSTURE_NUM}"
          data-status="${posture.STATUS}"
          ${posture.STATUS === "locked" ? "disabled" : ""}
        >
          <span class="posture-icon">
            ${getPostureIcon(posture.STATUS)}
          </span>
          <span class="posture-name">${posture.G_NAME}</span>
        </button>
      `).join("");

      document.querySelectorAll(".posture-item:not(.locked)").forEach((item) => {
        item.addEventListener("click", () => {
          const postureStatus = item.dataset.status;
          const postureNum = Number(item.dataset.postureNum);

          TRAIN_HIS.POSTURE_NUM = postureNum;

          if (postureStatus === "done") {
            openRetrainModal(postureNum);
            return;
          }

          startPostureTraining();
        });
      });
    }

    function openRetrainModal(postureNum) {
      selectedRestartPostureNum = Number(postureNum);

      const retrainModal = document.getElementById("retrainModal");
      retrainModal.classList.add("show");
      retrainModal.setAttribute("aria-hidden", "false");
    }

    function closeRetrainModal() {
      const retrainModal = document.getElementById("retrainModal");
      retrainModal.classList.remove("show");
      retrainModal.setAttribute("aria-hidden", "true");
    }

    function setupRetrainModal() {
      const retrainNoBtn = document.getElementById("retrainNoBtn");
      const retrainYesBtn = document.getElementById("retrainYesBtn");

      retrainNoBtn.addEventListener("click", () => {
        closeRetrainModal();
        location.href = "main.jsp";
      });

      retrainYesBtn.addEventListener("click", () => {
        closeRetrainModal();

        if (selectedRestartPostureNum) {
          TRAIN_HIS.POSTURE_NUM = selectedRestartPostureNum;
        }

        startPostureTraining();
      });
    }

    function startPostureTraining() {
      TRAIN_HIS.T_DATE = new Date().toISOString();

      const selectedPosture = POSTURE_LIST.find((posture) => {
        return posture.DIVISION === TRAIN_HIS.DIVISION && posture.POSTURE_NUM === TRAIN_HIS.POSTURE_NUM;
      });

      const trainingParams = new URLSearchParams({
        DIVISION: TRAIN_HIS.DIVISION,
        TRAIN_NUM: TRAIN_HIS.TRAIN_NUM,
        POSTURE_NUM: TRAIN_HIS.POSTURE_NUM,
        G_NAME: selectedPosture ? selectedPosture.G_NAME : "선택한 자세",
        T_DATE: TRAIN_HIS.T_DATE
      });

      location.href = `trainning.jsp?${trainingParams.toString()}`;
    }

    setTrainingQuote();
    renderTrainingLevel();
    setupRetrainModal();
    renderTrainingList();
    renderPostureList();
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