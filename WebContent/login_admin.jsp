<%@ page import="java.sql.*" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理员登录</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>

<body>   
	    <div class="htmleaf-container">
	<div class="wrapper">
		<div class="container"id="login">   
	        <h1>管理员登录</h1>   
	        <form action="user" method="get" ccept-charset="utf-8">   
	        	<input type="hidden" name="actionName" value="login"/>
	        	<input type="hidden" name="type" value="1"/>
	            <input type="text" placeholder="用户名" name="userName"></input>   
	            <input type="password" placeholder="密码" name="password"></input>               
	            <button type="submit">登录</button>
	        </form>   
	    </div> 
	    <ul class="bg-bubbles">
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	    </div>
	    </div>  
    <script src="js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script>
$('#login-button').click(function (event) {
	event.preventDefault();
	$('form').fadeOut(500);
	$('.wrapper').addClass('form-success');
});
</script>
</body>

</html>