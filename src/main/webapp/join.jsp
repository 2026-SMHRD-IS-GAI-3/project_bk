<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>

    <h2>회원가입</h2>

    <form action="JoinService" method="post">
        ID : <input type="text" name="id"><br>
        PW : <input type="password" name="pw"><br>
        이름 : <input type="text" name="name"><br>
        칭호 : <input type="text" name="goods" value="초보검사"><br>
        나이 : <input type="number" name="age"><br>
        성별 : <input type="text" name="gender"><br>
        <input type="submit" value="회원가입">
    </form>

</body>
</html>
