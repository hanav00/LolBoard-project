package com.LolBoard.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.LolBoard.dto.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	//의존성 주입
	@Autowired
	private SqlSession sql;	
	public static String namespace="com.LolBoard.mappers.User";
	
	//로그인할 떄 필요한 정보 가져오기
	@Override
	public UserVO login(String userid) throws Exception {
		return sql.selectOne(namespace + ".login", userid);
	}

	//아이디 중복 체크
	@Override
	public int idCheck(String userid) throws Exception {
		return sql.selectOne(namespace + ".idCheck", userid);
	}

	//회원가입
	@Override
	public void SignUp(UserVO user) throws Exception {
		sql.insert(namespace + ".SignUp", user);
		
	}

	//마이페이지
	@Override
	public UserVO mypage(String userid) throws Exception {
		return sql.selectOne(namespace + ".mypage", userid);
	}

	@Override
	public void authkeyUpdate(UserVO user) throws Exception {
		sql.update(namespace + ".authkeyUpdate", user);
		
	}

	//자동로그인
	@Override
	public UserVO userinfoByAuthkey(String authkey) throws Exception {
		return sql.selectOne(namespace + ".userinfoByAuthkey", authkey);
	}

	//아이디찾기
	@Override
	public String searchID(UserVO user) {
		return sql.selectOne(namespace + ".searchID", user);
	}

	//비밀번호 찾기
	@Override
	public int searchPassword(UserVO user) {
		return sql.selectOne(namespace + ".searchPassword", user);
	}

	//회원정보 수정
	@Override
	public void userInfoUpdate(UserVO user) {
		sql.update(namespace + ".userInfoUpdate", user);
		
	}
	
	//avatar 수정
	@Override
	public void userAvatarUpdate(UserVO user) {
		sql.update(namespace + ".userAvatarUpdate", user);
	}

	//비밀번호 수정
	@Override
	public void passwordUpdate(UserVO user) {
		sql.update(namespace + ".passwordUpdate", user);
	}

	//회원탈퇴
	@Override
	public void deleteAccount(String userid) {
		sql.delete(namespace + ".deleteAccount", userid);
	}


	//password Time check
	@Override
	public int passwordTime(String userid) {
		return sql.selectOne(namespace + ".passwordTime", userid);
	}
	
	
	
	
	
	
	

}
