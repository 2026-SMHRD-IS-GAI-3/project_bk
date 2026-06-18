<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>

<%
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

    if (loginUser == null) {
        response.sendRedirect("login.jsp?login=required");
        return;
    }

    String mode = request.getParameter("mode");

    String pageTitle = "수련 설정";
    String pageDesc = "종목별 현재 난이도를 선택하세요";
    String buttonText = "설정 저장하기";

    if ("reset".equals(mode)) {
        pageTitle = "수련 재설정";
        pageDesc = "수련 설정 화면에서 종목과 난이도를 다시 선택합니다.";
        buttonText = "재설정 저장하기";
    }

    int kGrade = loginUser.getkGrade();
    int lGrade = loginUser.getlGrade();

    // 대한검도 기본값은 10급
    if (kGrade <= 0) {
        kGrade = 10;
    }

    // 리히테나워 기본값은 초급
    if (lGrade <= 0) {
        lGrade = 1;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title><%= pageTitle %></title>

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

    .setting-page {
      width: 100%;
      height: 100%;
      padding: 54px 28px 32px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }

    .title {
      font-size: 36px;
      font-weight: 700;
      text-align: center;
      margin-bottom: 14px;
      color: #213638;
      letter-spacing: -1px;
    }

    .desc {
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      font-weight: 700;
      color: rgba(33, 54, 56, 0.64);
      text-align: center;
      margin-bottom: 42px;
    }

    .setting-box {
      width: 100%;
      border-radius: 28px;
      padding: 26px 24px;
      background-color: rgba(255, 255, 255, 0.42);
      border: 1px solid rgba(255, 255, 255, 0.78);
      box-shadow: 0 24px 52px rgba(40, 70, 72, 0.20);
      backdrop-filter: blur(8px);
    }

    .setting-card {
      width: 100%;
      padding: 16px 14px;
      border-radius: 8px;
      background-color: rgba(255, 255, 255, 0.48);
      border: 1px solid rgba(255, 255, 255, 0.82);
      margin-bottom: 14px;
    }

    .setting-card label {
      display: block;
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      font-weight: 800;
      color: #213638;
      margin-bottom: 14px;
    }

    .setting-card select {
      width: 100%;
      height: 54px;
      border: none;
      border-radius: 18px;
      padding: 0 18px;
      font-family: 'Pretendard', sans-serif;
      font-size: 14px;
      font-weight: 700;
      color: #213638;
      background-color: rgba(255, 255, 255, 0.84);
      outline: none;
      cursor: pointer;
    }

    .save-btn {
      width: 100%;
      height: 56px;
      border: none;
      border-radius: 8px;
      margin-top: 12px;
      background-color: #070b1d;
      color: #ffffff;
      font-family: 'Gowun Batang', serif;
      font-size: 18px;
      font-weight: 700;
      cursor: pointer;
    }

    .version {
      margin-top: 34px;
      font-family: 'Pretendard', sans-serif;
      font-size: 12px;
      font-weight: 800;
      color: rgba(33, 54, 56, 0.34);
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
    <main class="setting-page">

      <h1 class="title"><%= pageTitle %></h1>
      <p class="desc"><%= pageDesc %></p>

      <form class="setting-box" action="ProfileSetService" method="post">
        <input type="hidden" name="mode" value="<%= mode == null ? "first" : mode %>">

      <div class="setting-card">
  <label for="kGrade">대한검도 현재 난이도</label>
  <select id="kGrade" name="kGrade" required>
    <option value="">대한검도 급수를 선택하세요</option>
    <option value="10" <%= kGrade == 10 ? "selected" : "" %>>10급</option>
    <option value="9" <%= kGrade == 9 ? "selected" : "" %>>9급</option>
    <option value="8" <%= kGrade == 8 ? "selected" : "" %>>8급</option>
    <option value="7" <%= kGrade == 7 ? "selected" : "" %>>7급</option>
    <option value="6" <%= kGrade == 6 ? "selected" : "" %>>6급</option>
    <option value="5" <%= kGrade == 5 ? "selected" : "" %>>5급</option>
    <option value="4" <%= kGrade == 4 ? "selected" : "" %>>4급</option>
    <option value="3" <%= kGrade == 3 ? "selected" : "" %>>3급</option>
    <option value="2" <%= kGrade == 2 ? "selected" : "" %>>2급</option>
    <option value="1" <%= kGrade == 1 ? "selected" : "" %>>1급</option>
  </select>
</div>

        <div class="setting-card">
          <label for="lGrade">리히테나워 현재 난이도</label>
          <select id="lGrade" name="lGrade" required>
            <option value="">리히테나워 난이도를 선택하세요</option>
            <option value="1" <%= lGrade == 1 ? "selected" : "" %>>초급</option>
            <option value="2" <%= lGrade == 2 ? "selected" : "" %>>중급</option>
            <option value="3" <%= lGrade == 3 ? "selected" : "" %>>고급</option>
          </select>
        </div>

        <button type="submit" class="save-btn"><%= buttonText %></button>
      </form>

      <div class="version">v1.0.0</div>

    </main>
  </div>
</body>
</html>