package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.LeftController;
import controller.LoginController;
import controller.TopController;

@Configuration
public class ControllerConfig {
	
	@Bean
	public LoginController loginController() {
		return new LoginController();
	}
	
	@Bean
	public LeftController leftController() {
		return new LeftController();
	}
	
	@Bean
	public TopController topController() {
		return new TopController();
	}
}
