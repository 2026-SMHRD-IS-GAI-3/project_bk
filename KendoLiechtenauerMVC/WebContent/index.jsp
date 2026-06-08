<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검도 / 리히테나워 자세 교정</title>
<link rel="stylesheet" href="assets/style.css">
</head>
<body>

    <!-- 메인 화면 -->
    <div class="container">
        <h1>검도 / 리히테나워 자세 교정 프로그램</h1>
        <p>이미지를 업로드하면 Python OpenCV + MediaPipe 서버로 분석 요청을 보냅니다.</p>

        <%-- Servlet에서 error 메시지를 보냈을 때 출력 --%>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <p class="error"><%= error %></p>
        <%
            }
        %>

        <!-- 파일 업로드 form -->
        <!-- enctype="multipart/form-data"는 파일 업로드할 때 반드시 필요 -->
        <form action="AnalyzePose" method="post" enctype="multipart/form-data">

            <label>검술 종류</label>
            <select name="styleType">
                <option value="KENDO">대한검도</option>
                <option value="LIECHTENAUER">리히테나워 검술</option>
            </select>

            <label>자세 이름</label>
            <input type="text" name="poseName" placeholder="예: 중단세, 머리치기, Vom Tag, Pflug">

            <label>자세 이미지 업로드</label>
            <input type="file" name="poseFile" accept="image/*">

            <button type="submit">자세 분석하기</button>
        </form>
    </div>

</body>
</html>
