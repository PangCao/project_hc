package controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import command.MemberCommand;
import service.MemberDao;
//공통 컨트롤
@Controller
public class CommonController {
		
	
		// 로그인
		@RequestMapping("/login")
		public String login(MemberCommand MC, HttpSession session, HttpServletResponse rep) {
			
			return "mainpage";
		}
		
		//로그아웃
		@RequestMapping("/logout")
		public String logout() {
			return "main";
		}
		
		//메인 페이지
		@RequestMapping("/mainpage")
		public String mainpage() {
			return "mainpage";
		}
		
		//공지사항
		@RequestMapping("/notice")
		public String notice() {
			return "board/notice";
		}
		
		//이슈관리
		@RequestMapping("/issue")
		public String issue() {
			return "board/issue";
		}
		
		//개인정보 관리
		@RequestMapping("/user_modify")
		public String user_authentication() {
			return "user_setting/user_modify";
		}
		
		//공지사항쓰기
	    @RequestMapping("/notice_write")
	    public String notice_write() {
	        return "board/notice_write";
	    }
}
