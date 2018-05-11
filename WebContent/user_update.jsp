<%@page import="com.example.bean.user"%>
<%@page import="com.example.dao.SelectDao"%>
<%@page import="com.example.bean.resource"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" buffer="none"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<script>parent.document.title=document.title</script>
<style type="text/css">
#form {
	font-size: 20px;
}

ul {
	padding: 5px;
	display: block;
	margin: 0 auto;
	position: relative;
}

li {
	float: left;
	list-style: none;
	margin-right: 5px
}

.text {
	width: 300px;
	height: 15px;
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
<script type="text/javascript">

	function validate_required(field, alerttxt) {

	}

	function validate_form(thisform) {
		return true;
	}
</script>

</head>
<body>

	<%
	user r = null; 
	String actionName = request.getParameter("actionName");
	if(actionName.equals("updateUser")){
		String id = request.getParameter("userId");
		r = SelectDao.findUser(Integer.valueOf(id));
	}
%>

	<form id="update" action="user" target="id_iframe2"
		accept-charset="utf-8" method="get">

		<h3>用户修改</h3>
		<input class="text" readOnly="true" required="required"
			placeholder="用户名" type="text" name="user_name"
			value="<%=r.getUser_name() %>" size="40"><br> <br>
		<input class="text" required="required" placeholder="地址" type="text"
			name="address" value="<%=r.getAddress()%>" size="40"><br>

		<br> <input class="text" required="required" placeholder="手机号"
			type="text" name="mobile" value="<%=r.getMobile()%>" size="40"><br>


		<input type="hidden" name="id" value="<%=r.getId()%>"> <input
			type="hidden" name="actionName" value="updateUser"> <input
			type="submit" value="提交" style="width: 80px;">
	</form>


	<br>
	<iframe id="id_iframe2" name="id_iframe2" width=300px height=50px>

	</iframe>

</body>
</html>