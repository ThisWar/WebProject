<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>insert_page</title>
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
    		request.setCharacterEncoding("UTF-8");

    		String title = new String(request.getParameter("title").getBytes(), "UTF-8");
    		String content = request.getParameter("content");

    		//out.println("title = " + title);
    		//out.println("content = " + content);

    		if ((title != null) && (content != null)) {
    			// 实例化Statement对象
    			PreparedStatement statement = connection.prepareStatement("insert into t_page(page_title, page_content) values (?, ?)");
    			//statement.setInt(1, 1);
    			statement.setString(1, title);
    			statement.setString(2, content);
    			int i = statement.executeUpdate();
    			if (i == 1) {
    				out.println("<h4>添加成功</h4>");
    				out.println("<h4><a style=\"float: left;\" href=\"index.jsp\">返回首页</a></h4>");
    			} else {
    				out.println("<h4>添加失败</h4>");
    				out.println("<h4><a style=\"float: left;\" href=\"manager.jsp\">返回管理员页面</a></h4>");
    			}
    			statement.close();
    		}
    		dataBaseConnection.close();
    	} catch (Exception e) {
    		// TODO: handle exception
    		out.println(e.getMessage());
    	}
    %>
</body>
</html>