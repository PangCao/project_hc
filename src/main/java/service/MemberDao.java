package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import command.MemberCommand;

public class MemberDao {
	
	private JdbcTemplate jt;
	
	public MemberDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	//로그인
	public boolean memberlist(MemberCommand memcom, HttpSession session){
		if(memcom != null) {
			
			String sql = "select * from member where m_num = ? and m_password = ? ";
			
			List<MemberCommand> result = jt.query(sql, new RowMapper<MemberCommand>(){
	
				@Override
				public MemberCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
					MemberCommand dto = new MemberCommand();
					dto.setM_name(rs.getString("m_name"));
					dto.setM_position(rs.getString("m_position"));
					dto.setM_department(rs.getString("m_department"));
					return dto;
				}},memcom.getM_num(),memcom.getM_password());
			if(!result.isEmpty()) {
				session.setAttribute("member", result.get(0));
				return true;
			}
		}
		return false;
	}
	
	//로그아웃
	public void logout(HttpSession session) {
		session.invalidate();
	}
}
