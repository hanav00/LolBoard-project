package com.LolBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;

import com.LolBoard.dao.MasterDAO;
import com.LolBoard.dto.BoardVO;
import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.UserVO;

@Service
public class MasterServiceImpl implements MasterService{

	@Autowired
	MasterDAO dao;
	
	@Override
	public int fileDeleteCount() {
		return dao.fileDeleteCount();
	}

	@Override
	public List<FileVO> fileDeleteList() {
		return dao.fileDeleteList();
	}

	@Override
	public void deleteFile(int fileseqno) {
		dao.deleteFile(fileseqno);
	}

	
	//회원 수
	@Override
	public int memberNumber() {
		return dao.memberNumber();
	}
	
	//회원 정보
	@Override
	public List<UserVO> memberInfo() {
		return dao.memberInfo();
	}

	@Override
	public int boardNumber() {
		return dao.boardNumber();
	}

	@Override
	public List<BoardVO> boardInfo() {
		return dao.boardInfo();
	}
}
