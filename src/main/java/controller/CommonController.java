package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import command.MemberCommand;
import service.BoardDao;
import service.MemberDao;
//공통 컨트롤
@Controller
public class CommonController {
	
	@Autowired
	private BoardDao dao;
	@Autowired
	private MemberDao memdao;
	
	// 로그인
	@RequestMapping("/login")
	public String login(MemberCommand MC, HttpSession session, Model model) {
		boolean res = memdao.memberlist(MC,session);
		if(res) {
			return "redirect:mainpage";
		}
		else {
			model.addAttribute("error","아이디 및 비밀번호를 입력해주세요");
			return "main";
		}
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout() {
		return "main";
	}
	
	//메인 페이지
	@RequestMapping("/mainpage")
	public String mainpage(@RequestParam(defaultValue = "1") int noticepage, @RequestParam(defaultValue = "1") int remarkpage, Model model) {
		model.addAttribute("noticelist", dao.noticeView(noticepage, 5));
		model.addAttribute("noticepage", (Integer)noticepage);
		model.addAttribute("remarkpage", (Integer)remarkpage);
		model.addAttribute("noticetotal", dao.totalpage("notice"));
		model.addAttribute("remarktotal", dao.totalpage("remark"));
		return "mainpage";
	}
	
	//공지사항
	@RequestMapping("/notice")
	public String notice(@RequestParam(defaultValue = "1") int noticepage, Model model) {
		model.addAttribute("noticelist", dao.noticeView(noticepage, 10));
		model.addAttribute("noticepage", (Integer)noticepage);
		model.addAttribute("noticetotal", dao.totalpage("notice"));
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
