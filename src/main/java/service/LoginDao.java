package service;

import java.sql.ResultSet;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import controller.LoginCommand;

public class LoginDao {
	
	private JdbcTemplate jdbcTemplate;
	
	public LoginDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private RowMapper<LoginCommand> loginRowMapper = new RowMapper<LoginCommand>();
	
	@Override
	public LoginCommand loginCommand(ResultSet rs,)
}
