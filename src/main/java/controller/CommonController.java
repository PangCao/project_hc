package controller;

import java.util.Map;

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
import command.Remark_projectCommand;
import service.CommonDao;
import service.DefaultDao;
import service.MemberDao;
//공통 컨트롤
@Controller
public class CommonController {
	
	@Autowired
	private CommonDao dao;
	
	@Autowired
	private MemberDao memdao;
	
	@Autowired
	private DefaultDao dfdao;
	
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
	public String mainpage(@RequestParam Map<String, Object> requestValues, Model model) {
		model.addAttribute("noticelist", dao.noticeView(requestValues, 5));
		model.addAttribute("issuelist", dao.issueMainView(requestValues, 5));
		model.addAttribute("issueSublist", dao.issueSubView());
		model.addAttribute("noticepage", requestValues.get("noticepage") == null? 1:Integer.valueOf((String)requestValues.get("noticepage")));
		model.addAttribute("remarkpage", requestValues.get("remarkpage") == null? 1:Integer.valueOf((String)requestValues.get("remarkpage")));
		model.addAttribute("noticetotal", dao.totalpage("notice", requestValues));
		model.addAttribute("remarktotal", dao.totalpage("remark", requestValues));
		model.addAttribute("projectmap", dao.projectmap());
		
		return "mainpage";
	}
	
	//공지사항 페이지
	@RequestMapping("/notice")
	public String notice(@RequestParam Map<String, Object> requestValues, Model model) {
		model.addAttribute("noticelist", dao.noticeView(requestValues, 10));
		model.addAttribute("noticepage", (Integer)requestValues.get("noticepage"));
		model.addAttribute("paging",dfdao.paging(dao.totalpage("notice", requestValues), requestValues));
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
  	@RequestMapping("/issue") // required = false는 null값을 받아도 된다는 설정
  	public String issue(@RequestParam Map<String, Object> requestValues, Model model) {
//  	public String issue(@RequestParam(defaultValue = "1") int issuepage,
//  			@RequestParam(required = false) String search_title, 
//  			@RequestParam(required = false) String r_class, 
//  			@RequestParam(required = false) String sdate,
//  			@RequestParam(required = false) String fdate,
//  			Model model) {
//  		model.addAttribute("issuepage", (Integer)issuepage);
//  		model.addAttribute("issuetotal", dao.totalpage("issue", search_title));
  		
  		
  		model.addAttribute("sdate", (String)requestValues.get("sdate"));
  		model.addAttribute("fdate", (String)requestValues.get("fdate"));
  		model.addAttribute("issuelist", dao.issueView(requestValues, 10));
  		model.addAttribute("paging", dfdao.paging(dao.issuetotal(requestValues, 10), requestValues));
  		model.addAttribute("r_class",requestValues.get("r_class"));
  		model.addAttribute("search_title", requestValues.get("search_title"));
  		return "board/issue";
  	}
  	
  	//이슈 작성 등록
    @RequestMapping("/issue_write_input")
    public String issue_write(@RequestParam String p_num, Remark_projectCommand rp_command, RemarkCommand remarkCommand, HttpSession session) {
    	System.out.println(p_num);
    	int r_id = dao.issue_input(remarkCommand, session, p_num);
    	dao.issue_input_sub(r_id, rp_command, remarkCommand);
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
    public String issue_delete(@RequestParam int r_id, RedirectAttributes ra) {
    	dao.issue_del(r_id);
    	ra.addFlashAttribute("delete", "true");
    	return "redirect:issue";
    }
    
    @RequestMapping("/issue_search_popup")
    public String issue_search(@RequestParam Map<String, Object> requestValues,Model model) {
    	model.addAttribute("productlist", dao.product_issue_select(requestValues));
    	model.addAttribute("projectmap", dao.projectmap());
    	model.addAttribute("projectlist", dao.projectlist());
    	model.addAttribute("project_id", requestValues.get("project_id"));
    	model.addAttribute("searchword", requestValues.get("searchword"));
		model.addAttribute("paging", dfdao.paging(dao.product_issue_total(requestValues),requestValues));
    	return "board/issue_search_popup";
    }
}
