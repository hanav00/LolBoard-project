package com.LolBoard.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;

import com.LolBoard.dto.BoardVO;
import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.LikeVO;
import com.LolBoard.dto.ReplyVO;

@Repository
public class BoardDAOImpl implements BoardDAO{

	
	//의존성 주입으로 Spring Beans를 가져와야 함
	@Autowired
	private SqlSession sql;
	
	private static String namespace = "com.LolBoard.mappers.Board";
	
	//게시물 목록 보기
	@Override
	public List<BoardVO> list(int startPoint, int postNum, String keyword) throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("startPoint", startPoint);
		data.put("postNum", postNum);
		data.put("keyword", keyword);
		return sql.selectList(namespace + ".list", data);
	}
	
	//avatar 가져오기
	@Override
	public String getAvatar(int seqno) throws Exception {
		return sql.selectOne(namespace + ".getAvatar", seqno);
	}
	
	//게시물 등록하기
	@Override
	public void write(BoardVO board) throws Exception {
		sql.insert(namespace + ".write", board);
	}
	
	//게시물 상세보기
	@Override
	public BoardVO view(int seqno) throws Exception {
		return sql.selectOne(namespace + ".view", seqno);
	}

	//조회수 증가
	@Override
	public void hitno(int seqno) throws Exception {
		sql.update(namespace + ".hitno", seqno);
	}

	//게시물 수정하기
	@Override
	public void modify(BoardVO board) throws Exception {
		sql.update(namespace + ".modify", board);
	}

	//게시물 삭제하기
	@Override
	public void delete(int seqno) throws Exception {
		sql.delete(namespace + ".delete", seqno);
	}

	//게시물 전체 개수 계산
	@Override
	public int getTotalCount(String keyword) throws Exception {
		return sql.selectOne(namespace + ".getTotalCount", keyword);
	}

	//이전보기
	@Override
	public int pre_seqno(int seqno, String keyword) throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("keyword", keyword);
		return sql.selectOne(namespace + ".pre_seqno", data);
	}

	//다음 보기
	@Override
	public int next_seqno(int seqno, String keyword) throws Exception {
		Map<String, Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("keyword", keyword);
		return sql.selectOne(namespace + ".next_seqno", data);
	}

	//댓글 보기
	@Override
	public List<ReplyVO> replyView(ReplyVO reply) throws Exception {
		return sql.selectList(namespace + ".replyView", reply);
	}
	
	//댓글 수정
	@Override
	public void replyUpdate(ReplyVO reply) throws Exception {
		sql.update(namespace + ".replyUpdate", reply);
		
	}
	
	//댓글 등록
	@Override
	public void replyRegistry(ReplyVO reply) throws Exception {
		sql.insert(namespace + ".replyRegistry", reply);
		
	}

	//댓글 삭제
	@Override
	public void replyDelete(ReplyVO reply) throws Exception {
		sql.delete(namespace + ".replyDelete", reply);
		
	}

	//좋아요/싫어요 확인 가져 오기
	@Override
	public LikeVO likeCheckView(int seqno, String userid) throws Exception {
		Map<String,Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("userid", userid);
		return sql.selectOne(namespace + ".likeCheckView", data);
	}

	//좋아요/싫어요 갯수 수정하기
	@Override
	public void boardLikeUpdate(int seqno, int likecnt) throws Exception {
		Map<String,Integer> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("likecnt", likecnt);
		sql.update(namespace + ".boardLikeUpdate", data);
		
	}

	//좋아요/싫어요 확인 등록하기
	@Override
	public void likeCheckRegistry(Map<String, Object> map) throws Exception {
		sql.insert(namespace + ".likeCheckRegistry", map);
		
	}

	//좋아요/싫어요 확인 수정하기
	@Override
	public void likeCheckUpdate(Map<String, Object> map) throws Exception {
		sql.update(namespace + ".likeCheckUpdate", map);
		
	}

	
	
	//파일 업로드 정보 등록
	@Override
	public void fileInfoRegistry(Map<String,Object> fileInfo) throws Exception{
		sql.insert(namespace+".fileInfoRegistry", fileInfo);
	}

	//게시글 내에서 업로드된 파일 목록 보기
	@Override
	public List<FileVO> fileListView(int seqno) throws Exception{
		return sql.selectList(namespace + ".fileListView", seqno);
	}
	
	//게시물 수정에서 파일 삭제
	@Override
	public void deleteFileList(Map<String,Object> data) throws Exception{
		sql.delete(namespace + ".deleteFileList", data);
	}
	
	//게시물 삭제에서 파일 삭제를 위한 파일 목록 가져 오기
	@Override
	public List<FileVO> deleteFileOnBoard(int seqno) throws Exception{
		return sql.selectList(namespace + ".deleteFileOnBoard", seqno);
	}
	
	//회원 탈퇴 시 회원이 업로드한 파일 정보 가져 오기
	@Override
	public List<FileVO> fileInfoByUserid(String userid) throws Exception{
		return sql.selectList(namespace + ".fileInfoByUserid", userid);
	}

	//다운로드를 위한 파일 정보 가져오기
	@Override
	public FileVO fileInfo(int fileseqno) throws Exception {
		return sql.selectOne(namespace + ".fileInfo", fileseqno);
	}

	
	

}
