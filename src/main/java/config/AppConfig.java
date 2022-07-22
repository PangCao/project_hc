package config;


import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import service.BoardDao;
import service.ManagementDao;
import service.MemberDao;

@Configuration
@EnableTransactionManagement
public class AppConfig {
	
	@Bean(destroyMethod="close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost:3306/hcproject?characterEncoding=utf8&useSSL=false");
		ds.setUsername("root");
		ds.setPassword("1234");
		return ds;
	}
	
	@Bean
	public MemberDao loginDao() {
		return new MemberDao(dataSource());
	}
	
	@Bean
	public BoardDao boardDao() {
		return new BoardDao(dataSource());
	}
	
	@Bean
	public ManagementDao managementDao() {
		return new ManagementDao(dataSource());
	}
	
}
