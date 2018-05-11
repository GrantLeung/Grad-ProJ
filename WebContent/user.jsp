
<%@page import="java.util.List"%>
<%@page import="com.example.dao.CreateDao"%>
<%@page import="com.example.bean.user"%>
<%@page import="com.example.dao.DeleteDao"%>
<%@page import="com.example.bean.user_score"%>
<%@page import="com.example.dao.DeleteDao"%>
<%@page import="com.example.util.Util"%>
<%@page import="com.example.dao.SelectDao"%>
<%@page import="com.example.bean.resource"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<script>parent.document.title=document.title</script>
<script src="jquery-1.12.2.min.js"></script>
<style type="text/css">
#form {
	font-size:20px;
}

table{ background-color:#aaa; line-height:25px;}
th{ background-color:#fff;}
td{ background-color:#fff; text-align:center}
</style>
<script>
function sleep(sleepTime) {
    for(var start = Date.now(); Date.now() - start <= sleepTime; ) { } 
}

function onDelete(){
	var id = arguments[0];
	var form = document.forms[1];
	document.forms[1].elements[0].value = id;
	form.submit();
}

function onUpdate(){
	var id = arguments[0];
	var form = document.forms[0];
	document.forms[0].elements[0].value = id;
	form.submit();
}

</script>
</head>
<body >

<form id="update" style="display:none;" name="update" method="get" action="user_update.jsp" > 
	<input type="hidden" name="userId" value="userId">
	<input type="hidden" name="actionName" value="updateUser">
	<input type="hidden" name="clientType" value="browser">
	<input type="submit" value="提交" style="width: 80px;"><br>
</form>

<form id="delete" style="display:none;" name="delete" method="get" action=""> 
	<input type="hidden" name="userId" value="userId">
	<input type="hidden" name="actionName" value="removeUser">
	<input type="submit" value="提交" style="width: 80px;"><br>
</form>

<%
	String actionName = request.getParameter("actionName");
	if(actionName != null){
		if(actionName.equals("removeUser")){
			String id = request.getParameter("userId");
			//删除用户
			DeleteDao.deleteUser(Integer.valueOf(id));
			//删除用户的打分
			ArrayList<user_score> l2 = SelectDao.getAllUserScore();
			for (user_score order : l2) {
				if(order.getUser_id().equals(id)){
					DeleteDao.removeObject(order);
				}
			}
		}
	}

	List<user> resources = SelectDao.getAllUser();
	String key = request.getParameter("key");
	if(key != null){
		List<user> temp = new ArrayList<user>();
		for(user u : resources){
			if(u.getUser_name().contains(key)){
				temp.add(u);
			}
		}
		resources.clear();
		resources.addAll(temp);
	}
%>

<br>
<form id="search" name="search" method="get" action=""> 
	<input type="text" name="key" style="width: 80px;">
	<input type="submit" value="搜索" style="width: 80px;"><br><br>
</form>

<%	
	String html = "";
	html += "<table cellpadding='1' cellspacing='1'>\n";
	html += "<tr>";
	html += "<th>用户名</th>" + "<th>地址</th>" + "<th>手机</th>"+"<th>选项</th>";
	html += "</tr>\n";
	
	for (user r : resources) {

		html += "<tr>";
		html += "<td>" + r.getUser_name() + "</td>";
		html += "<td>" + r.getAddress() + "</td>";
		html += "<td>" + r.getMobile() + "</td>";
		html += "<td>" + "<button onclick=\"onUpdate('" + r.getId() + "')\">修改</button>" + "<button onclick=\"onDelete('" + r.getId() + "')\">删除</button>" + "</td>";
		html += "</tr>\n";
	}
	
	html += "</table>\n";
	out.print(html);
%>

</body>
</html>