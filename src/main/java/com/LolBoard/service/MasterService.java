package com.LolBoard.service;

import java.util.List;

import com.LolBoard.dto.BoardVO;
import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.UserVO;

public interface MasterService {
	
	//삭제할 파일 목록 개수
	public int fileDeleteCount();
	
	//삭제할 파일 목록 정보
	public List<FileVO> fileDeleteList();
	
	//파일 삭제
	public void deleteFile(int fileseqno);

	//회원 수
	public int memberNumber();
	
	//회원 정보
	public List<UserVO> memberInfo();
	
	//글 수
	public int boardNumber();
	
	//글 정보
	public List<BoardVO> boardInfo();
}
