<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>order_manager</title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
</head>
<body>
    <jsp:include page="navbar_admin.jsp" />

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

    		int total = 0; // 总记录数
    		int page_record = 10; // 每页记录数
    		int page_total = 0; // 总页数
    		int page_num = 0; // 当前页数

    		if ((request.getParameter("page_num") != null) && (request.getParameter("page_num") != ""))
    		{
    			page_num = Integer.parseInt(request.getParameter("page_num"));
    		}

    		ResultSet resultSet = statement.executeQuery("select count(*) from t_client");
    		while (resultSet.next())
    		{
    			total = resultSet.getInt(1);
    		}
    		page_total = (total + page_record - 1) / page_record;
    		resultSet = statement.executeQuery("select t_client.client_id, t_client.client_name, t_client.client_phone, t_page.page_title from t_client, t_page where t_client.client_number = t_page.page_id limit " + (page_num * page_record) + ", " + page_record);

    		out.println("<br />");
    		out.println("<div style=\"margin: auto; width: 80%;\">");
    		out.println("<br />");
    		out.println("<h2>订单管理</h2>");
    		out.println("<br />");
    		out.println("<table class=\"table table-striped\">");
    		out.println("<tr>");
    		out.println("<th>订单编号</th>");
    		out.println("<th>客户姓名</th>");
    		out.println("<th>客户电话</th>");
    		out.println("<th>景点名称</th>");
    		out.println("</tr>");

    		while (resultSet.next())
    		{
    			out.println("<tr>");
    			out.println("<td>");
    			out.println(resultSet.getString("t_client.client_id"));
    			out.println("</td>");
    			out.println("<td>");
    			out.println(resultSet.getString("t_client.client_name"));
    			out.println("</td>");
    			out.println("<td>");
    			out.println(resultSet.getString("t_client.client_phone"));
    			out.println("</td>");
    			out.println("<td>");
    			out.println(resultSet.getString("t_page.page_title"));
    			out.println("</td>");

    			out.println("</tr>");
    		}
    		out.println("</table>");

    		out.println("<br />");

    		out.println("<ul class=\"pagination\">");
    		out.println("<li>");
    		out.println("<a style=\"float: left;\" href=\"order_manager.jsp?page_num=0\">首页&nbsp;&nbsp;</a>");
    		out.println("</li>");
    		if (page_num > 0)
    		{
    			out.println("<li>");
    			out.println("<a style=\"float: left;\" href=\"order_manager.jsp?page_num=" + (page_num - 1) + "\">上一页&nbsp;&nbsp;</a>");
    			out.println("</li>");
    		}
    		if (page_num < (page_total - 1))
    		{
    			out.println("<li>");
    			out.println("<a style=\"float: left;\" href=\"order_manager.jsp?page_num=" + (page_num + 1) + "\">&nbsp;下一页&nbsp;</a>");
    			out.println("</li>");
    		}
    		out.println("<li>");
    		out.println("<a style=\"float: left;\" href=\"order_manager.jsp?page_num=" + (page_total - 1) + "\">&nbsp;&nbsp;末页</a>");
    		out.println("</li>");
    		out.println("</ul>");

    		out.println("</div>");

    		resultSet.close();
    		statement.close();
    		connection.close();
    	}
    	catch (Exception e)
    	{
    		// TODO: handle exception
    		out.println(e.getMessage());
    	}
    %>
</body>
</html>