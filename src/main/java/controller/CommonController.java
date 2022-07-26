package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import command.MemberCommand;
import command.NoticeCommand;
import command.RemarkCommand;
import service.CommonDao;
import service.MemberDao;
//공통 컨트롤
@Controller
public class CommonController {
	
	@Autowired
	private CommonDao dao;
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
	public String logout(HttpSession session) {
		memdao.logout(session);
		return "main";
	}
	
	//메인 페이지
	@RequestMapping("/mainpage")
	public String mainpage(@RequestParam(defaultValue = "1") int noticepage, @RequestParam(defaultValue = "1") int remarkpage, Model model) {
		model.addAttribute("noticelist", dao.noticeView(noticepage, null, 5));
		model.addAttribute("noticepage", (Integer)noticepage);
		model.addAttribute("remarkpage", (Integer)remarkpage);
		model.addAttribute("noticetotal", dao.totalpage("notice", null));
		model.addAttribute("remarktotal", dao.totalpage("remark", null));
		return "mainpage";
	}
	
	//공지사항 페이지
	@RequestMapping("/notice")
	public String notice(@RequestParam(defaultValue = "1") int noticepage, @RequestParam(required = false) String search_title, Model model) {
		model.addAttribute("noticelist", dao.noticeView(noticepage, search_title, 10));
		model.addAttribute("noticepage", (Integer)noticepage);
		model.addAttribute("paging", dao.pageConut(dao.totalpage("notice", search_title), noticepage));
		return "board/notice";
	}
	
	//공지사항 작성 등록
    @RequestMapping("/notice_write_input")
    public String notice_write(NoticeCommand noticeCommand) {
    	dao.notice_input(noticeCommand);
        return "redirect:notice";
    }
    
    //공지사항 상세 뷰 페이지
    @RequestMapping("/notice_view")
    public String notice_view(@RequestParam int n_id, Model model) {
    	dao.notice_viewUp(n_id);
    	model.addAttribute("notice_detail", dao.noticeDetail(n_id));
    	model.addAttribute("paging", dao.noticepaging(n_id));
    	return "board/notice_view";
    }
    
    //공지사항 게시물 삭제
    @RequestMapping("/notice_delete")
    public String notice_delete(@RequestParam int n_id, RedirectAttributes ra) {
    	dao.notice_del(n_id);
    	ra.addFlashAttribute("delete", "true");
    	return "redirect:notice";
    }
    
    //이슈관리 페이지
  	@RequestMapping("/issue")
  	public String issue(@RequestParam(defaultValue = "1") int issuepage,@RequestParam(required = false) String search_title, @RequestParam(required = false) String r_class, Model model) {
  		model.addAttribute("issuelist", dao.issueView(issuepage,search_title,r_class,10));
  		model.addAttribute("issuepage", (Integer)issuepage);
  		model.addAttribute("issuetotal", dao.totalpage("issue", search_title));
  		return "board/issue";
  	}
  	
  	//이슈 작성 등록
    @RequestMapping("/issue_write_input")
    public String issue_write(RemarkCommand remarkCommand, HttpSession session) {
    	dao.issue_input(remarkCommand, session);
        return "redirect:issue";
    }
    
    //이슈 상세 뷰 페이지
    @RequestMapping("/issue_view")
    public String issue_view(@RequestParam int r_id, Model model) {
    	dao.issue_viewUp(r_id);
    	model.addAttribute("issue_detail", dao.issueDetail(r_id));
    	model.addAttribute("paging", dao.issuepaging(r_id));
    	return "board/issue_view";
    }
    
    //이슈 게시물 삭제
    @RequestMapping("/issue_delete")
    public String issue_delete(@RequestParam int n_id, RedirectAttributes ra) {
    	dao.issue_del(n_id);
    	ra.addFlashAttribute("delete", "true");
    	return "redirect:issue";
    }
}
