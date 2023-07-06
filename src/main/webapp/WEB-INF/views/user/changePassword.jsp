<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
async function changePassword(){
	if($("#old_password") == '') { Swal.fire("Enter your password"); $("#old_password").focus(); return false; }
  	var Pass = $("#password").val();
	var Pass1 = $("#password1").val();
	if(Pass == '') { Swal.fire("Enter your new password"); $("#password").focus(); return false; }
	if(Pass1 == '') { Swal.fire("Enter your new password"); $("#password1").focus(); return false; }
	if(Pass != Pass1) 
		{ Swal.fire("Enter your new password correctly"); $("#password1").focus(); return false; }
	
	// 암호유효성 검사
	var num = Pass.search(/[0-9]/g); // /검사영역/태크 -> 0부터 9까지의 숫자가 들어가있는지 검색, 검색이 안되면 -1 리턴
 	var eng = Pass.search(/[a-z]/ig); //(i:알파벳 대소문자 구분없이)a부터 z까지 영문자가 들어가있는지 검색, 검색이 안되면 -1 리턴
 	var spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	
	if(Pass.length < 8 || Pass.length > 20) { Swal.fire("Password should be 8 to 20 letters"); return false; }
	else if(Pass.search(/\s/) != -1){ Swal.fire("Password should NOT include space"); return false; }
	else if(num < 0 || eng < 0 || spe < 0 ){ Swal.fire("Password should include letters, numbers and special character"); return false; }
	
	let wForm = document.getElementById('PasswordForm');
 	let formData = new FormData(wForm);

	await fetch("/user/changePassword", {
		method: 'POST',
		body: formData
	}).then((response) => response.text())
	  .then((data) => {
		  if(data == 'good') {
			  Swal.fire(
					  "Successfully changed!",
					  "Please login again with your new password",
					  "success"
				).then((result) => {
					if(result){
						document.location.href="/user/logout";
					}
				});
		  }
		  else {
			  Swal.fire("Wrong password");
			  return false;
		  }
	  }).catch((error) => {
		  Swal.fire("Server Error \n Can't upload your post to server");
		  console.log((error) => console.log("error", error));
	  })
}
</script>


</head>
<body>


<%
	String userid = (String)session.getAttribute("userid");
%>

	<c:if test="${userid == null}">
		<br><br><br><br>
		<div class="container" style="width:500px;"><br><br>
		<div class="login100-form-title p-b-26">
						NOT AUTHORIZED.<br>PLEASE LOG IN
					</div><br>
		<input type="button" value="Go back" onclick="history.back()" style="background-color: #DFDFDF;"><br>
		
		<p style="text-align:center"><a href="/">Login</a></p><br>
		<p style="text-align:center"><a href="/user/sign">Sign up</a></p><br>
		</div>
	</c:if>
	<c:if test="${userid != null}">


<br><br><br><br>
<form name="PasswordForm" id="PasswordForm" method="post">
		<div class="container" style="width:500px;"><br><br>
		<div class="login100-form-title p-b-26">
						Change Password<br>
					</div><br>
		<div style="margin:0 50px;">
		<p style="text-align:center">${passwordTime} days have passed since you changed your password.<br>You should change your password after 30 days!</p>
							<br><br>
							<div class="form-group">
								<input type="password" id="old_password" name="old_password" class="old_password" placeholder="Current Password">
	        					<span style="color:red;text-align:center;"></span>
	        					
							</div>
							
                            <div class="form-group">
                                <label for="password">New Password</label>
                                <input type="password" class="form-input" name="password" id="password" placeholder="combination of 8~20 letters, numbers and special character"/>
                            </div>
                            <div class="form-group">
                                <label for="password1">Repeat your new password</label>
                                <input type="password" class="form-input" name="password1" id="password1" placeholder="Repeat your password"/>
                            </div>
		
		<input type="button" value="Change" id="btn_IDSearch" class="btn_IDSearch" onclick="changePassword()" style="background-color: #DFDFDF;"><br>
		<input type="button" value="Cancel" onclick="history.back()" style="background-color: #DFDFDF;"><br>

</form>
</c:if>

</body>
</html>