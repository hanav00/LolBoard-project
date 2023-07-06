package com.LolBoard.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.LolBoard.dto.UserVO;

@Controller
public class StudyController {
	
	/*
	@Autowired //비밀번호 암호화 이존성 주입
	private BCryptPasswordEncoder pwdEncoder;
	
	
	
	@PostMapping("/study/userInfo")
	public void getUserInfo(UserVO user, Model model) throws Exception{
		model.addAttribute("user", user);
	}
	
	@GetMapping("/study/imgView")
	public void getImgView() throws Exception {
	
	}
	
	@GetMapping("/study/imgViews")
	public void getImgViews() throws Exception {
	
	}
	
	@GetMapping("/study/fileUpload")
	public void getFileUpload() throws Exception{
	
	}
	
	@PostMapping("/study/fileUpload")
	public void postFileUpload(@RequestParam("painter") String painter,
	@RequestParam ("fileUpload") List<MultipartFile> multipartFile) throws Exception {
	
	String path = "c:\\Repository\\test\\"; 
	String org_filename= "";
	long filesize = 0L;
	
	if(!multipartFile.isEmpty()) {
	File targetFile = null; 	
	
	for(MultipartFile mpr:multipartFile) {
	
	org_filename = mpr.getOriginalFilename();	
	//String org_fileExtension = org_filename.substring(org_filename.lastIndexOf(".")); //*.txt 에서 .txt를 가져오는 거
	//String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
	filesize = mpr.getSize() ;
	
	//File file = new File("c:\\Repository\\test\\kkk.txt);
	targetFile = new File(path + org_filename);
	mpr.transferTo(targetFile); //raw data를 targetFile에서 가진 정보대로 변환
	
	System.out.println("파일명 = " + org_filename);
	}
	
	System.out.println("파일사이즈 = " + filesize);
	}	
	
	}
	
	
	
	@GetMapping("/study/fileUploadBySink")
	public void getFileUploadBySink() throws Exception{
	
	}
	@ResponseBody
	@PostMapping("/studyy/fileUploadBySink")
	public String postFileUploadBySink(@RequestParam("painter") String painter,
	@RequestParam ("fileUpload") List<MultipartFile> multipartFile) throws Exception {
	
	String path = "c:\\Repository\\test\\"; 
	String org_filename= "";
	long filesize = 0L;
	
	if(!multipartFile.isEmpty()) {
	File targetFile = null; 	
	
	for(MultipartFile mpr:multipartFile) {
	
	org_filename = mpr.getOriginalFilename();	
	//String org_fileExtension = org_filename.substring(org_filename.lastIndexOf(".")); //*.txt 에서 .txt를 가져오는 거
	//String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
	filesize = mpr.getSize() ;
	
	//File file = new File("c:\\Repository\\test\\kkk.txt);
	targetFile = new File(path + org_filename);
	mpr.transferTo(targetFile); //raw data를 targetFile에서 가진 정보대로 변환
	
	}
	
	}	
	
	return "good";
	
	}
	
	@GetMapping("/study/fileList")
	public void getFileList() throws Exception{
	
	}
	
	
	//파일 다운로드
	@GetMapping("/study/fileDownload")
	public void fileDownload(@RequestParam("file") String file, HttpServletResponse rs) throws Exception {
	
	String path = "c:\\Repository\\test\\";
	
	byte fileByte[] = FileUtils.readFileToByteArray(new File(path+file));
	
	//헤드값을 Content-Disposition로 주게 되면 Response Body로 오는 값을 filename으로 다운받으라는 것임
	//예) Content-Disposition: attachment; filename="hello.jpg"
	rs.setContentType("application/octet-stream");
	rs.setContentLength(fileByte.length);
	rs.setHeader("Content-Disposition",  "attachment; filename=\""+URLEncoder.encode(file, "UTF-8")+"\";");
	rs.getOutputStream().write(fileByte);
	rs.getOutputStream().flush(); //버퍼에 있는 내용을 write
	rs.getOutputStream().close();
	
	}
	
	
	
	@GetMapping("/study/login")
	public void getLogin(HttpSession session) throws Exception {
	
	String password_before = "12345";
	String password_after = pwdEncoder.encode(password_before);
	
	System.out.println("password = " + password_before + " -> " + password_after);
	
	if(pwdEncoder.matches(password_before, password_after))
	System.out.println("password correct");
	else
	System.out.println("password error");
	
	//session 가져오는 법 (Server)
	session.setAttribute("userid", "minie2000");
	session.setAttribute("username", "김민영");
	//session 유지 시간 설정 
	session.setMaxInactiveInterval(3600*24*7); //sec단위, 7일간 유지
	}*/
	

}
