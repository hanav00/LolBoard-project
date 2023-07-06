package com.LolBoard.controller;

import java.io.File;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.LolBoard.dto.BoardVO;
import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.LikeVO;
import com.LolBoard.dto.ReplyVO;
import com.LolBoard.service.BoardService;
import com.LolBoard.util.Page;




@Controller
public class BoardController {
	
	
	@Autowired //mapper 인터페이스 의존성 주입
	//SFtestMapper mapper;
	BoardService service;
	
	//게시물 목록 보기
	@GetMapping("/board/list")
	public void getList(@RequestParam("page") int pageNum, Model model, @RequestParam(name="keyword", defaultValue="", required=false) String keyword) throws Exception{
		int postNum = 10;
		int startPoint = (pageNum - 1) * postNum;
		int pageListCount = 5;
		
		Page page = new Page();
		
		model.addAttribute("list", service.list(startPoint, postNum, keyword));
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageList", page.getPageList(pageNum, postNum, pageListCount, service.getTotalCount(keyword), keyword));
		
		//System.out.println("pageNum=" + pageNum + " postNum=" + postNum + " pageListCount=" + pageListCount + " TotalCount=" + service.getTotalCount());
	}
	
	//게시물 등록하기 (화면보기)
	@GetMapping("/board/write")
	public void getWrite() {}

	
	//첨부 파일 없는 게시물 등록
	@ResponseBody
	@PostMapping("/board/write")
	public String PostWrite(BoardVO board) throws Exception{

		service.write(board);		
		return "{\"message\":\"good\"}";

	}
	
	//파일 업로드
	@ResponseBody
	@PostMapping("/board/fileUpload")
	public String postFileUpload(BoardVO board,@RequestParam("SendToFileList") List<MultipartFile> multipartFile, 
			@RequestParam("kind") String kind,@RequestParam(name="deleteFileList", required=false) int[] deleteFileList) throws Exception{

		String path = "c:\\Repository\\file\\"; 
		int seqno =0;
		
		//게시물 수정 시
		if(kind.equals("U")) {
			seqno = board.getSeqno();
			service.modify(board);
			
			if(deleteFileList != null) {
				
				for(int i=0; i<deleteFileList.length; i++) {

					//파일 삭제
					FileVO fileInfo = new FileVO();
					fileInfo = service.fileInfo(deleteFileList[i]);
					//File file = new File(path + fileInfo.getStored_filename());
					//file.delete();
					
					//파일 테이블에서 파일 정보 삭제
					Map<String,Object> data = new HashMap<>();
					data.put("kind", "F");
					data.put("fileseqno", deleteFileList[i]);
					service.deleteFileList(data);
					
				}
			}	
		}
		
		if(!multipartFile.isEmpty()) {
			File targetFile = null; 
			Map<String,Object> fileInfo = null;		
			
			for(MultipartFile mpr:multipartFile) {
				
				String org_filename = mpr.getOriginalFilename();	
				String org_fileExtension = org_filename.substring(org_filename.lastIndexOf("."));	
				String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
				long filesize = mpr.getSize() ;
				
				targetFile = new File(path + stored_filename);
				mpr.transferTo(targetFile);
				
				fileInfo = new HashMap<>();
				fileInfo.put("org_filename",org_filename);
				fileInfo.put("stored_filename", stored_filename);
				fileInfo.put("filesize", filesize);
				fileInfo.put("seqno", seqno);
				fileInfo.put("userid", board.getUserid());
				fileInfo.put("kind", kind);
				service.fileInfoRegistry(fileInfo);
	
			}
		}
		
		//게시물 등록 시
		if(kind.equals("I")) { 
			//Oracle용!
			//seqno = service.getSeqnoWithNextval();
			//board.setSeqno(seqno);
			service.write(board);
		}
		return "{\"message\":\"good\"}";
}

	
	
	//게시물 상세보기 (화면보기)
	@GetMapping("/board/view")
	public void getView(@RequestParam("seqno") int seqno, @RequestParam("page") int pageNum,
			@RequestParam(name="keyword",required=false) String keyword,
			Model model,HttpSession session) throws Exception{
		//상세보기 누르면 조회수가 1 오름
		String sessionUserid = (String)session.getAttribute("userid");
		BoardVO view = service.view(seqno);
		
		
		//본인 글이 아닌 경우에만 조회수 오름
		if (sessionUserid != null && !sessionUserid.equals(view.getUserid()))
			service.hitno(view.getSeqno());
		
		
		//좋아요 관리
		LikeVO likeCheckView = service.likeCheckView(seqno, sessionUserid);
		
		//초기에 좋아요/싫어요 등록이 안되어져 있을 경우 "N"으로 초기화 
		if(likeCheckView == null) {
			model.addAttribute("myLikeCheck", "N");
		} else if(likeCheckView != null) {
			model.addAttribute("myLikeCheck", likeCheckView.getMylikecheck());
		}
		
		
		model.addAttribute("view", view);
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pre_seqno", service.pre_seqno(seqno, keyword));
		model.addAttribute("next_seqno", service.next_seqno(seqno, keyword));
		model.addAttribute("likeCheckView", likeCheckView);
		model.addAttribute("fileListView", service.fileListView(seqno));
	}
	
	//게시물 수정하기 (화면보기)
	@GetMapping("/board/modify")
	public void getModify(@RequestParam("seqno") int seqno, @RequestParam("page") int pageNum, Model model,
			@RequestParam(name="keyword",required=false) String keyword
			) throws Exception{ 
		model.addAttribute("view", service.view(seqno));
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword);
		model.addAttribute("fileListView", service.fileListView(seqno));
	}
	
	//게시물 수정하기
	@PostMapping("/board/modify")
	public String postModify(BoardVO board,@RequestParam("page") int pageNum,
			@RequestParam(name="keyword", required=false) String keyword,
			@RequestParam(name="deleteFileList", required=false) int[] deleteFileList) throws Exception {
		
		//mapper.modify(board);
		System.out.println(keyword);
		
		service.modify(board);
		
		if(deleteFileList != null) {
			
			for(int i=0; i<deleteFileList.length; i++) {

				
				//파일 테이블에서 파일 정보 삭제
				Map<String,Object> data = new HashMap<>();
				data.put("kind", "F");
				data.put("fileseqno", deleteFileList[i]);
				service.deleteFileList(data);
				
			}
		}
		return "redirect:/board/view?seqno=" + board.getSeqno() + "&page=" + pageNum+ "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
	}
	
	//게시물 삭제하기
	@GetMapping("/board/delete")
	public String getDelete(@RequestParam("seqno") int seqno) throws Exception{
		
		//게시물 삭제 시 tbl_file 내의 파일 정보 수정하기
		service.delete(seqno);
		return "redirect:/board/list?page=1";
	}
		
	
	
/////////////////////////////////////////////////////////////////////////////////////////
	
	
	//파일 다운로드
		@GetMapping("/board/fileDownload")
		public void fileDownload(@RequestParam(name="fileseqno") int fileseqno, HttpServletResponse rs) throws Exception {
		
		String path = "c:\\Repository\\file\\";
		System.out.println("fileseqno=" + fileseqno);
		
		FileVO fileInfo = service.fileInfo(fileseqno);
		System.out.println("here1");
		String org_filename = fileInfo.getOrg_filename();
		System.out.println("here2");
		String stored_filename = fileInfo.getStored_filename();
		System.out.println("here3");
		
		System.out.println("org=" + org_filename);
		System.out.println("stored=" + stored_filename);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(path+stored_filename));
		
		//헤드값을 Content-Disposition로 주게 되면 Response Body로 오는 값을 filename으로 다운받으라는 것임
		//예) Content-Disposition: attachment; filename="hello.jpg"
		rs.setContentType("application/octet-stream");
		rs.setContentLength(fileByte.length);
		rs.setHeader("Content-Disposition",  "attachment; filename=\""+URLEncoder.encode(org_filename, "UTF-8")+"\";");
		rs.getOutputStream().write(fileByte);
		rs.getOutputStream().flush(); //버퍼에 있는 내용을 write
		rs.getOutputStream().close();
		
		}
	
		
	///////////////////////////////////////////

		//댓글 처리
		@ResponseBody
		@PostMapping("/board/reply")
		public List<ReplyVO> postReply(ReplyVO reply,@RequestParam("option") String option)throws Exception{
			//javaScript로 하려면 @RequestBody ReplyVO reply 로 해야함
			switch(option) {
			
			case "I" : service.replyRegistry(reply); //댓글 등록
					   break;
			case "U" : service.replyUpdate(reply); //댓글 수정
					   break;
			case "D" : service.replyDelete(reply); //댓글 삭제
					   break;
			}

			return service.replyView(reply);
		}
		
	
	
	////////////////////////////

	
	//좋아요/싫어요 관리
	@ResponseBody
	@PostMapping(value = "/board/likeCheck")
	public Map<String, Object> postLikeCheck(@RequestBody Map<String, Object> likeCheckData) throws Exception {
		
		int seqno = (int)likeCheckData.get("seqno");
		String userid = (String)likeCheckData.get("userid");
	
		//현재 날짜, 시간 구해서 좋아요/싫어요 한 날짜/시간 입력 및 수정
		String likeDate = "";
		if(likeCheckData.get("mylikecheck").equals("Y")) 
			likeDate = LocalDateTime.now().toString();
	
		System.out.println(likeDate);
		likeCheckData.put("likedate", likeDate);
	
		//TBL_LIKE 테이블 입력/수정
		LikeVO likeCheckView = service.likeCheckView(seqno,userid);
		if(likeCheckView == null) service.likeCheckRegistry(likeCheckData);
			else service.likeCheckUpdate(likeCheckData);
	
		//TBL_BOARD 내의 likecnt,dislikecnt 입력/수정 
		BoardVO board = service.view(seqno);
		
		int likeCnt = board.getLikecnt();
		
		if(likeCheckData.get("mylikecheck").equals("Y"))
			likeCnt ++;
		else
			likeCnt --;
		System.out.println(likeCnt);
		service.boardLikeUpdate(seqno,likeCnt);
		
		//AJAX에 전달할 map JSON 데이터 만들기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seqno", seqno);
		map.put("likeCnt", likeCnt);
		
		return map;
		
	}
}
	
	
			
		
		
		
		
