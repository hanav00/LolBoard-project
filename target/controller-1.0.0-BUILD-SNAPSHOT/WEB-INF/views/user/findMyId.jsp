<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/signup.css">
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<script>
function IDSearchCheck(){

	if($("#username").val() == "") { swal("Fill in"); $("#username").focus();  return false; }
	if($("#email").val() == '') { swal("Fill in"); $("#email").focus(); return false; }
	$("#IDSearchForm").attr("action", "/user/findMyId").submit();
}

function press() {
	
	if(event.keyCode == 13){ IDSearchCheck(); }
	
}

</script>
</head>
<body>

<br><br><br><br>
<form name="IDSearchForm" class="IDSearchForm" id="IDSearchForm" method="post">
		<div class="container" style="width:500px;"><br><br>
		<div class="login100-form-title p-b-26">
						Find My ID<br>
					</div><br>
		<div style="margin:0 50px;">
		<div class="wrap-input100 validate-input">
						<input class="input100" type="text" name="username" id="username" placeholder="NAME">
						<span class="focus-input100"></span>
		</div>
		<div class="wrap-input100 validate-input">
						<input class="input100" type="email" name="email" id="email" onkeydown="press(this.form)" placeholder="E-MAIL">
						<span class="focus-input100"></span>
		</div>
		
		<input type="button" value="FIND" id="btn_IDSearch" class="btn_IDSearch" onclick="IDSearchCheck()" style="background-color: #DFDFDF;"><br>
		</div>
		<p style="text-align:center"><a href="/">Login</a></p><br>
		<p style="text-align:center"><a href="/user/sign">Sign up</a></p><br>
		</div>
</form>

</body>
</html>