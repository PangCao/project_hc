package controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/product_management")
public class LoginController {
	
	
	
	@PostMapping
	public String login(LoginCommand loginCommand, HttpSession session, HttpServletResponse rep) {
		
		
		return "product_management/product_management";
	}
	
	
}
