<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>delete_page</title>
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
    		String number = request.getParameter("number");
    		if (number != null) {
    			// 实例化Statement对象
    			PreparedStatement preparedStatement = connection.prepareStatement("delete from t_page where page_id = ?");
    			preparedStatement.setString(1, number);
    			int i = preparedStatement.executeUpdate();
    			if (i == 1) {
    				out.println("<h4>删除成功</h4>");
    				out.println("<h4><a style=\"float: left;\" href=\"manager.jsp\">返回首页</a></h4>");
    				out.println("<script>alert('删除成功！');window.location.href='manager.jsp'</script>");
    			} else {
    				out.println("<h4>删除失败</h4>");
    				out.println("<h4><a style=\"float: left;\" href=\"manager.jsp\">返回管理员页面</a></h4>");
    				out.println("<script>alert('删除失败！');window.location.href='manager.jsp'</script>");
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