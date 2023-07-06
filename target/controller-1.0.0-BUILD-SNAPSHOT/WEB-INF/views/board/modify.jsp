<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Post</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/signup.css">
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
	      	swal('Max '+uploadCountLimit+' files');
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
		        if(file.size > 1073741824) { swal('Max 1GB'); return; }
			
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
	
	//file delete
	const fileDelete = (fileNum) => {
		let no = fileNum.replace(/[^0-9]/g, "");
	    content_files[no].is_delete = true;
		document.querySelector('#' + fileNum).remove();
		fileCount --;
	}
		
	//modify cancel button
		$(document).ready(function(){
		 $("#btn_modifyCancel").on("click", function(){
				 Swal.fire({
					  title: 'Cancel Modifying?',
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
	
		//modify button
		function modify(){

			const title = document.querySelector("#title");
			const content = document.querySelector("#content");
			
			if(title.value == '') {swal("Write the title"); title.focus(); return false;}
			if(content.value == '') {swal("Write the content"); content.focus(); return false;}
			
		
			let mForm = document.getElementById('ModifyForm');	
		 	let formData = new FormData(mForm);
			for (var x = 0; x < content_files.length; x++) {
					if(!content_files[x].is_delete) { 
								
						formData.append("SendToFileList", content_files[x]);
					}
			}
		
			let uploadURL = '';
			
			if(content_files.length != 0)
				uploadURL = '/board/fileUpload?kind=U';
			else 			
				uploadURL = '/board/modify';
			
			formData.append("seqno",${view.seqno});
		     
			$.ajax({
		        url: uploadURL,
		        type: "POST",
		        contentType:false,
		        processData: false,
		        cache: false,
		        enctype: "multipart/form-data",
		        data: formData,
		        xhr:function(){
		        	var xhr = $.ajaxSettings.xhr();
		        	xhr.upload.onprogress = function(e){
		        		var per = e.loaded * 100/e.total;
		        		setProgress(per);
		        	};
		        	return xhr;        	
		        },
		        success: function(data){
		        	 Swal.fire(
							  "Successfully Modified!",
							  "",
							  "success"
						).then((result) => {
							if(result){
								document.location.href="/board/view?seqno=${view.seqno}&page=${page}&searchType=${searchType}&keyword=${keyword}";
							}
						});
		        },
		        error: function (xhr, status, error) {
		       	    	swal("Server Error");
		       	     return false;
		       	}   
		       
		    }); 
	
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

	<c:if test="${(userid == null)||(userid != view.userid)}">
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
	<c:if test="${userid == view.userid}">
		<br><br><br><br>
		<span class="login100-form-title p-b-26">
						Modify
					</span><br>
	
	<div class="main" style=" display: flex; justify-content: center;">
		<div class="container" style="width:700px;margin: 0 auto;">
		<br>
		<div class="ModifyForm" style="width:80%; align:center;">
			<form id="ModifyForm" name="ModifyForm" method="POST">
			
			 <div class="form-group" style="margin: 0px 60px;" >
                            
                                <span><label for="writer">Writer</label></span>
                                <span><input type="text" style="align-text:center;" class="form-input" id="writer" name="writer" value='${view.writer}' readonly></span>
                            </div>
              <div class="form-group" style="margin: 0px 60px;" >
                                <span><label for="title">Title</label></span>
                                <span><input type="text" class="input_field" id="title" name="title" value='${view.title}'></span>
                            </div>
                        </div>
				
				<input type="hidden" name="seqno" value="${view.seqno}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="userid" value='${userid}'>
				<input type="hidden" name="keyword" value='${keyword}'>
				<div class="form-group" style="margin: 0px 60px;" >
									<label for="content">Content</label>
									<textarea id="content" cols="54" rows="17" name="content"
										style="font-family:'Montserrat';font-size: 18px; padding: 10px;box-sizing: border-box;border: solid 2px #ebebeb;border-radius: 5px;resize: none;"
										> ${view.content}</textarea><br>
								</div>
								
							<c:if test="${fileListView != null }">
					         	<div id="fileListForm"><p style="text-align:left; margin-left: 55px;font-family:'Montserrat';">Check files you want to delete</p></div>
					         	<div id="fileList">	
					         		<p style="text-align:left; margin-left: 50px;font-family:'Montserrat';font-weight:light;">
					        	 		<c:forEach items="${fileListView}" var="file" >
					         				&nbsp<input type="checkbox" name="deleteFileList" value="${file.fileseqno}"> 
					         				 ${file.org_filename}&nbsp( ${file.filesize} Byte)<br>
					         			</c:forEach>
					         		</p><br>
					         	</div>       
        					</c:if>
        					
        		<!-- file upload -->
				
				<div class="form-group" style="width:80%;">
						<div class="fileuploadForm">
							<input type="file" id="inputFile" name="uploadFile" style="display:none;" multiple />
							<div id="fileClick">Click or drag to upload files<br>(Max 5)</div>
					  		<div id="fileUploadList"></div>
						</div>
				</div>
			</form>

			        <div class="form-group">
			             <div class="form-row">
		                    <div class="container-login100-form-btn" style="margin: 0px 0px 0 400px;">
								<div class="wrap-login100-form-btn">
									<div class="login100-form-bgbtn"></div>
									<input type="button" class="login100-form-btn" id="btn_modify" onclick="modify()" value="SUBMIT">

								
							</div>
							</div>
						<div class="form-row">
		                    <div class="container-login100-form-btn" style="margin: 0px 60px;" >
								<div class="wrap-login100-form-btn">
									<div class="login100-form-bgbtn"></div>
									<input type="button" class="login100-form-btn" id="btn_modifyCancel" value="CANCEL">

								</div>
							</div>
						</div>
					</div>
			</div>

	</div>
	</div><br><br><br><br>

	</c:if>
</body>
</html>