<%@page import="com.example.dao.CreateDao"%>
<%@ page import="java.sql.*" language="java"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.example.dao.SelectDao"%>
<%@page import="com.example.bean.resource"%>
<%@page import="com.example.bean.user_score"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>电影打分</title>


<style type="text/css">
#login {
	position: absolute;
	top: 40%;
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
	min-height: 40px;
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


	<%
	String userId = request.getSession().getAttribute("userId").toString();
	String id = request.getParameter("id");
	resource r = SelectDao.findResource(Integer.valueOf(id));
	String actionName = request.getParameter("actionName");
	if(actionName != null){
		if(actionName.equals("addScore")){
			String scoreGived = request.getParameter("score");
			user_score us = SelectDao.getUserScore(Integer.valueOf(userId), Integer.valueOf(id));
			if(us == null){
				us = new user_score(Integer.valueOf(userId), Integer.valueOf(id), Float.valueOf(scoreGived));
			}else{
				us.setScore(Float.valueOf(scoreGived));
			}
			CreateDao.createObject(us);
		}
	}
	
	user_score us = SelectDao.getUserScore(Integer.valueOf(userId), Integer.valueOf(id));
	String score = "";
	if(us != null){
		score = us.getScore().toString();
	}
	
	if(r.getUrl().startsWith("http")){
		
	}else{
		r.setUrl("image/" + r.getUrl());
	}
	boolean isUpdate = true;
%>
	<center>
		<form id="update" action="resource_single.jsp" accept-charset="utf-8"
			method="post">
			<h3>电影打分</h3>

			<img src="<%=r.getUrl()%>"
				style="width: 220px; height: 280px; margin-bottom: 10px"><br>

			电影描述：&nbsp;&nbsp;&nbsp;&nbsp;<br>
			<textarea class="input" readonly="readonly" name="description"
				style="width: 300px; margin-bottom: 10px"><%=r.getDescription()%></textarea>
			<br> <br>
			<h5>分值为：0-10 数字</h5>
			<input class="text" required="required" placeholder="分值"
				type="number" max=10 min=0 step=1 name="score"
				value="<%=isUpdate ? score  : "5"%>" size="40"><br> <input
				type="hidden" name="id" value="<%=isUpdate ? r.getId() : ""%>">
			<input type="hidden" name="actionName" value="addScore"> <input
				type="submit" value="提交" style="width: 80px; height: 40px;">
			<a href="main.jsp"><input type="button" value="返回"
				style="width: 80px; height: 40px;"></a>
		</form>
	</center>

</body>

</html>