package com.LolBoard.controller;


import java.io.File;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.checkerframework.checker.units.qual.t;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.LolBoard.dto.FileVO;
import com.LolBoard.dto.UserVO;
import com.LolBoard.service.BoardService;
import com.LolBoard.service.UserService;

@Controller
public class UserController {

////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	@Autowired
	//SFtestMapper mapper;
	UserService service;

	@Autowired
	BoardService boardService;
	
	@Autowired //비밀번호 암호화 이존성 주입
	private BCryptPasswordEncoder pwdEncoder;
	
	
	
	//회원가입 화면 보기
	@GetMapping("/user/sign")
	public void getSignup() throws Exception {	}
	
	//사용자 등록 시 아이디 중복 확인
	@ResponseBody
	@PostMapping("/user/idCheck")
	public int idCheck(@RequestBody String userid) throws Exception{ //@RequestBody를 써야 body를 가져옴 !!!
		
		int result = service.idCheck(userid);
		
		return result;
	}
	
	//회원가입 처리
	@PostMapping("/user/sign")
	public String postSignup(UserVO user, @RequestParam("country") String country, HttpServletRequest request) throws Exception {
		
		String inPwd = user.getPassword();
		String pwd = pwdEncoder.encode(inPwd);
		user.setPassword(pwd);
		
		user.setCountry(country);
		
		service.SignUp(user);
		//request.setAttribute("message", "Successfully signed up!");
		//request.setAttribute("url", "/");
		//return "alert";
		return "redirect:/";
	}

	@GetMapping("/user/loginCheck")
	public void getLogin(Model model) {}
	
	//로그인 기능
	@ResponseBody
	@PostMapping("/user/loginCheck")
	public String loginCheck(HttpSession session, UserVO loginData, HttpServletRequest request, @RequestParam("autologin") String autologin) throws Exception {
		
		String authkey = "";
		
		if(autologin.equals("NEW")) {
			authkey = UUID.randomUUID().toString().replaceAll("-", "");
			loginData.setAuthkey(authkey);
			service.authkeyUpdate(loginData);
		}
		
		if(autologin.equals("PASS")) {
			UserVO userinfo = service.userinfoByAuthkey(loginData.getAuthkey());
			
			if(userinfo != null) {
				session.setMaxInactiveInterval(3600*7);
				session.setAttribute("userid", userinfo.getUserid());
				session.setAttribute("username", userinfo.getUsername());
				session.setAttribute("role", userinfo.getRole());
				session.setAttribute("avatar", userinfo.getAvatar());
				
				return "{\"message\":\"good\"}";
			} else {
				return "{\"message\":\"bad\"}";
			}
		}
		
		//아이디 존재 여부 확인
				//아이디가 없으면 첫 페이지로 돌아감
				if(service.idCheck(loginData.getUserid()) == 0) {
				
					return "{\"message\":\"ID_NOT_FOUND\"}";
					
					
					//request.setAttribute("message", "Invalid ID. Please try again.");
					//request.setAttribute("url", "/");
					//return "alert";
				}

				//아이디가 존재하면 userid로 로그인 정보 가져오기
				UserVO user = service.login(loginData.getUserid());
				
				/*password를 해시화 안했을 때 그냥 String 값으로 비교
				System.out.println("loginData = " + loginData.getPassword()); //입력한 pw값
				System.out.println("user = " + user.getPassword()); //db에서 가져온 id의 pw값
				System.out.println(pwdEncoder.matches(user.getPassword(), loginData.getPassword()));
				
				if(!loginData.getUserid().equals(user.getUserid()))
					return "redirect:/";
				else
					session.setAttribute("userid", user.getUserid());
					session.setAttribute("username", user.getUsername());
					return "redirect:/board/list";
				*/
				
				//password를 해시화 했을 때 matches 함수를 통해 확인
				if(!pwdEncoder.matches(loginData.getPassword(), user.getPassword())) { //로그인으로 한 userid의 password와 db에 있는 user의 userid가 다르면

					return "{\"message\":\"PASSWORD_NOT_FOUND\"}";
					
					//request.setAttribute("message", "Invalid Password. Please try again.");
					//request.setAttribute("url", "/");
					
					//return "alert";

				}else {
									
					//세션 가져오기
					session.setAttribute("userid", user.getUserid());
					session.setAttribute("username", user.getUsername()); 
					session.setAttribute("role", user.getRole());
					session.setAttribute("avatar", user.getAvatar());

					System.out.println(session.getAttribute("userid"));
					System.out.println("role = " + session.getAttribute("role"));
					System.out.println("avatar = " + session.getAttribute("avatar"));

					//return "redirect:/board/list?page=1";
					return "{\"message\":\"good\",\"authkey\":\"" + user.getAuthkey() + "\"}";
				}
		}
	
	
	
	//로그아웃 기능
	@GetMapping("/user/logout")
	public String getLogout(HttpSession session,Model model, HttpServletRequest request) {
	
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	
	model.addAttribute("userid", userid);
	model.addAttribute("username", username);
	
	session.invalidate(); //모든 세션 종료--> 로그아웃...
	
	//request.setAttribute("message", "Successfully logged out");
	//request.setAttribute("url", "/");
	//return "alert";
	return "redirect:/";
	
	}
	
	//마이페이지 보기
	@GetMapping("/user/mypage")
	public void getMypage(UserVO user, Model model, HttpSession session) throws Exception {
		
		System.out.println((String)session.getAttribute("userid"));
		model.addAttribute("user", service.mypage((String)session.getAttribute("userid")));
		
		if ((String)session.getAttribute("userid") != null){
		int passwordTimeSec = service.passwordTime((String)session.getAttribute("userid"));
		int passwordTime = (int) Math.floor(passwordTimeSec / (60 * 60 * 24 * 10));
		model.addAttribute("passwordTime", passwordTime);
		}
		
		
	}
	
	//사용자 정보 수정 보기
	@GetMapping("/user/changeInfo")
	public void getUserInfoModify(Model model,HttpSession session) throws Exception {
		
		String userid = (String)session.getAttribute("userid");
		UserVO user = service.mypage(userid);
		
		model.addAttribute("user", user);
	}
	
	//사용자 정보 수정
	@ResponseBody
	@PostMapping("/user/changeInfo")
	public String postUserInfoModify(UserVO user) throws Exception{

		service.userInfoUpdate(user);
		
		//return "{\"message\":\"good\"}";
		return "good";
	}
	
	//avatar 수정
	@PostMapping("/user/changeAvatar")
	public String postChangeAvatar(UserVO user, HttpSession session) throws Exception {
		
		String userid = (String)session.getAttribute("userid");
		user.setUserid(userid);
		System.out.println("Change Avatar to " + user.getAvatar() + user.getUserid());
		service.userAvatarUpdate(user);
		
		return "redirect:/user/changeInfo";
		
	}
	
	//password 변경
	@GetMapping("/user/changePassword")
	public void getChangePassword(HttpSession session, Model model) throws Exception{
		
		String userid = (String)session.getAttribute("userid");
		int passwordTimeSec = service.passwordTime(userid);
		int passwordTime = (int) Math.floor(passwordTimeSec / (60 * 60 * 24 * 10));
		model.addAttribute("passwordTime", passwordTime);
	}
	
	@ResponseBody
	@PostMapping("/user/changePassword")
	public String postChangePassword(@RequestParam("old_password") String old_password, 
					@RequestParam("password") String password, HttpSession session) throws Exception {
		
		String userid = (String)session.getAttribute("userid");
			System.out.println("userid = " + userid);
		UserVO user = service.mypage(userid);
			System.out.println("password = " + user.getPassword());
		if(pwdEncoder.matches(old_password, user.getPassword())) {
			user.setPassword(pwdEncoder.encode(password));
			service.passwordUpdate(user);
			System.out.println("new password = " + user.getPassword());
			
			return "good";
		}
		
		else {
			return "bad";
		}
		
		//return "redirect:/user/logout";
	}
	
	//아이디 찾기 보기
	@GetMapping("/user/findMyId")
	public void getSearchID() { } 
	
	//사용자 아이디 찾기 
	@PostMapping("/user/findMyId")
	public String postSearchID(UserVO user, HttpServletRequest request) { 
		
		String userid = service.searchID(user);
		System.out.println("userid = " + userid);		
		//조건에 해당하는 사용자가 아닐 경우 
		if(userid == null ) { 
			request.setAttribute("message", "NO ID FOUND");
			request.setAttribute("url", "/user/findMyId");
			return "alert";
		}
		
		return "redirect:/user/IDView?userid=" + userid;		
	} 
	
	//찾은 아이디 보기
	@GetMapping("/user/IDView")
	public void postSearchID(@RequestParam("userid") String userid, Model model) {
		
		model.addAttribute("userid", userid);
		
	}
	
	//사용자 패스워드 임시 발급 보기
	@GetMapping("/user/findMyPassword")
	public void getSearchPassword() {}
	


	//사용자 패스워드 임시 발급
	@PostMapping("/user/findMyPassword")
	public String postSearchPassword(UserVO user, HttpServletRequest request) { 
		
		if(service.searchPassword(user)==0) {
			
			request.setAttribute("message", "PASSWORD NOT FOUND");
			request.setAttribute("url", "/user/findMyPassword");
			return "alert";			
		}
		
		//숫자 + 영문대소문자 7자리 임시패스워드 생성
		StringBuffer tempPW = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 7; i++) {
		    int rIndex = rnd.nextInt(3);
		    switch (rIndex) {
		    case 0:
		        // a-z : 아스키코드 97~122
		    	tempPW.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // A-Z : 아스키코드 65~122
		    	tempPW.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        // 0-9
		    	tempPW.append((rnd.nextInt(10)));
		        break;
		    }
		}
		
		user.setPassword(pwdEncoder.encode(tempPW));
		service.passwordUpdate(user);
			
		return "redirect:/user/tempPasswordView?password=" + tempPW;
		
	} 
	
	//발급한 임시패스워드 보기
	@GetMapping("/user/tempPasswordView")
	public void getTempPWView(Model model, @RequestParam("password") String password) {
		
		model.addAttribute("password", password);
		
	}
	
	//회원탈퇴
	@GetMapping("user/deleteAccount")
	public String getDeleteAccount(HttpSession session) throws Exception {
		
		String userid = (String)session.getAttribute("userid"); 
		String path_file = "c:\\Repository\\file\\";
		
		//회원이 업로드한 파일 삭제
		List<FileVO> fileList = boardService.fileInfoByUserid(userid);
		for(FileVO vo:fileList) {
			File f = new File(path_file + vo.getStored_filename());
			f.delete();
		}
		
		//게시물,댓글,파일업로드 정보, 회원정보 전체 삭제
		service.deleteAccount((String)session.getAttribute("userid"));
		
		session.invalidate();
		
		return "redirect:/";
	}


}



	

