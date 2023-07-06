package com.LolBoard.service;

import java.util.List;
import java.util.Map;

import com.LolBoard.dto.BoardVO;
import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.LikeVO;
import com.LolBoard.dto.ReplyVO;



public interface BoardService {
	
	//게시물 목록보기
	public List<BoardVO> list(int startPoint, int postNum, String keywod) throws Exception;
	
	//avatar 가져오기
	public String getAvatar(int seqno) throws Exception;
	
	//게시물 등록
	public void write(BoardVO board) throws Exception;

	//게시물 내용 보기
	public BoardVO view(int seqno) throws Exception;
	
	//게시물 조회수 증가
	public void hitno(int seqno) throws Exception;
	
	//게시물 수정
	public void modify(BoardVO board) throws Exception;
	
	//게시물 삭제
	public void delete(int seqno) throws Exception;
	
	//게시물 전체 개수 계산
	public int getTotalCount(String keyword) throws Exception;
	
	//이전보기
	public int pre_seqno(int seqno, String keyword) throws Exception;
	
	//다음보기
	public int next_seqno(int seqno, String keyword) throws Exception;
	
	
	//댓글 보기
	public List<ReplyVO> replyView(ReplyVO reply) throws Exception;
	
	//댓글 수정
	public void replyUpdate(ReplyVO reply) throws Exception;
	
	//댓글 등록 
	public void replyRegistry(ReplyVO reply) throws Exception;
	
	//댓글 삭제
	public void replyDelete(ReplyVO reply) throws Exception;
	
	
	
	
	//좋아요/싫어요 확인 가져 오기
	public LikeVO likeCheckView(int seqno,String userid) throws Exception;
	
	//좋아요/싫어요 갯수 수정하기
	public void boardLikeUpdate(int seqno, int likecnt) throws Exception;
	
	//좋아요/싫어요 확인 등록하기
	public void likeCheckRegistry(Map<String,Object> map) throws Exception;
	
	//좋아요/싫어요 확인 수정하기
	public void likeCheckUpdate(Map<String,Object> map) throws Exception;


	
	

	//파일 업로드 정보 등록
	public void fileInfoRegistry(Map<String,Object> fileInfo) throws Exception;

	//게시글 내에서 업로드된 파일 목록 보기
	public List<FileVO> fileListView(int seqno) throws Exception;
		
	//게시물 수정에서 파일 삭제
	public void deleteFileList(Map<String,Object> data) throws Exception;
		
	//게시물 삭제에서 파일 삭제를 위한 파일 목록 가져 오기
	public List<FileVO> deleteFileOnBoard(int seqno) throws Exception;

	//회원 탈퇴 시 회원이 업로드한 파일 정보 가져 오기
	public List<FileVO> fileInfoByUserid(String userid) throws Exception; 
	
	//다운로드를 위한 파일 정보 보기
	public FileVO fileInfo(int fileseqno) throws Exception;

}
