<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

	<script>
		//cookie 만드는법
		window.onload = () => {
			
			document.cookie = "userid=" + encodeURIComponent("minie2000") + "; path=/; expires=Sun, 31 Dec 2024 23:59:59 GMT";
			//한글은 오류가 날 수도 있기 때문에 이스케이프 처리를 해줘야함
			document.cookie = "username=" + encodeURIComponent("김민영") + "; path=/; expires=Sun, 31 Dec 2024 23:59:59 GMT";
		}
	
	</script>

<meta charset="UTF-8">
<title>로그안</title>
</head>
<body>

<%
	String userid = (String)session.getAttribute("userid");
	if(!userid.equals("minie2000"))
		response.sendRedirect("/user/sign.jsp");
%>

	<script>
	//cookie
	const getCookie = (name) => {
		
		const cookies = document.cookie.split('; ').map((el) => el.split('='));
		let getItem = []; //Array.prototype을 의미함 --> 배열이 됨
		
		for(let i=0; i<cookies.length; i++) {
			
			if(cookies[i][0] === name){
				getItem.push(cookies[i][1]);
				break;
			}
		}
		
		if(getItem.length > 0)
			return decodeURIComponent(getItem[0]);
	}

	const getCookieName = () => {
		
		const userid = getCookie("userid");
		const username = getCookie("username");
		
		document.querySelector("#userid").innerHTML = userid;
		document.querySelector("#username").innerHTML = username;
		
	}
	
	//로그아웃할 때 쿠키를 삭제한다
	const deleteCookie = () => {
		
		document.cookie = 'userid=minie2000; path=/; max-age=0';
		document.cookie = 'username=' + encodeURIComponent("김민영") + '; path=/; max-age=0';
	
		document.querySelector("#userid").innerHTML = '';
		document.querySelector("#username").innerHTML = '';
	}
	
	</script>


	<!-- session 가져오는 법 (Client) -->
	<h1>세션 userid = ${userid}</h1>
	<h1>세션 username = ${username}</h1>

	<!-- cookie 화면에 뿌리기 -->
	<input type="button" value="쿠키 가져오기" onclick="getCookieName()"><br>
	<div style="font-size: 50px">쿠키 userid = <span id="userid"></span></div>
	<div style="font-size: 50px">쿠키 username = <span id="username"></span></div>
	<input type="button" value="쿠키 삭제하기" onclick="deleteCookie()"><br>
	
</body>
</html>