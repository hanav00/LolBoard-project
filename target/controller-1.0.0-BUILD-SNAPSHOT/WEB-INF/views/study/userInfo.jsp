<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/board.css">
<title>마이페이지</title>
</head>
<body bgcolor="#DFDFDF">

	<div>
		<img id="topBanner" src="/resources/images/logo.jpg">	
	</div>
	
	<div class="main">
		<h1>회원 정보 보기</h1><br>
		
		<div class="boardView">
			<div class="field">아이디 : ${user.userid}</div>
			<div class="field">이름 : ${user.username}</div>
			<div class="field">e-mail : ${user.email}</div>
			<div class="field">성별 : ${user.gender}</div>
			<div class="field">직업 : ${user.job}</div>
			<div class="field">취미 : ${user.hobby}</div>
			<div class="content">${user.description}</div>
		</div>
	</div>

</body>
</html>