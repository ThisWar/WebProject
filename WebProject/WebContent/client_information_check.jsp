<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>client_information_check</title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
</head>
<body>
    <%
    	try
    	{
    		DataBaseConnection dataBaseConnection = new DataBaseConnection();
    		Connection connection = dataBaseConnection.getConnection();
    		request.setCharacterEncoding("UTF-8");

    		String name = request.getParameter("name");
    		String phone = request.getParameter("phone");
    		int number = Integer.valueOf(request.getParameter("number"));

    		if ((name != null) && (phone != null))
    		{
    			// 实例化Statement对象
    			PreparedStatement statement = connection.prepareStatement("insert into t_client(client_name, client_phone, client_number) values (?, ?, ?)");
    			statement.setString(1, name);
    			statement.setString(2, phone);
    			statement.setInt(3, number);
    			int i = statement.executeUpdate();
    			if (i == 1)
    			{
    				out.println("<div style=\"width: 80%; margin: auto;\" class=\"form-group\">");
    				out.println("<h4>添加成功</h4>");
    				out.println("<h4>稍后我们的服务人员将与你电话联系</h4>");
    				out.println("</div>");
    				out.println("<script>alert('添加成功！');window.location.href='index.jsp'</script>");
    			}
    			else
    			{
    				out.println("<div style=\"width: 80%; margin: auto;\" class=\"form-group\">");
    				out.println("<h4>添加失败</h4>");
    				out.println("</div>");
    				out.println("<script>alert('添加成功！');window.location.href='index.jsp'</script>");
    			}
    			statement.close();
    		}
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