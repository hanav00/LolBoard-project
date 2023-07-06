package com.LolBoard.dto;


public class UserVO {
	
	private String userid;
	private String username;
	private String password;
	private String email;
	private String gender;
	private String job;
	private String description;
	private String birthdate;
	private String country;
	private String authkey;
	private String role;
	private String avatar;
	private String lastPasswordUpdateString;
	private int passwordCheck;
	private int passwordDiff;
	

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;	
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getLastPasswordUpdateString() {
		return lastPasswordUpdateString;
	}
	public void setLastPasswordUpdateString(String lastPasswordUpdateString) {
		this.lastPasswordUpdateString = lastPasswordUpdateString;
	}
	public int getPasswordCheck() {
		return passwordCheck;
	}
	public void setPasswordCheck(int passwordCheck) {
		this.passwordCheck = passwordCheck;
	}
	public int getPasswordDiff() {
		return passwordDiff;
	}
	public void setPasswordDiff(int passwordDiff) {
		this.passwordDiff = passwordDiff;
	}
	
	
	

}

