<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>upload_file</title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
<script type="text/javascript">
	function returnValue() {
		var s = window.document.getElementById("filePath").getAttribute("value");
		if (s != null) {
			s = "<br/><img alt=\"image\" width=\"800\" height=\"600\" src=\"" + s;
			s += "\"/><br/>";

			// 这里必须要使用value，而不能使用innerHTML，否则会导致Chrome浏览器无法获取textarea的值
			// window.opener.document.getElementById("textarea1").innerHTML += s;
			window.opener.document.getElementById("textarea1").value += s;

			window.close();
		}
	}
</script>
</head>
<body>
    <br />
    <div style="width: 80%; margin: auto;" class="form-group">
        <label>上传图片</label>
        <form action="upload_file.jsp" method="post" enctype="multipart/form-data">
            <input type="file" name="image_file" class="form-control" value="image_file" />
            <br>
            <input type="submit" value="上传" class="btn btn-default" />
            <input type="reset" value="重置" class="btn btn-default" />
        </form>
        <%
        	//由于password是跳转的依据，因此借助session中是否有password信息来判断用户是否有登录，
        	if (session.getAttribute("password") == null)
        	{
        		out.print("<script>alert('请管理员登录！');window.location.href='login.jsp'</script>");
        	}

        	//由于管理员与用户登录后session中都会有信息且相同，会有以user权限登录后向该管理页面跳转的可能，所以要进行权限判断，
        	if (session.getAttribute("type") == null || !session.getAttribute("type").equals("manager"))
        	{
        		out.print("<script>alert('请重新登录！');window.location.href='login.jsp'</script>");
        	}
        	try
        	{
        		DiskFileItemFactory factory = new DiskFileItemFactory(); // 创建磁盘工厂
        		factory.setRepository(new File(application.getRealPath("/") + "uploadtemp")); // 设置临时文件夹
        		ServletFileUpload upload = new ServletFileUpload(factory); // 创建处理工具
        		upload.setFileSizeMax(10 * 1024 * 1024); // 最大10M
        		List<FileItem> items = upload.parseRequest(request); // 接收全部内容
        		Iterator<FileItem> iterator = items.iterator(); // 将全部的内容变为Iterator实例
        		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        		while (iterator.hasNext())
        		{
        			FileItem item = iterator.next(); // 取出每一个上传的文件
        			// String fieldName = item.getFieldName(); // 得到表单控件的名称
        			if (item.isFormField())
        			{
        				// 如果是普通的本文数据
        				String value = item.getString(); // 取得表单的内容
        				out.println("文本数据：" + value);
        			}
        			else
        			{
        				// 如果是上传文件
        				// 定义文件名
        				String fileName = dateFormat.format(new Date()) + "." + item.getName().split("\\.")[1];
        				// 定义输出文件路径
        				String path = application.getRealPath("/") + "upload" + File.separator + fileName;
        				String s = "upload/" + fileName;

        				/* out.println("path = " + path);
        				out.println("<br/>");
        				out.println("s = " + s);
        				out.println("<br/>"); */

        				InputStream inputStream = item.getInputStream();
        				OutputStream outputStream = new FileOutputStream(new File(path));
        				byte data[] = new byte[512];
        				int temp = 0;
        				while ((temp = inputStream.read(data, 0, 512)) != -1)
        				{
        					outputStream.write(data);
        				}

        				out.println("<input type=\"hidden\" value=\"" + s + "\" id=\"filePath\"/>");
        				out.println("<h4>上传成功</h4>");

        				inputStream.close();
        				outputStream.close();
        			}
        		}
        	}
        	catch (Exception e)
        	{
        		out.println("<h4>上传失败</h4>");
        		//out.println("e.getMessage() = " + e.getMessage());
        	}
        %>
        <br />
        <input type="button" value="确定" onclick="returnValue()" class="btn btn-default" />
    </div>
</body>
</html>