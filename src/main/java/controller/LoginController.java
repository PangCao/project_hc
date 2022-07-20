package controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class LoginController {
	
	@RequestMapping("/product_management")
	public String login(LoginCommand loginCommand, HttpSession session, HttpServletResponse rep) {
		
		return "product_management/project_management";
	}
	
	@RequestMapping("/management")//전체 공정 현황
	public String management(){
		return "product_management/project_management";
	}
	
	@RequestMapping("/input")//생산 작업 지시 등록
	public String input(){
		return "product_management/process_input";
	}
	
	@RequestMapping("/complete")//생산 작업 지시 착수
	public String complete(){
		return "product_management/product_complete";
	}
}
