<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%@ page import="com.kendo.model.UserDAO" %>
<%@ page import="java.util.Map" %>

<%
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

    if (loginUser == null) {
        response.sendRedirect("login.jsp?login=required");
        return;
    }

    UserDAO dao = new UserDAO();

    Map<String, Object> myPageStats =
        dao.selectMyPageStats(loginUser.getmNum());

    int completeCount = 0;
    int avgAccuracy = 0;

    if (myPageStats != null) {
        Object completeObj = myPageStats.get("completeCount");
        Object avgObj = myPageStats.get("avgAccuracy");

        if (completeObj == null) {
            completeObj = myPageStats.get("COMPLETECOUNT");
        }

        if (avgObj == null) {
            avgObj = myPageStats.get("AVGACCURACY");
        }

        if (completeObj != null) {
            completeCount = Integer.parseInt(String.valueOf(completeObj));
        }

        if (avgObj != null) {
            avgAccuracy = (int) Math.round(
                Double.parseDouble(String.valueOf(avgObj))
            );
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>방구석 검도 - 마이페이지</title>

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

    .mypage {
      height: 100%;
      padding: 28px 22px 116px;
      overflow-y: auto;
      scrollbar-width: none;
      -ms-overflow-style: none;
    }

    .mypage::-webkit-scrollbar {
      display: none;
    }

    .profile-panel {
      min-height: 184px;
      border-radius: 8px;
      border: 1px solid rgba(246, 251, 248, 0.32);
      background:
        linear-gradient(90deg, rgba(12, 22, 26, 0.96) 0%, rgba(24, 43, 45, 0.82) 52%, rgba(24, 43, 45, 0.24) 100%),
        url("../Project_Logo/logo_02.png") center center/cover;
      background-color: #182b2d;
      overflow: hidden;
      position: relative;
      padding: 22px 20px;
      color: #f6fbf8;
      display: flex;
      align-items: center;
      margin-bottom: 22px;
      box-shadow: 0 24px 44px rgba(34, 58, 60, 0.24);
      animation: profileSceneIn 560ms ease-out both;
    }

    .profile-panel::before {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(90deg, transparent calc(100% - 28px), rgba(24, 43, 45, 0.46) 100%);
      pointer-events: none;
    }

    .profile-setting-btn {
      position: absolute;
      top: 16px;
      right: 16px;
      z-index: 2;
      width: 38px;
      height: 38px;
      border: 1px solid rgba(246, 251, 248, 0.28);
      border-radius: 12px;
      background-color: rgba(246, 251, 248, 0.12);
      color: #f6fbf8;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      backdrop-filter: blur(8px);
      transition: 0.18s;
    }

    .profile-setting-btn:hover {
      background-color: rgba(246, 251, 248, 0.20);
      transform: translateY(-1px);
    }

    .profile-setting-btn svg {
      width: 21px;
      height: 21px;
      stroke: currentColor;
      stroke-width: 2;
      fill: none;
    }

    .profile-panel::after {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(180deg, transparent 0%, rgba(7, 11, 29, 0.40) 100%);
      pointer-events: none;
    }

    .profile-content {
      position: relative;
      z-index: 1;
      width: 100%;
      display: grid;
      grid-template-columns: 78px 1fr;
      gap: 16px;
      align-items: center;
      padding-right: 38px;
    }

    .profile-avatar {
      width: 78px;
      height: 78px;
      border-radius: 50%;
      background: rgba(7, 11, 29, 0.88);
      border: 2px solid rgba(216, 232, 127, 0.74);
      display: flex;
      align-items: center;
      justify-content: center;
      color: #f6fbf8;
      box-shadow: 0 0 0 8px rgba(246, 251, 248, 0.08), 0 18px 30px rgba(6, 14, 18, 0.34);
      animation: profileAvatarFloat 4.2s ease-in-out infinite;
    }

    .profile-avatar svg {
      width: 38px;
      height: 38px;
      stroke: currentColor;
      stroke-width: 1.9;
      fill: none;
    }

    .profile-title {
      display: inline-flex;
      min-height: 22px;
      align-items: center;
      padding: 0 9px;
      border-radius: 999px;
      background-color: rgba(216, 232, 127, 0.16);
      border: 1px solid rgba(216, 232, 127, 0.30);
      color: #d8e87f;
      font-family: 'Pretendard', sans-serif;
      font-size: 10px;
      font-weight: 800;
      margin-bottom: 8px;
      backdrop-filter: blur(8px);
    }

    .profile-name {
      font-size: 25px;
      line-height: 1.15;
      margin-bottom: 8px;
      color: #f6fbf8;
      text-shadow: 0 3px 18px rgba(7, 11, 29, 0.44);
    }

    .profile-meta {
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 700;
      line-height: 1.5;
      color: rgba(246, 251, 248, 0.78);
      word-break: keep-all;
    }

    @keyframes profileSceneIn {
      from {
        opacity: 0;
        transform: translateY(10px);
      }

      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    @keyframes profileAvatarFloat {
      0%,
      100% {
        transform: translateY(0);
      }

      50% {
        transform: translateY(-4px);
      }
    }

    .storage-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 12px;
      margin-bottom: 22px;
    }

    .stat-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 8px;
      margin-bottom: 22px;
    }

    .stat-item {
      min-height: 112px;
      border-radius: 8px;
      border: 1px solid rgba(255, 255, 255, 0.76);
      background-color: rgba(255, 255, 255, 0.54);
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.10);
      padding: 16px 14px;
      text-align: center;
      font-family: 'Pretendard', sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }

    .storage-grid .stat-item {
      min-height: 108px;
      gap: 7px;
      padding: 15px 12px;
    }

    .storage-grid .point-storage-card {
      background-color: rgba(238, 247, 242, 0.58);
      border-color: rgba(255, 255, 255, 0.82);
    }

    .storage-grid .item-storage-card {
      background-color: rgba(221, 236, 232, 0.66);
      border-color: rgba(255, 255, 255, 0.76);
    }

    .storage-action {
      cursor: pointer;
      transition: 0.18s;
    }

    .storage-action:hover {
      transform: translateY(-2px);
      background-color: rgba(255, 255, 255, 0.72);
    }

    .storage-grid .item-storage-card:hover {
      background-color: rgba(230, 242, 238, 0.76);
    }

    .stat-grid .complete-stat-card {
      background-color: rgba(238, 247, 242, 0.54);
      border-color: rgba(255, 255, 255, 0.78);
    }

    .stat-grid .accuracy-stat-card {
      background-color: rgba(221, 236, 232, 0.62);
      border-color: rgba(255, 255, 255, 0.74);
    }

    .complete-stat-card .stat-icon {
      background-color: rgba(68, 103, 107, 0.12);
      color: #213638;
    }

    .accuracy-stat-card .stat-icon {
      background-color: rgba(68, 103, 107, 0.12);
      color: #44676b;
    }

    .storage-grid .stat-icon {
      width: 42px;
      height: 42px;
      border-radius: 50%;
      margin-bottom: 0;
      background-color: rgba(33, 54, 56, 0.08);
      color: #213638;
      overflow: hidden;
    }

    .storage-grid .stat-value {
      font-size: 24px;
    }

    .stat-icon {
      width: 34px;
      height: 34px;
      border-radius: 12px;
      background-color: rgba(68, 103, 107, 0.13);
      color: #44676b;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 12px;
    }

    .stat-icon svg {
      width: 21px;
      height: 21px;
      stroke: currentColor;
      stroke-width: 2;
      fill: none;
    }

    .stat-icon img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
    }

    .stat-value {
      display: block;
      font-size: 22px;
      font-weight: 800;
      color: #213638;
      line-height: 1.1;
    }

    .stat-label {
      display: block;
      margin-top: 8px;
      font-size: 10px;
      font-weight: 800;
      color: rgba(33, 54, 56, 0.58);
      word-break: keep-all;
    }

    .storage-grid .stat-label {
      margin-top: 0;
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
      margin-bottom: 22px;
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

    .setup-link-btn {
      min-width: 122px;
      height: 36px;
      border: none;
      border-radius: 8px;
      padding: 0 12px;
      background-color: #213638;
      color: #f6fbf8;
      font-family: 'Pretendard', sans-serif;
      font-size: 11px;
      font-weight: 800;
      cursor: pointer;
      white-space: nowrap;
      flex-shrink: 0;
    }

    .logout-btn {
      width: 100%;
      height: 50px;
      border: none;
      border-radius: 8px;
      background-color: rgb(7, 11, 29);
      color: #f6fbf8;
      font-family: 'Pretendard', sans-serif;
      font-size: 13px;
      font-weight: 800;
      cursor: pointer;
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.12);
      margin-top: 2px;
    }

    .section-title {
      font-family: 'Pretendard', sans-serif;
      font-size: 16px;
      line-height: 1.25;
      font-weight: 800;
      color: #213638;
      margin: 24px 0 12px;
      display: flex;
      align-items: center;
      gap: 8px;
      letter-spacing: 0;
    }

    .profile-panel + section .section-title {
      margin-top: 0;
    }

    .item-modal-overlay {
      position: absolute;
      inset: 0;
      z-index: 210;
      display: none;
      align-items: center;
      justify-content: center;
      padding: 24px;
      background-color: rgba(7, 11, 29, 0.42);
      backdrop-filter: blur(8px);
    }

    .item-modal-overlay.active {
      display: flex;
    }

    .item-modal {
      width: min(100%, 330px);
      max-height: 72vh;
      border-radius: 14px;
      border: 1px solid rgba(255, 255, 255, 0.82);
      background-color: rgba(246, 251, 248, 0.94);
      box-shadow: 0 24px 54px rgba(7, 11, 29, 0.26);
      padding: 18px;
      font-family: 'Pretendard', sans-serif;
      color: #213638;
      overflow: hidden;
    }

    .item-modal-head {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
      margin-bottom: 14px;
    }

    .item-modal-title {
      font-size: 17px;
      line-height: 1.25;
      font-weight: 800;
      margin: 0;
    }

    .item-modal-close {
      width: 34px;
      height: 34px;
      border: none;
      border-radius: 12px;
      background-color: rgba(33, 54, 56, 0.10);
      color: #213638;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      flex-shrink: 0;
    }

    .item-modal-close svg {
      width: 18px;
      height: 18px;
      stroke: currentColor;
      stroke-width: 2.2;
      fill: none;
    }

    .owned-item-list {
      max-height: 54vh;
      overflow-y: auto;
      display: grid;
      gap: 8px;
      scrollbar-width: none;
      -ms-overflow-style: none;
    }

    .owned-item-list::-webkit-scrollbar {
      display: none;
    }

    .owned-item {
      min-height: 62px;
      border-radius: 12px;
      border: 1px solid rgba(33, 54, 56, 0.10);
      background-color: rgba(255, 255, 255, 0.64);
      padding: 11px 12px;
    }

    .owned-kind {
      display: inline-flex;
      height: 18px;
      align-items: center;
      padding: 0 7px;
      border-radius: 999px;
      font-size: 9px;
      font-weight: 800;
      margin-bottom: 5px;
    }

    .owned-kind.title {
      background-color: rgba(216, 232, 127, 0.30);
      color: #60752d;
    }

    .owned-kind.profile {
      background-color: rgba(31, 41, 51, 0.14);
      color: #1f2933;
    }

    .owned-name {
      display: block;
      font-size: 13px;
      font-weight: 800;
      line-height: 1.3;
    }

    .owned-empty {
      min-height: 92px;
      border-radius: 12px;
      border: 1px dashed rgba(33, 54, 56, 0.18);
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      padding: 16px;
      color: rgba(33, 54, 56, 0.58);
      font-size: 12px;
      font-weight: 800;
      line-height: 1.45;
    }

    .mobile-frame.dark-mode .stat-item {
      background-color: rgba(255, 255, 255, 0.10);
      border-color: rgba(255, 255, 255, 0.16);
    }

    .mobile-frame.dark-mode .storage-grid .point-storage-card {
      background-color: rgba(238, 247, 242, 0.12);
      border-color: rgba(238, 247, 242, 0.22);
    }

    .mobile-frame.dark-mode .storage-grid .item-storage-card {
      background-color: rgba(238, 247, 242, 0.10);
      border-color: rgba(238, 247, 242, 0.18);
    }

    .mobile-frame.dark-mode .stat-grid .complete-stat-card {
      background-color: rgba(238, 247, 242, 0.12);
      border-color: rgba(238, 247, 242, 0.22);
    }

    .mobile-frame.dark-mode .stat-grid .accuracy-stat-card {
      background-color: rgba(238, 247, 242, 0.10);
      border-color: rgba(238, 247, 242, 0.18);
    }

    .mobile-frame.dark-mode .complete-stat-card .stat-icon {
      background-color: rgba(238, 247, 242, 0.16);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .accuracy-stat-card .stat-icon {
      background-color: rgba(238, 247, 242, 0.14);
      color: rgba(238, 247, 242, 0.86);
    }

    .mobile-frame.dark-mode .storage-action:hover {
      background-color: rgba(255, 255, 255, 0.16);
    }

    .mobile-frame.dark-mode .profile-panel {
      border-color: rgba(246, 251, 248, 0.22);
      background:
        linear-gradient(90deg, rgba(7, 11, 29, 0.96) 0%, rgba(24, 43, 45, 0.82) 52%, rgba(24, 43, 45, 0.24) 100%),
        url("../Project_Logo/logo_02.png") center center/cover;
      background-color: #182b2d;
      color: #eef7f2;
      box-shadow: 0 24px 44px rgba(0, 0, 0, 0.24);
    }

    .mobile-frame.dark-mode .profile-setting-btn {
      border-color: rgba(238, 247, 242, 0.20);
      background-color: rgba(238, 247, 242, 0.12);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .profile-avatar {
      background: rgba(7, 11, 29, 0.88);
      border-color: rgba(216, 232, 127, 0.74);
      color: #f6fbf8;
    }

    .mobile-frame.dark-mode .profile-title {
      background-color: rgba(216, 232, 127, 0.16);
      border-color: rgba(216, 232, 127, 0.30);
      color: #d8e87f;
    }

    .mobile-frame.dark-mode .profile-name {
      color: #f6fbf8;
      text-shadow: 0 3px 18px rgba(7, 11, 29, 0.44);
    }

    .mobile-frame.dark-mode .profile-meta {
      color: rgba(246, 251, 248, 0.78);
    }

    .mobile-frame.dark-mode .section-title,
    .mobile-frame.dark-mode .stat-value,
    .mobile-frame.dark-mode .setting-name {
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .stat-label,
    .mobile-frame.dark-mode .setting-desc {
      color: rgba(238, 247, 242, 0.62);
    }

    .mobile-frame.dark-mode .setting-card {
      background-color: rgba(255, 255, 255, 0.10);
      border-color: rgba(255, 255, 255, 0.16);
    }

    .mobile-frame.dark-mode .select-control {
      background-color: rgba(255, 255, 255, 0.14);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .setup-link-btn {
      background-color: #d8e87f;
      color: #213638;
    }

    .mobile-frame.dark-mode .item-modal {
      border-color: rgba(238, 247, 242, 0.18);
      background-color: rgba(24, 37, 39, 0.96);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .item-modal-close {
      background-color: rgba(238, 247, 242, 0.14);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .owned-item {
      border-color: rgba(238, 247, 242, 0.14);
      background-color: rgba(255, 255, 255, 0.10);
    }

    .mobile-frame.dark-mode .owned-kind.title {
      background-color: rgba(216, 232, 127, 0.22);
      color: #d8e87f;
    }

    .mobile-frame.dark-mode .owned-kind.profile {
      background-color: rgba(238, 247, 242, 0.16);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .owned-empty {
      border-color: rgba(238, 247, 242, 0.18);
      color: rgba(238, 247, 242, 0.62);
    }

    @media (prefers-reduced-motion: reduce) {
      .profile-panel,
      .profile-avatar {
        animation: none;
      }
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
      .mypage {
        padding: 24px 18px 108px;
      }

      .profile-content {
        grid-template-columns: 64px 1fr;
        gap: 14px;
        padding-right: 28px;
      }

      .profile-avatar {
        width: 64px;
        height: 64px;
        border-radius: 20px;
      }

      .profile-name {
        font-size: 23px;
      }

      .select-control {
        width: 112px;
      }

      .setup-link-btn {
        min-width: 112px;
        padding: 0 10px;
        font-size: 10px;
      }

      .stat-grid {
        gap: 7px;
      }

      .stat-item {
        min-height: 102px;
        padding: 13px 10px;
      }

      .stat-value {
        font-size: 20px;
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
    <main class="mypage">
      <section class="profile-panel" aria-label="회원 프로필">
        <button type="button" class="profile-setting-btn" onclick="location.href='settings.jsp'" aria-label="환경설정으로 이동">
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <circle cx="12" cy="12" r="3"></circle>
            <path d="M19.4 15A1.7 1.7 0 0 0 20 13.7V10.3A1.7 1.7 0 0 0 19.4 9L17.8 7.7L17.2 5.7A1.7 1.7 0 0 0 15.6 4.5H8.4A1.7 1.7 0 0 0 6.8 5.7L6.2 7.7L4.6 9A1.7 1.7 0 0 0 4 10.3V13.7A1.7 1.7 0 0 0 4.6 15L6.2 16.3L6.8 18.3A1.7 1.7 0 0 0 8.4 19.5H15.6A1.7 1.7 0 0 0 17.2 18.3L17.8 16.3L19.4 15Z"></path>
          </svg>
        </button>
        <div class="profile-content">
          <div class="profile-avatar" id="profileAvatar"></div>
          <div>
            <span class="profile-title" id="equippedTitle"></span>
            <h1 class="profile-name" id="memberName">수련생</h1>
            <p class="profile-meta">오늘도 자세를 세우는 중입니다.</p>
          </div>
        </div>
      </section>

      <section aria-label="수련 설정">
        <h2 class="section-title">수련 설정</h2>
        <article class="setting-card">
          <div class="setting-left">
            <span class="setting-icon">
              <svg viewBox="0 0 24 24" aria-hidden="true">
                <path d="M4 20L20 4"></path>
                <path d="M14 4L20 10"></path>
                <path d="M4 14L10 20"></path>
              </svg>
            </span>
            <div class="setting-info">
              <h3 class="setting-name">수련 난이도 재설정</h3>
              <p class="setting-desc">수련 설정 화면에서 종목과 난이도를 다시 선택합니다.</p>
            </div>
          </div>
          <button type="button" class="setup-link-btn" onclick="goTrainingSetup()">재설정</button>
        </article>
      </section>

      <section aria-label="회원 요약">
        <h2 class="section-title">내 보관함</h2>
        <div class="storage-grid">
          <div class="stat-item point-storage-card">
            <span class="stat-icon">
              <img src="Project_Logo/point_icon.png" alt="보유 포인트 아이콘">
            </span>
            <span class="stat-value" id="memberPoint">0P</span>
            <span class="stat-label">보유 포인트</span>
          </div>
          <button type="button" class="stat-item storage-action item-storage-card" onclick="openOwnedItemModal()" aria-label="나의 아이템 목록 보기">
            <span class="stat-icon">
              <img src="Project_Logo/item_icon.png" alt="나의 아이템 아이콘">
            </span>
            <span class="stat-value" id="ownedTitleCount">0</span>
            <span class="stat-label">나의 아이템</span>
          </button>
        </div>
      </section>

       <section aria-label="통계">
        <h2 class="section-title">통계</h2>
        <div class="stat-grid">
          <div class="stat-item complete-stat-card">
            <span class="stat-icon">
             <img src="Project_Logo/mypage_icon02.png" alt="완료 스테이지 아이콘">
            </span>
            <span class="stat-value" id="completedStageCount">0개</span>
            <span class="stat-label">완료 스테이지</span>
          </div>
          <div class="stat-item accuracy-stat-card">
            <span class="stat-icon">
             <img src="Project_Logo/mypage_icon01.png" alt="평균 정확도 아이콘">
            </span>
            <span class="stat-value" id="averageAccuracy">-</span>
            <span class="stat-label">평균 정확도</span>
          </div>
        </div>
      </section>

<button
type="button"
class="logout-btn"
onclick="location.href='LogoutService'">
로그아웃
</button>    </main>

    <div class="item-modal-overlay" id="ownedItemModal" onclick="closeOwnedItemModal(event)">
      <section class="item-modal" role="dialog" aria-modal="true" aria-labelledby="ownedItemModalTitle">
        <div class="item-modal-head">
          <h2 class="item-modal-title" id="ownedItemModalTitle">나의 아이템</h2>
          <button type="button" class="item-modal-close" onclick="closeOwnedItemModal()" aria-label="아이템 목록 닫기">
            <svg viewBox="0 0 24 24" aria-hidden="true">
              <path d="M6 6L18 18"></path>
              <path d="M18 6L6 18"></path>
            </svg>
          </button>
        </div>
        <div class="owned-item-list" id="ownedItemList"></div>
      </section>
    </div>

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
  회원마다 데이터가 다르기 때문에 세션에서 가져온다.
  */
  const M_NUM = <%= loginUser.getmNum() %>;
    const POINT_STORAGE_KEY = `BGS_MEMBER_POINT_${M_NUM}`;
    const ITEM_STORAGE_KEY = `BGS_MEMBER_ITEMS_${M_NUM}`;

    if (localStorage.getItem(POINT_STORAGE_KEY) === null) {
      localStorage.setItem(POINT_STORAGE_KEY, "<%= loginUser.getPoint() %>");
    }
    const PROFILE_SETTING_KEY = `BGS_PROFILE_SETTING_${M_NUM}`;
    const APP_SETTING_KEY = `BGS_APP_SETTING_${M_NUM}`;
    const TRAIN_HISTORY_KEY = `BGS_TRAIN_HISTORY_${M_NUM}`;

    const DB_COMPLETE_COUNT = <%= completeCount %>;
    const DB_AVG_ACCURACY = <%= avgAccuracy %>;
    
    const ITEM_LIST = [
      { ITEM_NUM: 1, ITEM_TYPE: "TITLE", ITEM_ICON: "rookie", ITEM_NAME: "견습 기사" },
      { ITEM_NUM: 2, ITEM_TYPE: "TITLE", ITEM_ICON: "sword", ITEM_NAME: "초심의 검" },
      { ITEM_NUM: 3, ITEM_TYPE: "TITLE", ITEM_ICON: "stance", ITEM_NAME: "고요한 중단" },
      { ITEM_NUM: 4, ITEM_TYPE: "TITLE", ITEM_ICON: "flame", ITEM_NAME: "한 판 더" },
      { ITEM_NUM: 5, ITEM_TYPE: "PROFILE", ITEM_ICON: "armor", ITEM_NAME: "청록 호구" },
      { ITEM_NUM: 6, ITEM_TYPE: "PROFILE", ITEM_ICON: "shadow", ITEM_NAME: "목검 그림자" }
    ];

    const DEFAULT_PROFILE_SETTING = {
      TITLE_ITEM_NUM: 0,
      PROFILE_ITEM_NUM: 0
    };

    const DEFAULT_APP_SETTING = {
      DARK_MODE: false,
      TRAIN_NOTICE: false,
      TRAIN_DIVISION: "1",
      DIFFICULTY: "k2",
      KENDO_DIFFICULTY: "k2",
      LIECHTENAUER_DIFFICULTY: "l_middle"
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

    function getMemberPoint() {
      return Number(localStorage.getItem(POINT_STORAGE_KEY)) || 0;
    }

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

    function getAvatarIcon(iconName) {
      if (iconName === "armor") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M7 5H17L19 9V17C19 19.2 16 21 12 21C8 21 5 19.2 5 17V9L7 5Z"></path>
            <path d="M8 10H16"></path>
            <path d="M9 14H15"></path>
            <path d="M12 5V21"></path>
          </svg>
        `;
      }

      if (iconName === "shadow") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M5 19L19 5"></path>
            <path d="M15 5H19V9"></path>
            <path d="M4 21H13"></path>
            <path d="M8 17L11 20"></path>
          </svg>
        `;
      }

      return `
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <circle cx="12" cy="8" r="4"></circle>
          <path d="M5 21C5 17 8 14 12 14C16 14 19 17 19 21"></path>
        </svg>
      `;
    }

    function getOwnedItems() {
      const memberItems = getMemberItems();
      return ITEM_LIST.filter((item) => memberItems.includes(item.ITEM_NUM));
    }

    function getItemKindText(itemType) {
      return itemType === "PROFILE" ? "프로필" : "칭호";
    }

    function getSavedDifficulty(appSetting, division) {
      if (division === "2") {
        return appSetting.LIECHTENAUER_DIFFICULTY || (appSetting.TRAIN_DIVISION === "2" ? appSetting.DIFFICULTY : DEFAULT_APP_SETTING.LIECHTENAUER_DIFFICULTY);
      }

      return appSetting.KENDO_DIFFICULTY || (appSetting.TRAIN_DIVISION === "1" ? appSetting.DIFFICULTY : DEFAULT_APP_SETTING.KENDO_DIFFICULTY);
    }

    function getDifficultyLabel(division, value) {
      const difficultyOptions = DIFFICULTY_OPTIONS[division] || DIFFICULTY_OPTIONS["1"];
      const difficultyItem = difficultyOptions.find((item) => item.value === value) || difficultyOptions[0];
      return difficultyItem.label;
    }

    function getTrainingLevelText(appSetting) {
      const kendoDifficulty = getSavedDifficulty(appSetting, "1");
      const liechtenauerDifficulty = getSavedDifficulty(appSetting, "2");

      return `대한검도 | ${getDifficultyLabel("1", kendoDifficulty)} · 리히테나워 | ${getDifficultyLabel("2", liechtenauerDifficulty)}`;
    }

    function renderOwnedItemList() {
      const ownedItemList = document.getElementById("ownedItemList");
      const ownedItems = getOwnedItems();

      if (!ownedItems.length) {
        ownedItemList.innerHTML = `
          <div class="owned-empty">
            아직 보유한 아이템이 없습니다.<br>
            상점에서 아이템을 구매해보세요.
          </div>
        `;
        return;
      }

      ownedItemList.innerHTML = ownedItems.map((item) => {
        const typeClass = item.ITEM_TYPE === "PROFILE" ? "profile" : "title";
        return `
          <article class="owned-item">
            <span class="owned-kind ${typeClass}">${getItemKindText(item.ITEM_TYPE)}</span>
            <span class="owned-name">${item.ITEM_NAME}</span>
          </article>
        `;
      }).join("");
    }

    function openOwnedItemModal() {
      renderOwnedItemList();
      document.getElementById("ownedItemModal").classList.add("active");
    }

    function closeOwnedItemModal(event) {
      if (event && event.target !== event.currentTarget) {
        return;
      }

      document.getElementById("ownedItemModal").classList.remove("active");
    }

    function goTrainingSetup() {
    	location.href = "login.jsp?setup=training";   }

    function renderProfile() {
      const profileSetting = loadJson(PROFILE_SETTING_KEY, DEFAULT_PROFILE_SETTING);
      const appSetting = loadJson(APP_SETTING_KEY, DEFAULT_APP_SETTING);
      const memberItems = getMemberItems();
      const titleItem = ITEM_LIST.find((item) => {
        return item.ITEM_TYPE === "TITLE"
          && item.ITEM_NUM === Number(profileSetting.TITLE_ITEM_NUM)
          && memberItems.includes(item.ITEM_NUM);
      });

      if (Number(profileSetting.TITLE_ITEM_NUM) !== 0 && !titleItem) {
        saveJson(PROFILE_SETTING_KEY, {
          ...profileSetting,
          TITLE_ITEM_NUM: 0
        });
      }

      const profileItem = ITEM_LIST.find((item) => item.ITEM_NUM === Number(profileSetting.PROFILE_ITEM_NUM));

      const equippedTitle = document.getElementById("equippedTitle");
      equippedTitle.innerText = titleItem ? titleItem.ITEM_NAME : "";
      equippedTitle.style.display = titleItem ? "inline-flex" : "none";
      /*
      회원가입 시 입력한 이름을 표시한다.
      */
      document.getElementById("memberName").innerText =
      "<%= loginUser.getName() %>";
      /*
      DB에 저장된 대한검도/리히테나워 난이도를 표시한다.
      */
      document.querySelector(".profile-meta").innerText =
      "대한검도 <%= loginUser.getkGrade() %>급 / 리히테나워 <%
      if(loginUser.getlGrade()==1){
          out.print("초급");
      }else if(loginUser.getlGrade()==2){
          out.print("중급");
      }else if(loginUser.getlGrade()==3){
          out.print("고급");
      }else{
          out.print("-");
      }
      %>";
      document.getElementById("profileAvatar").innerHTML = getAvatarIcon(profileItem ? profileItem.ITEM_ICON : "default");
    }

    function renderStats() {
    	  document.getElementById("memberPoint").innerText = `${getMemberPoint()}P`;
    	  document.getElementById("ownedTitleCount").innerText = getOwnedItems().length;

    	  document.getElementById("completedStageCount").innerText =
    	    `${DB_COMPLETE_COUNT}개`;

    	  document.getElementById("averageAccuracy").innerText =
    	    DB_COMPLETE_COUNT > 0 ? `${DB_AVG_ACCURACY}%` : "-";
    	}
    function applyAppSettings() {
      const appSetting = loadJson(APP_SETTING_KEY, DEFAULT_APP_SETTING);
      const mobileFrame = document.getElementById("mobileFrame");
      mobileFrame.classList.toggle("dark-mode", Boolean(appSetting.DARK_MODE));
    }

    applyAppSettings();
    renderProfile();
    renderStats();
  </script>
</body>
</html>