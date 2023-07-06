<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>System Manage</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/master.css">

</head>
<body>

<%
	String role = (String)session.getAttribute("role");
%>

	<c:if test="${role != 'MASTER'}">
		<br><br><br><br>
		<div class="container" style="width:500px;margin:auto;"><br><br>
		<div class="login100-form-title p-b-26">
						NOT AUTHORIZED.<br>
					</div><br>
		<p style="text-align:center"><a href="/">Go back to first page</a></p><br>

		</div>
	</c:if>
	<c:if test="${role == 'MASTER'}">

	<div class="menubar">
		<ul class="main_menu">
			<li><a href="/board/list?page=1">Go back to list</a></li>
			<li><a href="/master/sysinfo">System Information</a></li>
			<li><a href="/master/filemanage">File Management</a></li>
			<li><a href="/master/boardmanage">Board Management</a></li>
			<li><a href="/master/membermanage">Member Information</a></li>
		</ul>
	</div>
</c:if>


</body>
</html>