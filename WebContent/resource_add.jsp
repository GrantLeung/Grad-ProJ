<%@page import="com.example.dao.SelectDao"%>
<%@page import="com.example.bean.resource"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" buffer="none"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理</title>
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
	resource r = null; 
	String actionName = request.getParameter("actionName");
	if(actionName != null){
		if(actionName.equals("updateResource")){
			String id = request.getParameter("resourceId");
			r = SelectDao.findResource(Integer.valueOf(id));
		}
	}
	
	boolean isUpdate = r!=null;
	String addStyle = isUpdate ? "display:none" : "";
	String updateStyle = isUpdate ? "" : "display:none";
%>

	<form id="add" name="add" style="<%=addStyle%>" action="file"
		target="id_iframe1" enctype="multipart/form-data"
		accept-charset="utf-8" method="post">
		<h3>电影添加</h3>
		<input class="text" required="required" placeholder="电影编号" type="text"
			name="number" size="40"><br> <br> <input
			class="text" required="required" placeholder="电影名称" type="text"
			name="name" size="40"><br> <label>类型：</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<ul>
			<li><label><input name="type" type="checkbox" value=爱情>爱情</label></li>
			<li><label><input name="type" type="checkbox" value=喜剧>喜剧</label></li>
			<li><label><input name="type" type="checkbox" value=剧情>剧情</label></li>
			<li><label><input name="type" type="checkbox" value=动画>动画</label></li>
			<li><label><input name="type" type="checkbox" value=科幻>科幻</label></li>
			<li><label><input name="type" type="checkbox" value=动作>动作</label></li>
			<li><label><input name="type" type="checkbox" value=经典>经典</label></li>
			<li><label><input name="type" type="checkbox" value=悬疑>悬疑</label></li>
			<li><label><input name="type" type="checkbox" value=青春>青春</label></li>
			<li><label><input name="type" type="checkbox" value=犯罪>犯罪</label></li>
			<li><label><input name="type" type="checkbox" value=惊悚>惊悚</label></li>
			<li><label><input name="type" type="checkbox" value=文艺>文艺</label></li>
			<li><label><input name="type" type="checkbox" value=搞笑>搞笑</label></li>
			<li><label><input name="type" type="checkbox" value=纪录片>纪录片</label></li>
			<li><label><input name="type" type="checkbox" value=励志>励志</label></li>
			<li><label><input name="type" type="checkbox" value=恐怖>恐怖</label></li>
			<li><label><input name="type" type="checkbox" value=战争>战争</label></li>
			<li><label><input name="type" type="checkbox" value=短片>短片</label></li>
			<li><label><input name="type" type="checkbox" value=黑色幽默>黑色幽默</label></li>
			<li><label><input name="type" type="checkbox" value=魔幻>魔幻</label></li>
		</ul>
		<br> <label>年份：</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<ul>
			<li><label><input name="year" type="radio" value=2001>2001</label></li>
			<li><label><input name="year" type="radio" value=2002>2002</label></li>
			<li><label><input name="year" type="radio" value=2003>2003</label></li>
			<li><label><input name="year" type="radio" value=2004>2004</label></li>
			<li><label><input name="year" type="radio" value=2005>2005</label></li>
			<li><label><input name="year" type="radio" value=2006>2006</label></li>
			<li><label><input name="year" type="radio" value=2007>2007</label></li>
			<li><label><input name="year" type="radio" value=2008>2008</label></li>
			<li><label><input name="year" type="radio" value=2009>2009</label></li>
			<li><label><input name="year" type="radio" value=2010>2010</label></li>
			<li><label><input name="year" type="radio" value=2011>2011</label></li>
			<li><label><input name="year" type="radio" value=2012>2012</label></li>
			<li><label><input name="year" type="radio" value=2013>2013</label></li>
			<li><label><input name="year" type="radio" value=2014>2014</label></li>
			<li><label><input name="year" type="radio" value=2015>2015</label></li>
			<li><label><input name="year" type="radio" value=2016>2016</label></li>
			<li><label><input name="year" type="radio" value=2017>2017</label></li>
		</ul>
		<br> <label>地区：</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<ul>
			<li><label><input name="area" type="radio" value=美国>美国</label></li>
			<!-- 大陆 -->
			<li><label><input name="area" type="radio" value=日本>日本</label></li>
			<!-- 港台 -->
			<li><label><input name="area" type="radio" value=香港>香港</label></li>
			<!-- 日韩 -->
			<li><label><input name="area" type="radio" value=英国>英国</label></li>
			<!-- 欧美 -->
			<li><label><input name="area" type="radio" value=中国>中国</label></li>
			<li><label><input name="area" type="radio" value=韩国>韩国</label></li>
			<li><label><input name="area" type="radio" value=法国>法国</label></li>
			<li><label><input name="area" type="radio" value=台湾>台湾</label></li>
			<li><label><input name="area" type="radio" value=中国大陆>中国大陆</label></li>
			<li><label><input name="area" type="radio" value=德国>德国</label></li>
			<li><label><input name="area" type="radio" value=意大利>意大利</label></li>
			<li><label><input name="area" type="radio" value=印度>印度</label></li>
			<li><label><input name="area" type="radio" value=泰国>泰国</label></li>
			<li><label><input name="area" type="radio" value=西班牙>西班牙</label></li>
			<li><label><input name="area" type="radio" value=加拿大>加拿大</label></li>
		</ul>
		<br> 描述：&nbsp;&nbsp;&nbsp;&nbsp;
		<textarea class="input" name="description"
			style="height: 100px; width: 300px; margin-bottom: 10px"></textarea>
		<br> 图片：&nbsp;&nbsp;&nbsp;&nbsp; <input type="file"
			accept="image/*" name="image" size="40" style="margin-bottom: 10px"><br>

		<input type="hidden" name="actionName" value="addResource"> <input
			type="submit" value="提交" class="but">
	</form>
	<br>
	<iframe style="<%=addStyle%>" id="id_iframe1" name="id_iframe1"
		width=300px height=50px> </iframe>

	<form id="update" style="<%=updateStyle%>" action="file"
		target="id_iframe2" enctype="multipart/form-data"
		accept-charset="utf-8" method="post">
		<h3>电影修改</h3>
		<input class="text" required="required" placeholder="电影编号" type="text"
			name="number" value="<%=isUpdate ? r.getNumber() : ""%>" size="40"><br>

		<br> <input class="text" required="required" placeholder="电影名称"
			type="text" name="name" value="<%=isUpdate ? r.getName() : ""%>"
			size="40"><br> <label>类型：</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<ul>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("冒险")? "checked='checked'" : ""%>
					value=动作>动作</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("冒险")? "checked='checked'" : ""%>
					value=冒险>冒险</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("动画")? "checked='checked'" : ""%>
					value=动画>动画</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("儿童")? "checked='checked'" : ""%>
					value=儿童>儿童</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("喜剧")? "checked='checked'" : ""%>
					value=喜剧>喜剧</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("犯罪")? "checked='checked'" : ""%>
					value=犯罪>犯罪</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("爱情")? "checked='checked'" : ""%>
					value=爱情>爱情</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("惊悚")? "checked='checked'" : ""%>
					value=惊悚>惊悚</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("战争")? "checked='checked'" : ""%>
					value=战争>战争</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("奇幻")? "checked='checked'" : ""%>
					value=奇幻>奇幻</label></li>
			<li><label><input name="type" type="checkbox"
					<%=isUpdate && r.getType().contains("恐怖")? "checked='checked'" : ""%>
					value=恐怖>恐怖</label></li>
		</ul>
		<br> <label>年份：</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<ul>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2010")? "checked='checked'" : ""%>
					value=2010>2010</label></li>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2011")? "checked='checked'" : ""%>
					value=2011>2011</label></li>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2012")? "checked='checked'" : ""%>
					value=2012>2012</label></li>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2013")? "checked='checked'" : ""%>
					value=2013>2013</label></li>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2014")? "checked='checked'" : ""%>
					value=2014>2014</label></li>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2015")? "checked='checked'" : ""%>
					value=2015>2015</label></li>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2016")? "checked='checked'" : ""%>
					value=2016>2016</label></li>
			<li><label><input name="year" type="radio"
					<%=isUpdate && r.getYear().contains("2017")? "checked='checked'" : ""%>
					value=2017>2017</label></li>
		</ul>
		<br> <label>地区：</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<ul>
			<li><label><input name="area" type="radio"
					<%=isUpdate && r.getYear().contains("大陆")? "checked='checked'" : ""%>
					value=大陆>大陆</label></li>
			<li><label><input name="area" type="radio"
					<%=isUpdate && r.getYear().contains("港台")? "checked='checked'" : ""%>
					value=港台>港台</label></li>
			<li><label><input name="area" type="radio"
					<%=isUpdate && r.getYear().contains("日韩")? "checked='checked'" : ""%>
					value=日韩>日韩</label></li>
			<li><label><input name="area" type="radio"
					<%=isUpdate && r.getYear().contains("欧美")? "checked='checked'" : ""%>
					value=欧美>欧美</label></li>
		</ul>
		<br> 描述：&nbsp;&nbsp;&nbsp;&nbsp;
		<textarea class="input" name="description"
			style="height: 100px; width: 300px; margin-bottom: 10px"><%=isUpdate ? r.getDescription() : ""%></textarea>
		<br> 图片：&nbsp;&nbsp;&nbsp;&nbsp; <input type="file"
			accept="image/*" name="image" size="40" style="margin-bottom: 10px"><br>

		<input type="hidden" name="id" value="<%=isUpdate ? r.getId() : ""%>">
		<input type="hidden" name="actionName" value="addResource"> <input
			type="submit" value="提交" style="width: 80px;">
	</form>


	<br>
	<iframe style="<%=updateStyle%>" id="id_iframe2" name="id_iframe2"
		width=300px height=50px> </iframe>

</body>
</html>