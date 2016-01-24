<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>manager</title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <%
    	//由于password是跳转的依据，因此借助session中是否有password信息来判断用户是否有登录，
    	if (session.getAttribute("password") == null)
    	{
    		out.print("<script>alert('请管理员登录！');window.location.href='login.jsp'</script>");
    	}

    	//由于管理员与用户登录后session中都会有信息且相同，会有以user权限登录后向该管理页面跳转的可能，所以要进行权限判断，
    	if (session.getAttribute("type") == null || !session.getAttribute("type").equals("manager"))
    	{
    		out.print("<script>alert('请重新登录！');window.location.href='login.jsp'</script>");
    	}

    	try
    	{
    		DataBaseConnection dataBaseConnection = new DataBaseConnection();
    		Connection connection = dataBaseConnection.getConnection();
    		Statement statement = connection.createStatement();

    		ResultSet resultSet = statement.executeQuery("select * from t_page");

    		out.println("<div style=\"margin: auto; width: 80%;\">");
    		//out.println("<h2>");

    		//out.println("<a style=\"float: left;\" href=\"index.jsp\">首页</a>");
    		out.println("<br />");
    		out.println("<table class=\"table table-striped\">");
    		while (resultSet.next())
    		{
    			out.println("<tr>");
    			out.println("<td>");
    			out.println(resultSet.getString("page_title"));
    			out.println("</td>");
    			out.println("<td>");
    			out.println("<a href=\"update_page.jsp?number=" + resultSet.getLong("page_id") + "\">" + "修改" + "</a>");
    			out.println("</td>");
    			out.println("<td>");
    			out.println("<a href=\"delete_page.jsp?number=" + resultSet.getLong("page_id") + "\">" + "删除" + "</a>");
    			out.println("</td>");
    			out.println("</tr>");
    		}
    		out.println("</table>");
    		//out.println("</h2>");
    		out.println("</div>");

    		resultSet.close();
    		statement.close();
    		dataBaseConnection.close();
    	}
    	catch (Exception e)
    	{
    		// TODO: handle exception
    		out.println(e.getMessage());
    	}
    %>


    <div style="margin: auto; width: 80%;">
        <h2>
            <a class="btn btn-primary" href="insert_page.jsp">新增文章</a>
        </h2>
    </div>
</body>
</html>