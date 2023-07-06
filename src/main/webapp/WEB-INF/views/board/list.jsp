<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOL Board</title>
<link rel="stylesheet" href="/resources/css/board.css">
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>cafe</title>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>
	
	//get cookie
	const getCookie = (name) => {
		const cookies = document.cookie.split(`; `).map((el) => el.split('='));
		let getItem = [];
		
		for (let i = 0; i < cookies.length; i++ ) {
			if (cookies[i][0] === name ) {
				getItem.push(cookies[i][1]);
				break;
			}
		}
		
		if (getItem.length > 0) {
			console.log(getItem[0]);
			return decodeURIComponent(getItem[0]);
		}

	}
	
	//logout
	function logout(){
		
		let authkey = getCookie('authkey');
		if (authkey !== undefined)
			document.cookie = 'authkey=' + authkey +'; path=/; max-age=0';
			
			event.preventDefault();
			Swal.fire({
				  title: 'Will you logout?',
				  text: "If you were auto-logged in, it will be turned off.",
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonText: 'Yes, I will',
				  cancelButtonText: 'No!',
				  reverseButtons: true
				}).then((result) => {
				  if (result.isConfirmed) {//event.preventDefault();
				    Swal.fire(
				      'Successfully logged out!',
				      'I will take you to the login page..',
				      'success'
				    ).then((result) => {
				    	 document.location.href='/user/logout';
				    }); 
				    
				  } else if (
				    result.dismiss === Swal.DismissReason.cancel
				  ) {
				    Swal.fire(
				      'Canceled',
				      'Play with us more!',
				      'error'
				    )
				  }
				})

	}
	
	//search keyword
	const search = () => {
		
		const keyword = document.querySelector('#keyword');
		document.location.href="/board/list?page=1&keyword=" + keyword.value;
		
	}
	
	
	//search - press enter
	const press = () => {
		if(event.keyCode==13)
			search();
	}
	

	</script>

</head>
<body bgcolor="#DFDFDF">
<%
	System.out.println("현재 session userid = " + session.getAttribute("userid"));
%>

	<div class="tableDiv">

		<br><br><br><br>
		<span class="login100-form-title p-b-26">
						<br>
						Welcome, ${username} :)<br>
					</span><br>
					
		<div class="search-container">
		<input type="text" name="keyword" id="keyword"
			style="width:600px; height:36px; border:none; color:black; font-size:16px; border-radius:5px; font-family:'Montserrat'" 
			placeholder="&nbsp;Enter the title, author name and content to search" onkeydown="press()">
		<button type="submit"><i class="fa fa-search" onclick="search()" ></i></button>
		</div>
		<br><br>		
					<div class="noUnderline">
				<label><span  style="padding:0 0 0 100px;" ><a href="/board/list?page=1" id="tab1">VIEW ALL</a></span></label>
				<label><span><a href="/board/write" id="tab2">WRITE</a></span></label>
				<label><span><a href="/user/mypage" id="tab3">MYPAGE</a></span></label><br>
			</div>
			

		
		<table class="InfoTable">
			<tr>
				<th style="width:60px;">NO.</th>
				<th >Title</th>
				<th style="width:150px;">writer</th>
				<th style="width:150px;">date</th>
				<th style="width:70px;">views</th>
			</tr>
			<tbody>
				<c:forEach items="${list}" var="list">
					<tr class="list" onmouseover="this.style.background='#ffe8fd';" onmouseout="this.style.background='white'">
						<td>${list.seq}</td>
						<td style="text-align:left"><a id="hypertext" 
							href="/board/view?seqno=${list.seqno}&page=${page}&keyword=${keyword}"
							onmouseover="this.style.textDecoration='underline'"
							onmouseout="this.style.textDecoration='none'">
							${list.title}</a></td>
						<td>${list.writer}</td>
						<td>${list.regdate}</td>
						<td>${list.hitno}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<div class="page">${pageList}</div>
		
		<c:if test="${userid == null}">
						<br>
						<a class="txt2" href="/">
							Login
						</a>
		</c:if>
		<c:if test="${userid != null}">
						<br>
						<a class="txt2" href="/user/logout" onclick="logout()">
							Logout
						</a>
						<c:if test="${role == 'MASTER'}">
						<br>
							<a class="txt2" href="/master/sysmanage">
								System Manage
							</a>
						</c:if>
		</c:if>

	</div><br><br>
</body>
</html>