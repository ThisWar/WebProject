<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <div style="margin: auto; width: 80%;" class="form-group">
        <form action="login_check.jsp" method="post">
            <br>
            <label>name :</label>
            <input type="text" class="form-control" name="name">
            <br>
            <label>password :</label>
            <input type="password" class="form-control" name="password">
            <br>
            <input type="reset" value="重置" class="btn btn-default">
            <input type="submit" value="登陆" class="btn btn-default">
        </form>
    </div>
</body>
</html>