<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kendo.model.media.MediaPoseResult" %>
<%
    MediaPoseResult poseResult = (MediaPoseResult) request.getAttribute("poseResult");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분석 결과</title>
</head>
<body>

    <h2>분석 결과</h2>

    <% if (poseResult != null) { %>
        <p>어깨 각도 : <%= poseResult.getShoulderAngle() %></p>
        <p>팔꿈치 각도 : <%= poseResult.getElbowAngle() %></p>
        <p>무릎 각도 : <%= poseResult.getKneeAngle() %></p>
        <p>결과 : <%= poseResult.getResult() %></p>
    <% } else { %>
        <p>분석 결과가 없습니다.</p>
    <% } %>

    <a href="pose.jsp">다시 분석하기</a>

</body>
</html>
