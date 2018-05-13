<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
<style>
	/* The following styles are used only for this page - the actual plugin styles are in slidernav.css */
	* { margin: 0; padding: 0; }
	body { background: url(image/bg.gif); }
	#content { padding: 40px 20px; font-family: "Helvetica Neue", Helvetica, Arial; font-size: 12px; line-height: 18px; color: #cfdae3; }
	a { text-decoration: none; }
	h2, h3 { margin: 0 0 20px; color: #fff; }
	h2 { font-size: 28px; }
	h3 { font-size: 22px; }
	pre { background: #fff; width: 460px; padding: 10px 20px; border-left: 5px solid #ccc; margin: 0 0 20px; }
	p { width: 500px; font-size: 18px; line-height: 24px; margin: 0 0 30px; }
	input { margin: 0; padding: 0; }
	
	/* Dark Button CSS */
	.button {
		outline: 0;
		padding: 5px 12px;
		display: block;
		color: #9fa8b0;
		font-weight: bold;
		text-shadow: 1px 1px #1f272b;
		border: 1px solid #1c252b;
		border-radius: 3px;
		-moz-border-radius: 3px;
		-webkit-border-radius: 3px;
		background: #232B30; /* old browsers */
		background: -moz-linear-gradient(top, #3D4850 3%, #313d45 4%, #232B30 100%); /* firefox */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(3%,#3D4850), color-stop(4%,#313d45), color-stop(100%,#232B30)); /* webkit */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3D4850', endColorstr='#232B30',GradientType=0 ); /* ie */
		box-shadow: 1px 1px 1px rgba(0,0,0,0.2); /* CSS3 */
		-moz-box-shadow: 1px 1px 1px rgba(0,0,0,0.2); /* Firefox */
		-webkit-box-shadow: 1px 1px 1px rgba(0,0,0,0.2); /* Safari, Chrome */
	}
	.button:hover {
		color: #fff;
		background: #4C5A64; /* old browsers */
		background: -moz-linear-gradient(top, #4C5A64 3%, #404F5A 4%, #2E3940 100%); /* firefox */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(3%,#4C5A64), color-stop(4%,#404F5A), color-stop(100%,#2E3940)); /* webkit */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#4C5A64', endColorstr='#2E3940',GradientType=0 ); /* ie */
	}
	.button:active {
		background-position: 0 top;
		position: relative;
		top: 1px;
		color: #fff;
		padding: 6px 12px 4px;
		background: #20282D; /* old browsers */
		background: -moz-linear-gradient(top, #20282D 3%, #252E34 51%, #222A30 100%); /* firefox */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(3%,#20282D), color-stop(51%,#252E34), color-stop(100%,#222A30)); /* webkit */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#20282D', endColorstr='#222A30',GradientType=0 ); /* ie */
		-moz-box-shadow: 1px 1px 1px rgba(255,255,255,0.1); /* Firefox */
		-webkit-box-shadow: 1px 1px 1px rgba(255,255,255,0.1); /* Safari, Chrome */
		box-shadow: 1px 1px 1px rgba(255,255,255,0.1); /* CSS3 */
	}
	
	/* Other stuff: */
	.button-list { list-style: none; padding: 0; margin: 0; width: 100%; float: left; display: block; margin: 0 0 30px; }
	.button-list li { float: left; margin: 0 10px 0 0; }
	.button-list li.search { border-left: 1px solid #273137; padding-left: 18px; margin-left: 10px; position: relative; }
	
	/* Search CSS: */
	.search-input {
		padding: 0 5px 0 22px;
		border: 1px solid #1c252b;
		height: 30px;
		color: #9fa8b0;
		font-size: 12px;
		line-height: 30px;
		font-weight: bold;
		text-shadow: 1px 1px #1f272b;
		border-radius: 25px;
		-moz-border-radius: 25px;
		-webkit-border-radius: 25px;
		background: #20282D; /* old browsers */
		background: -moz-linear-gradient(top, #20282D 3%, #252E34 51%, #222A30 100%); /* firefox */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(3%,#20282D), color-stop(51%,#252E34), color-stop(100%,#222A30)); /* webkit */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#20282D', endColorstr='#222A30',GradientType=0 ); /* ie */
		-moz-box-shadow: 1px 1px 1px rgba(255,255,255,0.1); /* Firefox */
		-webkit-box-shadow: 1px 1px 1px rgba(255,255,255,0.1); /* Safari, Chrome */
		box-shadow: 1px 1px 1px rgba(255,255,255,0.1); /* CSS3 */
	}
	.search-input:focus {outline: none;}
	.search-submit {
		width: 13px;
		height: 13px;
		border: none;
		background: url(mag-glass.png) no-repeat;
		display: block;
		position: absolute;
		left: 26px;
		top: 10px;
		text-indent: -9999em;
	}
	
	/* Vertical List: */
	
	


	.vertical-list li { margin: 0 0 5px; }
	.vertical-list li:last-child { margin: 0; }
</style>

</head>
<body>
<br>

<div id="content">
	<ul class="vertical-list">
		<li><a href="resource_add.jsp"	class = 'button' target="rightContent"	>电影添加</a></li>
		<li><a href="resource.jsp"	class = 'button' 	target="rightContent"	>电影列表</a></li>
		<li><a href="user.jsp" 		class = 'button' 	target="rightContent"	>用户管理</a></li>
		<li><a href= "choice.jsp"class = 'button'  target = "rightContent">推荐选项</a></li>
		<li><a href= "index.jsp" class = 'button' target = "_top">退出登录</a></li>
	</ul>
</div>

</body>







 
