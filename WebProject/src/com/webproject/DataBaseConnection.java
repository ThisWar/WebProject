package com.webproject;

import java.sql.Connection;
import java.sql.DriverManager;

public class DataBaseConnection
{

	Connection connection = null;

	public Connection getConnection()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/web_db?characterEncoding=utf-8", "root", "123456");
			return connection;
		}
		catch (Exception e)
		{
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}

	// public void close() {
	// try {
	// connection.close();
	// } catch (Exception e) {
	// // TODO: handle exception
	// e.printStackTrace();
	// }
	// }

}
