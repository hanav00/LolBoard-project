<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>LOL Board</title>
		<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/resources/css/login.css">
	<link rel="stylesheet" href="/resources/css/login_util.css">
<!--===============================================================================================-->
	<!-- JQuery -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
	<script>
	
	 window.onload = async function() {
		//쿠키값 가져오기
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
		
		let userid = getCookie("userid");
		let password = getCookie("password");
		let authkey = getCookie("authkey");
		
		
		//로그인 화면에서 userid 기억하기가 눌려져 있으면
		if(userid !== undefined || userid != null) {
			document.querySelector("#rememberUserid").checked = true;
			document.querySelector("#userid").value = userid;
		} else { //userid 쿠키가 없으면
			document.querySelector("#rememberUserid").checked = false;
		}
		
		//로그인 화면에서 password 기억하기가 눌려져 있으면
		if(userid !== undefined) {
			document.querySelector("#rememberPassword").checked = true;
			
			//Base64로 인코딩된 password를 디코딩
			const decrypt = CryptoJS.enc.Base64.parse(password);
			const hashData = decrypt.toString(CryptoJS.enc.Utf8);
			password = hashData;
			
			document.querySelector('#password').value = password;
		} else {
			document.querySelector("#rememberPassword").checked = false;
		}
		
		//로그인 화면에서 자동 로그인 처리
		if (authkey !== undefined) {
			
			let formData = new FormData();
			formData.append("authkey", authkey);
			
			//PASS: 이미 쿠키가 생성되어 있는 상태에서 로그인
			await fetch("/user/loginCheck?autologin=PASS", {
				method: "POST",
				body: formData
			}).then((response) => response.json())
			  .then((data) => {
				  console.log(data.message);
				  if(data.message == "good") {
					  document.location.href="/board/list?page=1";
				  } else {
					  alert("System Error2");
				  }
			  }).catch((error) => {
				  console.log("error", error);
			  });
		}
		
		
	}//end of window onload

	async function loginCheck2() {
		
		if (userid.value === '' || userid.value === null) {
			Swal.fire("Enter your ID");
			userid.focus();
			return false;
		}
		if (password.value === '' || password.value === null) {
			Swal.fire("Enter your Password");
			password.focus();
			return false;
		}
		
		let formData = new FormData();
		formData.append("userid", userid.value);
		formData.append("password", password.value);
		
		//NEW: 로그인하면서 쿠키 새로 생성
		//PASS: 이미 쿠키가 생성되어 있는 상태에서 로그인
		await fetch("/user/loginCheck?autologin=NEW", {
			method: "POST",
			body: formData
		}).then((response) => response.json())
		  .then((data) => {
			  if(data.message === "good") {
				  cookieManage(userid.value, password.value, data.authkey);
				  
				  Swal.fire(
						  "Logged in!",
						  "",
						  "success"
					).then((result) => {
						if(result){
							document.location.href="/board/list?page=1";
						}
					});
				  
			  } else if (data.message === "ID_NOT_FOUND") {
				  Swal.fire("ID not found");
			  } else if (data.message === "PASSWORD_NOT_FOUND") {
				  Swal.fire("Wrong Password");
			  } else {
				  Swal.fire("System Error");
			  }
		  }).catch((error) => {
			  console.log("error", error);
		  });
	}

	//Enter키 눌러도 실행되도록
	function press(){
		console.log("press");
		if(event.keyCode == 13){
			loginCheck2();}
		
	}
	
	//cookie 관리: cookie 생성, 삭제
	function cookieManage(userid, password, authkey) {
		
		//자동로그인 쿠키 관리
		if(rememberMe.checked)
			document.cookie = 'authkey=' + authkey + "; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT";
		else
			document.cookie = 'authkey=' + authkey + "; path=/ max-age=0"
			
		//userid 쿠키 관리
		if(rememberUserid.checked)
			document.cookie = 'userid=' + userid + "; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT";
		else
			document.cookie = 'userid=' + userid + "; path=/ max-age=0"
				
		//password 쿠키 관리
		const key = CryptoJS.enc.Utf8.parse(password);
		const base64 = CryptoJS.enc.Base64.stringify(key);
		password = base64;
		
		if(rememberPassword.checked)
			document.cookie = 'password=' + password + "; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT";
		else
			document.cookie = 'password=' + password + "; path=/ max-age=0"

	}

	</script>

</head>
<body bgcolor="#DFDFDF">
<script>
//자동 로그인 체크 관리
const checkRememberMe = () => {
	if(document.querySelector("#rememberMe").checked) {
		document.querySelector("#rememberUserid").checked = false;
		document.querySelector("#rememberPassword").checked = false;
	}
}

//자동 아이디 체크 관리
const checkRememberUserid = () => {
	if(document.querySelector("#rememberUserid").checked) {
		document.querySelector("#rememberMe").checked = false;
	}
}

//자동 비밀번호 체크 관리
const checkRememberPassword = () => {
	if(document.querySelector("#rememberPassword").checked) {
		document.querySelector("#rememberMe").checked = false;
	}
}
</script>
<%
	System.out.println("현재 session userid = " + session.getAttribute("userid"));
%>
<table border=0 width=100%>
<tr>
<td align=center>
  <div class="main" align="center">
  <div class="limiter">
  <div class="container-login100">
  <div class="wrap-login100">
  <form class="login100-form validate-form" name="loginForm" id="loginForm" method="POST">
  
  <span class="login100-form-title p-b-26">
						Welcome
					</span>
					<span class="login100-form-title p-b-48">
						<i class="zmdi zmdi-font"></i>
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Valid email is: a@b.c">
						<input class="input100" type="text" name="userid" id="userid">
						<span class="focus-input100" data-placeholder="ID"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<span class="btn-show-pass">
							<i class="zmdi zmdi-eye"></i>
						</span>
						<input class="input100" type="password" name="password" id="password" onkeydown="press(this.form)">
						<span class="focus-input100" data-placeholder="Password"></span>
					</div>


				<p id="msg" style="text-align:center;">

					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<input type="button" class="login100-form-btn" onclick="loginCheck2();" value="Login">
								
							
						</div>
					</div><br>
					
					<div class="remember" style="color:gray; text-align: left; margin:0 0 0 10px; font-size:15px;">
						<input type="checkbox" id="rememberUserid" onclick="checkRememberUserid()" >&nbsp;Remember ID<br>
						<input type="checkbox" id="rememberPassword" onclick="checkRememberPassword()">&nbsp;Remember Password<br>
						<input type="checkbox" id="rememberMe" onclick="checkRememberMe()">&nbsp;Remember Me
					</div>

					<div class="text-center p-t-115">
						<span class="txt1">
							Don’t have an account?
						</span>
						<a class="txt2" href="/user/sign">
							Sign Up
						</a><br>
						<span class="txt1">
							Fogot your ID?
						</span>

						<a class="txt2" href="/user/findMyId">
							Click here
						</a><br>
						<span class="txt1">
							Forgot your Password?
						</span>

						<a class="txt2" href="/user/findMyPassword">
							Click here
						</a><br>
						<span class="txt1">
							Go to board?
						</span>
						<a class="txt2" href="/board/list?page=1">
							Go!
						</a>
					</div>
  </form>
  </div>
  </div>
  </div>
  </div>
  </table>  
</body>
</html>
