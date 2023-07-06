<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


</head>
<body bgcolor="#DFDFDF">
<script> 
	var message = '${message}'; 
	var url = '${url}';  
	alert(message); 
	document.location.href = url; 
</script>
</body>
</html>