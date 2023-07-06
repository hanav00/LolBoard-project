<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Information</title>
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
	
	
	<div class="devInfo" align="center" style="margin: 300px 0 0 0;">
			There are ${count} members now<br>
			<table class="InfoTable">
			<tr>
				<th>ID</th>
				<th >Name</th>
				<th>gender</th>
				<th>email</th>
				<th>job</th>
				<th>birthdate</th>
				<th>country</th>
				<th>avatar</th>
				
			</tr>
			<tbody>
				<c:forEach items="${member}" var="member">
					<tr>
						<td>${member.userid}</td>
						<td>${member.username}</td>
						<td>${member.gender}</td>
						<td>${member.email}</td>
						<td>${member.job}</td>
						<td>${member.birthdate}</td>
						<td>${member.country}</td>
						<td>${member.avatar}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</div>
</c:if>
</body>
</html>