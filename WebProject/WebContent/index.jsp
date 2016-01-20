<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>index</title>
</head>
<body>
    <%
    	try {
    		DataBaseConnection dataBaseConnection = new DataBaseConnection();
    		Connection connection = dataBaseConnection.getConnection();
    		Statement statement = connection.createStatement();

    		String number = request.getParameter("number");

    		if (number == null) {
    			int total = 0; // 总记录数
    			int page_record = 20; // 每页记录数
    			int page_total = 0; // 总页数
    			int page_num = 0; // 当前页数

    			if ((request.getParameter("page_num") != null) && (request.getParameter("page_num") != "")) {
    				page_num = Integer.parseInt(request.getParameter("page_num"));
    			}

    			ResultSet resultSet = statement.executeQuery("select count(*) from t_page");
    			while (resultSet.next()) {
    				total = resultSet.getInt(1);
    			}
    			//out.println("total = " + total);
    			page_total = (total + page_record - 1) / page_record;
    			//out.println("page_total = " + page_total);
    			resultSet = statement.executeQuery("select * from t_page limit " + (page_num * page_record) + ", " + page_record);

    			out.println("<div style=\"margin: auto; background-color: #c0c0c0; width: 80%;\">");
    			out.println("<h2>");

    			out.println("<a style=\"float: left;\" href=\"index.jsp\">首页</a>");
    			out.println("<a style=\"float: right;\" href=\"login.html\">管理员登陆</a>");
    			out.println("<br />");
    			out.println("<div style=\"background-color: gray; width: 50%; height: 80%; margin: auto;\">");
    			while (resultSet.next()) {
    				out.println("<a href=\"index.jsp?number=" + resultSet.getLong("page_id") + "\">" + resultSet.getString("page_title") + "</a>");
    				out.println("<br />");
    			}
    			out.println("</div>");
    			out.println("<br />");
    			out.println("</h2>");

    			out.println("<div style=\"background-color: gray; width: 50%; height: 80%; margin: auto;\">");
    			out.println("<h4>");
    			out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=0\">首页&nbsp;&nbsp;</a>");
    			out.println("&nbsp;");
    			out.println("&nbsp;");
    			if (page_num > 0) {
    				out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=" + (page_num - 1) + "\">上一页&nbsp;&nbsp;</a>");
    			}
    			if (page_num < (page_total - 1)) {
    				out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=" + (page_num + 1) + "\">&nbsp;下一页&nbsp;</a>");
    			}
    			out.println("&nbsp;");
    			out.println("&nbsp;");
    			out.println("<a style=\"float: left;\" href=\"index.jsp?page_num=" + (page_total - 1) + "\">&nbsp;&nbsp;末页</a>");
    			out.println("</h4>");
    			out.println("</div>");

    			out.println("</div>");
    			resultSet.close();
    		} else {
    			ResultSet resultSet = statement.executeQuery("select * from t_page where page_id = " + number);

    			out.println("<div style=\"margin: auto; background-color: gray; text-align: center; width: 80%;\">");
    			//out.println("<h2>");

    			out.println("<a style=\"float: left;\" href=\"index.jsp\">首页</a>");
    			out.println("<br />");

    			while (resultSet.next()) {
    				out.println("<br />");
    				out.println(resultSet.getString("page_title"));
    				out.println("<br />");
    				out.println("<br />");
    				out.println(resultSet.getString("page_content"));
    			}

    			//out.println("</h2>");
    			out.println("</div>");

    			resultSet.close();
    		}

    		statement.close();
    		dataBaseConnection.close();
    	} catch (Exception e) {
    		// TODO: handle exception
    		out.println(e.getMessage());
    	}
    %>
</body>
</html>