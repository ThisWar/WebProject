<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <%
    	try
    	{
    		DataBaseConnection dataBaseConnection = new DataBaseConnection();
    		Connection connection = dataBaseConnection.getConnection();
    		Statement statement = connection.createStatement();

    		String number = request.getParameter("number");
    		String KeyWord = request.getParameter("KeyWord");

    		//out.println("<h1>number = *" + number + "*</h1>");
    		//out.println("<h1>KeyWord = *" + KeyWord + "*</h1>");

    		if (number == null)
    		{
    			if ((KeyWord == null) || (KeyWord == ""))
    			{
    				// 不需要做查询
    				int total = 0; // 总记录数
    				int page_record = 10; // 每页记录数
    				int page_total = 0; // 总页数
    				int page_num = 0; // 当前页数

    				if ((request.getParameter("page_num") != null) && (request.getParameter("page_num") != ""))
    				{
    					page_num = Integer.parseInt(request.getParameter("page_num"));
    				}

    				ResultSet resultSet = statement.executeQuery("select count(*) from t_page");
    				while (resultSet.next())
    				{
    					total = resultSet.getInt(1);
    				}
    				page_total = (total + page_record - 1) / page_record;
    				resultSet = statement.executeQuery("select * from t_page limit " + (page_num * page_record) + ", " + page_record);

    				out.println("<br />");
    				out.println("<div style=\" width: 80%; margin: auto;\">");

    				out.println("<div class=\"form-group\">");
    				out.println("<form class=\"form-inline\" role=\"form\" action = \"index.jsp\" method = \"post\">");
    				out.println("<input type = \"text\" class=\"form-control\" name = \"KeyWord\"/>");
    				out.println("<input type = \"submit\" class=\"btn btn-default\" value = \"查询\"/>");
    				out.println("</form>");
    				out.println("</div>");

    				out.println("<table class=\"table table-striped\">");
    				out.println("<br />");

    				while (resultSet.next())
    				{
    					out.println("<tr>");
    					out.println("<td>");
    					out.println("<a href=\"index.jsp?number=" + resultSet.getLong("page_id") + "\">" + resultSet.getString("page_title") + "</a>");
    					out.println("</td>");
    					out.println("</tr>");
    				}

    				out.println("</table>");

    				out.println("<br />");

    				out.println("<ul class=\"pagination\">");
    				out.println("<li>");
    				out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=0\">首页&nbsp;&nbsp;</a>");
    				out.println("</li>");
    				if (page_num > 0)
    				{
    					out.println("<li>");
    					out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=" + (page_num - 1) + "\">上一页&nbsp;&nbsp;</a>");
    					out.println("</li>");
    				}
    				if (page_num < (page_total - 1))
    				{
    					out.println("<li>");
    					out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=" + (page_num + 1) + "\">&nbsp;下一页&nbsp;</a>");
    					out.println("</li>");
    				}
    				out.println("<li>");
    				out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=" + (page_total - 1) + "\">&nbsp;&nbsp;末页</a>");
    				out.println("</li>");
    				out.println("</ul>");

    				out.println("</div>");
    				resultSet.close();
    			}
    			else
    			{
    				// 需要做查询
    				String s = "select * from t_page where page_title like \"%" + KeyWord + "%\";";
    				ResultSet resultSet = statement.executeQuery(s);
    				out.println("<br />");
    				out.println("<div style=\" width: 80%; margin: auto;\">");

    				out.println("<div class=\"form-group\">");
    				out.println("<form class=\"form-inline\" role=\"form\" action = \"index.jsp\" method = \"post\">");
    				out.println("<input type = \"text\" class=\"form-control\" name = \"KeyWord\"/>");
    				out.println("<input type = \"submit\" class=\"btn btn-default\" value = \"查询\"/>");
    				out.println("</form>");
    				out.println("</div>");

    				out.println("<table class=\"table table-striped\">");
    				out.println("<br />");

    				while (resultSet.next())
    				{
    					out.println("<tr>");
    					out.println("<td>");
    					out.println("<a href=\"index.jsp?number=" + resultSet.getLong("page_id") + "\">" + resultSet.getString("page_title") + "</a>");
    					out.println("</td>");
    					out.println("</tr>");
    				}

    				out.println("</table>");

    				out.println("<br />");

    				resultSet.close();
    			}
    		}
    		else
    		{
    			ResultSet resultSet = statement.executeQuery("select * from t_page where page_id = " + number);

    			out.println("<div style=\" width: 80%; margin: auto; text-align: center;\">");
    			out.println("<table class=\"table table-striped\">");
    			out.println("<br />");

    			while (resultSet.next())
    			{
    				out.println("<tr>");
    				out.println("<td>");
    				out.println(resultSet.getString("page_title"));
    				out.println("</td>");
    				out.println("</tr>");
    				out.println("<tr>");
    				out.println("<td class=\"active\">");
    				out.println(resultSet.getString("page_content"));
    				out.println("</td>");
    				out.println("</tr>");
    			}
    			out.println("</table>");
    			out.println("</div>");

    			resultSet.close();
    		}

    		statement.close();
    		dataBaseConnection.close();
    	}
    	catch (Exception e)
    	{
    		// TODO: handle exception
    		out.println(e.getMessage());
    	}
    %>
</body>
</html>