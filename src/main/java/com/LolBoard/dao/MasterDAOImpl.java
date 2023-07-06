package com.LolBoard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.LolBoard.dto.BoardVO;
import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.UserVO;

@Repository
public class MasterDAOImpl implements MasterDAO{

	@Autowired
	SqlSession sql;
	public static String namespace="com.LolBoard.mappers.Master";
	
	@Override
	public int fileDeleteCount() {
		return sql.selectOne(namespace + ".fileDeleteCount");
	}

	@Override
	public List<FileVO> fileDeleteList() {
		return sql.selectList(namespace + ".fileDeleteList");
	}

	@Override
	public void deleteFile(int fileseqno) {
		sql.delete(namespace + ".deleteFile", fileseqno);
	}

	
	//회원 수
	@Override
	public int memberNumber() {
		return sql.selectOne(namespace + ".memberNumber");
	}
	
	//회원 정보
	@Override
	public List<UserVO> memberInfo() {
		return sql.selectList(namespace + ".memberInfo");
	}

	@Override
	public int boardNumber() {
		return sql.selectOne(namespace + ".boardNumber");
	}

	@Override
	public List<BoardVO> boardInfo() {
		return sql.selectList(namespace + ".boardInfo");
	}
	
	
}
