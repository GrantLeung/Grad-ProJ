<%@ page import="java.sql.*" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录界面</title>


<style type="text/css">

</style>

</head>

<%
	String info = request.getAttribute("info").toString();
%>
<body>   
	<center>
	    <div>   
	        <h1><%=info%></h1>     
	    </div> 
    </center>
</body>

</html>