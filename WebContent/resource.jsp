
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.Vector"%>
<%@page import="com.example.bean.user"%>
<%@page import="com.example.bean.user_score"%>
<%@page import="com.example.dao.DeleteDao"%>
<%@page import="com.example.util.Util"%>
<%@page import="com.example.dao.SelectDao"%>
<%@page import="com.example.bean.resource"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理</title>
<script>parent.document.title=document.title</script>
<script src="js/jquery-1.12.2.min.js"></script>

<style type="text/css">
#form {
	font-size:20px;
}

.currentPage{
	font-weight:bold;
	color:#ff9a00;
}

.ortPage{
	font-weight:bold;
	color:#0000ff;
}

#jumpTo{
	width:20px;
}

table{ background-color:#aaa; line-height:25px;}
th{ background-color:#fff;}
td{ background-color:#fff; text-align:center}
    
    
    table{ 
table-layout:fixed; 
empty-cells:show; 
border-collapse: collapse; 
margin:0 auto; 
} 
td{ 
height:30px; 
} 
h1,h2,h3{ 
font-size:12px; 
margin:0; 
padding:0; 
} 
.table{ 
border:1px solid #cad9ea; 
color:#666; 
} 
.table th { 
background-repeat:repeat-x; 
height:30px; 
} 
.table td,.table th{ 
border:1px solid #cad9ea; 
padding:0 1em 0; 
} 
.table tr.alter{ 
background-color:#f5fafe; 
} 

</style>
<script>

function onUpdate(){
	var id = arguments[0];
	var form = document.forms[0];
	document.forms[0].elements[0].value = id;
	form.submit();
}

function onDelete(){
	var id = arguments[0];
	var form = document.forms[1];
	document.forms[1].elements[0].value = id;
	form.submit();
}

function jumpTo(maxPage){
	var page = $("#jumpTo").val();
	if(page > maxPage || page < 1){
		alert("对不起，无法到达该页");
	}else{
		var form = document.forms[2];
		document.forms[2].elements[0].value = page;
		form.submit();
	}
}

</script>
</head>
<body >

<form id="update" style="display:none;" name="update" method="get" action="resource_add.jsp"> 
	<input type="hidden" name="resourceId" value="resourceId">
	<input type="hidden" name="actionName" value="updateResource">
	<input type="submit" value="提交" style="width: 80px;"><br>
</form>

<form id="delete" style="display:none;" name="delete" method="get" action="resource.jsp"> 
	<input type="hidden" name="resourceId" value="resourceId">
	<input type="hidden" name="actionName" value="removeResource">
	<input type="submit" value="提交" style="width: 80px;"><br>
</form>




<%   //
	String actionName = request.getParameter("actionName");
	if(actionName != null){
		if(actionName.equals("removeResource")){
			String id = request.getParameter("resourceId");
			DeleteDao.removeResource(Integer.valueOf(id));

			ArrayList<user_score> l2 = SelectDao.getAllUserScore();
			for (user_score order : l2) {
				if(order.getResource_id().equals(id)){
					DeleteDao.removeObject(order);
				}
			}
		}
	}

	ArrayList<resource> resources = SelectDao.getAllResources();
	
	if(actionName != null && actionName.equals("searchResourceName")){//查询
		String key  = request.getParameter("key");
		List<resource> temp = new ArrayList<resource>();
		for(resource r : resources){
			if(r.getName().contains(key)){
				temp.add(r);
			}
		}
		resources.clear();
		resources.addAll(temp);
	}	
	
	
	class SortByScore implements Comparator<resource> {
		@Override
		public int compare(resource o1, resource o2){
			return Double.compare(o1.getScore(), o2.getScore());
		}
	}
	class SortByNumber implements Comparator<resource> {
		@Override
		public int compare(resource o1, resource o2){
			return o1.getNumber().compareTo(o2.getNumber());
		}
	}
	
	String order = request.getParameter("order");
	if(order != null){
		request.getSession().setAttribute("order", order);
	}
	
	Object orderSession = request.getSession().getAttribute("order");
	if(orderSession != null){
		if(orderSession.toString().equals("1")){
			Collections.sort(resources, new SortByScore());
			Collections.reverse(resources);
		}else if(orderSession.toString().equals("2")){
			Collections.sort(resources, new SortByNumber());
		}
	}
	
	
	ArrayList<resource> temp = new ArrayList<resource>();
	//总共的数量
	int total = resources.size();
	//每页显示几个
	int itemsPerPage = 5;
	
	//当前请求的页码
	int pageNum = request.getParameter("pageNum")==null ? 1 : Integer.parseInt(request.getParameter("pageNum"));
	//总共多少页
	int totalPage = total / itemsPerPage;
	if (total % itemsPerPage != 0) {
		totalPage += 1;
	}
	
	
	//上一页，下一页中间的数字
	Vector<Integer> pageArr = new Vector<Integer>();
	int start = 1;
	if (pageNum >= 10) {
		start = pageNum / 10 * 10;
	}
	int num = start;
	while (!(num > totalPage || num > start + 10)) {
		pageArr.add(new Integer(num));
		++num;
	}
	
	//将当前页需要显示的放到resources
	for(int i = (pageNum-1)*itemsPerPage;i < Math.min((pageNum)*itemsPerPage, resources.size());i++){
		temp.add(resources.get(i));
	}
	resources.clear(); 
	resources.addAll(temp);
	
	
	request.setAttribute("pageNum", pageNum);
	request.setAttribute("totalPage", totalPage);
	request.setAttribute("pageList", pageArr);
%>


按名称查询：<br><br>
<form id="cash" method="get" style="" onsubmit="return validate_form2(this)" action=""> 
	关键字：&nbsp;&nbsp;
	<input type="text" name="key" size="40" value=""><br>
	<input type="hidden" name="actionName" value="searchResourceName">
	<input type="submit" value="查询" style="width: 80px;">
</form>
<br><br>
	

<div style="text-align:center">
<a href="resource.jsp?order=1" class="sortPage">按评分排序</a>
<a href="resource.jsp?order=2" class="sortPage">按编号排序</a>
</div>


<table width='80%'  class="table" cellpadding='2px' cellspacing='2'>
	<tr>
	<th style="padding:2px;">图片</th> <th>编号</th> <th>名称</th> <th>类型</th> <th>年份</th> <th>地区</th>  <th>评分</th><th>选项</th> 
	</tr> 
	<%
		for (resource r : resources) {
			if(r.getUrl().startsWith("http")){
				
			}else{
				r.setUrl("image/" + r.getUrl());
			}
			String html = "";
			html += "<tr>";
			html += "<td width=100>" + "<img height='80' width='80' src='" + "" + r.getUrl() + "'/>" + "</td>";
			html += "<td>" + r.getNumber() + "</td>";
			html += "<td>" + r.getName() + "</td>";
			html += "<td>" + r.getType() + "</td>";
			html += "<td>" + r.getYear() + "</td>";
			html += "<td>" + r.getArea() + "</td>";
			//html += "<td>" + r.getDescription() + "</td>";
			html += "<td>" + r.getScore() + "</td>";
			html += "<td width=60>" + "<button onclick=\"onUpdate('" + r.getId() + "')\">修改</button>" + "<button onclick=\"onDelete('" + r.getId() + "')\">删除</button>" + "</td>";
			html += "</tr>\n";
			out.print(html);
		}
	%>
</table>



<br/>

<div id="pageControl" style="text-align: center">
	<!-- 上一页 按钮 -->
	<c:choose>
		<c:when test="${pageNum != 1}">
			<a href="resource.jsp?pageNum=${pageNum-1}">
				<input type="button"
					name="lastPage" value="上一页" />
			</a>
		</c:when>
		<c:otherwise>
			<input type="button" disabled="true" name="lastPage" value="上一页" />
			<!-- 为了要那个灰掉的button -->
		</c:otherwise>
	</c:choose>
	
	<!-- 页数列表 -->
	<c:forEach items="${pageList}" var="item">
		<c:choose>
			<c:when test="${item == pageNum}">
				<a href="resource.jsp?pageNum=${item}" class="currentPage">${item}</a>
			</c:when>
			<c:otherwise>
				<a href="resource.jsp?pageNum=${item}">${item}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 下一页 按钮 -->
	<c:choose>
		<c:when test="${pageNum != totalPage}">
			<a href="resource.jsp?pageNum=${pageNum+1}">
				<input type="button"
					name="nextPage" value="下一页" />
			</a>
		</c:when>
		<c:otherwise>
			<input type="button" disabled=true name="nextPage" value="下一页" />
			<!-- 为了要那个灰掉的button -->
		</c:otherwise>
	</c:choose>

	<!-- 直接跳转 -->
		共${totalPage}页 -向<input type="text" id="jumpTo" />页 <input
			type="button" value="跳转" onclick="jumpTo(${totalPage})" />
</div>


</body>
</html>