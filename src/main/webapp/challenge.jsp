<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%
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
  <title>방구석 검도 - 도전과제</title>

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

    .challenge-page {
      height: 100%;
      padding: 28px 22px 116px;
      overflow-y: auto;
      scrollbar-width: none;
      -ms-overflow-style: none;
    }

    .challenge-page::-webkit-scrollbar {
      display: none;
    }

    .challenge-visual {
      min-height: 150px;
      border-radius: 8px;
      background:
        linear-gradient(135deg, rgba(23, 35, 42, 0.90), rgba(61, 91, 88, 0.76)),
   		url("Project_Logo/logo_02.png") center/cover;
      overflow: hidden;
      position: relative;
      padding: 18px 20px;
      color: #f6fbf8;
      display: flex;
      align-items: center;
      margin-bottom: 18px;
      box-shadow: 0 22px 42px rgba(34, 58, 60, 0.20);
    }

    .challenge-visual::after {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(90deg, rgba(10, 18, 24, 0.82), rgba(10, 18, 24, 0.10));
    }

    .visual-copy {
      position: relative;
      z-index: 1;
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      text-align: left;
    }

    .visual-text {
      min-width: 0;
    }

    .eyebrow {
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 800;
      color: #d8e87f;
      letter-spacing: 1px;
      margin-bottom: 8px;
    }

    .visual-title {
      font-size: 27px;
      line-height: 1.18;
      margin-bottom: 9px;
    }

    .visual-desc {
      max-width: 292px;
      margin: 0;
      font-family: 'Pretendard', sans-serif;
      font-size: 12px;
      font-weight: 700;
      line-height: 1.48;
      color: rgba(246, 251, 248, 0.78);
      word-break: keep-all;
    }

    .point-value {
      min-width: 94px;
      min-height: 50px;
      border-radius: 8px;
      background-color: rgba(246, 251, 248, 0.18);
      border: 1px solid rgba(246, 251, 248, 0.24);
      padding: 9px 10px;
      font-family: 'Pretendard', sans-serif;
      text-align: center;
      box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.12);
      flex-shrink: 0;
    }

    .point-caption {
      display: block;
      margin-bottom: 6px;
      font-size: 9px;
      font-weight: 800;
      color: rgba(246, 251, 248, 0.70);
      white-space: nowrap;
    }

    .point-amount {
      display: flex;
      align-items: baseline;
      justify-content: center;
      font-size: 16px;
      font-weight: 800;
      line-height: 1;
    }

    .point-unit {
      font-size: 12px;
      margin-left: 4px;
      color: #d8e87f;
    }

    .summary-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 10px;
      margin-bottom: 22px;
    }

    .summary-item {
      min-height: 76px;
      border-radius: 8px;
      border: 1px solid rgba(255, 255, 255, 0.76);
      background-color: rgba(255, 255, 255, 0.54);
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.10);
      padding: 10px 8px 11px;
      text-align: center;
      font-family: 'Pretendard', sans-serif;
    }

    .summary-icon {
      width: 24px;
      height: 24px;
      margin: 0 auto 5px;
      border-radius: 8px;
      background-color: rgba(68, 103, 107, 0.13);
      color: #44676b;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .summary-icon svg {
      width: 16px;
      height: 16px;
      stroke: currentColor;
      stroke-width: 2.2;
      fill: none;
    }

    .summary-value {
      display: block;
      font-size: 19px;
      font-weight: 800;
      color: #213638;
      line-height: 1.1;
    }

    .summary-label {
      display: block;
      margin-top: 7px;
      font-size: 10px;
      font-weight: 800;
      color: rgba(33, 54, 56, 0.58);
      word-break: keep-all;
    }

    .section-head {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
      margin: 22px 0 10px;
    }

    .section-title {
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      font-weight: 800;
      color: #213638;
    }

    .section-caption {
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 800;
      color: rgba(33, 54, 56, 0.48);
      white-space: nowrap;
    }

    .challenge-list {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .challenge-card {
      border: 1px solid rgba(255, 255, 255, 0.76);
      border-radius: 8px;
      background-color: rgba(255, 255, 255, 0.56);
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.10);
      padding: 14px;
      display: grid;
      grid-template-columns: 48px 1fr;
      gap: 12px;
      font-family: 'Pretendard', sans-serif;
    }

    .challenge-card.done {
      background-color: rgba(255, 255, 255, 0.82);
      border-color: rgba(216, 232, 127, 0.92);
    }

    .challenge-icon {
      width: 48px;
      height: 48px;
      border-radius: 8px;
      background-color: #44676b;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #f6fbf8;
      box-shadow: 0 10px 18px rgba(33, 54, 56, 0.14);
    }

    .challenge-card.done .challenge-icon {
      background-color: #d8e87f;
      color: #213638;
    }

    .challenge-icon svg {
      width: 27px;
      height: 27px;
      stroke: currentColor;
      stroke-width: 2;
      fill: none;
    }

    .challenge-main {
      min-width: 0;
    }

    .challenge-top {
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      gap: 8px;
      margin-bottom: 6px;
    }

    .challenge-title {
      font-size: 14px;
      font-weight: 800;
      color: #213638;
      line-height: 1.35;
      word-break: keep-all;
    }

    .reward-badge {
      height: 24px;
      padding: 0 8px;
      border-radius: 999px;
      background-color: rgba(33, 54, 56, 0.08);
      color: rgba(33, 54, 56, 0.66);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 10px;
      font-weight: 800;
      flex-shrink: 0;
      white-space: nowrap;
    }

    .challenge-desc {
      font-size: 11px;
      font-weight: 700;
      line-height: 1.45;
      color: rgba(33, 54, 56, 0.58);
      margin-bottom: 10px;
      word-break: keep-all;
    }

    .progress-row {
      display: flex;
      align-items: center;
      gap: 9px;
    }

    .progress-track {
      flex: 1;
      height: 8px;
      border-radius: 999px;
      background-color: rgba(33, 54, 56, 0.10);
      overflow: hidden;
    }

    .progress-fill {
      width: var(--progress);
      height: 100%;
      border-radius: 999px;
      background-color: #44676b;
    }

    .challenge-card.done .progress-fill {
      background-color: #9eb450;
    }

    .progress-text {
      width: 48px;
      text-align: right;
      font-size: 10px;
      font-weight: 800;
      color: rgba(33, 54, 56, 0.62);
      flex-shrink: 0;
    }

    .action-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
      margin-top: 11px;
    }

    .status-text {
      font-size: 10px;
      font-weight: 800;
      color: rgba(33, 54, 56, 0.48);
    }

    .claim-btn {
      height: 32px;
      border: none;
      border-radius: 8px;
      padding: 0 12px;
      background-color: #213638;
      color: #f6fbf8;
      font-size: 11px;
      font-weight: 800;
      cursor: pointer;
      flex-shrink: 0;
    }

    .claim-btn:disabled {
      cursor: default;
      background-color: rgba(33, 54, 56, 0.13);
      color: rgba(33, 54, 56, 0.42);
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

    @media (max-width: 390px) {
      .challenge-page {
        padding: 24px 18px 108px;
      }

      .challenge-visual {
        min-height: 142px;
        padding: 16px 18px;
      }

      .visual-title {
        font-size: 25px;
      }

      .visual-copy {
        gap: 12px;
      }

      .point-value {
        min-width: 88px;
        min-height: 48px;
      }

      .challenge-card {
        grid-template-columns: 44px 1fr;
        gap: 10px;
        padding: 13px;
      }

      .challenge-icon {
        width: 44px;
        height: 44px;
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
    .mobile-frame.dark-mode .summary-value,
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
    <main class="challenge-page">
      <section class="challenge-visual" aria-label="도전과제 안내">
        <div class="visual-copy">
          <div class="visual-text">
            <h1 class="visual-title">오늘의 도전과제</h1>
            <p class="visual-desc">도전과제를 완료하면 포인트를 받을 수 있어요.</p>
          </div>
          <p class="point-value">
            <span class="point-caption">나의 포인트</span>
            <span class="point-amount"><span id="memberPoint">0</span><span class="point-unit">P</span></span>
          </p>
        </div>
      </section>

      <section class="summary-grid" aria-label="도전과제 요약">
        <div class="summary-item">
          <span class="summary-icon">
            <svg viewBox="0 0 24 24" aria-hidden="true">
              <circle cx="12" cy="12" r="9"></circle>
              <path d="M8 12L11 15L16 9"></path>
            </svg>
          </span>
          <span class="summary-value" id="completeCount">0</span>
          <span class="summary-label">완료된 과제</span>
        </div>
        <div class="summary-item">
          <span class="summary-icon">
            <svg viewBox="0 0 24 24" aria-hidden="true">
              <circle cx="12" cy="12" r="9"></circle>
              <path d="M12 7V12L15 15"></path>
            </svg>
          </span>
          <span class="summary-value" id="activeCount">0</span>
          <span class="summary-label">진행 중인 과제</span>
        </div>
      </section>

      <section aria-label="완료한 도전과제">
        <div class="section-head">
          <h2 class="section-title">완료</h2>
        </div>
        <div class="challenge-list" id="doneChallengeList"></div>
      </section>

      <section aria-label="진행 중인 도전과제">
        <div class="section-head">
          <h2 class="section-title">진행 중</h2>
        </div>
        <div class="challenge-list" id="activeChallengeList"></div>
      </section>
    </main>

    <nav class="bottom-nav">
    <a href="main.jsp" class="nav-item">
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

    <a href="challenge.jsp" class="nav-item active">
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
  </div>

  <script>
  const M_NUM = <%= loginUser.getmNum() %>;
    const POINT_STORAGE_KEY = `BGS_MEMBER_POINT_${M_NUM}`;
    const CHALLENGE_STORAGE_KEY = `BGS_MEMBER_CHALLENGE_${M_NUM}`;

    const TRAIN_HIS_LIST = [
      { HIS_NUM: 1, M_NUM, T_DATE: "2026-06-09", DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 1 },
      { HIS_NUM: 2, M_NUM, T_DATE: "2026-06-09", DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 2 },
      { HIS_NUM: 3, M_NUM, T_DATE: "2026-06-08", DIVISION: 1, TRAIN_NUM: 2, POSTURE_NUM: 7 },
      { HIS_NUM: 4, M_NUM, T_DATE: "2026-06-07", DIVISION: 2, TRAIN_NUM: 1, POSTURE_NUM: 11 },
      { HIS_NUM: 5, M_NUM, T_DATE: "2026-06-06", DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 3 }
    ];

    const CHALLENGE_LIST = [
      {
        CHALLENGE_NUM: 1,
        C_NAME: "첫 자세 제출",
        C_DESC: "훈련 화면에서 자세를 1회 제출하면 완료됩니다.",
        C_TYPE: "SUBMIT_COUNT",
        TARGET_COUNT: 1,
        REWARD_POINT: 100
      },
      {
        CHALLENGE_NUM: 2,
        C_NAME: "오늘의 검도 루틴",
        C_DESC: "하루 동안 자세 훈련을 3개 이상 완료합니다.",
        C_TYPE: "TODAY_TRAIN_COUNT",
        TARGET_COUNT: 3,
        REWARD_POINT: 150
      },
      {
        CHALLENGE_NUM: 3,
        C_NAME: "대한검도 입문",
        C_DESC: "대한검도 훈련 기록을 5회 남깁니다.",
        C_TYPE: "DIVISION_COUNT",
        DIVISION: 1,
        TARGET_COUNT: 5,
        REWARD_POINT: 300
      },
      {
        CHALLENGE_NUM: 4,
        C_NAME: "리히테나워 도전자",
        C_DESC: "리히테나워 훈련을 2회 이상 완료합니다.",
        C_TYPE: "DIVISION_COUNT",
        DIVISION: 2,
        TARGET_COUNT: 2,
        REWARD_POINT: 300
      },
      {
        CHALLENGE_NUM: 5,
        C_NAME: "꾸준한 수련생",
        C_DESC: "누적 훈련 기록을 10회 달성합니다.",
        C_TYPE: "SUBMIT_COUNT",
        TARGET_COUNT: 10,
        REWARD_POINT: 500
      }
    ];

    const DEFAULT_MEMBER_CHALLENGE_LIST = [
      { M_NUM, CHALLENGE_NUM: 1, ACHIEVE_YN: "Y", REWARD_YN: "Y", ACHIEVE_DATE: "2026-06-06" },
      { M_NUM, CHALLENGE_NUM: 2, ACHIEVE_YN: "N", REWARD_YN: "N", ACHIEVE_DATE: null },
      { M_NUM, CHALLENGE_NUM: 3, ACHIEVE_YN: "Y", REWARD_YN: "N", ACHIEVE_DATE: "2026-06-09" },
      { M_NUM, CHALLENGE_NUM: 4, ACHIEVE_YN: "N", REWARD_YN: "N", ACHIEVE_DATE: null },
      { M_NUM, CHALLENGE_NUM: 5, ACHIEVE_YN: "N", REWARD_YN: "N", ACHIEVE_DATE: null }
    ];

    let MEMBER_CHALLENGE_LIST = loadMemberChallengeList();

    function loadMemberChallengeList() {
      const savedChallengeList = localStorage.getItem(CHALLENGE_STORAGE_KEY);

      if (!savedChallengeList) {
        return DEFAULT_MEMBER_CHALLENGE_LIST.map((challenge) => ({ ...challenge }));
      }

      try {
        return JSON.parse(savedChallengeList);
      } catch (error) {
        return DEFAULT_MEMBER_CHALLENGE_LIST.map((challenge) => ({ ...challenge }));
      }
    }

    function saveMemberChallengeList() {
      localStorage.setItem(CHALLENGE_STORAGE_KEY, JSON.stringify(MEMBER_CHALLENGE_LIST));
    }

    function getMemberPoint() {
      return Number(localStorage.getItem(POINT_STORAGE_KEY)) || 0;
    }

    function renderMemberPoint() {
      document.getElementById("memberPoint").innerText = getMemberPoint();
    }

    function addMemberPoint(point) {
      const nextPoint = getMemberPoint() + point;
      localStorage.setItem(POINT_STORAGE_KEY, String(nextPoint));
      renderMemberPoint();
    }

    function initializeMemberPoint() {
      if (localStorage.getItem(POINT_STORAGE_KEY) !== null) {
        return;
      }

      const rewardedPoint = MEMBER_CHALLENGE_LIST.reduce((sum, memberChallenge) => {
        if (memberChallenge.REWARD_YN !== "Y") {
          return sum;
        }

        const challenge = CHALLENGE_LIST.find((item) => item.CHALLENGE_NUM === memberChallenge.CHALLENGE_NUM);
        return challenge ? sum + challenge.REWARD_POINT : sum;
      }, 0);

      localStorage.setItem(POINT_STORAGE_KEY, String(rewardedPoint));
    }

    function getTodayKey() {
      return new Date().toISOString().slice(0, 10);
    }

    function getChallengeProgress(challenge) {
      if (challenge.C_TYPE === "TODAY_TRAIN_COUNT") {
        return TRAIN_HIS_LIST.filter((history) => history.T_DATE === getTodayKey()).length;
      }

      if (challenge.C_TYPE === "DIVISION_COUNT") {
        return TRAIN_HIS_LIST.filter((history) => history.DIVISION === challenge.DIVISION).length;
      }

      return TRAIN_HIS_LIST.length;
    }

    function getMemberChallenge(challengeNum) {
      return MEMBER_CHALLENGE_LIST.find((item) => item.M_NUM === M_NUM && item.CHALLENGE_NUM === challengeNum) || {
        M_NUM,
        CHALLENGE_NUM: challengeNum,
        ACHIEVE_YN: "N",
        REWARD_YN: "N",
        ACHIEVE_DATE: null
      };
    }

    function getChallengeState(challenge) {
      const memberChallenge = getMemberChallenge(challenge.CHALLENGE_NUM);
      const currentCount = getChallengeProgress(challenge);
      const isAchieved = memberChallenge.ACHIEVE_YN === "Y" || currentCount >= challenge.TARGET_COUNT;

      return {
        currentCount: Math.min(currentCount, challenge.TARGET_COUNT),
        isAchieved,
        isRewarded: memberChallenge.REWARD_YN === "Y",
        progressPercent: Math.min(100, Math.round((currentCount / challenge.TARGET_COUNT) * 100))
      };
    }

    function getStatusText(state) {
      if (state.isRewarded) {
        return "보상 수령 완료";
      }

      if (state.isAchieved) {
        return "보상 수령 가능";
      }

      return "진행 중";
    }

    function getChallengeIcon(state) {
      if (state.isAchieved) {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M8 4H16V8C16 11 14 13 12 13C10 13 8 11 8 8V4Z"></path>
            <path d="M6 6H4C4 10 6 12 9 12"></path>
            <path d="M18 6H20C20 10 18 12 15 12"></path>
            <path d="M12 13V18"></path>
            <path d="M9 20H15"></path>
          </svg>
        `;
      }

      return `
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <circle cx="12" cy="12" r="9"></circle>
          <path d="M12 7V12L15 15"></path>
        </svg>
      `;
    }

    function createChallengeCard(challenge) {
      const state = getChallengeState(challenge);
      const buttonText = state.isRewarded ? "완료" : "받기";

      return `
        <article class="challenge-card ${state.isAchieved ? "done" : ""}">
          <div class="challenge-icon">${getChallengeIcon(state)}</div>
          <div class="challenge-main">
            <div class="challenge-top">
              <h3 class="challenge-title">${challenge.C_NAME}</h3>
              <span class="reward-badge">${challenge.REWARD_POINT}P</span>
            </div>
            <p class="challenge-desc">${challenge.C_DESC}</p>
            <div class="progress-row">
              <div class="progress-track">
                <div class="progress-fill" style="--progress: ${state.progressPercent}%"></div>
              </div>
              <span class="progress-text">${state.currentCount}/${challenge.TARGET_COUNT}</span>
            </div>
            <div class="action-row">
              <span class="status-text">${getStatusText(state)}</span>
              <button
                type="button"
                class="claim-btn"
                data-challenge-num="${challenge.CHALLENGE_NUM}"
                ${!state.isAchieved || state.isRewarded ? "disabled" : ""}
              >${buttonText}</button>
            </div>
          </div>
        </article>
      `;
    }

    function renderSummary() {
      const challengeStates = CHALLENGE_LIST.map(getChallengeState);
      const completeCount = challengeStates.filter((state) => state.isAchieved).length;
      const activeCount = challengeStates.filter((state) => !state.isAchieved).length;

      document.getElementById("completeCount").innerText = completeCount;
      document.getElementById("activeCount").innerText = activeCount;
    }

    function renderChallengeList() {
      const activeChallengeList = document.getElementById("activeChallengeList");
      const doneChallengeList = document.getElementById("doneChallengeList");

      const activeChallenges = CHALLENGE_LIST.filter((challenge) => !getChallengeState(challenge).isAchieved);
      const doneChallenges = CHALLENGE_LIST.filter((challenge) => getChallengeState(challenge).isAchieved);

      activeChallengeList.innerHTML = activeChallenges.map(createChallengeCard).join("");
      doneChallengeList.innerHTML = doneChallenges.map(createChallengeCard).join("");

      document.querySelectorAll(".claim-btn:not(:disabled)").forEach((button) => {
        button.addEventListener("click", () => {
          claimReward(Number(button.dataset.challengeNum));
        });
      });
    }

    function claimReward(challengeNum) {
      const memberChallenge = getMemberChallenge(challengeNum);
      const selectedChallenge = CHALLENGE_LIST.find((challenge) => challenge.CHALLENGE_NUM === challengeNum);

      if (memberChallenge.REWARD_YN === "Y" || !selectedChallenge) {
        return;
      }

      memberChallenge.ACHIEVE_YN = "Y";
      memberChallenge.REWARD_YN = "Y";
      memberChallenge.ACHIEVE_DATE = memberChallenge.ACHIEVE_DATE || getTodayKey();

      const exists = MEMBER_CHALLENGE_LIST.some((item) => {
        return item.M_NUM === memberChallenge.M_NUM && item.CHALLENGE_NUM === memberChallenge.CHALLENGE_NUM;
      });

      if (!exists) {
        MEMBER_CHALLENGE_LIST.push(memberChallenge);
      }

      addMemberPoint(selectedChallenge.REWARD_POINT);
      saveMemberChallengeList();
      renderSummary();
      renderChallengeList();
    }

    initializeMemberPoint();
    saveMemberChallengeList();
    renderMemberPoint();
    renderSummary();
    renderChallengeList();
  </script>
  <script>
    (function applyDarkMode() {
      try {
    	  const appSetting = JSON.parse(
    			  localStorage.getItem("BGS_APP_SETTING_<%= loginUser.getmNum() %>") || "{}"
    			);
        if (appSetting.DARK_MODE) {
          document.querySelector(".mobile-frame")?.classList.add("dark-mode");
        }
      } catch (error) {}
    })();
  </script>
</body>
</html>