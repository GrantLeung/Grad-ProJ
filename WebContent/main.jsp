<%@ page import="java.sql.*" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
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
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>首页</title>
<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript">
// Executes the function when DOM will be loaded fully
$(document).ready(function () {	
	// hover property will help us set the events for mouse enter and mouse leave
	$('.navigation li').hover(
		// When mouse enters the .navigation element
		function () {
			//Fade in the navigation submenu
			$('ul', this).fadeIn(); 	// fadeIn will show the sub cat menu
		}, 
		// When mouse leaves the .navigation element
		function () {
			//Fade out the navigation submenu
			$('ul', this).fadeOut();	 // fadeOut will hide the sub cat menu		
		}
	);
});
	</script>

<style type="text/css">
	body{ 
	    background: url(image/bg.gif);
		text-align:center;
		font-family: Arial, Helvetica,sans-serif; 
		font-size:15px;
	}
	.navigation  {
		margin:0; 
		padding:0; 
		list-style:none;	
		margin-bottom:10px;
		
	}	
	.navigation  li {
		float:left;			/* Show list items inline */
		width:150px; 
		position:relative; 
	}
	.navigation  li a {
		background:#262626; 
		color:#fff;
		display:block;  	/* Making sure a element covers whole li area */
		padding:8px 7px 8px 7px; 
		text-decoration:none; /* No underline */
		border-top:1px solid #F2861D;
		text-align:center; 
		text-transform:uppercase;
	}

	.navigation  li a:hover {
		color:#F2861D;
	}
		
	/* Sub Cat Menu stuff*/
	.navigation  ul {
		position:absolute; 
		left:0; 
		display:none; /* Hide it by default */
		margin:0 0 0 -1px; 
		padding:0; 
		list-style:none;
		border-bottom:3px solid #F2861D;
	}
		
	.navigation  ul li {
		width:150px; 
		float:left; 
		border-top:none;
	}
		
	/* Sub Cat menu link properties */
	.navigation  ul a {
		display:block;    	/* Making sure a element covers whole li area */
		height:15px;
		padding:8px 7px 13px 7px; 
		color:#fff;
		text-decoration:none;	
		border-top:none;
		border-bottom:1px dashed #6B6B6B;
	}
		
	.navigation  ul a:hover {
		color:#F2861D;
	}
	
	
	#bar{
		margin:0 auto;   
     	width:1000px;   
     	height:30px;  
     	background:#dddddd;
     	color:#F2861D;
     	padding-left:50px;
     	position: relative;
     	margin-bottom:10px;
	}
	#bar ul{
		padding:5px;
		display: block;
		margin: 0 auto;
		position: relative;
	}
	#bar li{
		float:left; 
		list-style:none;
		margin-right:40px
	}
	
	#frameright ul{
		padding:5px;
		display: block;
		margin: 0 auto;
		list-style:none;
		position: relative;
	}
	
	#frameright i{
		height:25px;
		font-size:23px;
		margin-bottom:5px;
	}
	
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

table{ 
table-layout:fixed; 
empty-cells:show; 
border-collapse: collapse; 
margin:0 auto; 
} 

td{ 
height:30px; 
} 

.table{ 
border:1px solid #cad9ea; 
color:#666; 
} 

.table td,.table th{ 
border:1px solid #cad9ea; 
padding:0 1em 0; 
} 
.table tr.alter{ 
background-color:#f5fafe; 
} 
	
	.block{
		width:200px;
		height:290px;
		margin:0;
	}
	.movie_image{
		width:200px;
		height:240px;
		margin:0;
	}
	.movie_title{
		font-size:18px;
		margin:0;
		margin-right:10px;
		color:#888277;
	}
	.movie_score{
		font-size:18px;
		color:#FFF68F;
		margin:0;
	}
	
	
#frame{ margin:0 auto;width:1024px;height:100%} 
#frameleft{ float:left; width:800px; height:100%;} 
#frameright{ margin-left:20px;margin-right:20px;float:left; width:200px;height:100%;background:#FAFAD2;} 

a:link {  color: #000000; text-decoration: none}
a:visited {  color: #000000; text-decoration: none}
a:hover {  color: #000000; text-decoration: none}

</style>

</head>

<body>   
    <div id="title">   
        <header class="zzsc-header bgcolor-11">
		<h1>主页</h1>
	</header>
    </div>   

	<%
		String userId = null;
		String userName = "";
		HttpSession session2 = request.getSession();
		if(session2!=null){
			userId = request.getSession().getAttribute("userId").toString();
		}
		if(userId != null){
			user u = SelectDao.findUser(Integer.valueOf(userId));
			userName = u.getUser_name();
		}
	%>
	<p>当前用户：<%=userName %></p>
	
<div id="bar">
<form action="main.jsp" accept-charset="utf-8" method="get" >
		<ul>
		<li><a href="">按名称搜索:</a></li>
		<li><input type=text placeholder="关键字" name="key" ize=30 /></li>
		<li><input type="submit" value="搜索" style="width: 80px;"></li>
		</ul>
		</form>
</div>	

<div style="width:650px; margin:0 auto">

<ul class="navigation">
			<li><a href="main.jsp?type=推荐">推荐电影</a></li>
			<li><a href="main.jsp">所有类型</a>
			<ul>
			<li><a href="main.jsp?c=类型&type=爱情">爱情</a></li>
			<li><a href="main.jsp?c=类型&type=喜剧">喜剧</a></li>
			<li><a href="main.jsp?c=类型&type=剧情">剧情</a></li>
			<li><a href="main.jsp?c=类型&type=动画">动画</a></li>
			<li><a href="main.jsp?c=类型&type=科幻">科幻</a></li>
			<li><a href="main.jsp?c=类型&type=动作">动作</a></li>
			<li><a href="main.jsp?c=类型&type=经典">经典</a></li>
			<li><a href="main.jsp?c=类型&type=悬疑">悬疑</a></li>
			<li><a href="main.jsp?c=类型&type=青春">青春</a></li>
			<li><a href="main.jsp?c=类型&type=犯罪">犯罪</a></li>
			<li><a href="main.jsp?c=类型&type=惊悚">惊悚</a></li>
			<li><a href="main.jsp?c=类型&type=文艺">文艺</a></li>
			<li><a href="main.jsp?c=类型&type=搞笑">搞笑</a></li>
			<li><a href="main.jsp?c=类型&type=纪录片">纪录片</a></li>
			<li><a href="main.jsp?c=类型&type=励志">励志</a></li>
			<li><a href="main.jsp?c=类型&type=恐怖">恐怖</a></li>
			<li><a href="main.jsp?c=类型&type=战争">战争</a></li>
			<li><a href="main.jsp?c=类型&type=短片">短片</a></li>
			<li><a href="main.jsp?c=类型&type=黑色幽默">黑色幽默</a></li>
			<li><a href="main.jsp?c=类型&type=魔幻">魔幻</a></li>
			</ul>
			<div class="clear"></div>
			</li>
			
		 
	 
		
			<li></li>
			<li><a href="main.jsp">所有年份</a>
			<ul>
			<li><a href="main.jsp?c=年份&type=2018">2018</a></li>
			<li><a href="main.jsp?c=年份&type=2017">2017</a></li>
			<li><a href="main.jsp?c=年份&type=2016">2016</a></li>
			<li><a href="main.jsp?c=年份&type=2015">2015</a></li>
			<li><a href="main.jsp?c=年份&type=2014">2014</a></li>
			<li><a href="main.jsp?c=年份&type=2013">2013</a></li>
			<li><a href="main.jsp?c=年份&type=2012">2012</a></li>
			<li><a href="main.jsp?c=年份&type=2011">2011</a></li>
			<li><a href="main.jsp?c=年份&type=2010">2010</a></li>
			<li><a href="main.jsp?c=年份&type=2009">2009</a></li>
			<li><a href="main.jsp?c=年份&type=2008">2008</a></li>
			<li><a href="main.jsp?c=年份&type=2007">2007</a></li>
			<li><a href="main.jsp?c=年份&type=2006">2006</a></li>
			<li><a href="main.jsp?c=年份&type=2005">2005</a></li>
			<li><a href="main.jsp?c=年份&type=2004">2004</a></li>
			<li><a href="main.jsp?c=年份&type=2003">2003</a></li>
			<li><a href="main.jsp?c=年份&type=2002">2002</a></li>
			<li><a href="main.jsp?c=年份&type=2001">2001</a></li>
			</ul>
			<div class="clear"></div>
		</li>
		 
		 
	
		
			<li></li>
			<li><a href="main.jsp">所有地区</a>
			<ul>
			<li><a href="main.jsp?c=地区&type=美国">美国</a></li><!-- 大陆 -->
			<li><a href="main.jsp?c=地区&type=日本">日本</a></li><!-- 港台 -->
			<li><a href="main.jsp?c=地区&type=香港">香港</a></li><!-- 日韩 -->
			<li><a href="main.jsp?c=地区&type=英国">英国</a></li><!-- 欧美 -->
			<li><a href="main.jsp?c=地区&type=中国">中国</a></li>
			<li><a href="main.jsp?c=地区&type=韩国">韩国</a></li>
			<li><a href="main.jsp?c=地区&type=法国">法国</a></li>
			<li><a href="main.jsp?c=地区&type=台湾">台湾</a></li>
			<li><a href="main.jsp?c=地区&type=中国大陆">中国大陆</a></li>
			<li><a href="main.jsp?c=地区&type=德国">德国</a></li>
			<li><a href="main.jsp?c=地区&type=意大利">意大利</a></li>
			<li><a href="main.jsp?c=地区&type=印度">印度</a></li>
			<li><a href="main.jsp?c=地区&type=泰国">泰国</a></li>
			<li><a href="main.jsp?c=地区&type=西班牙">西班牙</a></li>
			<li><a href="main.jsp?c=地区&type=加拿大">加拿大</a></li>
		</ul>
		<div class="clear"></div>
		</li>
</ul>

<div class="clear"></div>
</div>

<%  //
	String type = request.getParameter("type"); 
	String ctype = request.getParameter("c");
	
	ArrayList<resource> resources = SelectDao.getAllResources();
	
	if(type != null){
		if(type.equals("推荐")){//获取推荐列表
			if(userId == null){
				out.println("请登录后查看推荐列表");	
			}else{
				String path = request.getSession().getServletContext().getRealPath("") + "relation.txt"; 
				resources = SelectDao.getPreferResources(Integer.valueOf(userId),path);
			}
		}else{//根据类别,地区，年份，显示
			List<resource> temp = new ArrayList<resource>();
			for(resource r : resources){
				if(ctype.equals("类型")){
					if(r.getType().contains(type)){
						temp.add(r);
					}
				}
				if(ctype.equals("地区")){
					if(r.getArea().contains(type)){
						temp.add(r);
					}
				}
				if(ctype.equals("年份")){
					if(r.getYear().contains(type)){
						temp.add(r);
					}
				}

			}
			resources.clear();
			resources.addAll(temp);
		}
	}
	
	String key = request.getParameter("key");
	if(key != null){
		List<resource> temp = new ArrayList<resource>();
		for(resource r : resources){
			if(r.getName().contains(key)){
				temp.add(r);
			}
		}
		resources.clear();
		resources.addAll(temp);
	}
	
	String user = request.getParameter("user");
	if(user != null){
		List<resource> temp = new ArrayList<resource>();
		temp = SelectDao.getSelectedResources(Integer.valueOf(user));
		resources.clear();
		resources.addAll(temp);
	}
	
	class SortByScore implements Comparator<resource> {
		@Override
		public int compare(resource o1, resource o2){
			return Double.compare(o1.getScore(), o2.getScore());
		}
	}

	//按评分排序
	Collections.sort(resources, new SortByScore());
	Collections.reverse(resources);

	
	List<List<resource>> tableData = new ArrayList<>();
	int col = 3;//每行显示4个。
	int row = resources.size() / col + (resources.size()%col==0?0:1);
	for(int r=0;r<row;r++){
		List<resource> rowData = new ArrayList<>();
		for(int c=0;c< col;c++){
			int k = r*col+c;//Math.min(resources.size()%col,col)
			if(k<resources.size()){
				rowData.add(resources.get(k));
			}
		}
		tableData.add(rowData);
	}
%>


<div id="frame" style="float:inherit"> 
<div id="frameleft">



<table width='800px'  class="table" cellpadding='2px' cellspacing='2'>
	<!-- 
	<tr>
		<td>
			<div class="block">	<a href="resource_single.jsp?id=1"> <img class="movie_image" src="image/default.jpg" /> </a> <br/>
			<span class="movie_title">标题</span> <span class="movie_score">0.0</span></div>
		</td>
	</tr> 
	 -->
	<%
		for(List<resource> rowData:tableData){
			String html = "";
			html += "<tr>";
			for(resource r:rowData){
				html += "<td>";
				
				if(r.getUrl().startsWith("http")){
					html += "<div class='block'> <a href='resource_single.jsp?id=" + r.getId() + "'> <img class='movie_image' src='" + r.getUrl() + "'/>  </a> <br/>\n";
				}else{
					html += "<div class='block'> <a href='resource_single.jsp?id=" + r.getId() + "'> <img class='movie_image' src='image/" + r.getUrl() + "'/>  </a> <br/>\n";
				}
				html += "<span class='movie_title'>" + r.getName() + "</span> <span class='movie_score'>" + r.getScore() + "</span></div>\n";
				
				html += "</td>\n";
			}
			html += "</tr>";
			out.print(html);
		}
	%>
</table>

</div>
</div> 
<div id="frameright">

	<H3>我的最近邻居</H3>
	<ul>
	<%
		if(userId != null){
			List<user> neighbors = SelectDao.getNeighbors(Integer.valueOf(userId));
			for (user u : neighbors) {
				if(u.getId().equals(Integer.valueOf(userId))){
					continue;
				}
			if(u.getId()!=0)//最近邻居显示的时候不显示管理员admin
				{
				   String html = "<li><a href=\"main.jsp?user=" + "" + u.getId() + "\">" + u.getUser_name() + "</a></li>";
				   out.println(html);
				}
			}
		}
	%>
	</ul>
</div> 





<br/>
<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/main.js"></script> <!-- Resource jQuery -->
<script src = "js/modernizr.js"></script>
<div id="pageControl" style="text-align: center; position:fixed;bottom:0;left:1% "class = "cd-form floating-labels">
				<h5><a href="index.jsp">退出登录</a></h5>
</div>
</body>

</html>