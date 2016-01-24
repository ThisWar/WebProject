<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.webproject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
</head>
<body>
    <%
    	request.setCharacterEncoding("UTF-8");
    	String name = request.getParameter("name");
    	String password = request.getParameter("password");
    	if ((name != null) && (password != null) && (!name.equals("")) && (!password.equals(""))) {
    		try {
    			DataBaseConnection dataBaseConnection = new DataBaseConnection();
    			Connection connection = dataBaseConnection.getConnection();

    			PreparedStatement statement = connection.prepareStatement("select count(*) from t_user where user_name = ? and user_password = ?");
    			statement.setString(1, name);
    			statement.setString(2, password);
    			ResultSet resultSet = statement.executeQuery();

    			int count = 0;
    			while (resultSet.next()) {
    				count = resultSet.getInt(1);
    				if (count == 0) {
    					out.println("<script>alert('用户名或密码错误！');window.location.href='login.jsp'</script>");
    				}
    			}

    			if (count == 1) {
    				statement = connection.prepareStatement("select user_state from t_user where user_name = ? and user_password = ?");
    				statement.setString(1, name);
    				statement.setString(2, password);
    				resultSet = statement.executeQuery();
    				while (resultSet.next()) {
    					int state = resultSet.getInt("user_state");
    					session.setAttribute("name", name);
    					session.setAttribute("password", password);

    					if (state == 1) {
    						session.setAttribute("type", "manager");
    						response.sendRedirect("manager.jsp");
    					}
    				}
    			}

    			resultSet.close();
    			statement.close();
    			dataBaseConnection.close();
    		} catch (Exception e) {
    			// TODO: handle exception
    			out.println(e.getMessage());
    		}
    	} else {
    		out.println("<script>alert('用户名或密码不能为空！');window.location.href='login.jsp'</script>");
    	}
    %>
</body>
</html>