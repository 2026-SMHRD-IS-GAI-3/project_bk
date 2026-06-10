<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>

<%
UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

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
      font-size: 14px;
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
      width: 46px;
      height: 46px;
      border-radius: 14px;
      background-color: rgba(68, 103, 107, 0.13);
      color: #44676b;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }

    .setting-icon svg {
      width: 24px;
      height: 24px;
      stroke: currentColor;
      stroke-width: 2;
      fill: none;
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
      border: none;
      border-radius: 8px;
      background-color: rgba(33, 54, 56, 0.10);
      color: #213638;
      padding: 0 10px;
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 800;
      outline: none;
      flex-shrink: 0;
    }

    .select-control option {
      color: #213638;
      background-color: #ffffff;
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

    .mobile-frame.dark-mode .setting-desc {
      color: rgba(238, 247, 242, 0.62);
    }

    .mobile-frame.dark-mode .select-control {
      background-color: rgba(255, 255, 255, 0.14);
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

  <form action="ProfileSetService" method="post">

    <article class="setting-card">
      <div class="setting-left">
        <div class="setting-info">
          <h3 class="setting-name">대한검도 급수</h3>
        </div>
      </div>

      <select class="select-control" name="kGrade">
        <option value="1">1급</option>
        <option value="2">2급</option>
        <option value="3">3급</option>
        <option value="4">4급</option>
        <option value="5">5급</option>
        <option value="6">6급</option>
        <option value="7">7급</option>
        <option value="8">8급</option>
        <option value="9">9급</option>
        <option value="10">10급</option>
      </select>
    </article>

    <article class="setting-card">
      <div class="setting-left">
        <div class="setting-info">
          <h3 class="setting-name">리히테나워 급수</h3>
        </div>
      </div>

      <select class="select-control" name="lGrade">
        <option value="1">초급</option>
        <option value="2">중급</option>
        <option value="3">고급</option>
      </select>
    </article>
    		  <div style="margin-top:20px;">
      <button type="submit"
              style="width:100%;height:50px;border:none;border-radius:10px;">
        설정 완료
      </button>
    </div>

  </form>
    	
    
        <div class="setting-list">
          <article class="setting-card">
            <div class="setting-left">
              <span class="setting-icon">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M8 4H16V8C16 11 14 13 12 13C10 13 8 11 8 8V4Z"></path>
                  <path d="M12 13V18"></path>
                  <path d="M9 20H15"></path>
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
              <span class="setting-icon">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <circle cx="12" cy="8" r="4"></circle>
                  <path d="M5 21C5 17 8 14 12 14C16 14 19 17 19 21"></path>
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
              <span class="setting-icon">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <circle cx="12" cy="12" r="4"></circle>
                  <path d="M12 2V4"></path>
                  <path d="M12 20V22"></path>
                  <path d="M2 12H4"></path>
                  <path d="M20 12H22"></path>
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
              <span class="setting-icon">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M18 8C18 6.3 16.7 5 15 5H9C7.3 5 6 6.3 6 8V12C6 15 4 16 4 16H20C20 16 18 15 18 12V8Z"></path>
                  <path d="M10 19C10.4 20.2 11.2 21 12 21C12.8 21 13.6 20.2 14 19"></path>
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
      <a href="main.jsp"class="nav-item">
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
 	const M_NUM = <%= loginUser.getmNum() %>;
    const ITEM_STORAGE_KEY = `BGS_MEMBER_ITEMS_${M_NUM}`;
    const PROFILE_SETTING_KEY = `BGS_PROFILE_SETTING_${M_NUM}`;
    const APP_SETTING_KEY = `BGS_APP_SETTING_${M_NUM}`;

    const ITEM_LIST = [
      { ITEM_NUM: 1, ITEM_TYPE: "TITLE", ITEM_NAME: "견습 기사" },
      { ITEM_NUM: 2, ITEM_TYPE: "TITLE", ITEM_NAME: "초심의 검" },
      { ITEM_NUM: 3, ITEM_TYPE: "TITLE", ITEM_NAME: "고요한 중단" },
      { ITEM_NUM: 4, ITEM_TYPE: "TITLE", ITEM_NAME: "한 판 더" },
      { ITEM_NUM: 5, ITEM_TYPE: "PROFILE", ITEM_NAME: "청록 호구" },
      { ITEM_NUM: 6, ITEM_TYPE: "PROFILE", ITEM_NAME: "목검 그림자" }
    ];

    const DEFAULT_PROFILE_SETTING = {
      TITLE_ITEM_NUM: 2,
      PROFILE_ITEM_NUM: 0
    };

    const DEFAULT_APP_SETTING = {
      DARK_MODE: false,
      TRAIN_NOTICE: false,
      TRAIN_DIVISION: "1",
      DIFFICULTY: "k2"
    };

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

    function saveJson(key, value) {
      localStorage.setItem(key, JSON.stringify(value));
    }

    function getOwnedItemsByType(type) {
      const memberItems = getMemberItems();
      return ITEM_LIST.filter((item) => item.ITEM_TYPE === type && memberItems.includes(item.ITEM_NUM));
    }

    function renderProfileControls() {
      const profileSetting = loadJson(PROFILE_SETTING_KEY, DEFAULT_PROFILE_SETTING);
      const titleSelect = document.getElementById("titleSelect");
      const profileSelect = document.getElementById("profileSelect");
      const titleItems = getOwnedItemsByType("TITLE");
      const profileItems = getOwnedItemsByType("PROFILE");

      titleSelect.innerHTML = [
    	  { ITEM_NUM: 0, ITEM_NAME: "기본 칭호" },
    	  ...titleItems
    	].map((item) =>
    	  '<option value="' + item.ITEM_NUM + '" ' +
    	  (Number(profileSetting.TITLE_ITEM_NUM) === item.ITEM_NUM ? 'selected' : '') +
    	  '>' + item.ITEM_NAME + '</option>'
    	).join("");

      profileSelect.innerHTML = [
    	  { ITEM_NUM: 0, ITEM_NAME: "기본 프로필" },
    	  ...profileItems
    	].map((item) =>
    	  '<option value="' + item.ITEM_NUM + '" ' +
    	  (Number(profileSetting.PROFILE_ITEM_NUM) === item.ITEM_NUM ? 'selected' : '') +
    	  '>' + item.ITEM_NAME + '</option>'
    	).join("");
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

    renderProfileControls();
    renderAppSettings();
    
  </script>
</body>
</html>