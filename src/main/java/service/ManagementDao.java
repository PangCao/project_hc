package service;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

public class ManagementDao {
	
	private JdbcTemplate jt;
	
	public ManagementDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	public void setProject(String name,String date) {
		if(name != null& date != null) {
			String sql = "insert";
		}
	}
}
