package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.CommonController;
import controller.OutsourcingController;
import controller.ProductionController;
import controller.UserController;

@Configuration
public class ControllerConfig {
	
	@Bean
	public CommonController loginController() {
		return new CommonController();
	}
	
	@Bean
	public ProductionController leftController() {
		return new ProductionController();
	}
	
	@Bean
	public OutsourcingController topController() {
		return new OutsourcingController();
	}
	
	@Bean
	public UserController userController() {
		return new UserController();
	}
}
