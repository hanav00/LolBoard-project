<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 예제</title>

<script>
	function FileUpload(){
		document.FileForm.action='/board/fileUpload';
		document.FileForm.submit();
	}
	
	
</script>
</head>
<body>

	<form name="FileForm" method="POST" enctype="multipart/form-data">
		화가: <input type="text" name="painter">
		<input type="file" name="fileUpload" multiple><br>
		<input type="button" onclick="FileUpload()" value="파일전송">
	</form>

</body>
</html>