package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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
					dto.setM_num(rs.getString("m_num"));
					dto.setM_name(rs.getString("m_name"));
					dto.setM_position(rs.getString("m_position"));
					dto.setM_department(rs.getString("m_department"));
					dto.setM_tel(rs.getString("m_tel"));
					return dto;
				}},memcom.getM_num(),memcom.getM_password());
			if(!result.isEmpty()) {
				
				session.setAttribute("member", result.get(0));
				session.setAttribute("id", result.get(0).getM_num());
				session.setAttribute("department", result.get(0).getM_department());
				session.setAttribute("name", result.get(0).getM_name());
				return true;
			}
		}
		return false;
	}
	// 비밀번호 확인용 메서드(지금 접속한 아이디의 비밀번호와 입력한 비밀번호가 일치하는지)
		public boolean passwordchk(String password, HttpSession session) {
			MemberCommand memberCommand = (MemberCommand)session.getAttribute("member");
			String sql = "select count(*) from member where m_num=? and m_password=?";
			int result = jt.queryForObject(sql, Integer.class,memberCommand.getM_num() , password);
			if (result == 1) {
				return true;
			}
			else {
				return false;
			}
		}

		// 개인정보 수정 메서드(이름, 전화번호, 비밀번호 변경 가능)
		// 비밀번호가 아무 값이 없으면 비밀번호 제외 모든 값 변경(있다면 비밀번호도 포함하여 변경)
		public void user_modi(MemberCommand memberCommand, Map<String, Object> requestMap, HttpSession session) {
			String pw = (String)requestMap.get("password");
			String tel = requestMap.get("phone1")+"-"+requestMap.get("phone2")+"-"+requestMap.get("phone3");
			MemberCommand sessionMemberCommand = (MemberCommand)session.getAttribute("member");
			String sql = null;
			if(pw.equals("")) {
				sql = "update member set m_name=?, m_tel=? where m_num=?";
				jt.update(sql, memberCommand.getM_name(), tel, sessionMemberCommand.getM_num());
			} 
			else {
				sql = "update member set m_name=?, m_tel=?, m_password=? where m_num=?";
				jt.update(sql, memberCommand.getM_name(), tel, pw, sessionMemberCommand.getM_num());
			}
			sessionMemberCommand.setM_tel(tel);
			sessionMemberCommand.setM_name(memberCommand.getM_name());
		}
	
	//로그아웃
	public void logout(HttpSession session) {
		session.invalidate();
	}
}
