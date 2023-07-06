<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>패스워드 찾기</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/signup.css">
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<script>
function pwSearchCheck(){

	if($("#userid").val() == "") { swal("Fill in"); $("#userid").focus();  return false; }
	if($("#username").val() == '') { swal("Fill in"); $("#username").focus(); return false; }
	$("#pwSearchForm").attr("action", "/user/findMyPassword").submit();
}

function press() {
	
	if(event.keyCode == 13){ pwSearchCheck(); }
	
}

</script>

</head>

<body>

<br><br><br><br>
 
	<form name="pwSearchForm" class="pwSearchForm" id="pwSearchForm" method="post">
    

     	<div class="pwSearchFormDivision">
        
        <div class="container" style="width:500px;"><br><br>
		<div class="login100-form-title p-b-26">
						Reset My Password<br>
					</div><br>
		<div style="margin:0 50px;">
		<div class="wrap-input100 validate-input">
						<input class="input100" type="text" name="userid" id="userid" placeholder="ID">
						<span class="focus-input100"></span>
		</div>
		<div class="wrap-input100 validate-input">
						<input class="input100" type="text" name="username" id="username" onkeydown="press(this.form)" placeholder="NAME">
						<span class="focus-input100"></span>
		</div>
		
		<input type="button" value="RESET" id="btn_pwSearch" class="btn_pwSearch" onclick="pwSearchCheck()" style="background-color: #DFDFDF;"><br>
		</div>
		<p style="text-align:center"><a href="/">Login</a></p><br>
		</div>
		</div>
	</form>

</body>
</html>