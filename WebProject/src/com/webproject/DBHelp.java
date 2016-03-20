package com.webproject;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DBHelp
{
	public ArrayList<Integer> getPageCount()
	{
		ArrayList<Integer> list = new ArrayList<>();
		try
		{
			DataBaseConnection dataBaseConnection = new DataBaseConnection();
			Connection connection = dataBaseConnection.getConnection();
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery("select count(*) from t_page");
			while (resultSet.next())
			{
				list.add(resultSet.getInt(1));
			}
			resultSet.close();
			statement.close();
			connection.close();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		return list;
	}
}
