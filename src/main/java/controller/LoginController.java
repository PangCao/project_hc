package controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

//현재 여기 작성중에 그만둠
@Controller
@RequestMapping("/login")
public class LoginController {
	
	@PostMapping
	public String login(LoginCommand loginCommand, Errors errors , HttpSession session, HttpServletResponse rep) {
		new LoginCommandValidator().validate(loginCommand, errors);
		if(errors.hasErrors()) {
			return "login";
		}
		
		return "main";
	}
	
	
}
