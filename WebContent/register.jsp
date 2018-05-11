<%@ page import="java.sql.*" language="java"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录界面</title>


<style type="text/css">
#login {
	position: absolute;
	top: 50%;
	left: 50%;
	margin: -150px 0 0 -150px;
	width: 300px;
	height: 300px;
}

input {
	width: 278px;
	height: 18px;
	margin-bottom: 10px;
	outline: none;
	padding: 10px;
	font-size: 13px;
	border-top: 1px solid #312E3D;
	border-left: 1px solid #312E3D;
	border-right: 1px solid #312E3D;
	border-bottom: 1px solid #56536A;
	border-radius: 4px;
}

.but {
	width: 300px;
	min-height: 20px;
	border: 1px solid;
	padding: 9px 14px;
	font-size: 15px;
	line-height: normal;
	border-radius: 5px;
	margin: 0;
}
</style>

</head>

<body>
	<center>
		<div id="login">
			<h1>注册</h1>
			<form action="user" method="get" accept-charset="utf-8">
				<input type="hidden" name="actionName" value="register" /> 
				<input
					type="hidden" name="type" value="2" /> 
					<input type="text"
					required="required" placeholder="用户名" name="userName"></input> 
					<input
					type="password" required="required" placeholder="密码"
					name="password1"></input> 
					<input type="password"
					required="required" placeholder="重复密码" name="password2"></input>
					 <input
					type="text" required="required" placeholder="手机号" name="mobile"></input>
				<input type="text" required="required" placeholder="地址"
					name="address"></input>
					<input type= "text" required="required"placeholder="爱好" name="hobby"></input>
				<button class="but" type="submit">注册</button>
			</form>
		</div>
	</center>
</body>

</html>