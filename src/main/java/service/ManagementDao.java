package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.LocalDate;
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
	
	// 생산 작업을 등록하는 메서드
	public Integer product_insert(ProductCommand command, Map<String, Object> requestValues, HttpSession session) {
		String id = (String)session.getAttribute("id");
		String processnumber = (String)requestValues.get("p_prefix") + (String)requestValues.get("p_suffix");
		String sql = "insert into product_management (p_proid, p_tasknumber, p_processnumber, p_regdate, p_regnum, p_state) values (?,?,?,?,?,?)";
		KeyHolder kh = new GeneratedKeyHolder(); //자동 증가값을 알기 위해서 사용
		jt.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql, new String[] {"p_num"});
				pstmt.setString(1, (String)requestValues.get("project_id"));
				pstmt.setString(2, command.getP_tasknumber());
				pstmt.setString(3, processnumber);
				pstmt.setString(4, String.valueOf(LocalDateTime.now()));
				pstmt.setString(5, id);
				pstmt.setString(6, "결재 대기");
				return pstmt;
			}
		}, kh);
		Number keyValue = kh.getKey();
		return keyValue.intValue();
	}
	
	public Map<String, ArrayList<Integer>> product_issuelist() {
		Map<String, ArrayList<Integer>> result = new HashMap<String, ArrayList<Integer>>();
		
		String sql = "select * from product_management";
		List<Integer> p_num = jt.query(sql, new RowMapper<Integer>() {
	
			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("p_num");
			}});
		sql = "select * from remark where r_p_num=?";
		for (int i = 0; i < p_num.size(); i++) {
			List<Integer> list = jt.query(sql, new RowMapper<Integer>() {
	
				@Override
				public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
					
					return rs.getInt("r_id");
				}}, p_num.get(i));
			list = list == null?  new ArrayList<Integer>():list;
			
			result.put(String.valueOf(p_num.get(i)), (ArrayList)list);
			
		}
		return result;
	}

	public List<ProductCommand> productlist(String category, Map<String, Object> requestValues) {
		String sql = null;
		Integer page = Integer.valueOf((String)requestValues.get("page") == null? "1":(String)requestValues.get("page"));
		int SearchPage = (page -1 ) * 10;
		String project_id = (String)requestValues.get("project_id");
		String tasknumber = (String)requestValues.get("tasknumber");
		String processnumber = (String)requestValues.get("processnumber");
		
		if (category.equals("input")) {
			sql = "select * from product_management limit "+SearchPage+", 10";
		}
		else if (category.equals("complete")) {
			if (project_id != null && !project_id.equals("null")) {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"' and p_tasknumber like '%"+tasknumber+"%' limit "+SearchPage+", 10";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"' and p_processnumber like '%"+processnumber+"%' limit "+SearchPage+", 10";
				}
				else {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_proid='"+project_id+"' limit "+SearchPage+", 10";
				}
			}
			else {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_tasknumber like '%"+tasknumber+"%' limit "+SearchPage+", 10";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is null and p_compledate is null and p_processnumber like '%"+processnumber+"%' limit "+SearchPage+", 10";
				}
				else {
					sql = "select * from product_management where p_startdate is null and p_compledate is null";
				}
			}
		}
		else {
			if (project_id != null && !project_id.equals("null")) {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_proid='"+project_id+"' and p_tasknumber like '%"+tasknumber+"%' limit "+SearchPage+", 10";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_proid='"+project_id+"' and p_processnumber like '%"+processnumber+"%' limit "+SearchPage+", 10";
				}
				else {
					sql = "select * from product_management where p_startdate is not null and p_proid='"+project_id+"' limit "+SearchPage+", 10";
				}
			}
			else {
				if (tasknumber != null && !tasknumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_tasknumber like '%"+tasknumber+"%' limit "+SearchPage+", 10";
				}
				else if (processnumber != null && !processnumber.equals("")) {
					sql = "select * from product_management where p_startdate is not null and p_processnumber like '%"+processnumber+"%' limit "+SearchPage+", 10";
				}
				else {
					sql = "select * from product_management where p_startdate is not null limit "+SearchPage+", 10";
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
				command.setP_regnum(rs.getString("p_regnum"));
				command.setP_state(rs.getString("p_state"));
				return command;
			}});
		return result;
	}
	
	public void issue_delete(String r_id) {
		String sql = "delete from remark_project where rp_r_id=?";
		jt.update(sql, r_id);
		sql = "delete from remark where r_id=?";
		jt.update(sql, r_id);
	}
	
	// 이슈내역을 insert하고 키홀더 값을 반환하는 메서드
	public Integer remark_insert(RemarkCommand issue, HttpSession session, int p_num) {
		if(issue.getR_title() != null && !issue.getR_title().trim().equals("")) {
			String name = (String)session.getAttribute("name");
			String id = (String)session.getAttribute("id");
			String sql = "insert into remark (r_title, r_content, r_anthor, r_date, r_class, r_anthor_id, r_p_num) values (?,?,?,?,?,?,?)";
			KeyHolder kh = new GeneratedKeyHolder(); //자동 증가값을 알기 위해서 사용
			jt.update(new PreparedStatementCreator() {
				
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement pstmt = con.prepareStatement(sql, new String[] {"r_id"});
					pstmt.setString(1, issue.getR_title());
					pstmt.setString(2, issue.getR_content().replace("\n", "<br>"));
					pstmt.setString(3, name);
					pstmt.setString(4, String.valueOf(LocalDateTime.now()));
					pstmt.setString(5, issue.getR_class());
					pstmt.setString(6, id);
					pstmt.setInt(7, p_num);
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

	public List<RemarkCommand> issuelist(Map<String, Object> requestValues) {
		String p_num = (String)requestValues.get("p_num");
		int page =  requestValues.get("page") == null? 1:Integer.valueOf((String)requestValues.get("page"));
		int SearchPage = (page - 1) * 10;
		String sql = "select * from remark where r_p_num=? limit "+SearchPage+", 10";
		List<RemarkCommand> result = jt.query(sql, new RowMapper<RemarkCommand>() {

			@Override
			public RemarkCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				RemarkCommand command = new RemarkCommand();
				command.setR_id(rs.getInt("r_id"));
				command.setR_title(rs.getString("r_title"));
				command.setR_content(rs.getString("r_content"));
				command.setR_anthor(rs.getString("r_anthor"));
				command.setR_date(rs.getString("r_date").substring(0,10));
				command.setR_view(rs.getInt("r_view"));
				command.setR_class(rs.getString("r_class"));
				command.setR_anthor_id(rs.getString("r_anthor_id"));
				command.setR_p_num(rs.getInt("r_p_num"));
				return command;
			}}, p_num);
	
		
		return result;
	}
	
	public RemarkCommand issueDetail(Map<String, Object> requestValues) {
		String r_id = (String)requestValues.get("r_id");
		String sql = "select * from remark where r_id=?";
		List<RemarkCommand> result = jt.query(sql, new RowMapper<RemarkCommand>() {

			@Override
			public RemarkCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				RemarkCommand command = new RemarkCommand();
				command.setR_id(rs.getInt("r_id"));
				command.setR_title(rs.getString("r_title"));
				command.setR_content(rs.getString("r_content"));
				command.setR_anthor(rs.getString("r_anthor"));
				command.setR_date(rs.getString("r_date"));
				command.setR_view(rs.getInt("r_view"));
				command.setR_class(rs.getString("r_class"));
				command.setR_anthor_id(rs.getString("r_anthor_id"));
				command.setR_p_num(rs.getInt("r_p_num"));
				return command;
			}}, r_id);
		
		return result.isEmpty()? null : result.get(0);
	}
	
	public void issue_viewUp(int r_id) {
		String sql = "update remark set r_view = r_view+1 where r_id=?";
		jt.update(sql, r_id);
	}
	
	public Integer issuetotal() {
		String sql = "select count(*) from remark";
		Integer result = jt.queryForObject(sql, Integer.class);
		
		return result;
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
	
	public Map<String, String> next_prev(Map<String, Object> requestValues) {
		Map<String, String> result = new HashMap<String, String>();
		String sql = "select * from remark where r_p_num = ? and r_id > ? order by r_id asc limit 1";
		jt.query(sql,new RowMapper<Object>() {
	
			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				result.put("next", String.valueOf(rs.getInt("r_id")));
				return null;
			}}, requestValues.get("p_num"),requestValues.get("r_id"));
		
		sql = "select * from remark where r_p_num = ? and r_id < ? order by r_id desc limit 1";
		jt.query(sql,new RowMapper<Object>() {
	
			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				result.put("prev", String.valueOf(rs.getInt("r_id")));
				return null;
			}}, requestValues.get("p_num"),requestValues.get("r_id"));
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
	
	public Map<String, Integer> progressbar(List<ProjectCommand> project_list) {
		Map<String, Integer> result = new HashMap<String, Integer>();
		String sql = "select * from projectcreate where pc_id=? and pc_propart=?";
		if (project_list != null) {
			for (int i = 0; i < project_list.size(); i++) {
				int prochk = 0;
				List<String> ans = jt.query(sql, new RowMapper<String>() {
		
					@Override
					public String mapRow(ResultSet rs, int rowNum) throws SQLException {
						return rs.getString("pc_dpn");
					}}, project_list.get(i).getPj_id(), project_list.get(i).getPj_task());
				for (int j = 0; j < ans.size(); j++) {
					if (ans.get(j).equals("3333333333")) {
						prochk++;
					}
				}
				if (prochk == 48) {
					taskchange(project_list.get(i));
					if (!project_list.get(i).getPj_task().equals("J(진수)")) {
						result.put(project_list.get(i).getPj_id(), 0);
					}
					else {
						result.put(project_list.get(i).getPj_id(), prochk);
					}
				}
				else {
					result.put(project_list.get(i).getPj_id(), prochk);
				}
				
			}
		}
		
		return result;
	}
	
	private void taskchange(ProjectCommand command) {
		String task = command.getPj_task();
		String sql = "select * from task where t_name > ? order by t_name asc limit 1";
		List<String> result = jt.query(sql, new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getString("t_name");
			}}, task);
		task = result.isEmpty()? null : result.get(0);
		
		if (task != null) {
			sql = "update project set pj_task=? where pj_id=?";
			jt.update(sql, task, command.getPj_id());
			command.setPj_task(task);
		}
	}
	
	public Map<String, Integer> totalprogressbar(List<ProjectCommand> project_list) {
		Map<String, Integer> result = new HashMap<String, Integer>();
		if (project_list != null){
			for (int i = 0; i < project_list.size(); i++) {
				int ans = project_list.get(i).getPj_task().charAt(0)-'A';
				result.put(project_list.get(i).getPj_id(), ans * 48);
			} 
		}
		return result;
	}
	
	//ProjectCreate테이블 정보 가져오기(단 프로젝트 아이디가 같을 경우)
	public List<ProjectCreateCommand> PccSearch(String Sequence, String task){
		String sql = "select * from projectcreate where pc_id = ? and pc_propart=? order by pc_tasknumber asc";
		
		
		List<ProjectCreateCommand> result = jt.query(sql, new RowMapper<ProjectCreateCommand>() {

			@Override
			public ProjectCreateCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCreateCommand command = new ProjectCreateCommand();
				command.setPc_id(rs.getString("pc_id"));
				command.setPc_dpn(rs.getString("pc_dpn"));
				command.setPc_tasknumber(rs.getString("pc_tasknumber"));
				command.setPc_propart(rs.getString("pc_propart"));
				command.setPc_name(rs.getString("pc_name"));
				return command;
			}}, Sequence, task);
		return result;

	}
	
	//프로젝트 공정 현황 뷰 리스트
	public List<ProductCommand> detailView(String pj_id , String taskselector,int page, String tasknum, String processnum, String sdate, String fdate, int cnt){
		
		if(fdate != null && !fdate.equals("null")) {
			fdate = String.valueOf(LocalDate.parse(fdate).plusDays(1));   
	    }
		
		int searchPage = (page - 1) * cnt;
		
		String sql = null;
		
		if(pj_id != null && !pj_id.equals("")) {
			sql = "select count(*) from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%'";
			
			int countid = jt.queryForObject(sql, Integer.class, pj_id);
			
			if(countid >= 1) {
				if (tasknum != null && processnum != null && !tasknum.equals("") && !processnum.equals("") && !tasknum.equals("null") && !processnum.equals("null") && !tasknum.equals("all")) {
					sql = "select * from product_management where p_proid = ? and p_tasknumber ='"+taskselector+tasknum+"' and p_processnumber like '%"+processnum+"%' order by p_proid desc limit "+searchPage+", "+cnt;
				}
				else if(tasknum != null && !tasknum.equals("") && !tasknum.equals("null") && !tasknum.equals("all")) {
					sql = "select * from product_management where p_proid = ? and p_tasknumber ='"+taskselector+tasknum+"' order by p_proid desc limit "+searchPage+","+cnt;
				}
				else if(processnum != null && !processnum.equals("") && !processnum.equals("null")) {
					sql = "select * from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%' and p_processnumber like '%"+processnum+"%' order by p_proid desc limit "+searchPage+","+cnt;
				}
				else if(sdate != null && !sdate.equals("") && fdate != null && !fdate.equals("") && !sdate.equals("null") && !fdate.equals("null")) {
					sql = "select * from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%' and p_regdate between '"+sdate+"' and '"+fdate+"' order by p_proid desc limit "+searchPage+", "+cnt;
				}
				else{
					sql = "select * from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%' order by p_proid desc limit "+searchPage+", "+cnt;
				}
			}else{
				sql = "select * from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%' order by p_proid desc limit "+searchPage+", "+cnt;
			}
		}
		
		List<ProductCommand> result = jt.query(sql, new RowMapper<ProductCommand>() {

			@Override
			public ProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProductCommand pdc = new ProductCommand();
				pdc.setP_num(rs.getInt("p_num"));
				pdc.setP_proid(rs.getString("p_proid"));
				pdc.setP_tasknumber(rs.getString("p_tasknumber"));
				pdc.setP_processnumber(rs.getString("p_processnumber"));
				pdc.setP_regdate(rs.getString("p_regdate"));
				pdc.setP_startdate(rs.getString("p_startdate") == null ? "-" : rs.getString("p_startdate"));
				pdc.setP_compledate(rs.getString("p_compledate") == null ? "-" : rs.getString("p_compledate"));
				pdc.setP_regnum(rs.getString("p_regnum"));
				return pdc;
			}
		},pj_id);
		
		return result.isEmpty()? null : result;
	}
	
	
	public Integer totalpage_detail(String pj_id , String taskselector, String tasknum, String processnum, String sdate, String fdate) {
		if(fdate != null && !fdate.equals("null")) {
			fdate = String.valueOf(LocalDate.parse(fdate).plusDays(1));   
	    }
		String sql = null;
		
		if(pj_id != null && !pj_id.equals("")) {
			sql = "select count(*) from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%'";
			
			int countid = jt.queryForObject(sql, Integer.class, pj_id);
			
			if(countid >= 1) {
				if (tasknum != null && processnum != null && !tasknum.equals("") && !processnum.equals("") && !tasknum.equals("null") && !processnum.equals("null")) {
					sql = "select count(*) from product_management where p_proid = ? and p_tasknumber ='"+taskselector+tasknum+"' and p_processnumber like '%"+processnum+"%'";
				}
				else if(tasknum != null && !tasknum.equals("") && !tasknum.equals("null")) {
					sql = "select count(*) from product_management where p_proid = ? and p_tasknumber ='"+taskselector+tasknum+"'";
				}
				else if(processnum != null && !processnum.equals("") && !processnum.equals("null")) {
					sql = "select count(*) from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%' and p_processnumber like '%"+processnum+"%'";
				}
				else if(sdate != null && !sdate.equals("") && fdate != null && !fdate.equals("") && !sdate.equals("null") && !fdate.equals("null")) {
					sql = "select count(*) from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%' and p_regdate between '"+sdate+"' and '"+fdate+"'";
				}
				else{
					sql = "select count(*) from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%'";
				}
			}else{
				sql = "select count(*) from product_management where p_proid = ? and p_tasknumber like '"+taskselector+"%'";
			}
		}
		return jt.queryForObject(sql, Integer.class, pj_id);
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
}
