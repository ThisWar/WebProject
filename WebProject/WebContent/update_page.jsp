<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>update_page</title>
<script type="text/javascript">
	function openWindow() {
		window.open("upload_file.jsp", "_blank", "location=yes, directories=no, status=no, menubar=yes, scrollbars=yes, resizable=no, copyhistory=yes, width=600, height=400, top=200,left=200");
	}
</script>
</head>
<body>
    <%
    	//由于password是跳转的依据，因此借助session中是否有password信息来判断用户是否有登录，
    	if (session.getAttribute("password") == null) {
    		out.print("<script>alert('请管理员登录！');window.location.href='login.html'</script>");
    	}

    	//由于管理员与用户登录后session中都会有信息且相同，会有以user权限登录后向该管理页面跳转的可能，所以要进行权限判断，
    	if (session.getAttribute("type") == null || !session.getAttribute("type").equals("manager")) {
    		out.print("<script>alert('请重新登录！');window.location.href='login.html'</script>");
    	}
    	try {
    		DataBaseConnection dataBaseConnection = new DataBaseConnection();
    		Connection connection = dataBaseConnection.getConnection();
    		Statement statement = connection.createStatement();
    		request.setCharacterEncoding("UTF-8");
    		String title = request.getParameter("title");
    		String content = request.getParameter("content");
    		String number = request.getParameter("number");

    		if ((number != null) && (title == null) && (content == null)) {
    			ResultSet resultSet = statement.executeQuery("select * from t_page where page_id = " + number);
    			while (resultSet.next()) {
    				out.println("<div style=\"width: 80%; background-color: gray; margin: auto;\">");
    				out.println("<form action=\"update_page.jsp\" method=\"post\">");
    				out.println("<h2>标题</h2>");
    				//out.println("page_title = " + resultSet.getString("page_title"));
    				//out.println("page_content = " + resultSet.getString("page_content"));
    				out.println("<input type=\"text\" name=\"title\" value=\"" + resultSet.getString("page_title") + "\"/>");
    				out.println("<h2>内容</h2>");
    				out.println("<textarea rows=\"20\" cols=\"80\" id=\"textarea1\" name=\"content\">" + resultSet.getString("page_content") + "</textarea>");
    				out.println("<br>");
    				out.println("<input type=\"hidden\" name=\"number\" value=\"" + number + "\"/>");
    				out.println("<input type=\"button\" value=\"添加图片\" onclick=\"openWindow()\" />");
    				out.println("<input type=\"submit\" value=\"提交\">");
    				out.println("</form>");
    				out.println("</div>");

    			}
    			resultSet.close();
    		}

    		if ((number != null) && (title != null) && (content != null)) {
    			// 实例化Statement对象
    			PreparedStatement preparedStatement = connection.prepareStatement("update t_page set page_title = ?, page_content = ? where page_id = " + number);
    			preparedStatement.setString(1, title);
    			preparedStatement.setString(2, content);
    			int i = preparedStatement.executeUpdate();
    			if (i == 1) {
    				out.println("<div style=\"margin: auto; background-color: gray; width: 80%;\">");
    				out.println("<h4>更新成功</h4>");
    				out.println("<h4><a style=\"float: left;\" href=\"manager.jsp\">返回首页</a></h4>");
    				out.println("</div>");
    			} else {
    				out.println("<div style=\"margin: auto; background-color: gray; width: 80%;\">");
    				out.println("<h4>更新失败</h4>");
    				out.println("<h4><a style=\"float: left;\" href=\"manager.jsp\">返回管理员页面</a></h4>");
    				out.println("</div>");
    			}
    			preparedStatement.close();
    		}
    		dataBaseConnection.close();
    	} catch (Exception e) {
    		// TODO: handle exception
    		out.println(e.getMessage());
    	}
    %>
</body>
</html>