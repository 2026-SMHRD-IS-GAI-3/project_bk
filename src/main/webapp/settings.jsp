<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="true"%>

<%@ page import="com.kendo.model.UserDTO" %>

<%
/*
로그인한 회원 정보를 가져온다.
로그인하지 않은 경우 로그인 페이지로 이동한다.
*/
UserDTO loginUser =
(UserDTO)session.getAttribute("loginUser");

if(loginUser == null){
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>방구석 검도 - 환경설정</title>

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

    button,
    select {
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

    .mobile-frame.dark-mode {
      background: linear-gradient(145deg, #182527 0%, #243638 52%, #11191d 100%);
      color: #eef7f2;
    }

    .settings-page {
      height: 100%;
      padding: 26px 22px 116px;
      overflow-y: auto;
      scrollbar-width: none;
      -ms-overflow-style: none;
    }

    .settings-page::-webkit-scrollbar {
      display: none;
    }

    .page-header {
      min-height: 42px;
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 18px;
    }

    .back-btn {
      width: 38px;
      height: 38px;
      border: none;
      border-radius: 12px;
      background-color: rgba(255, 255, 255, 0.58);
      color: #213638;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      box-shadow: 0 10px 20px rgba(40, 70, 72, 0.10);
      flex-shrink: 0;
    }

    .back-btn svg {
      width: 22px;
      height: 22px;
      stroke: currentColor;
      stroke-width: 2;
      fill: none;
    }

    .page-title {
      font-size: 25px;
      line-height: 1.15;
      color: #213638;
    }

    .section-title {
      font-family: 'Pretendard', sans-serif;
      font-size: 17px;
      line-height: 1.25;
      font-weight: 800;
      color: #213638;
      margin: 22px 0 10px;
    }

    .setting-list {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .setting-card {
      min-height: 76px;
      border: 1px solid rgba(255, 255, 255, 0.76);
      border-radius: 8px;
      background-color: rgba(255, 255, 255, 0.56);
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.10);
      padding: 13px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
      font-family: 'Pretendard', sans-serif;
    }

    .setting-left {
      display: flex;
      align-items: center;
      gap: 12px;
      min-width: 0;
    }

    .setting-icon {
      width: 44px;
      height: 44px;
      border-radius: 50%;
      border: 1px solid var(--setting-icon-border, rgba(255, 255, 255, 0.72));
      background-color: var(--setting-icon-bg, rgba(246, 251, 248, 0.78));
      color: var(--setting-icon-color, #44676b);
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.74),
        0 8px 16px rgba(33, 54, 56, 0.08);
    }

    .setting-icon.title {
      --setting-icon-bg: rgba(216, 232, 127, 0.30);
      --setting-icon-border: rgba(216, 232, 127, 0.56);
      --setting-icon-color: #60752d;
    }

    .setting-icon.profile {
      --setting-icon-bg: rgba(159, 218, 210, 0.26);
      --setting-icon-border: rgba(159, 218, 210, 0.54);
      --setting-icon-color: #397d73;
    }

    .setting-icon.dark {
      --setting-icon-bg: rgba(143, 122, 245, 0.18);
      --setting-icon-border: rgba(143, 122, 245, 0.40);
      --setting-icon-color: #6a57d0;
    }

    .setting-icon.notice {
      --setting-icon-bg: rgba(240, 198, 94, 0.24);
      --setting-icon-border: rgba(240, 198, 94, 0.50);
      --setting-icon-color: #9a7420;
    }

    .setting-icon svg {
      width: 25px;
      height: 25px;
      stroke: currentColor;
      stroke-width: 1.8;
      fill: none;
      stroke-linecap: round;
      stroke-linejoin: round;
    }

    .setting-info {
      min-width: 0;
    }

    .setting-name {
      font-size: 13px;
      font-weight: 800;
      color: #213638;
      margin-bottom: 4px;
    }

    .setting-desc {
      font-size: 10px;
      font-weight: 700;
      color: rgba(33, 54, 56, 0.56);
      line-height: 1.4;
      word-break: keep-all;
    }

    .select-control {
      width: 122px;
      height: 36px;
      border: 1px solid rgba(255, 255, 255, 0.64);
      border-radius: 8px;
      background-color: rgba(246, 251, 248, 0.78);
      background-image: url("data:image/svg+xml,%3Csvg width='14' height='14' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M7 10L12 15L17 10' stroke='%23213638' stroke-width='2.4' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 10px center;
      background-size: 14px 14px;
      color: #213638;
      padding: 0 32px 0 12px;
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 800;
      outline: none;
      flex-shrink: 0;
      appearance: none;
      box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.72),
        0 8px 16px rgba(33, 54, 56, 0.08);
      cursor: pointer;
    }

    .select-control:focus {
      border-color: rgba(68, 103, 107, 0.42);
      box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.72),
        0 0 0 3px rgba(68, 103, 107, 0.10);
    }

    .select-control option {
      color: #213638;
      background-color: #eef7f2;
      font-weight: 800;
    }

    .toggle {
      width: 48px;
      height: 28px;
      border: none;
      border-radius: 999px;
      background-color: rgba(33, 54, 56, 0.16);
      position: relative;
      cursor: pointer;
      flex-shrink: 0;
      transition: 0.18s;
    }

    .toggle::after {
      content: "";
      position: absolute;
      top: 4px;
      left: 4px;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      background-color: #ffffff;
      box-shadow: 0 4px 10px rgba(33, 54, 56, 0.18);
      transition: 0.18s;
    }

    .toggle.active {
      background-color: rgb(7, 11, 29);
    }

    .toggle.active::after {
      transform: translateX(20px);
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

    .mobile-frame.dark-mode .page-title,
    .mobile-frame.dark-mode .section-title,
    .mobile-frame.dark-mode .setting-name {
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .setting-card {
      background-color: rgba(255, 255, 255, 0.10);
      border-color: rgba(255, 255, 255, 0.16);
    }

    .mobile-frame.dark-mode .setting-icon {
      border-color: var(--setting-icon-border, rgba(238, 247, 242, 0.18));
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.14);
    }

    .mobile-frame.dark-mode .setting-icon.title {
      --setting-icon-bg: rgba(216, 232, 127, 0.18);
      --setting-icon-border: rgba(216, 232, 127, 0.72);
      --setting-icon-color: #d8e87f;
    }

    .mobile-frame.dark-mode .setting-icon.profile {
      --setting-icon-bg: rgba(159, 218, 210, 0.18);
      --setting-icon-border: rgba(159, 218, 210, 0.70);
      --setting-icon-color: #9fdad2;
    }

    .mobile-frame.dark-mode .setting-icon.dark {
      --setting-icon-bg: rgba(143, 122, 245, 0.18);
      --setting-icon-border: rgba(143, 122, 245, 0.72);
      --setting-icon-color: #bdb2ff;
    }

    .mobile-frame.dark-mode .setting-icon.notice {
      --setting-icon-bg: rgba(240, 198, 94, 0.17);
      --setting-icon-border: rgba(240, 198, 94, 0.70);
      --setting-icon-color: #f0c65e;
    }

    .mobile-frame.dark-mode .setting-desc {
      color: rgba(238, 247, 242, 0.62);
    }

    .mobile-frame.dark-mode .select-control {
      border-color: rgba(238, 247, 242, 0.18);
      background-color: rgba(238, 247, 242, 0.12);
      background-image: url("data:image/svg+xml,%3Csvg width='14' height='14' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M7 10L12 15L17 10' stroke='%23EEF7F2' stroke-width='2.4' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
      color: #eef7f2;
      box-shadow: none;
    }

    .mobile-frame.dark-mode .select-control:focus {
      border-color: rgba(216, 232, 127, 0.38);
      box-shadow: 0 0 0 3px rgba(216, 232, 127, 0.10);
    }

    .mobile-frame.dark-mode .select-control option {
      background-color: #243638;
      color: #eef7f2;
    }

    @media (max-width: 390px) {
      .settings-page {
        padding: 24px 18px 108px;
      }

      .select-control {
        width: 112px;
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
  </style>
</head>

<body>
  <div class="mobile-frame" id="mobileFrame">
    <main class="settings-page">
      <header class="page-header">
        <button type="button" class="back-btn" onclick="location.href='mypage.jsp'" aria-label="마이페이지로 돌아가기">
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M15 18L9 12L15 6"></path>
          </svg>
        </button>
        <h1 class="page-title">환경설정</h1>
      </header>

      <section aria-label="프로필 설정">
        <h2 class="section-title">프로필 설정</h2>
        <div class="setting-list">
          <article class="setting-card">
            <div class="setting-left">
              <span class="setting-icon title">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M7 5H17V15L12 19L7 15V5Z"></path>
                  <path d="M9 8H15"></path>
                  <path d="M10 11H14"></path>
                  <path d="M12 15V19"></path>
                </svg>
              </span>
              <div class="setting-info">
                <h3 class="setting-name">칭호</h3>
                <p class="setting-desc">상점에서 구매한 칭호를 장착합니다.</p>
              </div>
            </div>
            <select class="select-control" id="titleSelect"></select>
          </article>

          <article class="setting-card">
            <div class="setting-left">
              <span class="setting-icon profile">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M6 6H18V18H6V6Z"></path>
                  <circle cx="12" cy="11" r="2.2"></circle>
                  <path d="M8.5 17C9.2 15.2 10.5 14.3 12 14.3C13.5 14.3 14.8 15.2 15.5 17"></path>
                  <path d="M4.5 9H6"></path>
                  <path d="M18 9H19.5"></path>
                </svg>
              </span>
              <div class="setting-info">
                <h3 class="setting-name">프로필 이미지</h3>
                <p class="setting-desc">구매한 프로필 장식을 적용합니다.</p>
              </div>
            </div>
            <select class="select-control" id="profileSelect"></select>
          </article>
        </div>
      </section>

      <section aria-label="앱 환경설정">
        <h2 class="section-title">환경설정</h2>
        <div class="setting-list">
          <article class="setting-card">
            <div class="setting-left">
              <span class="setting-icon dark">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M17.5 16.6C15.8 18.6 12.8 19.3 10.3 18C7.2 16.4 6 12.5 7.6 9.4C8.7 7.3 10.8 6 13 6C12.1 7.7 12 9.8 13 11.6C13.9 13.4 15.6 14.5 17.5 14.8V16.6Z"></path>
                  <path d="M17.5 5.5L18.1 6.8L19.5 7.4L18.1 8L17.5 9.3L16.9 8L15.5 7.4L16.9 6.8L17.5 5.5Z"></path>
                  <path d="M5.8 5.5H5.9"></path>
                </svg>
              </span>
              <div class="setting-info">
                <h3 class="setting-name">다크모드</h3>
                <p class="setting-desc">화면을 어두운 톤으로 전환합니다.</p>
              </div>
            </div>
            <button type="button" class="toggle" data-setting="DARK_MODE" aria-label="다크모드"></button>
          </article>

          <article class="setting-card">
            <div class="setting-left">
              <span class="setting-icon notice">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M17 9C17 6.8 15.2 5 13 5H11C8.8 5 7 6.8 7 9V12.5L5.5 16H18.5L17 12.5V9Z"></path>
                  <path d="M10 19C10.5 20 11.2 20.5 12 20.5C12.8 20.5 13.5 20 14 19"></path>
                  <path d="M5 8.5C5.5 7.3 6.2 6.4 7.2 5.6"></path>
                  <path d="M19 8.5C18.5 7.3 17.8 6.4 16.8 5.6"></path>
                </svg>
              </span>
              <div class="setting-info">
                <h3 class="setting-name">훈련 알림</h3>
                <p class="setting-desc">오늘의 훈련을 잊지 않도록 알림을 준비합니다.</p>
              </div>
            </div>
            <button type="button" class="toggle" data-setting="TRAIN_NOTICE" aria-label="훈련 알림"></button>
          </article>
        </div>
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

      <a href="mypage.jsp" class="nav-item active">
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
  /*
  현재 로그인한 회원 번호 사용
  회원별 설정을 구분하기 위해 사용한다.
  */
  const M_NUM = <%= loginUser.getmNum() %>;
    const ITEM_STORAGE_KEY = `BGS_MEMBER_ITEMS_${M_NUM}`;
    const PROFILE_SETTING_KEY = `BGS_PROFILE_SETTING_${M_NUM}`;
    const APP_SETTING_KEY = `BGS_APP_SETTING_${M_NUM}`;

    /*
    상점에서 구매한 칭호와 프로필 목록

    현재는 DB 연동 전이라 JavaScript 배열로 관리한다.

    추후 POINT_SHOP_HIS 또는 GOODS 테이블과
    연동할 예정이다.
    */
    const ITEM_LIST = [
      { ITEM_NUM: 1, ITEM_TYPE: "TITLE", ITEM_NAME: "견습 기사" },
      { ITEM_NUM: 2, ITEM_TYPE: "TITLE", ITEM_NAME: "초심의 검" },
      { ITEM_NUM: 3, ITEM_TYPE: "TITLE", ITEM_NAME: "고요한 중단" },
      { ITEM_NUM: 4, ITEM_TYPE: "TITLE", ITEM_NAME: "한 판 더" },
      { ITEM_NUM: 5, ITEM_TYPE: "PROFILE", ITEM_NAME: "청록 호구" },
      { ITEM_NUM: 6, ITEM_TYPE: "PROFILE", ITEM_NAME: "목검 그림자" }
    ];

    const DEFAULT_PROFILE_SETTING = {
      TITLE_ITEM_NUM: 0,
      PROFILE_ITEM_NUM: 0
    };

    const DEFAULT_APP_SETTING = {
      DARK_MODE: false,
      TRAIN_NOTICE: false,
      TRAIN_DIVISION: "1",
      DIFFICULTY: "k2"
    };
    /*
    회원이 구매한 아이템 목록을 가져온다.

    저장된 데이터가 없으면 빈 배열을 반환한다.
    */
    function getMemberItems() {
      const savedItems = localStorage.getItem(ITEM_STORAGE_KEY);

      if (!savedItems) {
        return [];
      }

      try {
        return JSON.parse(savedItems);
      } catch (error) {
        return [];
      }
    }

    /*
    localStorage에 저장된 JSON 데이터를 읽는다.

    데이터가 없거나 오류가 발생하면
    기본값(fallback)을 반환한다.
    */
    function loadJson(key, fallback) {
      const savedValue = localStorage.getItem(key);

      if (!savedValue) {
        return { ...fallback };
      }

      try {
        return { ...fallback, ...JSON.parse(savedValue) };
      } catch (error) {
        return { ...fallback };
      }
    }

    /*
    JSON 데이터를 localStorage에 저장한다.
    */
    function saveJson(key, value) {
      localStorage.setItem(key, JSON.stringify(value));
    }

    /*
    구매한 아이템 중에서

    TITLE = 칭호
    PROFILE = 프로필

    종류만 필터링해서 반환한다.
    */
    function getOwnedItemsByType(type) {
      const memberItems = getMemberItems();
      return ITEM_LIST.filter((item) => item.ITEM_TYPE === type && memberItems.includes(item.ITEM_NUM));
    }

    /*
    칭호 선택창과 프로필 선택창을 생성한다.

    회원이 구매한 아이템만 표시한다.
    */
    function renderProfileControls() {
      const profileSetting = loadJson(PROFILE_SETTING_KEY, DEFAULT_PROFILE_SETTING);
      const titleSelect = document.getElementById("titleSelect");
      const profileSelect = document.getElementById("profileSelect");
      const titleItems = getOwnedItemsByType("TITLE");
      const profileItems = getOwnedItemsByType("PROFILE");
      const selectedTitleNum = titleItems.some((item) => item.ITEM_NUM === Number(profileSetting.TITLE_ITEM_NUM))
        ? Number(profileSetting.TITLE_ITEM_NUM)
        : 0;

      if (Number(profileSetting.TITLE_ITEM_NUM) !== selectedTitleNum) {
        saveJson(PROFILE_SETTING_KEY, {
          ...profileSetting,
          TITLE_ITEM_NUM: selectedTitleNum
        });
      }

      titleSelect.innerHTML = [
        { ITEM_NUM: 0, ITEM_NAME: "칭호 없음" },
        ...titleItems
      ].map((item) => `
        <option value="${item.ITEM_NUM}" ${selectedTitleNum === item.ITEM_NUM ? "selected" : ""}>${item.ITEM_NAME}</option>
      `).join("");

      profileSelect.innerHTML = [
        { ITEM_NUM: 0, ITEM_NAME: "기본 프로필" },
        ...profileItems
      ].map((item) => `
        <option value="${item.ITEM_NUM}" ${Number(profileSetting.PROFILE_ITEM_NUM) === item.ITEM_NUM ? "selected" : ""}>${item.ITEM_NAME}</option>
      `).join("");

      titleSelect.addEventListener("change", () => {
        const nextSetting = loadJson(PROFILE_SETTING_KEY, DEFAULT_PROFILE_SETTING);
        nextSetting.TITLE_ITEM_NUM = Number(titleSelect.value);
        saveJson(PROFILE_SETTING_KEY, nextSetting);
      });

      profileSelect.addEventListener("change", () => {
        const nextSetting = loadJson(PROFILE_SETTING_KEY, DEFAULT_PROFILE_SETTING);
        nextSetting.PROFILE_ITEM_NUM = Number(profileSelect.value);
        saveJson(PROFILE_SETTING_KEY, nextSetting);
      });
    }

    /*
    다크모드, 훈련 알림 설정을 불러온다.

    설정 변경 시 localStorage에 저장한다.
    */
    function renderAppSettings() {
      const appSetting = loadJson(APP_SETTING_KEY, DEFAULT_APP_SETTING);
      const mobileFrame = document.getElementById("mobileFrame");

      mobileFrame.classList.toggle("dark-mode", Boolean(appSetting.DARK_MODE));

      document.querySelectorAll(".toggle").forEach((toggle) => {
        const settingName = toggle.dataset.setting;
        toggle.classList.toggle("active", Boolean(appSetting[settingName]));

        toggle.addEventListener("click", () => {
          const nextSetting = loadJson(APP_SETTING_KEY, DEFAULT_APP_SETTING);
          nextSetting[settingName] = !nextSetting[settingName];
          saveJson(APP_SETTING_KEY, nextSetting);
          toggle.classList.toggle("active", nextSetting[settingName]);

          if (settingName === "DARK_MODE") {
            mobileFrame.classList.toggle("dark-mode", nextSetting[settingName]);
          }
        });
      });
    }
    /*
    페이지가 열릴 때 다크모드 설정을 적용한다.
    */
    (function applyDarkMode() {

        try {

            const appSetting =
            JSON.parse(
                localStorage.getItem(
                "BGS_APP_SETTING_<%= loginUser.getmNum() %>"
                ) || "{}"
            );

            if(appSetting.DARK_MODE){

                document
                .getElementById("mobileFrame")
                ?.classList.add("dark-mode");

            }

        } catch(error){}

    })();
    renderProfileControls();
    renderAppSettings();
  </script>
</body>
</html>