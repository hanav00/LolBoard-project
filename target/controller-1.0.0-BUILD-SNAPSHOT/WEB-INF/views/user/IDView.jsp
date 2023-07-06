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
<script>
	$(document).ready(function(){
		$("#btn_goHome").on("click", function(){
			location.href="/"	
		})
	})
</script>
</head>
<body>

	

  
  
<br><br><br><br>

		<div class="container" style="width:500px;"><br><br>
		<div class="login100-form-title p-b-26">
		<div id="IDSearchResult">
						Find My ID<br>
						</div>
					</div><br>
		<div style="font-size:20px; text-align:center;">

						My ID is..<br><br><br>${userid}<br><br>

		
		</div>
		<p style="text-align:center"><a href="/">Login</a></p><br><br>
		</div>

</body>
</html>