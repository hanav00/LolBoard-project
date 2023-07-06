<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change my Info</title>

<!-- <link rel="stylesheet" href="/resources/css/board.css"> -->
<link rel="stylesheet" href="/resources/css/signup.css">
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/login_util.css">
<link rel="stylesheet" href="/resources/css/radio.css">
<link rel="stylesheet" href="/resources/css/modal.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
	window.onload = () => {
		console.log("avatar=" + ${user.avatar}.value);
	}

	//change avatar at modal
	const changeAvatar = () => {
		let avatar = document.querySelector('input[name="avatar"]:checked').value;
		console.log(${avatar}.value);
		document.ChangeAvatarForm.action='/user/changeAvatar';
		document.ChangeAvatarForm.submit();
	}


	//change information
	const changeInfo = async () => {
		

		const email = document.querySelector("#email");
		if(email.value == '') {Swal.fire("Enter your email"); email.focus(); return false;}
		
		const job = document.querySelector("#job");
		if(job.value == '') {Swal.fire("Enter your job"); job.focus(); return false;}
		
		const birthdate = document.querySelector("#birthdate");
		if(birthdate.value == '') {Swal.fire("Enter your birthdate"); birthdate.focus(); return false;}
		
		//birthdate validation
		console.log(birthdate.value);
		var birthDate = birthdate.value;
		var validation = /^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/
		     var date= new Date();
		        if (!validation.test(birthDate)) {
		            Swal.fire("Date of Birth is Invalid! it should in YYYY-MM-DD");
		            return false;
		        }
		        else if(birthDate >date.getFullYear()){
		            Swal.fire("Invaid Date");
		            return false;
		        }

		let ChangeInfoForm = document.getElementById("ChangeInfoForm");
		let formData = new FormData(ChangeInfoForm);
		
		await fetch('/user/changeInfo', {
			method: "POST",
			body: formData
		}).then((response) => response.text())
		  .then((data) => {
			  if(data === "good") {
				  	Swal.fire(
						  "Successfully Changed!",
						  "",
						  "success"
					).then((result) => {
						if(result){
							document.location.href="/user/mypage";
						}
					});
			  }
		  }).catch((error) => {
			  Swal.fire(
					  "Server Error",
					  "Please try later",
					  "error"
					  );
			  console.log((error) => console.log("error", error));
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

		

            <div class="container">
             <span class="login100-form-title p-b-26" style="color:white; background: #a64bf4;
					  background: -webkit-linear-gradient(left, #fffbc9, #ff7321, #fd21d5, #b721ff);"><br>
						 Change My Information
					</span>
                <div class="signup-content">
                    
                    <form method="POST" id="ChangeAvatarForm" name="ChangeAvatarForm">
                    <div class="form-group" style="margin:auto; text-align:center;">
                                <label for="avatar" style="margin-left:-170px;">My Avatar</label>
                                
                                <img src="/resources/images/avatar/${user.avatar}.png" style="height:200px; margin:auto;">
                                <span id="currentAvatar" ></span>
                                
                                <label class="btn_avatar" for="modal-1">Change Avatar</label>
              					<input class="modal-state" id="modal-1" type="checkbox" style="display: none;"/>
									
									
									<!-- start of modal -->
									<div class="modal">
									  <label class="modal__bg" for="modal-1"></label>
									  <div class="modal__inner">
									    <label class="modal__close" for="modal-1"></label>
         
                                    <label for="avatar">Choose your avatar</label>

										<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="aatrox" value="aatrox">
													<label class="for-checkbox-tools" for="aatrox">
														<i class='uil uil-line-alt'></i>
														Aatrox
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="ahri" value="ahri">
													<label class="for-checkbox-tools" for="ahri">
														<i class='uil uil-vector-square'></i>
														Ahri
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="akali" value="akali">
													<label class="for-checkbox-tools" for="akali">
														<i class='uil uil-ruler'></i>
														Akali
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="brand" value="brand">
													<label class="for-checkbox-tools" for="brand">
														<i class='uil uil-crop-alt'></i>
														Brand
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="caitlyn" value="caitlyn">
													<label class="for-checkbox-tools" for="caitlyn">
														<i class='uil uil-brush-alt'></i>
														Caitlyn
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="diana" value="diana">
													<label class="for-checkbox-tools" for="diana">
														<i class='uil uil-image-resize-landscape'></i>
														Diana
													</label>
												</div>
											</div>
											</div>
											
										<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="ekko" value="ekko">
													<label class="for-checkbox-tools" for="ekko">
														<i class='uil uil-line-alt'></i>
														Ekko
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="evelynn" value="evelynn">
													<label class="for-checkbox-tools" for="evelynn">
														<i class='uil uil-vector-square'></i>
														Evelynn
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="ezreal" value="ezreal">
													<label class="for-checkbox-tools" for="ezreal">
														<i class='uil uil-ruler'></i>
														Ezreal
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="fiora" value="fiora">
													<label class="for-checkbox-tools" for="fiora">
														<i class='uil uil-crop-alt'></i>
														Fiora
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="fizz" value="fizz">
													<label class="for-checkbox-tools" for="fizz">
														<i class='uil uil-brush-alt'></i>
														Fizz
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="garen" value="garen">
													<label class="for-checkbox-tools" for="garen">
														<i class='uil uil-image-resize-landscape'></i>
														Garen
													</label>
												</div>
											</div>
											</div>
											
										<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="gwen" value="gwen">
													<label class="for-checkbox-tools" for="gwen">
														<i class='uil uil-line-alt'></i>
														Gwen
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="irelia" value="irelia">
													<label class="for-checkbox-tools" for="irelia">
														<i class='uil uil-vector-square'></i>
														Irelia
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="janna" value="janna">
													<label class="for-checkbox-tools" for="janna">
														<i class='uil uil-ruler'></i>
														Janna
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="jinx" value="jinx">
													<label class="for-checkbox-tools" for="jinx">
														<i class='uil uil-crop-alt'></i>
														Jinx
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="kaisa" value="kaisa">
													<label class="for-checkbox-tools" for="kaisa">
														<i class='uil uil-brush-alt'></i>
														Kaisa
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="katarina" value="katarina">
													<label class="for-checkbox-tools" for="katarina">
														<i class='uil uil-image-resize-landscape'></i>
														Katarina
													</label>
												</div>
											</div>
											</div>
											
										<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="kayn" value="kayn">
													<label class="for-checkbox-tools" for="kayn">
														<i class='uil uil-line-alt'></i>
														Kayn
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="ksante" value="ksante">
													<label class="for-checkbox-tools" for="ksante">
														<i class='uil uil-vector-square'></i>
														Ksante
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="leana" value="leana">
													<label class="for-checkbox-tools" for="leana">
														<i class='uil uil-ruler'></i>
														Leana
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="leblanc" value="leblanc">
													<label class="for-checkbox-tools" for="leblanc">
														<i class='uil uil-crop-alt'></i>
														Leblanc
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="leesin" value="leesin">
													<label class="for-checkbox-tools" for="leesin">
														<i class='uil uil-brush-alt'></i>
														Leesin
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="lissandra" value="lissandra">
													<label class="for-checkbox-tools" for="lissandra">
														<i class='uil uil-image-resize-landscape'></i>
														Lissandra
													</label>
												</div>
											</div>
											</div>
											
										<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="lucian" value="lucian">
													<label class="for-checkbox-tools" for="lucian">
														<i class='uil uil-line-alt'></i>
														Lucian
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="lulu" value="lulu">
													<label class="for-checkbox-tools" for="lulu">
														<i class='uil uil-vector-square'></i>
														Lulu
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="lux" value="lux">
													<label class="for-checkbox-tools" for="lux">
														<i class='uil uil-ruler'></i>
														Lux
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="malphite" value="malphite">
													<label class="for-checkbox-tools" for="malphite">
														<i class='uil uil-crop-alt'></i>
														Malphite
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="masteryi" value="masteryi">
													<label class="for-checkbox-tools" for="masteryi">
														<i class='uil uil-brush-alt'></i>
														Master Yi
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="missfortune" value="missfortune">
													<label class="for-checkbox-tools" for="missfortune">
														<i class='uil uil-image-resize-landscape'></i>
														Miss Fortune
													</label>
												</div>
											</div>
											</div>
											
										<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="nami" value="nami">
													<label class="for-checkbox-tools" for="nami">
														<i class='uil uil-line-alt'></i>
														Nami
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="neeko" value="neeko">
													<label class="for-checkbox-tools" for="neeko">
														<i class='uil uil-vector-square'></i>
														Neeko
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="pantheon" value="pantheon">
													<label class="for-checkbox-tools" for="pantheon">
														<i class='uil uil-ruler'></i>
														Pantheon
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="qiyana" value="qiyana">
													<label class="for-checkbox-tools" for="qiyana">
														<i class='uil uil-crop-alt'></i>
														Qiyana
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="riven" value="riven">
													<label class="for-checkbox-tools" for="riven">
														<i class='uil uil-brush-alt'></i>
														Riven
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="senna" value="senna">
													<label class="for-checkbox-tools" for="senna">
														<i class='uil uil-image-resize-landscape'></i>
														Senna
													</label>
												</div>
											</div>
											</div>
											
											<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="seraphine" value="seraphine">
													<label class="for-checkbox-tools" for="seraphine">
														<i class='uil uil-line-alt'></i>
														Seraphine
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="sett" value="sett">
													<label class="for-checkbox-tools" for="sett">
														<i class='uil uil-vector-square'></i>
														Sett
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="sivir" value="sivir">
													<label class="for-checkbox-tools" for="sivir">
														<i class='uil uil-ruler'></i>
														Sivir
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="soraka" value="soraka">
													<label class="for-checkbox-tools" for="soraka">
														<i class='uil uil-crop-alt'></i>
														Soraka
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="sylas" value="sylas">
													<label class="for-checkbox-tools" for="sylas">
														<i class='uil uil-brush-alt'></i>
														Sylas
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="syndra" value="syndra">
													<label class="for-checkbox-tools" for="syndra">
														<i class='uil uil-image-resize-landscape'></i>
														Syndra
													</label>
												</div>
											</div>
											</div>
											
											<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="talon" value="talon">
													<label class="for-checkbox-tools" for="talon">
														<i class='uil uil-line-alt'></i>
														Talon
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="teemo" value="teemo">
													<label class="for-checkbox-tools" for="teemo">
														<i class='uil uil-vector-square'></i>
														Teemo
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="thresh" value="thresh">
													<label class="for-checkbox-tools" for="thresh">
														<i class='uil uil-ruler'></i>
														Thresh
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="vayne" value="vayne">
													<label class="for-checkbox-tools" for="vayne">
														<i class='uil uil-crop-alt'></i>
														Vayne
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="volibear" value="volibear">
													<label class="for-checkbox-tools" for="volibear">
														<i class='uil uil-brush-alt'></i>
														Volibear
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="warwick" value="warwick">
													<label class="for-checkbox-tools" for="warwick">
														<i class='uil uil-image-resize-landscape'></i>
														Warwick
													</label>
												</div>
											</div>
											</div>
											
											<div class="container pb-5">
											<div class="row justify-content-center pb-5">
												<div class="col-12 pt-5">
												</div>
												<div class="col-12 pb-5">
													<input class="checkbox-tools" type="radio" name="avatar" id="xayah" value="xayah">
													<label class="for-checkbox-tools" for="xayah">
														<i class='uil uil-line-alt'></i>
														Xayah
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="yasuo" value="yasuo">
													<label class="for-checkbox-tools" for="yasuo">
														<i class='uil uil-vector-square'></i>
														Yasuo
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="yuumi" value="yuumi">
													<label class="for-checkbox-tools" for="yuumi">
														<i class='uil uil-ruler'></i>
														Yuumi
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="zed" value="zed">
													<label class="for-checkbox-tools" for="zed">
														<i class='uil uil-crop-alt'></i>
														Zed
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="zoe" value="zoe">
													<label class="for-checkbox-tools" for="zoe">
														<i class='uil uil-brush-alt'></i>
														Zoe
													</label><!--
													--><input class="checkbox-tools" type="radio" name="avatar" id="zyra" value="zyra">
													<label class="for-checkbox-tools" for="zyra">
														<i class='uil uil-image-resize-landscape'></i>
														Zyra
													</label>
												</div>
											</div>
											</div>
											
											<div class="form-group">					                    <div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button id="btn_avatar" onclick="changeAvatar()"style="margin-left:260px; font-weight:bolder; color:white; font-family:'Montserrat';font-size:18px;"> SUBMIT </button>
						</div>
						</div>
						</div>
											
												
						  </div>
						</div>
						<!-- end of modal -->
						</div>
                       </form>
                       
                       <form method="POST" id="ChangeInfoForm" name="ChangeInfoForm" class="RegistryForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="userid">ID</label>
                                <input type="hidden" name="userid" value='${userid}'>
                                <span style="margin: 0px 20px;">${user.userid}</span>
                            </div>
                            <div class="form-group">
                                <label for="username">Name</label>
                                <span style="margin: 0px 20px;">${user.username}</span>
                            </div>
                        </div>
	

                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="button" value="Change Password" onclick="location.href='/user/changePassword'" style="background-color: #DFDFDF; width:50%;">
							</div>
						
                        <div class="form-row">
                            <div class="form-group form-icon">
                                <label for="birth_date">Birth date</label>
                                <input type="text" class="form-input" name="birthdate" id="birthdate" value="${user.birthdate}" />
                            </div>
                         	    <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-input" name="email" id="email" value="${user.email}" />
                                </div>
                        </div>

                        

                                
                                <div class="form-group">
									<label for="country">Country</label>
									    <input list="country" id="country1" name="country" class="dropdown" value="${user.country}" style="font-family: 'Montserrat'; font-weight:lighter;" onchange="getCountry()">
											<datalist id="country" class="dropdown" >
											<option value="${user.country}" selected>${user.country}</option>
										    <option value="AF">Afghanistan 🇦🇫</option>
											<option value="AO">Angola 🇦🇴</option>
											<option value="AL">Albania 🇦🇱</option>
											<option value="AD">Andorra 🇦🇩</option>
											<option value="AE">United Arab Emirates 🇦🇪</option>
											<option value="AR">Argentina 🇦🇷</option>
											<option value="AM">Armenia 🇦🇲</option>
											<option value="AG">Antigua and Barbuda 🇦🇬</option>
											<option value="AU">Australia 🇦🇺</option>
											<option value="AT">Austria 🇦🇹</option>
											<option value="AZ">Azerbaijan 🇦🇿</option>
											<option value="BI">Burundi 🇧🇮</option>
											<option value="BE">Belgium 🇧🇪</option>
											<option value="BJ">Benin 🇧🇯</option>
											<option value="BF">Burkina Faso 🇧🇫</option>
											<option value="BD">Bangladesh 🇧🇩</option>
											<option value="BG">Bulgaria 🇧🇬</option>
											<option value="BH">Bahrain 🇧🇭</option>
											<option value="BS">Bahamas 🇧🇸</option>
											<option value="BA">Bosnia and Herzegovina 🇧🇦</option>
											<option value="BY">Belarus 🇧🇾</option>
											<option value="BZ">Belize 🇧🇿</option>
											<option value="BO">Bolivia 🇧🇴</option>
											<option value="BR">Brazil 🇧🇷</option>
											<option value="BB">Barbados 🇧🇧</option>
											<option value="BN">Brunei 🇧🇳</option>
											<option value="BT">Bhutan 🇧🇹</option>
											<option value="BW">Botswana 🇧🇼</option>
											<option value="CF">Central African Republic 🇨🇫</option>
											<option value="CA">Canada 🇨🇦</option>
											<option value="CH">Switzerland 🇨🇭</option>
											<option value="CL">Chile 🇨🇱</option>
											<option value="CN">China 🇨🇳</option>
											<option value="CI">Ivory Coast 🇨🇮</option>
											<option value="CM">Cameroon 🇨🇲</option>
											<option value="CD">DR Congo 🇨🇩</option>
											<option value="CG">Republic of the Congo 🇨🇬</option>
											<option value="CO">Colombia 🇨🇴</option>
											<option value="KM">Comoros 🇰🇲</option>
											<option value="CV">Cape Verde 🇨🇻</option>
											<option value="CR">Costa Rica 🇨🇷</option>
											<option value="CU">Cuba 🇨🇺</option>
											<option value="CY">Cyprus 🇨🇾</option>
											<option value="CZ">Czechia 🇨🇿</option>
											<option value="DE">Germany 🇩🇪</option>
											<option value="DJ">Djibouti 🇩🇯</option>
											<option value="DM">Dominica 🇩🇲</option>
											<option value="DK">Denmark 🇩🇰</option>
											<option value="DO">Dominican Republic 🇩🇴</option>
											<option value="DZ">Algeria 🇩🇿</option>
											<option value="EC">Ecuador 🇪🇨</option>
											<option value="EG">Egypt 🇪🇬</option>
											<option value="ER">Eritrea 🇪🇷</option>
											<option value="ES">Spain 🇪🇸</option>
											<option value="EE">Estonia 🇪🇪</option>
											<option value="ET">Ethiopia 🇪🇹</option>
											<option value="FI">Finland 🇫🇮</option>
											<option value="FJ">Fiji 🇫🇯</option>
											<option value="FR">France 🇫🇷</option>
											<option value="FM">Micronesia 🇫🇲</option>
											<option value="GA">Gabon 🇬🇦</option>
											<option value="GB">United Kingdom 🇬🇧</option>
											<option value="GE">Georgia 🇬🇪</option>
											<option value="GH">Ghana 🇬🇭</option>
											<option value="GN">Guinea 🇬🇳</option>
											<option value="GM">Gambia 🇬🇲</option>
											<option value="GW">Guinea-Bissau 🇬🇼</option>
											<option value="GQ">Equatorial Guinea 🇬🇶</option>
											<option value="GR">Greece 🇬🇷</option>
											<option value="GD">Grenada 🇬🇩</option>
											<option value="GT">Guatemala 🇬🇹</option>
											<option value="GY">Guyana 🇬🇾</option>
											<option value="HN">Honduras 🇭🇳</option>
											<option value="HR">Croatia 🇭🇷</option>
											<option value="HT">Haiti 🇭🇹</option>
											<option value="HU">Hungary 🇭🇺</option>
											<option value="ID">Indonesia 🇮🇩</option>
											<option value="IN">India 🇮🇳</option>
											<option value="IE">Ireland 🇮🇪</option>
											<option value="IR">Iran 🇮🇷</option>
											<option value="IQ">Iraq 🇮🇶</option>
											<option value="IS">Iceland 🇮🇸</option>
											<option value="IL">Israel 🇮🇱</option>
											<option value="IT">Italy 🇮🇹</option>
											<option value="JM">Jamaica 🇯🇲</option>
											<option value="JO">Jordan 🇯🇴</option>
											<option value="JP">Japan 🇯🇵</option>
											<option value="KZ">Kazakhstan 🇰🇿</option>
											<option value="KE">Kenya 🇰🇪</option>
											<option value="KG">Kyrgyzstan 🇰🇬</option>
											<option value="KH">Cambodia 🇰🇭</option>
											<option value="KI">Kiribati 🇰🇮</option>
											<option value="KN">Saint Kitts and Nevis 🇰🇳</option>
											<option value="KR" selected>South Korea 🇰🇷</option>
											<option value="KW">Kuwait 🇰🇼</option>
											<option value="LA">Laos 🇱🇦</option>
											<option value="LB">Lebanon 🇱🇧</option>
											<option value="LR">Liberia 🇱🇷</option>
											<option value="LY">Libya 🇱🇾</option>
											<option value="LC">Saint Lucia 🇱🇨</option>
											<option value="LI">Liechtenstein 🇱🇮</option>
											<option value="LK">Sri Lanka 🇱🇰</option>
											<option value="LS">Lesotho 🇱🇸</option>
											<option value="LT">Lithuania 🇱🇹</option>
											<option value="LU">Luxembourg 🇱🇺</option>
											<option value="LV">Latvia 🇱🇻</option>
											<option value="MA">Morocco 🇲🇦</option>
											<option value="MC">Monaco 🇲🇨</option>
											<option value="MD">Moldova 🇲🇩</option>
											<option value="MG">Madagascar 🇲🇬</option>
											<option value="MV">Maldives 🇲🇻</option>
											<option value="MX">Mexico 🇲🇽</option>
											<option value="MH">Marshall Islands 🇲🇭</option>
											<option value="MK">Macedonia 🇲🇰</option>
											<option value="ML">Mali 🇲🇱</option>
											<option value="MT">Malta 🇲🇹</option>
											<option value="MM">Myanmar 🇲🇲</option>
											<option value="ME">Montenegro 🇲🇪</option>
											<option value="MN">Mongolia 🇲🇳</option>
											<option value="MZ">Mozambique 🇲🇿</option>
											<option value="MR">Mauritania 🇲🇷</option>
											<option value="MU">Mauritius 🇲🇺</option>
											<option value="MW">Malawi 🇲🇼</option>
											<option value="MY">Malaysia 🇲🇾</option>
											<option value="NA">Namibia 🇳🇦</option>
											<option value="NE">Niger 🇳🇪</option>
											<option value="NG">Nigeria 🇳🇬</option>
											<option value="NI">Nicaragua 🇳🇮</option>
											<option value="NL">Netherlands 🇳🇱</option>
											<option value="NO">Norway 🇳🇴</option>
											<option value="NP">Nepal 🇳🇵</option>
											<option value="NR">Nauru 🇳🇷</option>
											<option value="NZ">New Zealand 🇳🇿</option>
											<option value="OM">Oman 🇴🇲</option>
											<option value="PK">Pakistan 🇵🇰</option>
											<option value="PA">Panama 🇵🇦</option>
											<option value="PE">Peru 🇵🇪</option>
											<option value="PH">Philippines 🇵🇭</option>
											<option value="PW">Palau 🇵🇼</option>
											<option value="PG">Papua New Guinea 🇵🇬</option>
											<option value="PL">Poland 🇵🇱</option>
											<option value="KP">North Korea 🇰🇵</option>
											<option value="PT">Portugal 🇵🇹</option>
											<option value="PY">Paraguay 🇵🇾</option>
											<option value="QA">Qatar 🇶🇦</option>
											<option value="RO">Romania 🇷🇴</option>
											<option value="RU">Russia 🇷🇺</option>
											<option value="RW">Rwanda 🇷🇼</option>
											<option value="SA">Saudi Arabia 🇸🇦</option>
											<option value="SD">Sudan 🇸🇩</option>
											<option value="SN">Senegal 🇸🇳</option>
											<option value="SG">Singapore 🇸🇬</option>
											<option value="SB">Solomon Islands 🇸🇧</option>
											<option value="SL">Sierra Leone 🇸🇱</option>
											<option value="SV">El Salvador 🇸🇻</option>
											<option value="SM">San Marino 🇸🇲</option>
											<option value="SO">Somalia 🇸🇴</option>
											<option value="RS">Serbia 🇷🇸</option>
											<option value="SS">South Sudan 🇸🇸</option>
											<option value="ST">São Tomé and Príncipe 🇸🇹</option>
											<option value="SR">Suriname 🇸🇷</option>
											<option value="SK">Slovakia 🇸🇰</option>
											<option value="SI">Slovenia 🇸🇮</option>
											<option value="SE">Sweden 🇸🇪</option>
											<option value="SZ">Swaziland 🇸🇿</option>
											<option value="SC">Seychelles 🇸🇨</option>
											<option value="SY">Syria 🇸🇾</option>
											<option value="TD">Chad 🇹🇩</option>
											<option value="TG">Togo 🇹🇬</option>
											<option value="TH">Thailand 🇹🇭</option>
											<option value="TJ">Tajikistan 🇹🇯</option>
											<option value="TM">Turkmenistan 🇹🇲</option>
											<option value="TL">Timor-Leste 🇹🇱</option>
											<option value="TO">Tonga 🇹🇴</option>
											<option value="TT">Trinidad and Tobago 🇹🇹</option>
											<option value="TN">Tunisia 🇹🇳</option>
											<option value="TR">Turkey 🇹🇷</option>
											<option value="TV">Tuvalu 🇹🇻</option>
											<option value="TZ">Tanzania 🇹🇿</option>
											<option value="UG">Uganda 🇺🇬</option>
											<option value="UA">Ukraine 🇺🇦</option>
											<option value="UY">Uruguay 🇺🇾</option>
											<option value="US">United States 🇺🇸</option>
											<option value="UZ">Uzbekistan 🇺🇿</option>
											<option value="VA">Vatican City 🇻🇦</option>
											<option value="VC">Saint Vincent and the Grenadines 🇻🇨</option>
											<option value="VE">Venezuela 🇻🇪</option>
											<option value="VN">Vietnam 🇻🇳</option>
											<option value="VU">Vanuatu 🇻🇺</option>
											<option value="WS">Samoa 🇼🇸</option>
											<option value="YE">Yemen 🇾🇪</option>
											<option value="ZA">South Africa 🇿🇦</option>
											<option value="ZM">Zambia 🇿🇲</option>
											<option value="ZW">Zimbabwe 🇿🇼</option>
										  </datalist>					       
                                </div>

                                <div class="form-group">
                                    <label for="job">Job</label>
                                     <select class="dropdown" name="job" id="job" >
                                     	<option value="${user.job}" selected>${user.job}</option>
									    <option value="student">Student</option>
									    <option value="employee">Employee</option>
									    <option value="unemployed">Unemployed</option>
									    <option value="others">Others</option>
									</select>
								</div>
								<div class="form-group">
									<label for="description">Description</label>
									<textarea id="content" cols="54" rows="5" name="description" placeholder="Introduce yourself."
										style="font-family:'Montserrat';font-size:18px; padding: 10px;box-sizing: border-box;border: solid 2px #ebebeb;border-radius: 5px;resize: none;"
										>${user.description}</textarea><br>
								</div>
                        <div class="form-row">
                <div class="form-group">
                    <div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<input type="button" class="login100-form-btn" onclick="return changeInfo()" value="Save Changes">
						</div>
						</div>
					</div>
					<div class="form-group">
					                    <div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<input type="button" class="login100-form-btn" onclick="history.back()" value="Cancel">
						</div>
						</div>
					</div>
					</div>
			
                    </form>
                </div>
            </div>


    </div>
<br><br><br>
</c:if>
</body>
</html>