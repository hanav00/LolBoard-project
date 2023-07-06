package com.LolBoard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.LolBoard.dao.BoardDAO;
import com.LolBoard.dto.BoardVO;
import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.LikeVO;
import com.LolBoard.dto.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService{

	//의존성 주입
	@Autowired
	BoardDAO dao;
	
	//게시물 목록 보기
	@Override
	public List<BoardVO> list(int startPoint, int postNum, String keyword) throws Exception {
		return dao.list(startPoint, postNum, keyword);
	}
	
	//avatar 가져오기
	@Override
	public String getAvatar(int seqno) throws Exception {
		return dao.getAvatar(seqno);
	}

	//게시물 등록하기
	@Override
	public void write(BoardVO board) throws Exception {
		dao.write(board);
	}

	//게시물 상세보기
	@Override
	public BoardVO view(int seqno) throws Exception {
		return dao.view(seqno);
	}

	//조회수 증가
	@Override
	public void hitno(int seqno) throws Exception {
		dao.hitno(seqno);
	}

	//게시물 수정하기
	@Override
	public void modify(BoardVO board) throws Exception {
		dao.modify(board);
	}

	//게시물 삭제하기
	@Override
	public void delete(int seqno) throws Exception {
		dao.delete(seqno);
	}

	//전체 개수
	@Override
	public int getTotalCount(String keyword) throws Exception{
		return dao.getTotalCount(keyword);
	}

	//이전 보기
	@Override
	public int pre_seqno(int seqno, String keyword) throws Exception {
		return dao.pre_seqno(seqno, keyword);
	}

	//다음 보기
	@Override
	public int next_seqno(int seqno, String keyword) throws Exception {
		return dao.next_seqno(seqno, keyword);
	}

	//댓글 보기
	@Override
	public List<ReplyVO> replyView(ReplyVO reply) throws Exception {
		return dao.replyView(reply);
	}

	//댓글 수정
	@Override
	public void replyUpdate(ReplyVO reply) throws Exception {
		dao.replyUpdate(reply);
	}

	//댓글 등록
	@Override
	public void replyRegistry(ReplyVO reply) throws Exception {
		dao.replyRegistry(reply);
	}

	//댓글 삭제
	@Override
	public void replyDelete(ReplyVO reply) throws Exception {
		dao.replyDelete(reply);		
	}

	//좋아요/싫어요 확인 가져 오기
	@Override
	public LikeVO likeCheckView(int seqno, String userid) throws Exception {
		return dao.likeCheckView(seqno, userid);
	}

	//좋아요/싫어요 갯수 수정하기
	@Override
	public void boardLikeUpdate(int seqno, int likecnt) throws Exception {
		dao.boardLikeUpdate(seqno, likecnt);
	}

	//좋아요/싫어요 확인 등록하기
	@Override
	public void likeCheckRegistry(Map<String, Object> map) throws Exception {
		dao.likeCheckRegistry(map);
	}

	//좋아요/싫어요 확인 수정하기
	@Override
	public void likeCheckUpdate(Map<String, Object> map) throws Exception {
		dao.likeCheckUpdate(map);
	}

	//파일 업로드 정보
	@Override
	public void fileInfoRegistry(Map<String, Object> fileInfo) throws Exception {
		dao.fileInfoRegistry(fileInfo);
		
	}

	//파일 업로드 목록 보기
	@Override
	public List<FileVO> fileListView(int seqno) throws Exception {
		return dao.fileListView(seqno);
	}

	//게시물 수정에서 파일 삭제
	@Override
	public void deleteFileList(Map<String,Object> data) throws Exception {
		dao.deleteFileList(data);
	}

	//게시물 삭제에서 파일 삭제를 위한 파일 정보 가져오기
	@Override
	public List<FileVO> deleteFileOnBoard(int seqno) throws Exception {
		return dao.deleteFileOnBoard(seqno);
	}

	//회원탈퇴시 필요한 파일정보 불러오기
	@Override
	public List<FileVO> fileInfoByUserid(String userid) throws Exception {
		return dao.fileInfoByUserid(userid);
	}

	//다운로드를 위한 파일 정보 보기
	@Override
	public FileVO fileInfo(int fileseqno) throws Exception {
		return dao.fileInfo(fileseqno);
	}

}
