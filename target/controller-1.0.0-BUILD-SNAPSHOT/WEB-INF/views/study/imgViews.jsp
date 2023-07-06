<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 미리 보기</title>
</head>
<body>

	<script>
		
		const previewFiles = () => {
			
			const preview = document.querySelector('#preview');
			const files = document.querySelector('input[type=file]').files;
			
			const readAndPreview = (file) => {
				
				//정규식
				if(/\.(jpe?g|png|gif)$/i.test(file.name)) {
					
					const reader = new FileReader();
					
					reader.addEventListener('load', function(){
						
						let image = new Image();
						image.height = 100;
						image.title = file.name;
						image.src = this.result;
						preview.appendChild(image);
						
					});
					
					reader.readAsDataURL(file); //바이너리 파일용, text파일은 따로 있음
					
				}
			}
			
			if(files) //유사배열
			//정식 배열: let a = [1, 2, 3, 4] 또는 let a = new Array();
			//정식 배열은 배열 객체에서 제공하는 메소드를 사용할 수 있는 반면, 유사 배열은 사용하지 못함.
			//아래는 유사 배열도 배열 객체에서 지원하는 메소드를 사용할 수 있도록 해주는 방법 []--> Array.prototype
				[].forEach.call(files, readAndPreview);
		}
	</script>

	<input type="file" id="browse" onchange="previewFiles()" multiple><br>
	<div id="preview">
	
	</div>

</body>
</html>