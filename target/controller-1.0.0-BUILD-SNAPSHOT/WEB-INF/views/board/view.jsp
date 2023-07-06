<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Posts</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/signup.css">
<link rel="stylesheet" href="/resources/css/like.css">

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
	<!-- JQuery -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>

	var likeCnt; 
	var myLikeCheck; 
	var username;
	
	window.onload = () => {
		
		//send post seqno to get like, replyList data
		var queryString = { "seqno": "${view.seqno}" };
		$.ajax({
			url : "reply?option=L",
			type : "post",
			datatype : "json",
			data : queryString,
			success : replyList,
			error : function(data) {
							swal("Server Error");
	              	    	return false;
					}
		});
		
		
		
		likeCnt = ${view.likecnt}; 
		myLikeCheck = '${myLikeCheck}'; 
		username = '${username}';
		console.log(myLikeCheck);
		$("#like").html(likeCnt); //like 개수가 현재 몇 개인지 보여줌(LIKE0)
		
		if (myLikeCheck == "Y") { //좋아요 상태
			$(".likeClick").addClass('clicked');
			$("#myChoice").html("You liked the post!"); 
		}
		else {
			$(".likeClick").css("backgroundColor", "#00ffff");
		}
		console.log("likeCnt", likeCnt);
	} //end of window.onload
	
	
	//buttons
		$(document).ready(function(){
			
			//modify
			$("#btn_modify").click(function(){
				document.location.href="/board/modify?seqno=${view.seqno}&page=${page}&keyword=${keyword}";
			})
			
			//delete
			$("#btn_delete").click(function(){
				
				Swal.fire({
					  title: 'Are you sure?',
					  text: "You will not be able to recover your post and files :(",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonText: 'Yes, I am sure',
					  cancelButtonText: 'No, cancel!',
					  reverseButtons: true
					}).then((result) => {
					  if (result.isConfirmed) {
					    Swal.fire(
					      'Post Deleted',
					      '',
					      'success'
					    ).then((result) => {
					    	document.location.href='/board/delete?seqno=${view.seqno}'; 
					    })
					  } else if (
					    result.dismiss === Swal.DismissReason.cancel
					  ) {
					    Swal.fire(
					      'Canceled',
					      'Your Post is safe :)',
					      'error'
					    )
					  }
					})
			})
			
			//list
			$("#btn_list").click(function(){
				document.location.href="/board/list?page=${page}&keyword=${keyword}";
			})
		}); //end of ready function
		
		
		//reply register
		function replyRegister() { //form 데이터 전송 --> 반드시 serialize()를 해야 한다.

			if($("#replyContent").val() == "") {swal("Write your comment"); $("#replyContent").focus(); return false;}
			
			var queryString = $("form[name=replyForm]").serialize(); //serialize --> 데이터를 String으로 보내기 위한 타입으로 바꾸는 함수, 제이쿼리에서는 비동기로 보내려면 이걸 반드시 해줘야함
			$.ajax({
				url : "reply?option=I",
				type : "post",
				datatype : "json",
				data : queryString,
				success : replyList,
				error : function(data) {
							swal("Server Error");
		              	    return false;
				}
			});
			$("#replyContent").val("");
		}

		//reply List data
		function replyList(data){
			var session_userid = '${userid}';
			const jsonInfo = data;
			
			let replyList = document.querySelector('#replyList')
			
			var result = "";
			for(const i in jsonInfo){

				result += "<div id='replyListView'>";
				result += "<div id = '" + jsonInfo[i].replySeqno + "' style='font-size: 15px; font-family:'Montserrat';>";
				result +=  "<img src='/resources/images/avatar/" +jsonInfo[i].avatar+ ".png' style='height:50px;'>&nbsp;";
				result +=  jsonInfo[i].replyWriter+ "&nbsp;";
								
				if(jsonInfo[i].userid == session_userid) {
					result += "&nbsp;[<a href=" + "'javascript:replyModify(" + jsonInfo[i].replySeqno + ")' style='cursor:pointer;'> modify </a> | " ;
					result += "<a href=" + "'javascript:replyDelete(" + jsonInfo[i].replySeqno + ")' style='cursor:pointer;'> delete </a>]&nbsp;" ;
				}
				
				result += "&nbsp;&nbsp;" + jsonInfo[i].replyRegdate
				result += "<div style='width:90%; height: auto; border-top: 2px solid #DEDEDE; border-radius:1px; overflow: hidden;'>";
				result += "<pre style='font-size: 15px; font-family:Montserrat; color:#494949' class='" + jsonInfo[i].replySeqno + "'>" + jsonInfo[i].replyContent + "</pre></div>";
				result += "</div>";
				result += "</div><br>";
			}
			$("#replyListView").remove();
			$("#replyList").html(result);
		}

		//show replyList when this page is loaded
		function startupPage(){
			
			var queryString = { "seqno": "${view.seqno}" };
			$.ajax({
				url : "reply?option=L",
				type : "post",
				datatype : "json",
				data : queryString,
				success : replyList,
				error : function(data) {
								swal("Server Error");
		              	    	return false;
						}
			});
		}
		
		//reply delete button
		function replyDelete(replySeqno) { 
			var rseqno = replySeqno
					Swal.fire({
						  title: 'Delete this comment?',
						  text: "",
						  icon: 'warning',
						  showCancelButton: true,
						  confirmButtonColor: '#3085d6',
						  cancelButtonColor: '#d33',
						  confirmButtonText: 'Yes'
						}).then((result) => {
						  if (result.isConfirmed) {
						    Swal.fire(
						      'Deleted',
						      '',
						      'success'
						    ).then((result) => {
								
									var queryString = { "replySeqno": replySeqno, "seqno":${view.seqno} };
									$.ajax({
										url : "reply?option=D",
										type : "post",
										data : queryString,
										dataType : "json",
										success : replyList,
										error : function(data) {
													swal("Server Error \n Please try later");
								            		return false;
										}
									});
								
						    })
						  }
						})
		}
		
		//reply modify click
		function replyModify(replySeqno) {
		
			var session_username = '${username}';
			var session_userid = '${userid}';
			var replyContent = $("." + replySeqno).html();
			
			var strReplyList = "<form id='formModify' name='formModify' method='POST'>"
							+ "${session_username}&nbsp;"
							+ "<input type='hidden' name='replySeqno' value='" + replySeqno + "'>"
							+ "<input type='hidden' name='seqno' value='${view.seqno}'>"
							+ "<input type='hidden' id='writer' name='replyWriter' value='${session_username}'>"
							+ "<input type='hidden' id='userid' name='userid' value='${session_userid}'><br>"
							+ "<textarea id='replyContent' name='replyContent' cols='80' rows='5' maxlength='150' style='font-family:Montserrat;font-size:18px; padding: 10px;box-sizing: border-box;border: solid 2px #ebebeb;border-radius: 5px;resize: none;'>" + replyContent + "</textarea><br>"
							+ "<input type='button' id='btn_replyModify' style='background-color: #DEDEDE;' value='SUBMIT'>"
							+ "<input type='button' id='btn_replyModifyCancel' style='background-color: #CDCDCD;' value='CANCEL'>"
							+ "</form>";
			$('#' + replySeqno).after(strReplyList);				
			$('#' + replySeqno).remove();
		
			
			//submit reply modify
			$("#btn_replyModify").on("click", function(){
				var queryString = $("form[name=formModify]").serialize();
				$.ajax({
					url : "reply?option=U",
					type : "post",
					dataType : "json",
					data : queryString,
					success : replyList,
					error : function(data) {
									swal("Server Error");
			              	    	return false;
					}
				});
			 }); 
			
			//submit reply modify cancel
			 $("#btn_replyModifyCancel").on("click", function(){
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
						    	$("#replyListView").remove(); startupPage();
						    })
						  }
						})
			 });	 
		}

		//click like
		function likeClick(){ 
			$(".likeClick").toggleClass('clicked');
			if (myLikeCheck == "N") { //버튼을 누르지 않은 상태에서 좋아요 => 좋아요
				$("#myChoice").html("You liked the post!"); 
				myLikeCheck = "Y";
				likeCnt ++;
				console.log("likeCnt", likeCnt);
				sendDataToServer(myLikeCheck,likeCnt);
			}
			else { //버튼을 이미 눌렀던 상태에서 좋아요 => 좋아요 취소
				$("#myChoice").html("");
				myLikeCheck = "N";
				likeCnt --;
				console.log("likeCnt", likeCnt);
				sendDataToServer(myLikeCheck,likeCnt);
			}
		}
		

		function sendDataToServer(myLike, likeCnt) {

		    var myLikeCheck = myLike;
		    console.log(likeCnt + myLikeCheck + "${userid}"+${view.seqno});
		    var queryString = {"seqno":${view.seqno},"userid":"${userid}",
		    		"mylikecheck":myLikeCheck};
		    
		    $.ajax({ //JSON --> MAP 타입일 경우 contentType를 반드시 입력...
		        url: "/board/likeCheck",
		        method: "POST",
		        data: JSON.stringify(queryString),
		        contentType: 'application/json; charset=UTF-8',
		        dataType : "json",
		        success: function(map) {
		            $("#like").html(likeCnt);
		        },
		        error: function(map) {
					swal("Server Error");
		  	    	return false;
				}
		    }); //End of ajax
		}
		
</script>
	


</head>
<body style="background-color:#DFDFDF;">
<script>
	startupPage();
</script>
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

		 <div class="RegistryForm" style=" height:800px; background-color:#DFDFDF;">
	<div class="main" style=" display: flex; justify-content: center;">
		<div class="container" style="width:700px;margin: 0 auto 100px auto; overflow-x:hidden;">
		<br>
		<div class="boardView" style="align:center;"><br>

		            <span class="login100-form-title p-b-26" style="vertical-align: middle;">
						${view.title}
					</span><br>
		 <div class="form-group" style="margin: 0px 60px;" >
		 <img src="/resources/images/avatar/${view.avatar}.png" style="height:80px;">

                                <span><label for="writer">Writer</label></span>
                                <span class="field" style="margin: 0px 20px;">${view.writer}</span>
          </div>

                       
              		 <div class="form-group" style="margin: 0px 60px;" >
                            
                                <span><label for="regdate">date</label></span>
                                <span class="field" style="margin: 0px 20px;">${view.regdate}</span>
                            </div>
                    		 <div class="form-group" style="margin: 0px 60px;" >
                            	
                                <label for="content">Content</label>
                                <div style="border:1px solid #BDBDBD; padding:5px; border-radius:5px; height:400px; width:570px;">
                                <div class="field" style="margin: 0px 20px;">${view.content}</div>
                            	</div>
                            </div>
				 </div>
				
				<input type="hidden" name="userid" value='${userid}'>

			<!-- file -->
			<c:if test="${fileListView != null}">
	        	<c:forEach items="${fileListView}" var="fileView">
					<div class="filename" style="margin: 0px 80px; color:gray;">Uploaded file : <a href="/board/fileDownload?fileseqno=${fileView.fileseqno}">${fileView.org_filename}</a> ( ${fileView.filesize} Byte )</div>
				</c:forEach>
			</c:if>
			<c:if test="${fileListView == null}">
				<div class="filename" style="margin: 0px 80px; color:gray;">No uploaded file</div>
			</c:if>
			
			
			<div style="width:50%;margin:auto;">
			
			<!-- session의 userid와 작성자의 userid가 다르면 수정/삭제 버튼이 보이지 않도록 설정 -->
			<c:if test="${userid != view.userid}">
<br>
				<div class="form-group">
                    <div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn" id="btn_list">
								Go back to list
							</button>
						</div>
						</div>
					</div>

			</c:if>
			<c:if test="${userid == view.userid}">

					<div class="form-group">
			             <div class="form-row">
		                    <div class="container-login100-form-btn" style="margin: 0px 0px 0 220px;">
								<div class="wrap-login100-form-btn">
									<div class="login100-form-bgbtn"></div>
									<button class="login100-form-btn" id="btn_modify">
										Modify
									</button>
								</div>
							</div>

						<div class="form-row">
		                    <div class="container-login100-form-btn" style="margin: 0px 60px;" >
								<div class="wrap-login100-form-btn">
									<div class="login100-form-bgbtn"></div>
									<button class="login100-form-btn" id="btn_delete">
										Delete
									</button>
								</div>
							</div>
						</div>
					</div>
					</div>
<br>
				<div class="form-group">
                    <div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn" id="btn_list">
								Go back to list
							</button>
						</div>
						</div>
					</div>
			</c:if>
			
			
			<!-- 이전글 다음글 -->
			</div>
							<div class="form-group">
					<c:if test="${pre_seqno != 0}">
						<span class="txt1" style="margin: 0px 0 0 50px;">
							<a href="/board/view?seqno=${pre_seqno}&page=${page}&keyword=${keyword}">◀before</a>
						</span>
					</c:if>
					<c:if test="${next_seqno != 0}">
						<span class="txt1" style="margin: 0px 0px 0 480px ;">
							<a href="/board/view?seqno=${next_seqno}&page=${page}&keyword=${keyword}">after▶</a>
						</span>
					</c:if>

				</div>
				
				
				
				
				<!-- 좋아요 -->
				<div class="form-group" style="width:100%;">
				<label for="like" style="text-align:center; color: gray;">Click heart if you liked the post!</label>
					
					<div class="likeForm" onclick="return likeClick();" style="width:fit-content; margin:auto;">
					<a href="javascript:likeClick()" class="likeClick" id="likeClick">
						<!-- <button class="likeClick" id="likeClick" style="margin:0 0 0 330px;"> -->
						  <div class="like-wrapper">
						    <div class="ripple"></div>
						    <svg class="heart" width="24" height="24" viewBox="0 0 24 24">
						      <path d="M12,21.35L10.55,20.03C5.4,15.36 2,12.27 2,8.5C2,5.41 4.42,3 7.5,3C9.24,3 10.91,3.81 12,5.08C13.09,3.81 14.76,3 16.5,3C19.58,3 22,5.41 22,8.5C22,12.27 18.6,15.36 13.45,20.03L12,21.35Z"></path>
						    </svg>
						    <div class="particles" style="--total-particles: 6">
						      <div class="particle" style="--i: 1; --color: #7642F0"></div>
						      <div class="particle" style="--i: 2; --color: #AFD27F"></div>
						      <div class="particle" style="--i: 3; --color: #DE8F4F"></div>
						      <div class="particle" style="--i: 4; --color: #D0516B"></div>
						      <div class="particle" style="--i: 5; --color: #5686F2"></div>
						      <div class="particle" style="--i: 6; --color: #D53EF3"></div>
						    </div>
						  </div>
						<!-- </button> -->
						</a>
					<label id='myChoice' style='color:gray; font-size:10px; height:30px;'></label>
					<label for="like" style="text-align:center;">Liked <span id='like'></span></label>
				</div>
				</div>
			<br>

				
				<!-- 댓글 --> 
				<form id="replyForm" name="replyForm" method="POST">
								<div class="form-group" style="margin: 0px 60px;" >
									<label for="content">Leave Comments</label>
								    	<input type="hidden" name="seqno" value="${view.seqno}">
								    	<input type="hidden" name="replyWriter" value="${username}">
								    	<input type="hidden" name="userid" value="${userid}">
								    	<input type="hidden" name="avatar" value="${avatar}">
									<textarea id="replyContent" cols="55" rows="3" name="replyContent" placeholder="Write your opinions."
										style="font-family:'Montserrat';font-size:18px; padding: 10px;box-sizing: border-box;border: solid 2px #ebebeb;border-radius: 5px;resize: none;"
										></textarea><br>
									
								</div>
								</form>
						<div class="container-login100-form-btn" style="margin: 0px 50px 0 500px;">
								<div class="wrap-login100-form-btn">
									<div class="login100-form-bgbtn"></div>
										<button class="login100-form-btn" id="btn_reply" onclick="replyRegister()">
											Sumbit
										</button>
								</div>
						</div><br><br>
					
							
							    <div class="form-group" style="margin: 0px 60px;" >
							   
                            		<div id="replyList" style="width:100%; height:600px; overflow:hidden; margin:0 0 0 20px; ">
									</div> 
                          
                            </div>
                            	

			</div>
		</div>
	</div><br><br>
	</c:if>

</body>
</html>