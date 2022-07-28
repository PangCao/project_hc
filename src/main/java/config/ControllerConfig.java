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
	public CommonController commonController() {
		return new CommonController();
	}
	
	@Bean
	public ProductionController productionController() {
		return new ProductionController();
	}
	
	@Bean
	public OutsourcingController outsourcingController() {
		return new OutsourcingController();
	}
	
	@Bean
	public UserController userController() {
		return new UserController();
	}
}
