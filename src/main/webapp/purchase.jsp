<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%@ page import="com.kendo.model.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

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

    private Object mv(Map<String, Object> map, String key) {
        Object value = map.get(key);

        if (value == null) {
            value = map.get(key.toUpperCase());
        }

        return value;
    }
%>

<%
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO dao = new UserDAO();
    List<Map<String, Object>> goodsList = dao.pointShopList();
    if (goodsList == null) {
        goodsList = new java.util.ArrayList<Map<String, Object>>();
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>방구석 검도 - 상점</title>

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

    .purchase-page {
      height: 100%;
      padding: 28px 22px 116px;
      overflow-y: auto;
      scrollbar-width: none;
      -ms-overflow-style: none;
    }

    .purchase-page::-webkit-scrollbar {
      display: none;
    }

    .point-panel {
      min-height: 132px;
      border-radius: 8px;
      background:
        linear-gradient(135deg, rgba(23, 35, 42, 0.90), rgba(61, 91, 88, 0.76)),
       url("Project_Logo/logo_02.png")center/cover;
      overflow: hidden;
      position: relative;
      padding: 20px;
      color: #f6fbf8;
      display: flex;
      flex-direction: column;
      justify-content: center;
      margin-bottom: 22px;
      box-shadow: 0 22px 42px rgba(34, 58, 60, 0.20);
    }

    .point-panel::after {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(90deg, rgba(10, 18, 24, 0.84), rgba(10, 18, 24, 0.14));
    }

    .point-content {
      position: relative;
      z-index: 1;
      width: 100%;
    }

    .point-head {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
    }

    .point-label {
      font-size: 27px;
      line-height: 1.18;
      font-weight: 700;
      color: #f6fbf8;
      margin: 0;
      letter-spacing: 0;
      text-align: left;
    }

    .point-value {
      min-width: 94px;
      min-height: 50px;
      border-radius: 8px;
      background-color: rgba(246, 251, 248, 0.18);
      border: 1px solid rgba(246, 251, 248, 0.26);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 0 10px;
      font-family: 'Pretendard', sans-serif;
      font-weight: 800;
      line-height: 1;
      letter-spacing: 0;
      flex-shrink: 0;
    }

    .point-caption {
      display: block;
      margin-bottom: 6px;
      font-size: 9px;
      font-weight: 800;
      color: rgba(246, 251, 248, 0.66);
      line-height: 1;
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

    .section-title {
      font-family: 'Pretendard', sans-serif;
      font-size: 17px;
      line-height: 1.25;
      font-weight: 800;
      color: #213638;
      margin: 22px 0 10px;
    }

    .item-list {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .item-card {
      min-height: 88px;
      border: 1px solid rgba(255, 255, 255, 0.76);
      border-radius: 8px;
      background-color: rgba(255, 255, 255, 0.56);
      box-shadow: 0 12px 24px rgba(40, 70, 72, 0.10);
      padding: 13px;
      display: grid;
      grid-template-columns: 44px 1fr auto;
      gap: 12px;
      align-items: center;
      font-family: 'Pretendard', sans-serif;
    }

    .item-icon {
      width: 44px;
      height: 44px;
      border-radius: 50%;
      border: 1px solid var(--item-icon-border, rgba(255, 255, 255, 0.72));
      background-color: var(--item-icon-bg, rgba(246, 251, 248, 0.78));
      color: var(--item-icon-color, #44676b);
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.74),
        0 8px 16px rgba(33, 54, 56, 0.08);
    }

    .item-card.title-item .item-icon {
      background-color: var(--item-icon-bg, rgba(246, 251, 248, 0.78));
      color: var(--item-icon-color, #44676b);
    }

    .item-card.profile-item .item-icon {
      background-color: var(--item-icon-bg, rgba(246, 251, 248, 0.78));
      color: var(--item-icon-color, #44676b);
    }

    .item-icon.rookie {
      --item-icon-bg: rgba(216, 232, 127, 0.30);
      --item-icon-border: rgba(216, 232, 127, 0.56);
      --item-icon-color: #60752d;
    }

    .item-icon.sword {
      --item-icon-bg: rgba(159, 218, 210, 0.26);
      --item-icon-border: rgba(159, 218, 210, 0.54);
      --item-icon-color: #397d73;
    }

    .item-icon.stance {
      --item-icon-bg: rgba(240, 198, 94, 0.24);
      --item-icon-border: rgba(240, 198, 94, 0.50);
      --item-icon-color: #9a7420;
    }

    .item-icon.flame {
      --item-icon-bg: rgba(255, 143, 125, 0.22);
      --item-icon-border: rgba(255, 143, 125, 0.48);
      --item-icon-color: #b85c4e;
    }

    .item-icon.armor {
      --item-icon-bg: rgba(88, 197, 215, 0.22);
      --item-icon-border: rgba(88, 197, 215, 0.46);
      --item-icon-color: #3d8d9c;
    }

    .item-icon.shadow {
      --item-icon-bg: rgba(143, 122, 245, 0.18);
      --item-icon-border: rgba(143, 122, 245, 0.40);
      --item-icon-color: #6a57d0;
    }

    .item-icon svg {
      width: 25px;
      height: 25px;
      stroke: currentColor;
      stroke-width: 1.8;
      fill: none;
      stroke-linecap: round;
      stroke-linejoin: round;
    }

    .item-kind {
      display: inline-flex;
      width: 42px;
      height: 18px;
      align-items: center;
      justify-content: center;
      padding: 0;
      border-radius: 999px;
      background-color: rgba(68, 103, 107, 0.12);
      color: rgba(33, 54, 56, 0.62);
      font-size: 9px;
      font-weight: 800;
      flex-shrink: 0;
    }

    .item-title-row {
      display: flex;
      align-items: center;
      gap: 7px;
      margin-bottom: 4px;
      flex-wrap: wrap;
    }

    .item-card.title-item .item-kind {
      background-color: rgba(216, 232, 127, 0.28);
      color: #60752d;
    }

    .item-card.profile-item .item-kind {
      background-color: rgba(31, 41, 51, 0.14);
      color: #1f2933;
    }

    .item-name {
      font-size: 14px;
      font-weight: 800;
      color: #213638;
      line-height: 1.35;
      margin: 0;
    }

    .item-desc {
      font-size: 10px;
      font-weight: 700;
      color: rgba(33, 54, 56, 0.56);
      line-height: 1.4;
      word-break: keep-all;
    }

    .buy-btn {
      min-width: 66px;
      height: 36px;
      border: none;
      border-radius: 8px;
      background-color: #213638;
      color: #f6fbf8;
      font-size: 11px;
      font-weight: 800;
      cursor: pointer;
      white-space: nowrap;
    }

    .buy-price {
      display: block;
      font-size: 10px;
      color: rgba(246, 251, 248, 0.68);
      line-height: 1;
      margin-top: 2px;
    }

    .buy-btn:disabled {
      cursor: default;
      background-color: rgba(33, 54, 56, 0.13);
      color: rgba(33, 54, 56, 0.42);
    }

    .buy-btn:disabled .buy-price {
      color: rgba(33, 54, 56, 0.36);
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
      .purchase-page {
        padding: 24px 18px 108px;
      }

      .point-value {
        min-width: 88px;
        min-height: 48px;
      }

      .point-label {
        font-size: 25px;
      }

      .item-card {
        grid-template-columns: 44px 1fr auto;
        gap: 10px;
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

    .mobile-frame.dark-mode .item-card {
      background-color: rgba(238, 247, 242, 0.16);
      border-color: rgba(238, 247, 242, 0.34);
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.20);
    }

    .mobile-frame.dark-mode .item-kind {
      background-color: rgba(216, 232, 127, 0.16);
      color: rgba(238, 247, 242, 0.86);
    }

    .mobile-frame.dark-mode .item-card.title-item .item-icon {
      background-color: var(--item-icon-bg, rgba(216, 232, 127, 0.20));
      color: var(--item-icon-color, #d8e87f);
      border-color: var(--item-icon-border, rgba(238, 247, 242, 0.18));
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.14);
    }

    .mobile-frame.dark-mode .item-icon.rookie {
      --item-icon-bg: rgba(216, 232, 127, 0.18);
      --item-icon-border: rgba(216, 232, 127, 0.72);
      --item-icon-color: #d8e87f;
    }

    .mobile-frame.dark-mode .item-icon.sword {
      --item-icon-bg: rgba(159, 218, 210, 0.18);
      --item-icon-border: rgba(159, 218, 210, 0.70);
      --item-icon-color: #9fdad2;
    }

    .mobile-frame.dark-mode .item-icon.stance {
      --item-icon-bg: rgba(240, 198, 94, 0.17);
      --item-icon-border: rgba(240, 198, 94, 0.70);
      --item-icon-color: #f0c65e;
    }

    .mobile-frame.dark-mode .item-icon.flame {
      --item-icon-bg: rgba(255, 143, 125, 0.17);
      --item-icon-border: rgba(255, 143, 125, 0.68);
      --item-icon-color: #ffab9d;
    }

    .mobile-frame.dark-mode .item-icon.armor {
      --item-icon-bg: rgba(88, 197, 215, 0.18);
      --item-icon-border: rgba(88, 197, 215, 0.72);
      --item-icon-color: #8edbed;
    }

    .mobile-frame.dark-mode .item-icon.shadow {
      --item-icon-bg: rgba(143, 122, 245, 0.18);
      --item-icon-border: rgba(143, 122, 245, 0.72);
      --item-icon-color: #bdb2ff;
    }

    .mobile-frame.dark-mode .item-card.title-item .item-kind {
      background-color: rgba(216, 232, 127, 0.22);
      color: #d8e87f;
    }

    .mobile-frame.dark-mode .item-card.profile-item .item-icon {
      background-color: var(--item-icon-bg, rgba(238, 247, 242, 0.16));
      color: var(--item-icon-color, #eef7f2);
      border-color: var(--item-icon-border, rgba(238, 247, 242, 0.18));
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.14);
    }

    .mobile-frame.dark-mode .item-card.profile-item .item-kind {
      background-color: rgba(238, 247, 242, 0.16);
      color: #eef7f2;
    }

    .mobile-frame.dark-mode .item-desc {
      color: rgba(238, 247, 242, 0.78);
    }

    .mobile-frame.dark-mode .buy-btn {
      background-color: #d8e87f;
      color: #213638;
    }

    .mobile-frame.dark-mode .buy-price {
      color: rgba(33, 54, 56, 0.72);
    }

    .mobile-frame.dark-mode .buy-btn:disabled {
      background-color: rgba(238, 247, 242, 0.18);
      color: rgba(238, 247, 242, 0.72);
    }

    .mobile-frame.dark-mode .buy-btn:disabled .buy-price {
      color: rgba(238, 247, 242, 0.60);
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
    <main class="purchase-page">
      <section class="point-panel" aria-label="나의 포인트">
        <div class="point-content">
          <div class="point-head">
            <h1 class="point-label">포인트 마켓</h1>
            <p class="point-value">
              <span class="point-caption">가용 포인트</span>
              <span class="point-amount"><span id="memberPoint">0</span><span class="point-unit">P</span></span>
            </p>
          </div>
        </div>
      </section>

      <section aria-label="상점 아이템">
        <h1 class="section-title">상품목록</h1>
        <div class="item-list" id="itemList"></div>
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

      <a href="purchase.jsp" class="nav-item active">
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
  /*
  현재 로그인한 회원 번호를 JSP 세션에서 가져온다.
  회원마다 포인트와 구매 아이템이 달라야 하므로
  M_NUM을 기준으로 localStorage 데이터를 구분한다.
  */
  const M_NUM = <%= loginUser.getmNum() %>;
  /*
  회원별 포인트 저장 key
  예: 회원번호가 3이면 BGS_MEMBER_POINT_3 으로 저장된다.

  현재는 DB 연동 전이라 localStorage를 사용한다.
  추후 MEMBER.POINT 컬럼과 연결하면 이 부분을 DB 조회 방식으로 변경한다.
  */
    const POINT_STORAGE_KEY = `BGS_MEMBER_POINT_${M_NUM}`;
    /*
    회원별 구매 아이템 저장 key
    예: 회원번호가 3이면 BGS_MEMBER_ITEMS_3 으로 저장된다.

    추후 POINT_SHOP_HIS 또는 구매 이력 테이블과 연결할 예정이다.
    */
    const ITEM_STORAGE_KEY = `BGS_MEMBER_ITEMS_${M_NUM}`;
    /*
    상점 상품 목록이다.

    현재는 DB 연동 전이라 JavaScript 배열로 임시 관리한다.
    나중에는 GOODS 또는 POINT_SHOP_HIS 테이블에서
    상품명, 가격, 설명을 가져오도록 변경할 예정이다.

    ITEM_TYPE
    TITLE = 칭호
    PROFILE = 프로필 장식
    */
    const ITEM_LIST = [
    	<%
    	    for (int i = 0; i < goodsList.size(); i++) {
    	        Map<String, Object> item = goodsList.get(i);

    	        Object goodsNum = mv(item, "goodsNum");
    	        Object goods = mv(item, "goods");
    	        Object goodsText = mv(item, "goodsText");
    	        Object price = mv(item, "price");
    	%>
    	  {
    	    ITEM_NUM: Number("<%= js(goodsNum) %>"),
    	    GOODS_NUM: Number("<%= js(goodsNum) %>"),
    	    ITEM_TYPE: "TITLE",
    	    ITEM_KIND: "상품",
    	    ITEM_ICON: "sword",
    	    ITEM_NAME: "<%= js(goods) %>",
    	    ITEM_DESC: "<%= js(goodsText) %>",
    	    PRICE: Number("<%= js(price) %>")
    	  }<%= i < goodsList.size() - 1 ? "," : "" %>
    	<%
    	    }
    	%>
    	];

    /*
    현재 회원의 포인트를 가져온다.
    저장된 포인트가 없으면 0P로 처리한다.
    */
    function getMemberPoint() {
      return Number(localStorage.getItem(POINT_STORAGE_KEY)) || 0;
    }

    /*
    회원 포인트를 새 값으로 저장한다.
    구매 후 포인트를 차감하고 화면을 다시 그리기 위해 사용한다.
    */
    function setMemberPoint(point) {
      localStorage.setItem(POINT_STORAGE_KEY, String(point));
      renderMemberPoint();
      renderItemList();
    }

    /*
    현재 회원이 구매한 아이템 목록을 가져온다.
    저장된 값이 없으면 빈 배열을 반환한다.
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
    구매한 아이템 목록을 저장한다.
    배열은 localStorage에 바로 저장할 수 없어서
    JSON 문자열로 변환해서 저장한다.
    */
    function saveMemberItems(items) {
      localStorage.setItem(ITEM_STORAGE_KEY, JSON.stringify(items));
    }

    async function savePurchaseHistoryDb(selectedItem) {
    	  try {
    	    const formData = new URLSearchParams();

    	    formData.append("goodsNum", selectedItem.GOODS_NUM || selectedItem.ITEM_NUM);

    	    const response = await fetch("PurchaseService", {
    	      method: "POST",
    	      headers: {
    	        "Content-Type": "application/x-www-form-urlencoded"
    	      },
    	      body: formData.toString()
    	    });

    	    const text = await response.text();
    	    console.log("포인트샵 구매 DB 저장 결과:", text);

    	    if (text.trim() === "LOGIN_FAIL") {
    	      alert("로그인이 필요합니다.");
    	      location.href = "login.jsp";
    	      return false;
    	    }

    	    return text.trim() === "OK";

    	  } catch (error) {
    	    console.error("포인트샵 구매 DB 저장 실패:", error);
    	    return false;
    	  }
    	}

    	  
    /*
    화면 상단의 가용 포인트를 표시한다.
    */
    function renderMemberPoint() {
      document.getElementById("memberPoint").innerText = getMemberPoint();
    }

    /*
    아이템 아이콘을 SVG로 반환한다.
    이미지 파일을 따로 만들지 않고 코드로 아이콘을 보여주기 위해 사용한다.
    */
    function getItemIcon(iconName) {
      if (iconName === "sword") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M6 18L17.5 6.5"></path>
            <path d="M16.2 5.2L18.8 7.8"></path>
            <path d="M8.5 15.5L10.5 17.5"></path>
            <path d="M5 19L7 21"></path>
            <path d="M4.8 14.8L9.2 19.2"></path>
            <path d="M14 5L19 10"></path>
          </svg>
        `;
      }

      if (iconName === "stance") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <circle cx="12" cy="6" r="2.1"></circle>
            <path d="M12 8.2V14"></path>
            <path d="M8.5 11.5L15.5 9.5"></path>
            <path d="M15.5 9.5L19 8.5"></path>
            <path d="M12 14L8.5 20"></path>
            <path d="M12 14L16.5 20"></path>
            <path d="M6 20H10.5"></path>
            <path d="M14 20H19"></path>
          </svg>
        `;
      }

      if (iconName === "flame") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M7 5V20"></path>
            <path d="M7 6H17L14.5 9.5L17 13H7"></path>
            <path d="M10 16H18"></path>
            <path d="M16 14L18 16L16 18"></path>
          </svg>
        `;
      }

      if (iconName === "armor") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M8 4H16L18.5 8.5V15.5C18.5 18.1 15.8 20 12 20C8.2 20 5.5 18.1 5.5 15.5V8.5L8 4Z"></path>
            <path d="M8 8H16"></path>
            <path d="M7.5 12H16.5"></path>
            <path d="M9 16H15"></path>
            <path d="M10 8V18"></path>
            <path d="M14 8V18"></path>
          </svg>
        `;
      }

      if (iconName === "shadow") {
        return `
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M5 17L17 5"></path>
            <path d="M15.5 4.5L19.5 8.5"></path>
            <path d="M4 20H20"></path>
            <path d="M8 17L10 20"></path>
            <path d="M16 17L14 20"></path>
            <path d="M7.5 14.5L10 17"></path>
          </svg>
        `;
      }

      return `
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <path d="M12 4L18 6.5V12.5C18 16.8 15.5 19.7 12 21C8.5 19.7 6 16.8 6 12.5V6.5L12 4Z"></path>
          <path d="M9 12.2L11 14.2L15 9.8"></path>
          <path d="M18.2 3.8L18.8 5.2L20.2 5.8L18.8 6.4L18.2 7.8L17.6 6.4L16.2 5.8L17.6 5.2L18.2 3.8Z"></path>
        </svg>
      `;
    }

    /*
    상품 목록을 화면에 출력한다.

    포인트가 부족하거나 이미 구매한 아이템이면
    구매 버튼을 비활성화한다.
    */
    function renderItemList() {
      const itemList = document.getElementById("itemList");
      const memberPoint = getMemberPoint();
      const memberItems = getMemberItems();

      itemList.innerHTML = ITEM_LIST.map((item) => {
        const isOwned = memberItems.includes(item.ITEM_NUM);

        return `
          <article class="item-card ${item.ITEM_TYPE.toLowerCase()}-item">
            <div class="item-icon ${item.ITEM_ICON}">${getItemIcon(item.ITEM_ICON)}</div>
            <div>
              <div class="item-title-row">
                <h2 class="item-name">${item.ITEM_NAME}</h2>
                <span class="item-kind">${item.ITEM_KIND}</span>
              </div>
              <p class="item-desc">${item.ITEM_DESC}</p>
            </div>
            <button
              type="button"
              class="buy-btn"
              data-item-num="${item.ITEM_NUM}"
              ${memberPoint < item.PRICE || isOwned ? "disabled" : ""}
            >${isOwned ? "보유" : `구매<span class="buy-price">${item.PRICE}P</span>`}</button>
          </article>
        `;
      }).join("");

      document.querySelectorAll(".buy-btn:not(:disabled)").forEach((button) => {
        button.addEventListener("click", () => {
          buyItem(Number(button.dataset.itemNum));
        });
      });
    }

    /*
    구매 버튼을 눌렀을 때 실행된다.

    1. 선택한 상품 찾기
    2. 포인트 부족 여부 확인
    3. 중복 구매 여부 확인
    4. 아이템 저장
    5. 포인트 차감
    */
    async function buyItem(itemNum) {
    	  const selectedItem = ITEM_LIST.find((item) => item.ITEM_NUM === itemNum);

    	  if (!selectedItem || getMemberPoint() < selectedItem.PRICE) {
    	    alert("포인트가 부족합니다.");
    	    return;
    	  }

    	  const memberItems = getMemberItems();

    	  if (memberItems.includes(selectedItem.ITEM_NUM)) {
    	    alert("이미 보유한 상품입니다.");
    	    return;
    	  }

    	  const dbSaved = await savePurchaseHistoryDb(selectedItem);

    	  if (!dbSaved) {
    	    alert("구매 내역 DB 저장에 실패했습니다.");
    	    return;
    	  }

    	  saveMemberItems([...memberItems, selectedItem.ITEM_NUM]);
    	  setMemberPoint(getMemberPoint() - selectedItem.PRICE);

    	  alert("구매가 완료되었습니다.");
    	}

    renderMemberPoint();
    renderItemList();
  </script>
  <script>
  (function applyDarkMode() {
	  try {
	    const appSetting = JSON.parse(localStorage.getItem(`BGS_APP_SETTING_${M_NUM}`) || "{}");

	    if (appSetting.DARK_MODE) {
	      document.querySelector(".mobile-frame")?.classList.add("dark-mode");
	    }
	  } catch (error) {}
	})();
  </script>
</body>
</html>