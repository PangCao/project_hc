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
import service.MemberDao;

@Controller
public class UserController {
	
	@Autowired
	private MemberDao dao;
	
	//개인정보 관리창 비밀번호 확인
	@RequestMapping("/user_modify")
	public String user_authentication(@RequestParam String password, HttpSession session, Model model) {
		boolean chk = dao.passwordchk(password, session);
		if (chk) {
			return "user_setting/user_modify";	
		}
		else {
			model.addAttribute("error", "1");
			return "user_setting/user_authentication";
		}
	}
	
	//개인정보 수정
	 @RequestMapping("/user_modify_submit")
    public String user_modify_submit(MemberCommand memberCommand, @RequestParam Map<String, Object> requestMap, HttpSession session, RedirectAttributes redirectAttribute) {
	    	dao.user_modi(memberCommand, requestMap, session);
	    	redirectAttribute.addFlashAttribute("error","2");
	    	return "redirect:user_authentication";
    }
}
