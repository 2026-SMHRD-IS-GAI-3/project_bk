<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%@ page import="com.kendo.model.UserDAO" %>
<%@ page import="com.kendo.model.TrainingDTO" %>

<%!
    private String js(Object value) {
        if (value == null) {
            return "";
        }

        return String.valueOf(value)
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "")
            .replace("\n", " ");
    }
%>

<%
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

    if (loginUser == null) {
        response.sendRedirect("login.jsp?login=required");
        return;
    }

    int division = 1;
    int trainNum = 1;
    int postureNum = 1;

    if (request.getParameter("DIVISION") != null) {
        division = Integer.parseInt(request.getParameter("DIVISION"));
    }

    if (request.getParameter("TRAIN_NUM") != null) {
        trainNum = Integer.parseInt(request.getParameter("TRAIN_NUM"));
    }

    if (request.getParameter("POSTURE_NUM") != null) {
        postureNum = Integer.parseInt(request.getParameter("POSTURE_NUM"));
    }

    String requestGName = request.getParameter("G_NAME");

    UserDAO dao = new UserDAO();
    TrainingDTO trainingData = dao.selectTrainingData(division, postureNum);

    System.out.println("division = " + division);
    System.out.println("trainNum = " + trainNum);
    System.out.println("postureNum = " + postureNum);
    System.out.println("trainingData = " + trainingData);

    if (trainingData != null) {
        System.out.println("gName = " + trainingData.getgName());
        System.out.println("url = " + trainingData.getUrl());
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
    const CONTEXT_PATH = "<%= request.getContextPath() %>";

    const TRAINING_DATA = [
      {
        DIVISION: <%= trainingData != null ? trainingData.getDivision() : division %>,
        TRAIN_NUM: <%= trainNum %>,
        POSTURE_NUM: <%= trainingData != null ? trainingData.getPostureNum() : postureNum %>,
        G_NAME: "<%= js(requestGName != null && !requestGName.trim().isEmpty() ? requestGName : (trainingData != null && trainingData.getgName() != null ? trainingData.getgName() : "훈련")) %>",        FILE_DIV: <%= trainingData != null ? trainingData.getFileDiv() : 1 %>,
        URL: "<%= js(trainingData != null && trainingData.getUrl() != null ? trainingData.getUrl() : "") %>"
      }
    ];

    const DIVISION_NAME = {
      1: "대한검도",
      2: "리히테나워"
    };

    const M_NUM = <%= loginUser.getmNum() %>;
    const TRAIN_HISTORY_KEY = `BGS_TRAIN_HISTORY_${M_NUM}`;

    let cameraStream = null;
    let CURRENT_TRAIN_HIS = null;

    const AUTO_SUBMIT_SCORE = 70;
    let autoSubmitTimer = null;
    let isAutoAnalyzing = false;
    let isAutoSubmitted = false;

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
        return Number(data.DIVISION) === Number(TRAIN_HIS.DIVISION)
          && Number(data.TRAIN_NUM) === Number(TRAIN_HIS.TRAIN_NUM)
          && Number(data.POSTURE_NUM) === Number(TRAIN_HIS.POSTURE_NUM);
      }) || {
        ...TRAIN_HIS,
        FILE_DIV: 1,
        URL: ""
      };

      document.getElementById("G_NAME_TEXT").innerText = selectedData.G_NAME || TRAIN_HIS.G_NAME;

      const referenceStage = document.getElementById("referenceStage");
      const referenceMedia = document.getElementById("referenceMedia");

      let imageUrl = selectedData.URL || "";

      const fallbackImageMap = {
    		  "1_1": "/uploads/img/jungdan.jpg",
    		  "1_2": "/uploads/img/jungdan.jpg",

    		  "2_1": "/uploads/img/vonTag.jpg",
    		  "2_2": "/uploads/img/pflug.jpg",
    		  "2_3": "/uploads/img/ox.jpg",
    		  "2_4": "/uploads/img/alber.jpg",

    		  "2_5": "/uploads/img/vonTag.jpg",
    		  "2_6": "/uploads/img/pflug.jpg",
    		  "2_7": "/uploads/img/ox.jpg",
    		  "2_8": "/uploads/img/alber.jpg"
    		};
      if (!imageUrl) {
        imageUrl = fallbackImageMap[`${selectedData.DIVISION}_${selectedData.POSTURE_NUM}`] || "";
      }

      if (imageUrl) {
        if (imageUrl.startsWith("http")) {
          imageUrl = imageUrl;
        } else if (imageUrl.startsWith("/")) {
          imageUrl = CONTEXT_PATH + imageUrl;
        } else if (imageUrl.includes("/")) {
          imageUrl = CONTEXT_PATH + "/" + imageUrl;
        } else {
          imageUrl = CONTEXT_PATH + "/uploads/img/" + imageUrl;
        }
      }

      console.log("선택 훈련 데이터:", selectedData);
      console.log("표준 자세 이미지 최종:", imageUrl);

      document.getElementById("FILE_DIV_TEXT").innerText = imageUrl
        ? (Number(selectedData.FILE_DIV) === 2 ? "VIDEO" : "IMAGE")
        : "DB CHECK";

      if (imageUrl) {
        referenceStage.classList.add("has-media");
        document.getElementById("REFERENCE_TITLE").innerText = selectedData.G_NAME || "표준 자세 자료";

        referenceMedia.innerHTML = Number(selectedData.FILE_DIV) === 2
          ? `<video src="${imageUrl}" controls playsinline></video>`
          : `<img src="${imageUrl}" alt="${selectedData.G_NAME || TRAIN_HIS.G_NAME} 훈련 자료">`;

        document.getElementById("REFERENCE_DESC").innerText = `DB에서 불러온 자료: ${imageUrl}`;
      } else {
        referenceStage.classList.remove("has-media");
        referenceMedia.innerHTML = "";
        document.getElementById("REFERENCE_TITLE").innerText = "DB 연결 점검중";
        document.getElementById("REFERENCE_DESC").innerText = "표준 자세 자료는 DB 연결 후 표시됩니다. 현재는 연결 실패 또는 점검중 상태입니다.";
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
    	  submitResultDesc.innerText = `자세가 제출되었습니다. 다음 수련은 ${nextData.G_NAME}입니다.`;        nextPostureBtn.innerText = "다음 자세";
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

    async function saveTrainingHistoryDb() {
    	  if (!CURRENT_TRAIN_HIS) {
    	    console.warn("CURRENT_TRAIN_HIS 없음");
    	    return false;
    	  }

    	  try {
    	    const formData = new URLSearchParams();

    	    formData.append("division", CURRENT_TRAIN_HIS.DIVISION);
    	    formData.append("trainNum", CURRENT_TRAIN_HIS.TRAIN_NUM);
    	    formData.append("postureNum", CURRENT_TRAIN_HIS.POSTURE_NUM);
    	    formData.append("accuracy", CURRENT_TRAIN_HIS.ACCURACY || 0);

    	    console.log("DB 저장 요청 데이터:", {
    	      division: CURRENT_TRAIN_HIS.DIVISION,
    	      trainNum: CURRENT_TRAIN_HIS.TRAIN_NUM,
    	      postureNum: CURRENT_TRAIN_HIS.POSTURE_NUM,
    	      accuracy: CURRENT_TRAIN_HIS.ACCURACY || 0
    	    });

    	    const response = await fetch("TrainHisService", {
    	      method: "POST",
    	      headers: {
    	        "Content-Type": "application/x-www-form-urlencoded"
    	      },
    	      body: formData.toString()
    	    });

    	    const text = await response.text();
    	    console.log("훈련 기록 DB 저장 결과:", text);

    	    return text.trim() === "OK";

    	  } catch (error) {
    	    console.error("훈련 기록 DB 저장 실패:", error);
    	    return false;
    	  }
    	}
    
    function stopAutoSubmitTraining() {
    	  if (autoSubmitTimer) {
    	    clearInterval(autoSubmitTimer);
    	    autoSubmitTimer = null;
    	  }

    	  isAutoAnalyzing = false;
    	}

    	function startAutoSubmitTraining() {
    	  stopAutoSubmitTraining();

    	  isAutoSubmitted = false;

    	  autoSubmitTimer = setInterval(async () => {
    	    await runAutoSubmitCheck();
    	  }, 1500);
    	}

    	async function runAutoSubmitCheck() {
    	  if (isAutoAnalyzing || isAutoSubmitted) {
    	    return;
    	  }

    	  if (!cameraStream) {
    	    return;
    	  }

    	  isAutoAnalyzing = true;

    	  try {
    	    const aiResult = await analyzePose(false);

    	    if (!aiResult || aiResult.error) {
    	      return;
    	    }

    	    const score = Math.round(Number(aiResult.final_score) || 0);

    	    console.log("자동 분석 점수:", score);

    	    if (score >= AUTO_SUBMIT_SCORE) {
    	      isAutoSubmitted = true;
    	      stopAutoSubmitTraining();

    	      stopAutoSubmitTraining();

    	      await finishTrainingWithAiResult(aiResult);    	    }

    	  } catch (error) {
    	    console.error("자동 제출 분석 실패:", error);

    	  } finally {
    	    isAutoAnalyzing = false;
    	  }
    	}
    
    	async function startCamera() {
    		  const cameraStage = document.getElementById("cameraStage");
    		  const cameraVideo = document.getElementById("cameraVideo");

    		  stopAutoSubmitTraining();

    		  isAutoSubmitted = false;

    		  cameraStage.classList.remove("submitted");

    		  try {
    		    if (cameraStream) {
    		      cameraStream.getTracks().forEach((track) => track.stop());
    		      cameraStream = null;
    		    }

    		    cameraStream = await navigator.mediaDevices.getUserMedia({
    		      video: {
    		        facingMode: "user"
    		      },
    		      audio: false
    		    });

    		    cameraVideo.srcObject = cameraStream;
    		    await cameraVideo.play();

    		    cameraStage.classList.add("camera-on");

    		    setTimeout(() => {
    		      startAutoSubmitTraining();
    		    }, 1000);

    		  } catch (error) {
    		    console.error(error);
    		    alert("카메라를 사용할 수 없습니다. 브라우저 권한을 확인해주세요.");
    		  }
    		}

    async function submitPosture() {
    	  const cameraVideo = document.getElementById("cameraVideo");

    	  const hasActiveCamera =
    	    cameraStream &&
    	    cameraStream.getVideoTracks().some((track) => track.readyState === "live") &&
    	    cameraVideo.readyState >= HTMLMediaElement.HAVE_CURRENT_DATA;

    	  if (!hasActiveCamera) {
    	    alert("카메라를 켜고 자세를 화면에 맞춘 뒤 제출해주세요.");
    	    return;
    	  }

    	  const aiResult = await analyzePose(true);

    	  if (!aiResult) {
    	    return;
    	  }

    	  if (aiResult.error) {
    	    alert("AI 분석 실패: " + aiResult.error);
    	    return;
    	  }

    	  await finishTrainingWithAiResult(aiResult);
    	}
    
    function captureImage() {
    	  const cameraVideo = document.getElementById("cameraVideo");

    	  return new Promise((resolve) => {
    	    const canvas = document.createElement("canvas");

    	    canvas.width = cameraVideo.videoWidth || 640;
    	    canvas.height = cameraVideo.videoHeight || 480;

    	    const context = canvas.getContext("2d");
    	    context.drawImage(cameraVideo, 0, 0, canvas.width, canvas.height);

    	    canvas.toBlob((blob) => {
    	      resolve(blob);
    	    }, "image/jpeg", 0.9);
    	  });
    	}

    	async function analyzePose(showAlert = true) {
    	  try {
    	    const imageBlob = await captureImage();

    	    const formData = new FormData();
    	    formData.append("image", imageBlob, "capture.jpg");

    	    const mode =
    	      Number(CURRENT_TRAIN_HIS.DIVISION) === 2
    	        ? "hema"
    	        : "kendo";

    	    formData.append("mode", mode);

    	    const AI_API_URL = "http://192.168.219.47:5000/predict";

    	    const response = await fetch(AI_API_URL, {
    	    	  method: "POST",
    	    	  body: formData
    	    	});
    	    
    	    const text = await response.text();
    	    console.log("AI 서버 응답:", text);

    	    let result;

    	    try {
    	      result = JSON.parse(text);
    	    } catch (error) {
    	      if (showAlert) {
    	        alert("AI 서버가 JSON이 아닌 응답을 보냈습니다.\n" + text);
    	      }
    	      return null;
    	    }

    	    return result;

    	  } catch (error) {
    	    console.error("AI 서버 연결 실패:", error);

    	    if (showAlert) {
    	      alert("AI 서버 연결 실패");
    	    }

    	    return null;
    	  }
    	}

    	async function finishTrainingWithAiResult(aiResult) {
    		  stopAutoSubmitTraining();

    		  const cameraStage = document.getElementById("cameraStage");
    		  const cameraVideo = document.getElementById("cameraVideo");

    		  if (cameraStream) {
    		    cameraStream.getTracks().forEach((track) => track.stop());
    		    cameraStream = null;
    		  }

    		  cameraVideo.srcObject = null;
    		  cameraStage.classList.remove("camera-on");
    		  cameraStage.classList.add("submitted");

    		  const score = Math.round(Number(aiResult.final_score) || 0);
    		  const aiPose = aiResult.pose || "분석 결과 없음";
    		  const aiStatus = aiResult.status || "결과 없음";

    		  CURRENT_TRAIN_HIS.ACCURACY = score;
    		  CURRENT_TRAIN_HIS.AI_POSE = aiPose;
    		  CURRENT_TRAIN_HIS.STATUS = aiStatus;

    		  const submitTitle = document.querySelector(".submit-title");
    		  const submitResultDesc = document.getElementById("submitResultDesc");

    		  if (submitTitle) {
    		    submitTitle.innerText = "자세 분석 완료";
    		  }

    		  if (submitResultDesc) {
    		    submitResultDesc.innerText =
    		      "표준 자세 : " + CURRENT_TRAIN_HIS.G_NAME +
    		      "\nAI 판단 자세 : " + aiPose +
    		      "\n나의 자세 점수 : " + score + "점" +
    		      "\n결과 : " + aiStatus;
    		  }

    		  saveTrainingHistory();

    		  const dbSaved = await saveTrainingHistoryDb();

    		  if (dbSaved) {
    		    console.log("훈련 기록 DB 저장 성공");
    		  } else {
    		    console.warn("훈련 기록 DB 저장 실패");
    		  }
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

    		  location.href = `trainning.jsp?${nextParams.toString()}`;
    		}

    		renderTrainingSession();
  </script>
  <script>
    (function applyDarkMode() {
      try {
    	  const appSetting = JSON.parse(localStorage.getItem(`BGS_APP_SETTING_${M_NUM}`) || "{}");        if (appSetting.DARK_MODE) {
          document.querySelector(".mobile-frame")?.classList.add("dark-mode");
        }
      } catch (error) {}
    })();
  </script>
</body>
</html>