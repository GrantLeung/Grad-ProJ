<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<select onchange="checkRadio(this.value)">
    <option value="">请选择</option>
    <script>for (i = 1; i <= 10; i++) document.write('<option value="' + i + '">' + i + '</option>');</script>
</select>
<input type="radio" name="level" />方法一 <input type="radio" name="level" />方法二 <input type="radio" name="level" />方法三
<div id="div3" style="display:none">div3</div>
<script >
    function checkRadio(v) {
        v = parseInt(v) || 0;
        var levels = document.getElementsByName('level');
        if (v == 0) levels[0].checked = levels[1].checked = levels[2].checked = false;
        else if (v <= 3) levels[0].checked = true;
        else if (v <= 6) levels[1].checked = true;
        else levels[2].checked = true;
    }
</script>
</body>
</html>