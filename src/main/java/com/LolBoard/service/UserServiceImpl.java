package com.LolBoard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.LolBoard.dao.UserDAO;
import com.LolBoard.dto.UserVO;

@Service
public class UserServiceImpl implements UserService{

	//의존성 주입
	@Autowired
	UserDAO dao;
	
	//로그인에 필요한 정보 불러오기
	@Override
	public UserVO login(String userid) throws Exception {
		return dao.login(userid);
	}

	//아이디 중복 체크
	@Override
	public int idCheck(String userid) throws Exception {
		return dao.idCheck(userid);
	}

	//회원가입
	@Override
	public void SignUp(UserVO user) throws Exception {
		dao.SignUp(user);
	}

	//마이페이지
	@Override
	public UserVO mypage(String userid) throws Exception {
		return dao.mypage(userid);
	}

	//자동로그인
	@Override
	public void authkeyUpdate(UserVO user) throws Exception {
		dao.authkeyUpdate(user);;
	}

	@Override
	public UserVO userinfoByAuthkey(String authkey) throws Exception {
		return dao.userinfoByAuthkey(authkey);
	}

	//아이디찾기
	@Override
	public String searchID(UserVO user) {
		return dao.searchID(user);
	}

	//비밀번호 찾기
	@Override
	public int searchPassword(UserVO user) {
		return dao.searchPassword(user);
	}

	//회원정보 수정
	@Override
	public void userInfoUpdate(UserVO user) {
		dao.userInfoUpdate(user);
	}
	
	//avatar 수정
	@Override
	public void userAvatarUpdate(UserVO user) {
		dao.userAvatarUpdate(user);
	}

	//비밀번호 수정
	@Override
	public void passwordUpdate(UserVO user) {
		dao.passwordUpdate(user);
	}

	//회원탈퇴
	@Override
	public void deleteAccount(String userid) {
		dao.deleteAccount(userid);
	}

	
	
	

	//password Time check
	@Override
	public int passwordTime(String userid) {
		return dao.passwordTime(userid);
	}

}
