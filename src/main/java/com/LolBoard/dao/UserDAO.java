package com.LolBoard.dao;

import com.LolBoard.dto.UserVO;

public interface UserDAO {
	
	//로그인 정보 확인
	public UserVO login(String userid) throws Exception; 
		
	//아이디 확인
	public int idCheck(String userid) throws Exception; 
	
	//회원가입
	public void SignUp(UserVO user) throws Exception;

	//마이페이지
	public UserVO mypage(String userid) throws Exception;

	//authkey
	public void authkeyUpdate(UserVO user) throws Exception;
	public UserVO userinfoByAuthkey(String authkey) throws Exception;
	
	
	//사용자 아이디 찾기
	public String searchID(UserVO user);
	
	//사용자 패스워드 신규 발급을 위한 확인
	public int searchPassword(UserVO user);
	
	//사용자 정보 수정
	public void userInfoUpdate(UserVO user);
	
	//avatar 수정
	public void userAvatarUpdate(UserVO user);
	
	//패스워드 수정
	public void passwordUpdate(UserVO user);
	
	//회원탈퇴
	public void deleteAccount(String userid);
	
	
	
	
	//password Time check
	public int passwordTime(String userid);

}
