<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Posting</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/signup.css">
<link rel="stylesheet" href="/resources/css/file.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<!-- JQuery -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>
	
	
	window.onload = () => {
		const fileZone = document.querySelector('#fileClick');
		const inputFile = document.querySelector('#inputFile');
		
		//fileClick을 클릭하면 ..
		fileZone.addEventListener('click', (e) => {
			inputFile.click(e);
		});
		
		//파일 탐색창을 열어 선택한 파일 정보를 files에 넣음
		inputFile.addEventListener('change', (e) => {
			const files = e.target.files;
			fileCheck(files);
		});
		
		/*마우스 이벤트 종류
		dragstart: 사용자가 객체를 드래그 할려고 시작할 떄 발생
		drag: 대상 객체를 드래그하면서 마우스를 움직일 떄 발생
		dragenter(*): 마우스가 대상 객체의 위로 처음 진입될 때 발생
		drageover(*): 드래그하면서 마우스가 대상 객체 영역 위에 자리잡고 있을 때 발생
		drop(*): 드래그가 끝나서 드래그 하던 객체를 놓는 장소에 위치한 객체에서 발생
		dragleave: 드래그가 끝나서 마우스가 객체 위에서 벗어날 때 발생
		drageend: 대상 객체를 드래그하다가 마우스 버튼을 놓는 순간 발생
		*/
		
		//fileZone으로 dragenter 이벤트 발생 시 처리하는 이벤트 핸들러
		fileZone.addEventListener('dragenter', (e) => {
			e.stopPropagation(); //웹 브라우저의 고유 동작을 중단함
			e.preventDefault(); //상위 엘레먼트들로의 이벤트 전파를 중단함
			fileZone.style.border = '2px solid gray';
		});
		
		//fileZone으로 dragover 이벤트 발생 시 처리하는 이벤트 핸들러
		fileZone.addEventListener('dragover', (e) => {
			e.stopPropagation();
			e.preventDefault();
		});
		
		//fileZone으로 drop 이벤트 발생 시 처리하는 이벤트 핸들러
		fileZone.addEventListener('drop', (e) => {
			e.stopPropagation();
			e.preventDefault();
			const files = e.dataTransfer.files;
			fileCheck(files);
		});
	}

	var uploadCountLimit = 5; // 업로드 가능한 파일 갯수
	var fileCount = 0; // 파일 현재 필드 숫자 totalCount랑 비교값
	var fileNum = 0; // 파일 고유넘버
	var content_files = new Array(); // 첨부파일 배열
	var rowCount=0;
	
	const fileCheck = (files) => {
		//배열로 변환
		var filesArr = Array.prototype.slice.call(files); 
		//let filesArr = Object.values(files); //ECMAScript 2017 ver.부터 제공
		
		 // 파일 개수 확인 및 제한
	    if (fileCount + filesArr.length > uploadCountLimit) {
	      	Swal.fire('Max '+uploadCountLimit+' files');
	      	return;
	    } else {
	    	 fileCount = fileCount + filesArr.length;
	    }
		
		filesArr.forEach((file) => {
			var reader = new FileReader();
			
			//file 읽기
			reader.readAsDataURL(file);
			
		      reader.onload = (e) => {
		        content_files.push(file);
		        console.log(file);
		        if(file.size > 1073741824) { Swal.fire('Max 1GB'); return; }
			
		    	rowCount++;
		        var row="odd";
		        if(rowCount %2 ==0) row ="even";
		        
		        let statusbar = document.createElement('div');
		        statusbar.setAttribute('class', 'statusbar ' + row); //<div class='statusbar odd'></div>
		        statusbar.setAttribute('id', 'file' + fileNum); //<div class='statusbar' id='file0'></div>
		       
		        let filename = "<div class='filename'>" + file.name + "</div>";
		        
		        let sizeStr = "";
		        let sizeKB = file.size/1024;
		        if(parseInt(sizeKB) > 1024){
		        	var sizeMB = sizeKB/1024;
		            sizeStr = sizeMB.toFixed(2)+" MB";
		        }else sizeStr = sizeKB.toFixed(2)+" KB";	        
		        
		        let size = "<span class='filesize'> (" + sizeStr + ") </span>";
		        let btn_delete = "<span class='btn_delete' onclick=fileDelete('file" + fileNum + "')>Delete</span></div>";
		       
		        statusbar.innerHTML = filename + size + btn_delete;
		        
		        fileUploadList.appendChild(statusbar);

		        fileNum ++;
		      };
	    });
		inputFile.value = "";                
	}

	//delete file
	const fileDelete = (fileNum) => {
		let no = fileNum.replace(/[^0-9]/g, "");
	    content_files[no].is_delete = true;
		document.querySelector('#' + fileNum).remove();
		fileCount --;
	}


	$(document).ready(function(){
		//cancel posting
		 $("#btn_writeCancel").on("click", function(){
				 Swal.fire({
					  title: 'Cancel Posting?',
					  text: "",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: 'Yes'
					}).then((result) => {
					  if (result.isConfirmed) {
					    Swal.fire(
					      'Canceled',
					      '',
					      'success'
					    ).then((result) => {
					    	document.location.href="/board/view?seqno=${view.seqno}&page=${page}&searchType=${searchType}&keyword=${keyword}";
					    })
					  }
					})
		 });	 
		})
	
		//register post
		const register = async() => {
			
			const title = document.querySelector("#title");
			const content = document.querySelector("#content");
			
			if(title.value == '') {Swal.fire("Write the title"); title.focus(); return false;}
			if(content.value == '') {Swal.fire("Write the content"); content.focus(); return false;}
			
			let uploadURL = '';
			
					
			if(content_files.length != 0)
				uploadURL = '/board/fileUpload?kind=I';
			else 			
				uploadURL = '/board/write';
				
			let wForm = document.getElementById('WriteForm');
		 	let formData = new FormData(wForm);
			for (let i = 0; i < content_files.length; i++) {
					if(!content_files[i].is_delete) {  
								
						formData.append("SendToFileList", content_files[i]);
					}
			}
		
			await fetch(uploadURL, {
				method: 'POST',
				body: formData
			}).then((response) => response.json())
			  .then((data) => {
				  if(data.message == 'good') {
					  Swal.fire(
							  "Posted!",
							  "",
							  "success"
						).then((result) => {
							if(result){
								document.location.href="/board/list?page=1";
							}
						});
				  }
			  }).catch((error) => {
				  Swal.fire("Server Error \n Can't upload your post to server");
				  console.log((error) => console.log("error", error));
			  })
		}
		
	</script>
	<style>
	
.filename{
  display:inline-block;
  vertical-align:top;
}

.filesize{
  display:inline-block;
  vertical-align:top;
  color:#30693D;
  width:100px;
  margin-left:10px;
  margin-right:5px;
}

.fileuploadForm {
 margin: 5px;
 padding: 5px 5px 2px 30px;
 text-align: left;
 width:90%;
 
}

.fileListForm {
  border-bottom: 2px solid #adadad;
  margin: 5px;
  padding: 3px 3px;
  
}

#fileClick {
  background-color: #e1e1e1;
  width: 565px;
  height:67px;
  color: #ababab;
  text-align: center;
  vertical-align: middle;
  padding: 5px;
  font-size:120%;
  border-radius: 5px;
  margin: 0 0 0 30px;
}

.btn_delete{
  background: linear-gradient(-68deg, #F68678, #F6C76E);
  -moz-border-radius:4px;
  -webkit-border-radius:4px;
  border-radius:4px;display:inline-block;
  color:#fff;
  font-weight:normal;
  padding:4px 15px;
  cursor:pointer;
  vertical-align:top;
  float: right;
}

.statusbar{
  min-height:25px;
  width:99%;
  padding:10px 10px 0px 10px;
  vertical-align:top;
}
.statusbar:nth-child(odd){
  background:#EBEFF0;
  margin: 0 0 0 35px;
  width: 550px;
  height: 50px;
}
.statusbar:nth-child(even){
  background:#EBEFF0;
  margin: 0 0 0 35px;
  width: 550px;
  height: 50px;
}

.progressBar {
  width: 200px;
  height: 22px;
  border: 1px solid #ddd;
  border-radius: 5px; 
  overflow: hidden;
  display:inline-block;
  margin:0px 10px 5px 5px;
  vertical-align:top;
  }
             
.progressBar div {
  height: 100%;
  color: #fff;
  text-align: right;
  line-height: 22px; 
  width: 0;
  background-color: #0ba1b5; border-radius: 3px; 
}

	</style>

</head>
<body bgcolor="#DFDFDF">

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

		<span class="login100-form-title p-b-26">
						Write
					</span><br>
	
	<div class="main" style=" display: flex; justify-content: center;">
		<div class="container" style="width:700px;margin: 0 auto 100px auto;">
		<br>
		<div class="WriteForm" style="width:80%; align:center;">
			<form id="WriteForm" name="WriteForm" method="POST">
			
			 <div class="form-group" style="margin: 0px 60px;" >
                            
                                <span><label for="writer">Writer</label></span>
                                <span><input type="text" style="align-text:center;" class="form-input" id="writer" name="writer" value='${username}' readonly></span>
                            </div>
              <div class="form-group" style="margin: 0px 60px;" >
                                <span><label for="title">Title</label></span>
                                <span><input type="text" class="input_field" id="title" name="title" placeholder="제목을 입력하세요"></span>
                            </div>
                        
				
				
				<input type="hidden" name="userid" value='${userid}'>
				<div class="form-group" style="margin: 0px 60px;" >
									<label for="content">Content</label>
									<textarea id="content" cols="54" rows="19" name="content" placeholder="Introduce yourself."
										style="font-family:'Montserrat';font-size:18px; padding: 10px;box-sizing: border-box;border: solid 2px #ebebeb;border-radius: 5px;resize: none;"
										></textarea><br>
								</div>
								
				<!-- file upload -->
				
				<div class="form-group" style="width:80%;">
						<div class="fileuploadForm">
							<input type="file" id="inputFile" name="uploadFile" style="display:none;" multiple />
							<div id="fileClick">Click or drag to upload files<br>(Max 5)</div>
					  		<div id="fileUploadList"></div>
						</div>
				</div>
				
				


</form>
				


			<!-- 등록/ 취소 버튼 -->
			        <div class="form-group">
			             <div class="form-row">
		                    <div class="container-login100-form-btn" style="margin: 0px 0px 0 400px;">
								<div class="wrap-login100-form-btn">
									<div class="login100-form-bgbtn"></div>
									<input type="button" class="login100-form-btn" onclick="return register()" value="SUBMIT">

								
							</div>
							</div>
						<div class="form-row">
		                    <div class="container-login100-form-btn" style="margin: 0px 60px;" >
								<div class="wrap-login100-form-btn">
									<div class="login100-form-bgbtn"></div>
									<input type="button" class="login100-form-btn" id="btn_writeCancel" value="CANCEL">

								</div>
							</div>
						</div>
					</div>
		
			</div>
		</div>
	</div><br><br>
</div>
</c:if>
</body>
</html>