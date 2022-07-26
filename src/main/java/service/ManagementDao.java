package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import command.MemberCommand;
import command.ProductCommand;
import command.ProjectCommand;
import command.ProjectCreateCommand;
import command.RemarkCommand;

public class ManagementDao {
	
	private JdbcTemplate jt;
	
	public ManagementDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	// 프로젝트 명을 가져오는 메서드
	public List<ProjectCommand> projectlist() {
		String sql = "select * from project";
		
		List<ProjectCommand> result = jt.query(sql, new RowMapper<ProjectCommand>() {

			@Override
			public ProjectCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCommand command = new ProjectCommand();
				command.setPj_id(rs.getString("pj_id"));
				command.setPj_name(rs.getString("pj_name"));
				return command;
			}});
		
		return result;
	}
	
	// id에 일치하는 프로젝트 명과 아이디를 가져오는 메서드
	public ProjectCommand project_id_name(String project_id) {
		String sql = "select * from project where pj_id = ?";
		List<ProjectCommand> result = jt.query(sql, new RowMapper<ProjectCommand>() {

			@Override
			public ProjectCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCommand command = new ProjectCommand();
				command.setPj_id(rs.getString("pj_id"));
				command.setPj_name(rs.getString("pj_name"));
				return command;
			}}, project_id);
		return result.get(0);
	}
	
	// 이슈내역을 insert하고 키홀더 값을 반환하는 메서드
	public Integer remark_insert(RemarkCommand issue, HttpSession session) {
		if(issue.getR_title() != null && !issue.getR_title().trim().equals("")) {
			MemberCommand userInfo = (MemberCommand)session.getAttribute("member");
			String sql = "insert into remark (r_title, r_content, r_anthor, r_date, r_class, r_anthor_id) values (?,?,?,?,?,?)";
			KeyHolder kh = new GeneratedKeyHolder();
			jt.update(new PreparedStatementCreator() {
				
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement pstmt = con.prepareStatement(sql, new String[] {"r_id"});
					pstmt.setString(1, issue.getR_title());
					pstmt.setString(2, issue.getR_content());
					pstmt.setString(3, userInfo.getM_name());
					pstmt.setString(4, String.valueOf(LocalDateTime.now()));
					pstmt.setString(5, issue.getR_class());
					pstmt.setString(6, userInfo.getM_num());
					return pstmt;
				}
			}, kh);
			Number keyValue = kh.getKey();
			return keyValue.intValue();
		}
		else {
		 return -1;
		}
	}
	
	// 생산 작업을 등록하는 메서드
	public void product_insert(ProductCommand command, String prefix, String suffix, Integer remarkId, HttpSession session) {
		MemberCommand userInfo = (MemberCommand)session.getAttribute("member");
		String processnumber = prefix + suffix;
		String sql = "insert into product_management (p_proname, p_tasknumber, p_processnumber, p_regdate, p_remarkid, p_regnum, p_state) values (?,?,?,?,?,?,?)";
		if (remarkId == -1) {
			remarkId = null;
		} 
		jt.update(sql, command.getP_proname(), command.getP_tasknumber(), processnumber, LocalDateTime.now(), remarkId, userInfo.getM_num() , "결재 대기");
	}
	
	public List<ProductCommand> productlist() {
		String sql = "select * from product_management";
		List<ProductCommand> result = jt.query(sql, new RowMapper<ProductCommand>() {

			@Override
			public ProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProductCommand command = new ProductCommand();
				command.setP_num(rs.getInt("p_num"));
				command.setP_proname(rs.getString("p_proname"));
				command.setP_tasknumber(rs.getString("p_tasknumber"));
				command.setP_processnumber(rs.getString("p_processnumber"));
				command.setP_regdate(rs.getString("p_regdate"));
				command.setP_startdate(rs.getString("p_startdate") == null ? "-" : rs.getString("p_startdate"));
				command.setP_compledate(rs.getString("p_compledate") == null ? "-" : rs.getString("p_compledate"));
				command.setP_remarkid(rs.getString("p_remarkid"));
				command.setP_regnum(rs.getString("p_regnum"));
				return command;
			}});
		return result;
	}
	
	public Map<String, String> membermap() {
		Map<String, String> result = new HashMap<String, String>();
		String sql = "select m_num, m_name from member";
		jt.query(sql, new RowMapper<Object>() {

			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				result.put(rs.getString("m_num"), rs.getString("m_name"));
				return null;
			}});
			
		return result;
	}
	
	public List<RemarkCommand> issuelist(String issueids) {
		String[] search = issueids.split(",");
		String sql = "select * from remark where r_id = ?";
		List<RemarkCommand> remarklist = new ArrayList<RemarkCommand>();
		
		for (int i = 0; i < search.length; i++) {
			jt.query(sql, new RowMapper<Object>() {

				@Override
				public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
					RemarkCommand command = new RemarkCommand();
					command.setR_id(rs.getInt("r_id"));
					command.setR_title(rs.getString("r_title"));
					command.setR_content(rs.getString("r_content"));
					command.setR_anthor(rs.getString("r_anthor"));
					command.setR_date(rs.getString("r_date").substring(0,10));
					command.setR_view(rs.getInt("r_view"));
					command.setR_class(rs.getString("r_class"));
					command.setR_anthor_id(rs.getString("r_anthor_id"));
					remarklist.add(command);
					return null;
				}},search[i]);
		}
		
		return remarklist;
	}
	
	public void  ProjectCreate(String name){
		String sql = "insert into projectcreate (pc_namevalues) value(?)";
		jt.query(sql, new RowMapper<ProjectCreateCommand>() {

			@Override
			public ProjectCreateCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCreateCommand command = new ProjectCreateCommand();
				command.setPc_name(rs.getString("name"));
				return null;
			}
		},name);		
	}
}
