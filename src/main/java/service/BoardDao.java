package service;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

public class BoardDao {

	private JdbcTemplate jt;
	
	BoardDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
//	public List<> notice
}
