package controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class LoginController {
	
	// 로그인
	@RequestMapping("/login")
	public String login(LoginCommand loginCommand, HttpSession session, HttpServletResponse rep) {
		return "mainpage";
	}
	
	@RequestMapping("/logout")
	public String logout() {
		return "main";
	}
	
	@RequestMapping("/mainpage")
	public String mainpage() {
		return "mainpage";
	}
	
	@RequestMapping("/product_management")
	public String product_management() {
		
		return "product_management/project_management";
	}
	

}
