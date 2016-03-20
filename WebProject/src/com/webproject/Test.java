package com.webproject;

import java.util.ArrayList;

public class Test
{

	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
		DBHelp dbHelp = new DBHelp();
		ArrayList<Integer> list = dbHelp.getPageCount();
		System.out.println(list.get(0));
		for (int i = 0; i < list.size(); i++)
		{
			System.out.println(list.get(i));
		}
	}

}
