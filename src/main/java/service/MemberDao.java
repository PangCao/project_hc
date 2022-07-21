package service;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import command.MemberCommand;

public class MemberDao {
	
	private JdbcTemplate jt;
	
	public MemberDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
//	private RowMapper<LoginCommand> loginRowMapper = new RowMapper<LoginCommand>() {
//
//		@Override
//		public LoginCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
//			LoginCommand loinCom = new LoginCommand(
//					rs.getSrting("ID")
//					);
//			return null;
//		}
//		
//	};
}
