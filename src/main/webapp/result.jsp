<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <title>trainning</title>

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

    .training-session {
      height: 100%;
      padding: 22px 20px 24px;
      display: flex;
      flex-direction: column;
      gap: 14px;
    }

    .session-header {
      display: flex;
      align-items: center;
      gap: 12px;
      min-height: 44px;
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

    .title-wrap {
      min-width: 0;
    }

    .page-title {
      font-size: 25px;
      line-height: 1.15;
      color: #213638;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .split-view {
      flex: 1;
      min-height: 0;
      display: grid;
      grid-template-rows: 1fr 1fr;
      gap: 14px;
    }

    .training-panel {
      min-height: 0;
      border-radius: 8px;
      border: 1px solid rgba(255, 255, 255, 0.76);
      background-color: rgba(255, 255, 255, 0.50);
      box-shadow: 0 14px 28px rgba(40, 70, 72, 0.12);
      overflow: hidden;
      display: flex;
      flex-direction: column;
    }

    .panel-header {
      height: 42px;
      padding: 0 14px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-bottom: 1px solid rgba(33, 54, 56, 0.08);
      font-family: 'Pretendard', sans-serif;
      font-size: 12px;
      font-weight: 800;
      color: rgba(33, 54, 56, 0.66);
    }

    .panel-tag {
      font-size: 10px;
      color: rgba(33, 54, 56, 0.44);
    }

    .reference-stage,
    .camera-stage {
      flex: 1;
      min-height: 0;
      position: relative;
      display: flex;
      align-items: center;
      justify-content: center;
      background:
        linear-gradient(135deg, rgba(33, 54, 56, 0.82), rgba(75, 109, 110, 0.70)),
        url("Project_Logo/logo_02.png") center/cover;
      color: #f6fbf8;
    }

    .reference-stage::after,
    .camera-stage::after {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(180deg, rgba(10, 18, 24, 0.10), rgba(10, 18, 24, 0.34));
    }

    .reference-content,
    .camera-placeholder {
      position: relative;
      z-index: 1;
      width: 100%;
      height: 100%;
      padding: 18px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      font-family: 'Pretendard', sans-serif;
    }

    .reference-media {
      position: absolute;
      inset: 0;
      z-index: 1;
      display: none;
      background-color: rgba(246, 251, 248, 0.92);
    }

    .reference-stage.has-media .reference-media {
      display: block;
    }

    .reference-stage.has-media .reference-content {
      display: none;
    }

    .reference-media img,
    .reference-media video {
      width: 100%;
      height: 100%;
      object-fit: contain;
      display: block;
    }

    .reference-icon,
    .camera-icon {
      width: 54px;
      height: 54px;
      border-radius: 16px;
      background-color: rgba(255, 255, 255, 0.18);
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 12px;
      backdrop-filter: blur(4px);
    }

    .reference-icon svg,
    .camera-icon svg {
      width: 30px;
      height: 30px;
      stroke: #f6fbf8;
      stroke-width: 2;
      fill: none;
    }

    .reference-title,
    .camera-title {
      font-size: 15px;
      font-weight: 800;
      margin-bottom: 6px;
    }

    .reference-desc,
    .camera-desc {
      max-width: 280px;
      font-size: 12px;
      font-weight: 700;
      line-height: 1.5;
      color: rgba(246, 251, 248, 0.74);
    }

    .camera-stage {
      background: #1d3134;
    }

    .camera-stage video {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: none;
      z-index: 1;
    }

    .camera-stage.camera-on video {
      display: block;
    }

    .camera-stage.camera-on .camera-placeholder {
      display: none;
    }

    .submit-result {
      position: relative;
      z-index: 2;
      width: 100%;
      height: 100%;
      padding: 20px;
      display: none;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      font-family: 'Pretendard', sans-serif;
      color: #f6fbf8;
      background: linear-gradient(135deg, rgba(29, 49, 52, 0.94), rgba(68, 103, 107, 0.90));
    }

    .camera-stage.submitted video,
    .camera-stage.submitted .camera-placeholder,
    .camera-stage.submitted .camera-actions {
      display: none;
    }

    .camera-stage.submitted .submit-result {
      display: flex;
    }

    .submit-icon {
      width: 58px;
      height: 58px;
      border-radius: 18px;
      background-color: rgba(216, 232, 127, 0.20);
      border: 1px solid rgba(216, 232, 127, 0.48);
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 14px;
    }

    .submit-icon svg {
      width: 32px;
      height: 32px;
      stroke: #d8e87f;
      stroke-width: 2.2;
      fill: none;
    }

    .submit-title {
      font-size: 16px;
      font-weight: 800;
      margin-bottom: 7px;
    }

    .submit-desc {
      max-width: 280px;
      font-size: 12px;
      font-weight: 700;
      line-height: 1.55;
      color: rgba(246, 251, 248, 0.76);
      margin-bottom: 18px;
    }

    .submit-actions {
      width: 100%;
      display: flex;
      gap: 8px;
    }

    .camera-actions {
      position: absolute;
      left: 12px;
      right: 12px;
      bottom: 12px;
      z-index: 2;
      display: flex;
      gap: 8px;
    }

    .camera-btn {
      flex: 1;
      height: 44px;
      border: none;
      border-radius: 8px;
      background-color: rgba(246, 251, 248, 0.92);
      color: #213638;
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 800;
      cursor: pointer;
    }

    .camera-btn.primary {
      background-color: #d8e87f;
    }

    @media (max-width: 390px) {
      .training-session {
        padding: 20px 16px 22px;
        gap: 12px;
      }

      .page-title {
        font-size: 23px;
      }

      .panel-header {
        height: 40px;
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
    <main class="training-session">
      <header class="session-header">
        <button type="button" class="back-btn" onclick="location.href='main.jsp'" aria-label="훈련 목록으로 돌아가기">
          <svg viewBox="0 0 24 24">
            <path d="M15 18L9 12L15 6"></path>
          </svg>
        </button>

        <div class="title-wrap">
          <h1 class="page-title" id="G_NAME_TEXT">훈련</h1>
        </div>
      </header>

      <section class="split-view">
        <article class="training-panel">
          <div class="panel-header">
            <span>표준 자세</span>
            <span class="panel-tag" id="FILE_DIV_TEXT">IMAGE / VIDEO</span>
          </div>

          <div class="reference-stage" id="referenceStage">
            <div class="reference-media" id="referenceMedia"></div>
            <div class="reference-content">
              <div class="reference-icon">
                <svg viewBox="0 0 24 24">
                  <path d="M4 5H20V17H4V5Z"></path>
                  <path d="M8 21H16"></path>
                  <path d="M12 17V21"></path>
                  <path d="M8 13L11 10L13 12L16 8"></path>
                </svg>
              </div>
              <p class="reference-title" id="REFERENCE_TITLE">표준 자세 자료</p>
              <p class="reference-desc" id="REFERENCE_DESC">SM_IMG_VID 테이블의 URL 자료가 연결되면 이 영역에 이미지나 영상이 표시됩니다.</p>
            </div>
          </div>
        </article>

        <article class="training-panel">
          <div class="panel-header">
            <span>나의 자세</span>
            <span class="panel-tag">CAMERA</span>
          </div>

          <div class="camera-stage" id="cameraStage">
            <video id="cameraVideo" autoplay playsinline muted></video>
            <div class="camera-placeholder">
              <div class="camera-icon">
                <svg viewBox="0 0 24 24">
                  <path d="M4 8H8L10 5H14L16 8H20V19H4V8Z"></path>
                  <circle cx="12" cy="13.5" r="3.2"></circle>
                </svg>
              </div>
              <p class="camera-title">카메라 준비</p>
              <p class="camera-desc">카메라를 켜고 내 자세를 화면 중앙에 맞춰주세요.</p>
            </div>

            <div class="submit-result" id="submitResult">
              <div class="submit-icon">
                <svg viewBox="0 0 24 24">
                  <circle cx="12" cy="12" r="9"></circle>
                  <path d="M8 12L11 15L16 9"></path>
                </svg>
              </div>
              <p class="submit-title">자세 제출 완료</p>
              <p class="submit-desc" id="submitResultDesc">AI 분석을 위해 자세가 제출되었습니다.</p>
              <div class="submit-actions">
                <button type="button" class="camera-btn" onclick="location.href='main.jsp'">훈련 목록</button>
                <button type="button" class="camera-btn primary" id="nextPostureBtn" onclick="goNextPosture()">다음 자세</button>
              </div>
            </div>

            <div class="camera-actions">
              <button type="button" class="camera-btn primary" onclick="startCamera()">카메라 시작</button>
              <button type="button" class="camera-btn" onclick="submitPosture()">자세 제출</button>
            </div>
          </div>
        </article>
      </section>
    </main>
  </div>

  <script>
    const TRAINING_DATA = [
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 1, G_NAME: "기본 자세 - 중단세", FILE_DIV: 1, URL: "Project_Logo/logo_02.png" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 2, G_NAME: "기본 베기 - 정면 베기", FILE_DIV: 1, URL: "Project_Logo/logo_02.png" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 3, G_NAME: "발 동작 - 전진/후진", FILE_DIV: 2, URL: "" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 4, G_NAME: "자세 교정 - 중단세 심화", FILE_DIV: 1, URL: "" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 5, G_NAME: "연속 베기 - 좌우 베기", FILE_DIV: 2, URL: "" },
      { DIVISION: 1, TRAIN_NUM: 1, POSTURE_NUM: 6, G_NAME: "동작 교정 - 베기 분석", FILE_DIV: 2, URL: "" },
      { DIVISION: 1, TRAIN_NUM: 2, POSTURE_NUM: 7, G_NAME: "머리치기 - 기본", FILE_DIV: 2, URL: "" },
      { DIVISION: 1, TRAIN_NUM: 2, POSTURE_NUM: 8, G_NAME: "머리치기 - 연속", FILE_DIV: 2, URL: "" },
      { DIVISION: 2, TRAIN_NUM: 1, POSTURE_NUM: 11, G_NAME: "기본 자세 - Vom Tag", FILE_DIV: 1, URL: "Project_Logo/logo_02.png" },
      { DIVISION: 2, TRAIN_NUM: 1, POSTURE_NUM: 12, G_NAME: "기본 자세 - Pflug", FILE_DIV: 1, URL: "" },
      { DIVISION: 2, TRAIN_NUM: 1, POSTURE_NUM: 13, G_NAME: "기본 자세 - Ochs", FILE_DIV: 1, URL: "" },
      { DIVISION: 2, TRAIN_NUM: 2, POSTURE_NUM: 14, G_NAME: "Oberhau - 기본", FILE_DIV: 2, URL: "" },
      { DIVISION: 2, TRAIN_NUM: 2, POSTURE_NUM: 15, G_NAME: "Oberhau - 연결", FILE_DIV: 2, URL: "" }
    ]; 

    const DIVISION_NAME = {
      1: "대한검도",
      2: "리히테나워"
    };

    const M_NUM = <%= loginUser.getmNum() %>;
    const TRAIN_HISTORY_KEY = `BGS_TRAIN_HISTORY_\${M_NUM}`;

    let cameraStream = null;
    let CURRENT_TRAIN_HIS = null;

    function getTrainingParams() {
      const params = new URLSearchParams(location.search);

      return {
        DIVISION: Number(params.get("DIVISION")) || 1,
        TRAIN_NUM: Number(params.get("TRAIN_NUM")) || 1,
        POSTURE_NUM: Number(params.get("POSTURE_NUM")) || 1,
        G_NAME: params.get("G_NAME") || "기본 자세 - 중단세",
        T_DATE: params.get("T_DATE") || new Date().toISOString(),
        ACCURACY: params.get("ACCURACY")
      };
    }

    function renderTrainingSession() {
      const TRAIN_HIS = getTrainingParams();
      CURRENT_TRAIN_HIS = TRAIN_HIS;
      const selectedData = TRAINING_DATA.find((data) => {
        return data.DIVISION === TRAIN_HIS.DIVISION && data.POSTURE_NUM === TRAIN_HIS.POSTURE_NUM;
      }) || {
        ...TRAIN_HIS,
        FILE_DIV: 1,
        URL: ""
      };

      document.getElementById("G_NAME_TEXT").innerText = selectedData.G_NAME || TRAIN_HIS.G_NAME;
      document.getElementById("FILE_DIV_TEXT").innerText = selectedData.FILE_DIV === 2 ? "VIDEO" : "IMAGE";
      document.getElementById("REFERENCE_TITLE").innerText = selectedData.G_NAME || TRAIN_HIS.G_NAME;

      const referenceStage = document.getElementById("referenceStage");
      const referenceMedia = document.getElementById("referenceMedia");

      if (selectedData.URL) {
        referenceStage.classList.add("has-media");
        referenceMedia.innerHTML = selectedData.FILE_DIV === 2
          ? `<video src="\${selectedData.URL}" controls playsinline></video>`
          : `<img src="\${selectedData.URL}" alt="\${selectedData.G_NAME || TRAIN_HIS.G_NAME} 훈련 자료">`;
        document.getElementById("REFERENCE_DESC").innerText = `URL: \${selectedData.URL}`;
      } else {
        referenceStage.classList.remove("has-media");
        referenceMedia.innerHTML = "";
        document.getElementById("REFERENCE_DESC").innerText = "아직 연결된 훈련 자료가 없습니다. 이미지나 영상 URL을 연결하면 이 영역에 표시됩니다.";
      }
    }

    function getNextTrainingData() {
      if (!CURRENT_TRAIN_HIS) {
        return null;
      }

      const sameTrainingList = TRAINING_DATA
        .filter((data) => {
          return data.DIVISION === CURRENT_TRAIN_HIS.DIVISION && data.TRAIN_NUM === CURRENT_TRAIN_HIS.TRAIN_NUM;
        })
        .sort((a, b) => a.POSTURE_NUM - b.POSTURE_NUM);
      const currentIndex = sameTrainingList.findIndex((data) => {
        return data.POSTURE_NUM === CURRENT_TRAIN_HIS.POSTURE_NUM;
      });

      return currentIndex >= 0 ? sameTrainingList[currentIndex + 1] || null : null;
    }

    function updateSubmitResult() {
      const nextData = getNextTrainingData();
      const submitResultDesc = document.getElementById("submitResultDesc");
      const nextPostureBtn = document.getElementById("nextPostureBtn");

      if (nextData) {
        submitResultDesc.innerText = `자세가 제출되었습니다. 다음 수련은 \${nextData.G_NAME}입니다.`;
        nextPostureBtn.innerText = "다음 자세";
      } else {
        submitResultDesc.innerText = "이번 훈련의 모든 자세를 제출했습니다. 훈련 목록에서 다른 수련을 이어가세요.";
        nextPostureBtn.innerText = "훈련 목록으로";
      }
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

    function saveTrainingHistory() {
      if (!CURRENT_TRAIN_HIS) {
        return;
      }

      const history = getTrainingHistory();
      const rawAccuracy = CURRENT_TRAIN_HIS.ACCURACY;
      const savedAccuracy = rawAccuracy !== null && rawAccuracy !== undefined && rawAccuracy !== ""
        ? Number(rawAccuracy)
        : null;
      const nextRecord = {
        HIS_NUM: Date.now(),
        M_NUM,
        DIVISION: CURRENT_TRAIN_HIS.DIVISION,
        TRAIN_NUM: CURRENT_TRAIN_HIS.TRAIN_NUM,
        POSTURE_NUM: CURRENT_TRAIN_HIS.POSTURE_NUM,
        G_NAME: CURRENT_TRAIN_HIS.G_NAME,
        T_DATE: new Date().toISOString(),
        ACCURACY: Number.isFinite(savedAccuracy) ? savedAccuracy : null
      };

      localStorage.setItem(TRAIN_HISTORY_KEY, JSON.stringify([...history, nextRecord]));
    }

    async function startCamera() {
      const cameraStage = document.getElementById("cameraStage");
      const cameraVideo = document.getElementById("cameraVideo");
      cameraStage.classList.remove("submitted");

      try {
        cameraStream = await navigator.mediaDevices.getUserMedia({
          video: {
            facingMode: "user"
          },
          audio: false
        });
        cameraVideo.srcObject = cameraStream;
        cameraStage.classList.add("camera-on");
      } catch (error) {
        alert("카메라를 사용할 수 없습니다. 브라우저 권한을 확인해주세요.");
      }
    }

    function submitPosture() {
      const cameraStage = document.getElementById("cameraStage");
      const cameraVideo = document.getElementById("cameraVideo");

      if (cameraStream) {
        cameraStream.getTracks().forEach((track) => track.stop());
        cameraStream = null;
      }

      cameraVideo.srcObject = null;
      cameraStage.classList.remove("camera-on");
      cameraStage.classList.add("submitted");
      saveTrainingHistory();
      updateSubmitResult();
    }

    function goNextPosture() {
      const nextData = getNextTrainingData();

      if (!nextData) {
        location.href = "main.jsp";
        return;
      }

      const nextParams = new URLSearchParams({
        DIVISION: nextData.DIVISION,
        TRAIN_NUM: nextData.TRAIN_NUM,
        POSTURE_NUM: nextData.POSTURE_NUM,
        G_NAME: nextData.G_NAME,
        T_DATE: new Date().toISOString()
      });

      location.href = `trainning.jsp?\${nextParams.toString()}`;
    }

    renderTrainingSession();
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