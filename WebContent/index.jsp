<%@ page import="java.sql.*" language="java"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.5">
<title>登陆界面</title>
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" href="css/chinaz.css">
<link rel="stylesheet" href="css/reset.css"> <!-- CSS reset -->
<link rel="stylesheet" href="css/style.css"> <!-- Resource style -->
<script src="js/modernizr.js"></script> <!-- Modernizr -->
<script src="js/49f8daee.vendors.js"></script>
<script src="js/26f2fc0d.index.js"></script>
</head>


<body>
<header class="zzsc-header bgcolor-11">
		<h1>欢迎登录</h1>
	</header>
	<!--<div class="zzsc-content bgcolor-8">
	</div>-->
	<center>
		<div id="login" class = "zzsc-container">
		    
			<form action="user" method="get" ccept-charset="utf-8" class="cd-form floating-labels">
	        <div class="error-message">
				<p>Please enter a valid email address</p>
			</div>
	       <div class="icon">
				<input type="hidden" name="actionName" value="login" /> 
			</div>
			<div class="icon">
				<input type="hidden" name="type" value="2" /> 
			</div>
			<div class="icon">
				<label class="cd-label" for="cd-name">Name</label>
				<input class="user" type="text" name="userName" id="cd-user" required="required"></input>
			</div> 
				<div class="icon">
				<label class="cd-label" for="cd-company">Password</label>
				<input class="company" type="password" name="password" id="cd-company"required="required"></input>
			</div> 
				<fieldset>
			<div>
				<input type="submit" value="Login">
			</div>
			</form>
<form action="register.jsp" method="post">
		<div>
				<input type="submit" value=" Sign">
			</div>
			</fieldset>
			</form>
		</div>
		
		<script src="js/jquery-1.8.3.min.js"></script>
		<script src="js/main.js"></script> <!-- Resource jQuery -->
		<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
	</div>
</center>
	<h5 style="position: fixed; bottom: 0; left: 50%">
		<a href="login_admin.jsp">管理员登录</a>
	</h5>
</body>

</html>