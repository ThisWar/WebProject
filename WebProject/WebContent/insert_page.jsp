<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert page</title>
<link href="CSS/bootstrap.min.css" rel="stylesheet">
<script src="JAVASCRIPT/jquery-2.2.0.min.js"></script>
<script src="JAVASCRIPT/bootstrap.min.js"></script>
<script type="text/javascript">

    //多行文本框，按下回车键自动添加换行符。
    window.onload = function() {
    	var oTxt1 = document.getElementById('textarea1');
    	document.onkeydown = function(ev) {
    		var oEvent = ev || event;
    		if (oEvent.keyCode == 13) {
    			oTxt1.value += "<br/>";
    		}
    	};
    };

	function openWindow() {
		window.open("upload_file.jsp", "_blank", "location=yes, directories=no, status=no, menubar=yes, scrollbars=yes, resizable=no, copyhistory=yes, width=600, height=300, top=200,left=200");
	}
</script>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <div style="margin: auto; width: 80%;" class="form-group">
        <form action="insert_page_check.jsp" method="post">
            <label>标题</label>
            <br />
            <input type="text" class="form-control" name="title" />
            <br />
            <label>内容</label>
            <br />
            <textarea rows="10" id="textarea1" class="form-control" name="content"></textarea>
            <br>
            <input type="button" value="添加图片" class="btn btn-default" onclick="openWindow()" />
            <input type="submit" value="提交" class="btn btn-default">
        </form>
    </div>
</body>
</html>