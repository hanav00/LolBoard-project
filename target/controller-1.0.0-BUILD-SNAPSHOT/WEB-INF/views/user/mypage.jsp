<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/signup.css">
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/login_util.css">

<title>mypage</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>

	//if 30days passed..
	window.onload = () => {
		
		console.log('${passwordTime}');
		if ('${passwordTime}' > 29) {
			Swal.fire("Change Password");
		}
	}
	
	//change information
	function changeInfo() {
		
		document.location.href='/user/changeInfo'; 
		
	}
	
	//logout
	function logout() {
	
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
	
	//delete account
	function deleteAccount() {
	
			Swal.fire({
			  title: 'Are you sure?',
			  text: "You will not be able to recover your account :(",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonText: 'Yes, I am sure',
			  cancelButtonText: 'No, cancel!',
			  reverseButtons: true
			}).then((result) => {
			  if (result.isConfirmed) {
			    Swal.fire(
			      'Account Deleted :(',
			      'I will take you to the login page..',
			      'cancel'
			    ).then((result) => {
			    	document.location.href='/user/deleteAccount'; 
			    })
			  } else if (
			    result.dismiss === Swal.DismissReason.cancel
			  ) {
			    Swal.fire(
			      'Canceled',
			      'Your account is safe :)',
			      'success'
			    )
			  }
			})
	}

</script>

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

    <div class="main">

        <section class="signup">

            <div class="container">
             <span class="login100-form-title p-b-26" style="color:white; background: #a64bf4;
					  background: -webkit-linear-gradient(left, #fffbc9, #ff7321, #fd21d5, #b721ff);"><br>
						My Page
					</span>
                <div class="signup-content">
                    <form id="RegistryForm" class="RegistryForm">
                    
                     <div class="form-group" style="text-align:center;">
                                <label for="avatar">My Avatar</label>
                                <img src="/resources/images/avatar/${user.avatar}.png" style="height:200px; margin:auto;">
                            </div>
                           
                        <div class="form-row">
                            <div class="form-group">
                                <label for="userid">ID</label>
                                <span style="margin: 0px 20px;">${user.userid}</span>
                            </div>
                            <div class="form-group">
                                <label for="username">Name</label>
                                <span style="margin: 0px 20px;">${user.username}</span>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="birth_date">Birth date</label>
                                <span style="margin: 0px 20px;">${user.birthdate}</span>
                            </div>
                            <div class="form-row">
                            	<div class="form-group">
                                	<label for="gender">Gender</label>
                                    <span style="margin: 0px 20px;">${user.gender}</span>
                                </div>
                            </div>
                        </div>
                        
                        
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <span style="margin: 0px 20px;">${user.email}</span>
                                </div>

                                <div class="form-group">
                                    <label for="job">Job</label>
                                     <span style="margin: 0px 20px;">${user.job}</span>
								</div>
								<div class="form-group">
									<label for="description">Description</label>
										<div style="border:1px solid #BDBDBD; padding:5px; border-radius:5px; height:auto;">
                                			<div class="field" style="margin: 0px 20px;">${user.description}</div>
                            			</div>
								</div>
								

                 <div class="form-group">
                 			<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn" type="button" onclick="changeInfo()">
								Change my information
							</button>
						</div>
						</div>
                 
                    <div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn" type="button" onclick="location.href='/board/list?page=1'">
								Go back to board
							</button>
						</div>
						</div>
						
		

						<div class="text-center p-t-115">
						<span class="txt1">
							Want to Logout?
						</span>
						<a class="txt2" href="javascript:logout()">
							Logout
						</a><br>
					</div>
					
					<div class="text-center p-t-115">
						<span class="txt1">
							If you want to delete your account,
						</span>
						<a class="txt2" href="javascript:deleteAccount();" onclick="deleteAccount()">
							Click here ..
						</a><br>
					</div>
					
					</div>
					
                    </form>
                </div>
            </div>
        </section>

    </div>
    </c:if>
</body>
</html>