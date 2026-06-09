<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kendo.model.UserDTO" %>
<%
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
</head>
<body>

    <h2>메인 페이지</h2>

    <% if (loginUser != null) { %>
        <p><%= loginUser.getName() %>님 환영합니다.</p>
    <% } else { %>
        <p>로그인 정보가 없습니다.</p>
    <% } %>

    <a href="pose.jsp">자세 분석하러 가기</a>

</body>
</html>
