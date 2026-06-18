<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

    if (loginUser == null) {
        response.sendRedirect("login.jsp?login=required");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>방구석 검도 - 자세교정</title>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Pretendard:wght@400;600;700;800&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    html, body {
      width: 100%; height: 100%;
      font-family: 'Gowun Batang', serif;
      background-color: #a7bcbb;
    }
    body { display: flex; justify-content: center; align-items: center; }
    button { font: inherit; }

    .mobile-frame {
      width: 100%; max-width: 430px; height: 100vh; min-height: 720px;
      overflow: hidden; position: relative;
      background: linear-gradient(145deg, #dce8e5 0%, #bfd1cf 50%, #96aeb0 100%);
      color: #213638;
    }
    .correction-page {
      height: 100%; padding: 28px 22px 116px; overflow-y: auto;
      scrollbar-width: none; -ms-overflow-style: none;
    }
    .correction-page::-webkit-scrollbar { display: none; }
    .hero {
      min-height: 116px; border-radius: 8px;
      background: linear-gradient(135deg, rgba(23,35,42,.90), rgba(61,91,88,.76)), url("Project_Logo/logo_02.png") center/cover;
      color: #f6fbf8; padding: 18px 20px; margin-bottom: 18px;
      display: flex; align-items: center; box-shadow: 0 22px 42px rgba(34,58,60,.20);
    }
    .hero h1 { font-size: 25px; line-height: 1.2; margin-bottom: 8px; }
    .hero p { font-family: 'Pretendard', sans-serif; font-size: 12px; font-weight: 700; color: rgba(246,251,248,.78); }
    .badge {
      display: inline-flex; align-items: center; min-height: 22px; margin-top: 10px;
      padding: 0 9px; border-radius: 999px;
      background-color: rgba(246,251,248,.16); border: 1px solid rgba(246,251,248,.24);
      font-family: 'Pretendard', sans-serif; font-size: 10px; font-weight: 800;
    }
    .panel {
      border: 1px solid rgba(255,255,255,.76); border-radius: 8px;
      background-color: rgba(255,255,255,.56); box-shadow: 0 12px 24px rgba(40,70,72,.10);
      padding: 14px; margin-bottom: 14px; font-family: 'Pretendard', sans-serif;
    }
    .section-title { font-family: 'Pretendard', sans-serif; font-size: 17px; font-weight: 800; margin: 20px 0 10px; }
    .camera-box {
      width: 100%; aspect-ratio: 3 / 4; border-radius: 10px; overflow: hidden;
      background: #111; display: flex; align-items: center; justify-content: center;
      position: relative;
    }
    #cameraVideo { width: 100%; height: 100%; object-fit: cover; display: none; }
    .camera-box.camera-on #cameraVideo { display: block; }
    .camera-placeholder {
      color: rgba(255,255,255,.78); text-align: center; font-weight: 800; line-height: 1.6;
    }
    .camera-box.camera-on .camera-placeholder { display: none; }
.button-row {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
  margin-top: 12px;
}

.btn {
  height: 44px;
  border: none;
  border-radius: 12px;
  cursor: pointer;
  font-family: 'Pretendard', sans-serif;
  font-size: 13px;
  font-weight: 800;
  background: rgba(33,54,56,.10);
  color: #213638;
}
    .btn.primary { background: #213638; color: #f6fbf8; }
    .feedback-title { font-size: 15px; font-weight: 800; margin-bottom: 8px; }
    .feedback-text {
      white-space: pre-line; font-size: 12px; line-height: 1.6; font-weight: 700;
      color: rgba(33,54,56,.70);
    }
    .bottom-nav {
      position: absolute; left: 18px; right: 18px; bottom: 18px; height: 78px;
      background: rgba(255,255,255,.72); border: 1px solid rgba(255,255,255,.82);
      border-radius: 26px; display: flex; justify-content: space-around; align-items: center;
      z-index: 100; box-shadow: 0 18px 36px rgba(40,70,72,.18); backdrop-filter: blur(10px);
    }
    .nav-item {
      width: 25%; height: 100%; text-decoration: none; color: rgba(33,54,56,.52);
      display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 4px;
      font-family: 'Pretendard', sans-serif; font-size: 10px; font-weight: 800;
    }
    .icon-box { height: 34px; display: flex; justify-content: center; align-items: center; }
    .nav-icon { width: 27px; height: 27px; stroke: rgba(33,54,56,.52); stroke-width: 1.8; fill: none; }
    .nav-item.active { color: #213638; }
    .nav-item.active .icon-box {
      width: 46px; height: 46px; border: 2px solid khaki; border-radius: 16px;
      background-color: rgba(255,255,255,.78); margin-bottom: 1px;
    }
    .nav-item.active .nav-icon { stroke: #213638; }

    .mobile-frame.dark-mode {
      background: linear-gradient(145deg, #182527 0%, #243638 52%, #11191d 100%);
      color: #eef7f2;
    }
    .mobile-frame.dark-mode .section-title,
    .mobile-frame.dark-mode .feedback-title { color: #eef7f2; }
    .mobile-frame.dark-mode .panel,
    .mobile-frame.dark-mode .bottom-nav {
      background-color: rgba(255,255,255,.10); border-color: rgba(255,255,255,.18); color: #eef7f2;
    }
    .mobile-frame.dark-mode .feedback-text { color: rgba(238,247,242,.76); }
    .mobile-frame.dark-mode .btn { background: rgba(238,247,242,.18); color: #eef7f2; }
    .mobile-frame.dark-mode .btn.primary { background: #d8e87f; color: #213638; }
    .mobile-frame.dark-mode .nav-item { color: rgba(238,247,242,.58); }
    .mobile-frame.dark-mode .nav-icon { stroke: rgba(238,247,242,.58); }
    .mobile-frame.dark-mode .nav-item.active { color: #eef7f2; }
    .mobile-frame.dark-mode .nav-item.active .nav-icon { stroke: #eef7f2; }
  </style>
</head>
<body>
  <div class="mobile-frame">
    <main class="correction-page">
      <section class="hero">
        <div>
          <h1>자세교정 피드백</h1>
          <p id="heroDesc">카메라로 자세를 촬영하면 AI가 교정 포인트를 알려줍니다.</p>
          <span class="badge" id="targetBadge">교정 준비</span>
        </div>
      </section>

      <section class="panel">
        <h2 class="section-title">카메라 분석</h2>
        <div class="camera-box" id="cameraBox">
          <video id="cameraVideo" autoplay playsinline muted></video>
          <p class="camera-placeholder">카메라 시작을 누르고<br>자세를 화면 중앙에 맞춰주세요.</p>
        </div>
       <div class="button-row">
  <button type="button" class="btn primary" onclick="startCamera()">카메라 시작</button>
</div>
      </section>

      <section class="panel">
        <p class="feedback-title">피드백 결과</p>
        <p class="feedback-text" id="feedbackText">아직 분석 전입니다.</p>
      </section>
    </main>

    <nav class="bottom-nav">
      <a href="main.jsp" class="nav-item active">
        <div class="icon-box"><svg class="nav-icon" viewBox="0 0 24 24"><path d="M4 20L20 4"></path><path d="M14 4L20 10"></path><path d="M4 14L10 20"></path><path d="M8 16L6 18"></path><path d="M16 8L18 6"></path></svg></div>
        <span>훈련</span>
      </a>
      <a href="challenge.jsp" class="nav-item"><div class="icon-box"><svg class="nav-icon" viewBox="0 0 24 24"><path d="M8 4H16V8C16 11 14 13 12 13C10 13 8 11 8 8V4Z"></path><path d="M6 6H4C4 10 6 12 9 12"></path><path d="M18 6H20C20 10 18 12 15 12"></path><path d="M12 13V18"></path><path d="M9 20H15"></path></svg></div><span>도전과제</span></a>
      <a href="purchase.jsp" class="nav-item"><div class="icon-box"><svg class="nav-icon" viewBox="0 0 24 24"><path d="M6 6H21L19 14H8L6 6Z"></path><path d="M6 6L5 3H2"></path><circle cx="9" cy="19" r="1.5"></circle><circle cx="18" cy="19" r="1.5"></circle></svg></div><span>상점</span></a>
      <a href="mypage.jsp" class="nav-item"><div class="icon-box"><svg class="nav-icon" viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"></circle><path d="M5 21C5 17 8 14 12 14C16 14 19 17 19 21"></path></svg></div><span>마이페이지</span></a>
    </nav>
  </div>

  <script>
    const M_NUM = <%= loginUser.getmNum() %>;
    const TRAIN_HISTORY_KEY = `BGS_TRAIN_HISTORY_${M_NUM}`;
    const APP_SETTING_KEY = `BGS_APP_SETTING_${M_NUM}`;
    const AI_API_URL = "http://192.168.219.47:5000/predict";

    const params = new URLSearchParams(location.search);
    const CORRECTION_HIS = {
      M_NUM,
      T_DATE: params.get("T_DATE") || new Date().toISOString(),
      DIVISION: Number(params.get("DIVISION")) || 1,
      TRAIN_NUM: Number(params.get("TRAIN_NUM")) || 2,
      POSTURE_NUM: Number(params.get("POSTURE_NUM")) || 1,
      G_NAME: params.get("G_NAME") || "자세교정"
    };

    let cameraStream = null;
    let feedbackTimer = null;
    let isFeedbackAnalyzing = false;
    let hasSavedCorrectionHistory = false;
    let hasTriedSaveCorrectionHistory = false;
    const REFERENCE_ANGLES = {
      alber: {
        left_elbow: 153.038666,
        right_elbow: 154.996765,
        left_shoulder: 19.299189
      },
      jungdan: {
        left_elbow: 135.548920,
        right_elbow: 166.514069,
        left_shoulder: 17.296896
      },
      ochs: {
        left_elbow: 81.082932,
        right_elbow: 79.016754,
        left_shoulder: 75.690910
      },
      pflug: {
        left_elbow: 146.343323,
        right_elbow: 138.327438,
        left_shoulder: 19.169174
      },
      sangdan: {
        left_elbow: 118.279388,
        right_elbow: 126.089233,
        left_shoulder: 135.221054
      },
      vomtag: {
        left_elbow: 112.533607,
        right_elbow: 103.753288,
        left_shoulder: 77.598984
      }
    };

    function getAiMode() {
    	  return Number(CORRECTION_HIS.DIVISION) === 2 ? "hema" : "kendo";
    	}

    	function getDivisionName() {
    	  return Number(CORRECTION_HIS.DIVISION) === 2 ? "리히테나워" : "대한검도";
    	}

    	function renderTargetInfo() {
    	  document.getElementById("targetBadge").innerText =
    	    `${getDivisionName()} · 교정 ${CORRECTION_HIS.POSTURE_NUM}번`;

    	  document.getElementById("heroDesc").innerText = CORRECTION_HIS.G_NAME;
    	}

    	function getCurrentPoseKey() {
    	  const name = String(CORRECTION_HIS.G_NAME || "").toLowerCase();

    	  if (name.includes("alber")) return "alber";
    	  if (name.includes("jungdan") || name.includes("중단")) return "jungdan";
    	  if (name.includes("ochs") || name.includes("ox")) return "ochs";
    	  if (name.includes("pflug")) return "pflug";
    	  if (name.includes("sangdan") || name.includes("상단")) return "sangdan";
    	  if (name.includes("vom") || name.includes("tag")) return "vomtag";

    	  const division = Number(CORRECTION_HIS.DIVISION);
    	  const postureNum = Number(CORRECTION_HIS.POSTURE_NUM);

    	  if (division === 1 && postureNum === 1) return "jungdan";
    	  if (division === 1 && postureNum === 2) return "sangdan";

    	  if (division === 2 && postureNum === 1) return "vomtag";
    	  if (division === 2 && postureNum === 2) return "pflug";
    	  if (division === 2 && postureNum === 3) return "ochs";
    	  if (division === 2 && postureNum === 4) return "alber";

    	  if (division === 2 && postureNum === 5) return "vomtag";
    	  if (division === 2 && postureNum === 6) return "pflug";
    	  if (division === 2 && postureNum === 7) return "ochs";
    	  if (division === 2 && postureNum === 8) return "alber";

    	  return "jungdan";
    	}


    	async function startCamera() {
    		  try {
    		    const video = document.getElementById("cameraVideo");
    		    const cameraBox = document.getElementById("cameraBox");

    		    stopAutoCorrectionFeedback();

    		    hasSavedCorrectionHistory = false;
    		    hasTriedSaveCorrectionHistory = false;

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

    		    video.srcObject = cameraStream;
    		    await video.play();

    		    cameraBox.classList.add("camera-on");

    		    document.getElementById("feedbackText").innerText =
    		      "AI가 자세를 자동으로 분석 중입니다.\n자세를 화면 중앙에 맞춰주세요.";

    		    setTimeout(() => {
    		      startAutoCorrectionFeedback();
    		    }, 800);

    		  } catch (error) {
    		    console.error(error);

    		    document.getElementById("feedbackText").innerText =
    		      "카메라를 사용할 수 없습니다.\n브라우저 권한을 확인해주세요.";

    		    return null;
    		  }
    		}
    	
    	function stopCamera() {
    		  stopAutoCorrectionFeedback();

    		  const video = document.getElementById("cameraVideo");
    		  const cameraBox = document.getElementById("cameraBox");

    		  if (cameraStream) {
    		    cameraStream.getTracks().forEach((track) => track.stop());
    		    cameraStream = null;
    		  }

    		  if (video) {
    		    video.srcObject = null;
    		  }

    		  if (cameraBox) {
    		    cameraBox.classList.remove("camera-on");
    		  }
    		}
    	
  	  function captureBlob() {
      return new Promise((resolve) => {
        const video = document.getElementById("cameraVideo");
        const canvas = document.createElement("canvas");
        canvas.width = video.videoWidth || 640;
        canvas.height = video.videoHeight || 480;
        const ctx = canvas.getContext("2d");
        ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
        canvas.toBlob((blob) => resolve(blob), "image/jpeg", 0.92);
      });
    }

  	function isPassResult(aiResult) {
  	  const status = String(aiResult.status || "").trim().toUpperCase();
  	  return status === "PASS";
  	}
  	  
    
    function getAiPoseName(aiResult) {
      if (!aiResult) {
        return "";
      }

      return String(
        aiResult.pose ||
        aiResult.label ||
        aiResult.prediction ||
        aiResult.predicted_pose ||
        aiResult.class_name ||
        ""
      ).trim();
    }

    function normalizePoseKey(poseName) {
      const name = String(poseName || "")
        .toLowerCase()
        .replace(/[\s_-]/g, "");

      if (name.includes("jungdan") || name.includes("중단")) return "jungdan";
      if (name.includes("sangdan") || name.includes("상단")) return "sangdan";
      if (name.includes("vomtag") || name.includes("vom") || name.includes("tag")) return "vomtag";
      if (name.includes("pflug")) return "pflug";
      if (name.includes("ochs") || name.includes("ox")) return "ochs";
      if (name.includes("alber")) return "alber";

      return name;
    }

    function isTargetPoseResult(aiResult) {
      const targetPoseKey = getCurrentPoseKey();
      const aiPoseKey = normalizePoseKey(getAiPoseName(aiResult));

      return aiPoseKey === targetPoseKey;
    }

    function isCorrectionSuccess(aiResult) {
      return isPassResult(aiResult) && isTargetPoseResult(aiResult);
    }

function getAnglesFromAiResult(aiResult) {
    	  if (!aiResult) {
    	    return null;
    	  }

    	  if (aiResult.angles) {
    	    return {
    	      left_elbow: Number(aiResult.angles.left_elbow),
    	      right_elbow: Number(aiResult.angles.right_elbow),
    	      left_shoulder: Number(aiResult.angles.left_shoulder)
    	    };
    	  }

    	  return {
    	    left_elbow: Number(aiResult.left_elbow),
    	    right_elbow: Number(aiResult.right_elbow),
    	    left_shoulder: Number(aiResult.left_shoulder)
    	  };
    	}

    	function makeFeedback(aiResult) {
    	  const poseKey = getCurrentPoseKey();
    	  const standardAngles = REFERENCE_ANGLES[poseKey];
    	  const userAngles = getAnglesFromAiResult(aiResult);

    	  const aiPose = getAiPoseName(aiResult) || "분석 결과 없음";
    	  const aiScore = Math.round(Number(aiResult.final_score || aiResult.score || 0));
    	  const status = aiResult.status || "";

    	  if (!standardAngles || !userAngles) {
    	    return `목표 자세: ${CORRECTION_HIS.G_NAME}
    	AI 판단: ${aiPose}
    	점수: ${aiScore}점

    	관절 각도 데이터를 찾을 수 없습니다.
    	Flask 서버에서 left_elbow, right_elbow, left_shoulder 값을 보내는지 확인해주세요.`;
    	  }

    	  const angleNames = {
    	    left_elbow: "왼쪽 팔꿈치",
    	    right_elbow: "오른쪽 팔꿈치",
    	    left_shoulder: "왼쪽 어깨"
    	  };

    	  const feedbackMessages = [];
    	  const diffs = [];

    	  Object.keys(standardAngles).forEach((key) => {
    	    const standardValue = Number(standardAngles[key]);
    	    const userValue = Number(userAngles[key]);

    	    if (!Number.isFinite(userValue)) {
    	      feedbackMessages.push(`${angleNames[key]} 각도를 인식하지 못했습니다.`);
    	      diffs.push(40);
    	      return;
    	    }

    	    const diff = Math.abs(userValue - standardValue);
    	    diffs.push(diff);

    	    if (diff <= 10) {
    	      feedbackMessages.push(`${angleNames[key]} 각도는 좋습니다.`);
    	      return;
    	    }

    	    if (key === "left_elbow" || key === "right_elbow") {
    	      if (userValue < standardValue) {
    	        feedbackMessages.push(`${angleNames[key]}를 조금 더 펴주세요.`);
    	      } else {
    	        feedbackMessages.push(`${angleNames[key]}를 조금 더 접어주세요.`);
    	      }
    	    }

    	    if (key === "left_shoulder") {
    	      if (userValue < standardValue) {
    	        feedbackMessages.push("왼쪽 어깨와 팔을 조금 더 들어주세요.");
    	      } else {
    	        feedbackMessages.push("왼쪽 어깨와 팔을 조금 낮춰주세요.");
    	      }
    	    }
    	  });

    	  const averageDiff =
    	    diffs.reduce((sum, value) => sum + value, 0) / diffs.length;

    	  const angleScore = Math.max(0, Math.round(100 - averageDiff * 2.2));

    	  let feedback = `목표 자세: ${CORRECTION_HIS.G_NAME}
    	AI 판단: ${aiPose}
    	AI 점수: ${aiScore}점
    	관절 기준 점수: ${angleScore}점

    	[관절 피드백]
    	- ${feedbackMessages.join("\n- ")}`;

    	  if (status) {
    	    feedback += `\n\n상태: ${status}`;
    	  }

    	  return feedback;
    	}

    function getTrainingHistory() {
      try {
        return JSON.parse(localStorage.getItem(TRAIN_HISTORY_KEY) || "[]");
      } catch (error) {
        return [];
      }
    }

    function saveLocalHistory() {
      if (hasSavedCorrectionHistory) {
        return;
      }

      const history = getTrainingHistory();

      history.push({
        HIS_NUM: Date.now(),
        M_NUM,
        T_DATE: new Date().toISOString(),
        DIVISION: CORRECTION_HIS.DIVISION,
        TRAIN_NUM: CORRECTION_HIS.TRAIN_NUM,
        POSTURE_NUM: CORRECTION_HIS.POSTURE_NUM,
        G_NAME: CORRECTION_HIS.G_NAME
      });

      localStorage.setItem(TRAIN_HISTORY_KEY, JSON.stringify(history));
      hasSavedCorrectionHistory = true;

      console.log("도전과제용 훈련 기록 저장 완료:", TRAIN_HISTORY_KEY, history);
    }

    async function saveDbHistory() {
      const formData = new URLSearchParams();
      formData.append("division", CORRECTION_HIS.DIVISION);
      formData.append("trainNum", CORRECTION_HIS.TRAIN_NUM);
      formData.append("postureNum", CORRECTION_HIS.POSTURE_NUM);

      const response = await fetch("TrainHisService", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
      });

      const text = await response.text();
      console.log("교정 기록 DB 저장 결과:", text);
      return text.trim() === "OK";
    }

    async function analyzeCorrection(showMessage = true) {
    	  const video = document.getElementById("cameraVideo");
    	  const hasCamera =
    	    cameraStream &&
    	    video.readyState >= HTMLMediaElement.HAVE_CURRENT_DATA;

    	  if (!hasCamera) {
    	    if (showMessage) {
    	      alert("카메라를 먼저 켜주세요.");
    	    }
    	    return null;
    	  }

    	  if (showMessage) {
    	    document.getElementById("feedbackText").innerText = "AI가 자세를 분석 중입니다...";
    	  }

    	  try {
    	    const blob = await captureBlob();

    	    const formData = new FormData();
    	    formData.append("image", blob, "correction.jpg");
    	    formData.append("mode", getAiMode());

    	    const response = await fetch(AI_API_URL, {
    	      method: "POST",
    	      body: formData
    	    });

    	    const text = await response.text();
    	    console.log("교정 AI 서버 응답:", text);

    	    let aiResult;

    	    try {
    	      aiResult = JSON.parse(text);
    	    } catch (error) {
    	      document.getElementById("feedbackText").innerText =
    	        "AI 서버 응답이 JSON 형식이 아닙니다.\n" + text;
    	      return null;
    	    }
        const feedback = makeFeedback(aiResult);
        const feedbackText = document.getElementById("feedbackText");
        const correctionSuccess = isCorrectionSuccess(aiResult);

        if (correctionSuccess) {
          saveLocalHistory();
          stopCamera();

          feedbackText.innerText =
            feedback +
            "\n\n목표 자세와 AI 판단이 일치하고 PASS 판정을 받아 카메라를 종료했습니다.";
        } else {
          feedbackText.innerText = feedback;

          if (isPassResult(aiResult) && !isTargetPoseResult(aiResult)) {
            feedbackText.innerText +=
              "\n\nPASS 판정이지만 목표 자세와 AI 판단이 달라 카메라를 계속 유지합니다.";
          }
        }


    	    if (correctionSuccess && !hasTriedSaveCorrectionHistory) {
    	      hasTriedSaveCorrectionHistory = true;

    	      try {
    	        const dbSaved = await saveDbHistory();

    	        if (dbSaved) {
    	          hasSavedCorrectionHistory = true;
    	        } else {
    	          console.warn("교정 기록 DB 저장 실패");
    	        }

    	      } catch (dbError) {
    	        console.error("교정 기록 DB 저장 중 오류:", dbError);
    	      }
    	    }
    	    return aiResult;

    	  } catch (error) {
    		  console.error(error);

    		  document.getElementById("feedbackText").innerText =
    		    "AI 서버 연결에 실패했습니다.\nFlask 서버가 켜져 있는지 확인해주세요.";

    		  return null;
    		}
    	}
    function startAutoCorrectionFeedback() {
    	  stopAutoCorrectionFeedback();

    	  runAutoCorrectionFeedback();

    	  feedbackTimer = setInterval(() => {
    	    runAutoCorrectionFeedback();
    	  }, 3000);
    	}

    	function stopAutoCorrectionFeedback() {
    	  if (feedbackTimer) {
    	    clearInterval(feedbackTimer);
    	    feedbackTimer = null;
    	  }

    	  isFeedbackAnalyzing = false;
    	}

    	async function runAutoCorrectionFeedback() {
    	  if (isFeedbackAnalyzing) {
    	    return;
    	  }

    	  isFeedbackAnalyzing = true;

    	  try {
    	    await analyzeCorrection(false);
    	  } catch (error) {
    	    console.error("자동 교정 피드백 실패:", error);
    	  } finally {
    	    isFeedbackAnalyzing = false;
    	  }
    	}
    
    function applyDarkMode() {
      try {
        const appSetting = JSON.parse(localStorage.getItem(APP_SETTING_KEY) || "{}");
        const isDarkMode = appSetting.DARK_MODE === true || appSetting.DARK_MODE === "true" || appSetting.DARK_MODE === "Y";
        document.querySelector(".mobile-frame")?.classList.toggle("dark-mode", isDarkMode);
      } catch (error) {}
    }

    window.addEventListener("beforeunload", () => {
    	  stopAutoCorrectionFeedback();

    	  if (cameraStream) {
    	    cameraStream.getTracks().forEach((track) => track.stop());
    	    cameraStream = null;
    	  }
    	});

    	renderTargetInfo();
    	applyDarkMode();
  </script>
</body>
</html>
