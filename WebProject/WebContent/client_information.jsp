<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>client_information</title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
    <%
    	String number = request.getParameter("number");
    	//out.println("<h1>number = *" + number + "*</h1>");
    %>


    <jsp:include page="navbar.jsp" />
    <div style="margin: auto; width: 80%;" class="form-group">
        <form action="client_information_check.jsp" method="post">
            <br />
            <h2>门票预订</h2>
            <br />
            <label>姓名：</label>
            <br />
            <input type="text" class="form-control" name="name" />
            <br />
            <label>电话：</label>
            <br />
            <input type="text" class="form-control" name="phone" />
            <input type="hidden" class="form-control" name="number" value=<%=number%> />
            <br>
            <input type="submit" value="提交" class="btn btn-default">
        </form>
    </div>
</body>
</html>