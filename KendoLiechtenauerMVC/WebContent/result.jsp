<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kendo.model.media.MediaPoseResult"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자세 분석 결과</title>
<link rel="stylesheet" href="assets/style.css">
</head>
<body>

<%
    String styleType = (String) request.getAttribute("styleType");
    String poseName = (String) request.getAttribute("poseName");
    String uploadedImage = (String) request.getAttribute("uploadedImage");
    MediaPoseResult result = (MediaPoseResult) request.getAttribute("result");
%>

<div class="container">
    <h1>자세 분석 결과</h1>

    <h3>입력 정보</h3>
    <p>검술 종류: <%= styleType %></p>
    <p>자세 이름: <%= poseName %></p>

    <h3>업로드 이미지</h3>
    <img class="preview" src="<%= uploadedImage %>">

    <h3>MediaPipe 분석 결과</h3>

    <%
        if (result != null && result.isSuccess()) {
    %>
        <table>
            <tr>
                <th>어깨 각도</th>
                <td><%= result.getShoulderAngle() %></td>
            </tr>
            <tr>
                <th>팔꿈치 각도</th>
                <td><%= result.getElbowAngle() %></td>
            </tr>
            <tr>
                <th>무릎 각도</th>
                <td><%= result.getKneeAngle() %></td>
            </tr>
            <tr>
                <th>피드백</th>
                <td><%= result.getFeedback() %></td>
            </tr>
        </table>
    <%
        } else {
    %>
        <p class="error">분석 실패</p>
        <p><%= result == null ? "결과 객체가 없습니다." : result.getErrorMessage() %></p>
    <%
        }
    %>

    <a href="index.jsp">다시 분석하기</a>
</div>

</body>
</html>
