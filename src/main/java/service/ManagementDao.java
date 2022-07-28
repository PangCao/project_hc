package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
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
	
	//프로젝트 명을 맵으로 가져오는 메서드
	public Map<String, String> projectmap() {
		String sql = "select * from project";
		Map<String, String> resultmap = new HashMap<String, String>();
		
		jt.query(sql, new RowMapper<Object>() {

			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				resultmap.put(rs.getString("pj_id"), rs.getString("pj_name"));
				return null;
			}});
		
		return resultmap;
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
			String name = (String)session.getAttribute("name");
			String id = (String)session.getAttribute("id");
			String sql = "insert into remark (r_title, r_content, r_anthor, r_date, r_class, r_anthor_id) values (?,?,?,?,?,?)";
			KeyHolder kh = new GeneratedKeyHolder(); //자동 증가값을 알기 위해서 사용
			jt.update(new PreparedStatementCreator() {
				
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement pstmt = con.prepareStatement(sql, new String[] {"r_id"});
					pstmt.setString(1, issue.getR_title());
					pstmt.setString(2, issue.getR_content());
					pstmt.setString(3, name);
					pstmt.setString(4, String.valueOf(LocalDateTime.now()));
					pstmt.setString(5, issue.getR_class());
					pstmt.setString(6, id);
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
	public void product_insert(ProductCommand command, Map<String, Object> requestValues, Integer remarkId, HttpSession session) {
		String id = (String)session.getAttribute("id");
		String processnumber = (String)requestValues.get("p_prefix") + (String)requestValues.get("p_suffix");
		String sql = "insert into product_management (p_proid, p_tasknumber, p_processnumber, p_regdate, p_remarkid, p_regnum, p_state) values (?,?,?,?,?,?,?)";
		if (remarkId == -1) {
			remarkId = null;
		} 
		jt.update(sql, requestValues.get("project_id"), command.getP_tasknumber(), processnumber, LocalDateTime.now(), remarkId, id , "결재 대기");
	}
	
	public List<ProductCommand> productlist(String category, Map<String, Object> requestValues) {
		String sql = null;
		String project_id = (String)requestValues.get("project_id");
		String tasknumber = (String)requestValues.get("tasknumber");
		String processnumber = (String)requestValues.get("processnumber");
		
		if (category.equals("input")) {
			sql = "select * from product_management";
		}
		else if (category.equals("complete")) {
			if (project_id != null && !project_id.equals("null")) {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"' and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"' and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"'";
				}
			}
			else {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select * from product_management where p_startdate is null and p_compledate is null";
				}
			}
		}
		else {
			if (project_id != null && !project_id.equals("null")) {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_proid='"+project_id+"' and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_proid='"+project_id+"' and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select * from product_management where p_startdate is not null and p_proid='"+project_id+"'";
				}
			}
			else {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select * from product_management where p_startdate is not null";
				}
			}
		}
		List<ProductCommand> result = jt.query(sql, new RowMapper<ProductCommand>() {

			@Override
			public ProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProductCommand command = new ProductCommand();
				command.setP_num(rs.getInt("p_num"));
				command.setP_proid(rs.getString("p_proid"));
				command.setP_tasknumber(rs.getString("p_tasknumber"));
				command.setP_processnumber(rs.getString("p_processnumber"));
				command.setP_regdate(rs.getString("p_regdate"));
				command.setP_startdate(rs.getString("p_startdate") == null ? "-" : rs.getString("p_startdate"));
				command.setP_compledate(rs.getString("p_compledate") == null ? "-" : rs.getString("p_compledate"));
				command.setP_remarkid(rs.getString("p_remarkid"));
				command.setP_regnum(rs.getString("p_regnum"));
				command.setP_state(rs.getString("p_state"));
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
	
	public Integer totalpage(String category, Map<String, Object> requestValues) {
		String sql = null;
		String project_id = (String)requestValues.get("project_id");
		String tasknumber = (String)requestValues.get("tasknumber");
		String processnumber = (String)requestValues.get("processnumber");
		if (category.equals("input")) {
			
			sql = "select count(*) from product_management";
		}
		else if (category.equals("complete")) {
			if (project_id != null && !project_id.equals("null")) {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"' and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"' and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select count(*) from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"'";
				}
			}
			else {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is null and p_compledate is null and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is null and p_compledate is null and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select count(*) from product_management where p_startdate is null and p_compledate is null";
				}
			}
		}
		else {
			if (project_id != null && !project_id.equals("null")) {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is not null and p_proid='"+project_id+"' and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is not null and p_proid='"+project_id+"' and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select count(*) from product_management where p_startdate is not null and p_proid='"+project_id+"'";
				}
			}
			else {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is not null and p_tasknumber like '%"+tasknumber+"%'";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select count(*) from product_management where p_startdate is not null and p_processnumber like '%"+processnumber+"%'";
				}
				else {
					sql = "select count(*) from product_management where p_startdate is not null";
				}
			}
		}
		Integer result = jt.queryForObject(sql, Integer.class);

		return result;
	}
	
	public Map<String, Integer> paging(Integer totalpage, Map<String, Object> requestValues) {
		Map<String, Integer> result = new HashMap<String, Integer>();
		int max = 5;
		int min = 0;
		int page = 1;
		if (requestValues.get("page") != null && !requestValues.get("page").equals("null")) {
			page = Integer.valueOf((String)requestValues.get("page"));
		}
		if (page > 3) {
			min = page - 3;
			max = page + 2;
		}
		if (max > totalpage/10 +1) {
			max = totalpage/10 + 1;
		}		
		if (totalpage % 10 == 0) {
			max -= 1;
		}
		if (totalpage == 0) {
			max = 1;
		}
		result.put("max", max);
		result.put("min", min);
		result.put("total", totalpage);
		result.put("page", page);
		
		return result;
	}
	
	public void startdate_update(int product_id) {
		String sql = "update product_management set p_startdate=? where p_num=?";
		jt.update(sql, LocalDateTime.now(), product_id);
	}
	
	public void compledate_update(int product_id) {
		String sql = "update product_management set p_compledate=? where p_num=?";
		jt.update(sql, LocalDateTime.now(), product_id);
	}
	
	
	//프로젝트 생성시 초기 데이터베이스 저장
	public void  ProjectCreate(String name, String date){
		String[] tasknum = {"A","B","C","D"};
		String[] propart = {"A(가공)","B(소조립)","C(대조립)","D(선행의장)","E(블럭도장)","F(P.E)","G(탑재)","H(DOCK의장)","I(진수선행도장)","J(진수)"};
		DecimalFormat df = new DecimalFormat("0000");
		DecimalFormat df2 = new DecimalFormat("00");
		int yyyy = LocalDateTime.now().getYear();
		
		String pc_sql = "select count(distinct pj_id) from project where pj_id like '%-"+yyyy+"-%'";
		long cnt = jt.queryForObject(pc_sql, Long.class);
		String pc_id = "PJT-"+yyyy+"-"+df.format(++cnt);
		
		String pj_sql = "insert into project(pj_id, pj_name, pj_regdate, pj_eta) values(?,?,?,?)";
		jt.update(pj_sql, pc_id, name, LocalDateTime.now(), date);
		
		String pc_sql1 = "insert into projectcreate(pc_id, pc_name, pc_tasknumber, pc_propart, pc_dpn) values(?,?,?,?,?)";
		
		ProjectCreateCommand pcc = new ProjectCreateCommand();
		
		for(int i=0;i<4;i++) {
			pcc.setPc_id(pc_id);
			for(int k=0; k<12;k++) {
				pcc.setPc_tasknumber((String)tasknum[i]+df2.format(k+1));
				for(int j=0; j<10;j++) {
					pcc.setPc_propart((String)propart[j]);
					jt.update(pc_sql1, pcc.getPc_id(), name, pcc.getPc_tasknumber(), pcc.getPc_propart() , "0000000000");
				}
			}
		}
	}
	
	public void remark_project_insert(ProductCommand command, RemarkCommand issue, int remarkId, Map<String, Object> requestValues) {
		String sql = "insert into remark_project (rp_r_id, rp_proid, rp_task, rp_process) values (?,?,?,?)";
		jt.update(sql, remarkId, requestValues.get("project_id"), command.getP_tasknumber(), (String)requestValues.get("p_prefix")+(String)requestValues.get("p_suffix"));
		
	}
	
	public Map<String, String> proparts(String project_id, String task) {
		Map<String, String> result = new HashMap<String, String>();
		String sql = "select * from projectcreate where pc_id=? and pc_tasknumber=?";
		jt.query(sql, new RowMapper<Object>() {

			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				result.put(rs.getString("pc_propart"),rs.getString("pc_dpn"));
				return null;
			}}, project_id, task);
		
		return result;
	}
	
	public void projectcreate_update(Map<String, Object> requestValues, int value) {
		String project_id = (String)requestValues.get("project_id");
		String p_tasknumber = (String)requestValues.get("p_tasknumber");
		String p_prefix= (String)requestValues.get("p_prefix");
		String p_suffix= (String)requestValues.get("p_suffix");
		String sql = "select * from projectcreate where pc_id=? and pc_tasknumber=? and pc_propart=?";
		List<String> result = jt.query(sql, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				System.out.println(rs.getString("pc_dpn"));
				return rs.getString("pc_dpn");
			}}, project_id, p_tasknumber, p_prefix);
		
		String dpn = result.get(0);
		int index = Integer.valueOf(p_suffix);
		dpn = dpn.substring(0, index-1) + value +dpn.substring(index);
		sql = "update projectcreate set pc_dpn=? where pc_id=? and pc_tasknumber=? and pc_propart=?";
		jt.update(sql, dpn, project_id, p_tasknumber, p_prefix);
	}
	
	//project테이블정보 가져오기
	public List<ProjectCommand> ProjectSearch () {
		String sql = "select * from project";
		
		List<ProjectCommand> result = jt.query(sql, new RowMapper<ProjectCommand>() {

			@Override
			public ProjectCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCommand procom = new ProjectCommand();
				procom.setPj_id(rs.getString("pj_id"));
				procom.setPj_name(rs.getString("pj_name"));
				procom.setPj_regdate(rs.getString("pj_regdate"));
				procom.setPj_eta(rs.getString("pj_eta").substring(0,11));
				procom.setPj_task(rs.getString("pj_task"));
				procom.setPj_progress(rs.getFloat("pj_progress"));
				return procom;
			}
		});
		return result.isEmpty() ? null : result;
	}
	
	//ProjectCreate테이블 정보 가져오기(단 프로젝트 아이디가 같을 경우)
	public List<ProjectCreateCommand> PccSearch(String Sequence){
		String sql = "select * from projectcreate where pc_id = ?";
		
		List<ProjectCreateCommand> result = jt.query(sql, new RowMapper<ProjectCreateCommand>() {

			@Override
			public ProjectCreateCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCreateCommand pcc = new ProjectCreateCommand();
				pcc.setPc_id(rs.getString("pc_id"));
				pcc.setPc_name(rs.getString("pc_name"));
				pcc.setPc_tasknumber(rs.getString("pc_tasknumber"));
				pcc.setPc_propart(rs.getString("pc_propart"));
				pcc.setPc_dpn(rs.getString("pc_dpn"));
				return pcc;
			}
		}, Sequence);
		return result.isEmpty() ? null : result;
	}
	
	public List<ProductCommand> pcom(String sq){
		String sql = "select * from product_management where p_proname = ?";
		
		List<ProductCommand> result = jt.query(sql, new RowMapper<ProductCommand>() {

			@Override
			public ProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProductCommand pdc = new ProductCommand();
				pdc.setP_proid(rs.getString("p_proname"));
				pdc.setP_tasknumber(rs.getString("p_tasknumber"));
				pdc.setP_processnumber(rs.getString("p_tasknumber"));
				pdc.setP_regdate(rs.getString("p_regdate"));
				pdc.setP_startdate(rs.getString("p_startdate"));
				pdc.setP_compledate(rs.getString("p_compledate"));
				pdc.setP_remarkid(rs.getString("p_remarkid"));
				pdc.setP_regnum(rs.getString("p_regnum"));
				return pdc;
			}
		},sq);
		return result.isEmpty()? null : result;
	}
}
