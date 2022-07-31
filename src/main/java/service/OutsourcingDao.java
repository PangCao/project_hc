package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.ui.Model;

import command.OutCompanyListCommand;
import command.OutProductCommand;
import command.ProjectCommand;

public class OutsourcingDao {

	private JdbcTemplate jt;
	
	public OutsourcingDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	// 외주 목록을 출력하는 메서드(조건에 따라 다른 sql문을 사용함)
	public List<OutProductCommand> outlist(Map<String, Object> requestValues) {
		int page = requestValues.get("page") == null ? 1 : Integer.valueOf((String)requestValues.get("page"));
		page = (page - 1) * 10;
		String sql = null;
		String project_id = (String)requestValues.get("project_id");
		String comname = (String)requestValues.get("comname");
		String productname = (String)requestValues.get("productname");
		List<OutProductCommand> result = null;
		String startDate = (String)requestValues.get("startdate");
		String endDate = (String)requestValues.get("enddate");
		if (endDate != null && !endDate.equals("null")) {
			endDate = String.valueOf(LocalDate.parse(endDate).plusDays(1));	
		}
		
		if (project_id != null && !project_id.equals("null") && !project_id.equals("all") && startDate != null && endDate != null && !startDate.equals("null") && !endDate.equals("null")) {
			sql = "select * from out_product_management where op_proid=? and op_regdate between ? and ?";
			
			result = jt.query(sql, new RowMapper<OutProductCommand>() {

				@Override
				public OutProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
					OutProductCommand command = new OutProductCommand();
					command.setOp_num(rs.getInt("op_num"));
					command.setOp_ordernumber(rs.getString("op_ordernumber"));
					command.setOp_proid(rs.getString("op_proid"));
					command.setOp_comid(rs.getInt("op_comid"));
					command.setOp_regdate(rs.getString("op_regdate"));
					command.setOp_productname(rs.getString("op_productname"));
					command.setOp_productstandard(rs.getString("op_productstandard"));
					command.setOp_unit(rs.getInt("op_unit"));
					command.setOp_price(rs.getInt("op_price"));
					command.setOp_regnum(rs.getString("op_regnum"));
					return command;
				}}, project_id, startDate, endDate);
		}
		
		else if (project_id != null && !project_id.equals("null") && !project_id.equals("all")) {
			if (comname != null && !comname.equals("null") && !comname.equals("")) {
				sql = "select * from out_product_management where op_proid = ? and op_comid in (select o_id from out_company_list where o_name like '%"+comname+"%') limit "+page+", 10";
			}
			else if (productname != null && !productname.equals("null") && !productname.equals("")) {
				sql = "select * from out_product_management where op_proid = ? and op_productname like '%"+productname+"%' limit "+page+", 10";
			}
			else {
				sql = "select * from out_product_management where op_proid = ? limit "+page+", 10";
			}
			result = jt.query(sql, new RowMapper<OutProductCommand>() {

				@Override
				public OutProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
					OutProductCommand command = new OutProductCommand();
					command.setOp_num(rs.getInt("op_num"));
					command.setOp_ordernumber(rs.getString("op_ordernumber"));
					command.setOp_proid(rs.getString("op_proid"));
					command.setOp_comid(rs.getInt("op_comid"));
					command.setOp_regdate(rs.getString("op_regdate"));
					command.setOp_productname(rs.getString("op_productname"));
					command.setOp_productstandard(rs.getString("op_productstandard"));
					command.setOp_unit(rs.getInt("op_unit"));
					command.setOp_price(rs.getInt("op_price"));
					command.setOp_regnum(rs.getString("op_regnum"));
					return command;
				}}, project_id);
		}
		else if (startDate != null && endDate != null && !startDate.equals("null") && !endDate.equals("null")) {
			sql = "select * from out_product_management where op_regdate between ? and ?";
				
			result = jt.query(sql, new RowMapper<OutProductCommand>() {

				@Override
				public OutProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
					OutProductCommand command = new OutProductCommand();
					command.setOp_num(rs.getInt("op_num"));
					command.setOp_ordernumber(rs.getString("op_ordernumber"));
					command.setOp_proid(rs.getString("op_proid"));
					command.setOp_comid(rs.getInt("op_comid"));
					command.setOp_regdate(rs.getString("op_regdate"));
					command.setOp_productname(rs.getString("op_productname"));
					command.setOp_productstandard(rs.getString("op_productstandard"));
					command.setOp_unit(rs.getInt("op_unit"));
					command.setOp_price(rs.getInt("op_price"));
					command.setOp_regnum(rs.getString("op_regnum"));
					return command;
				}}, startDate, endDate);
		}
		else {
			if (comname != null && !comname.equals("null") && !comname.equals("")) {
				sql = "select * from out_product_management where op_comid in (select o_id from out_company_list where o_name like '%"+comname+"%') limit "+page+", 10";
			}
			else if (productname != null && !productname.equals("null") && !productname.equals("")){
				sql = "select * from out_product_management where op_productname like '%"+productname+"%' limit "+page+", 10";
			}
			else {
				sql = "select * from out_product_management limit "+page+", 10";
			}
			result = jt.query(sql, new RowMapper<OutProductCommand>() {

				@Override
				public OutProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
					OutProductCommand command = new OutProductCommand();
					command.setOp_num(rs.getInt("op_num"));
					command.setOp_ordernumber(rs.getString("op_ordernumber"));
					command.setOp_proid(rs.getString("op_proid"));
					command.setOp_comid(rs.getInt("op_comid"));
					command.setOp_regdate(rs.getString("op_regdate"));
					command.setOp_productname(rs.getString("op_productname"));
					command.setOp_productstandard(rs.getString("op_productstandard"));
					command.setOp_unit(rs.getInt("op_unit"));
					command.setOp_price(rs.getInt("op_price"));
					command.setOp_regnum(rs.getString("op_regnum"));
					return command;
				}});
		}
		return 	result;
	}
	
	// 외주 업체 리스트 조회
	public List<OutCompanyListCommand> out_com_list(Model model) {
		String sql = "select * from out_company_list";
		
		List<OutCompanyListCommand> result = jt.query(sql, new RowMapper<OutCompanyListCommand>() {
	
			@Override
			public OutCompanyListCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				OutCompanyListCommand command = new OutCompanyListCommand();
				command.setO_id(rs.getInt("o_id"));
				command.setO_name(rs.getString("o_name"));
				command.setO_task(rs.getString("o_task"));
				return command;
			}});
		
		return result;
	}

	// 외주 등록을 하는 메서드로 out_product_management와 out_company_progress 테이블에 같이 등록
	public void out_input(OutProductCommand command, Map<String, String> commap, String op_ordernumber) {
		String sql = "insert into out_product_management (op_ordernumber, op_proid, op_comid, op_regdate, op_productname, op_productstandard, op_unit, op_price, op_regnum) values (?,?,?,?,?,?,?,?,?)";
		
		KeyHolder kh = new GeneratedKeyHolder();
		jt.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql, new String[] {"op_num"});
				pstmt.setString(1, op_ordernumber);
				pstmt.setString(2, command.getOp_proid());
				pstmt.setInt(3, command.getOp_comid());
				pstmt.setString(4, String.valueOf(LocalDateTime.now()));
				pstmt.setString(5, command.getOp_productname());
				pstmt.setString(6, command.getOp_productstandard());
				pstmt.setInt(7, command.getOp_unit());
				pstmt.setInt(8, command.getOp_price());
				pstmt.setString(9, command.getOp_regnum());
				return pstmt;
			}
		}, kh);
		
		int kv = kh.getKey().intValue();
		
		String sql2 = "insert into out_company_progress (ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values(?,?,?,?)";
		jt.update(sql2, command.getOp_comid(), kv, commap.get(String.valueOf(command.getOp_comid())), "의뢰수락대기");		
	}

	// 프로젝트 이름을 조회해서 command에 set하는 메서드
	public void project_name_select(List<OutProductCommand> outlist) {
		String sql = null;
		
		for(int i = 0; i < outlist.size(); i++) {
			OutProductCommand command = outlist.get(i);
			String proid = command.getOp_proid();
			sql = "select pj_name from project where pj_id = ?";
			String result = jt.queryForObject(sql, String.class, proid);
			command.setOp_proname(result);
		}
	}
	
	// 작성자를 조회해서 command에 set하는 메서드
	public void author_select(List<OutProductCommand> outlist) {
		String sql = null;
		
		for (int i = 0; i < outlist.size(); i++) {
			OutProductCommand command = outlist.get(i);
			String author = command.getOp_regnum();
			sql = "select m_name from member where m_num = ?";
			String result = jt.queryForObject(sql, String.class, author);
			command.setAnthor_name(result);
		}
	}
	
	// 프로젝트의 id와 name 값을 command객체에 넣어서 List로 반환하는 메서드
	public List<ProjectCommand> projectlist() {
		String sql = "select * from project where pj_current_project=?";
		
		List<ProjectCommand> result = jt.query(sql, new RowMapper<ProjectCommand>() {

			@Override
			public ProjectCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCommand command = new ProjectCommand();
				command.setPj_id(rs.getString("pj_id"));
				command.setPj_name(rs.getString("pj_name"));
				return command;
			}}, true);
		
		return result;
	}
	
	// 외주 회사 id와 이름을 맵으로 만들어주는 메서드
	public Map<String, String> commap() {
		String sql = "select * from out_company_list";
		Map<String, String> resultmap = new HashMap<String, String>();
		
		jt.query(sql, new RowMapper<Object>() {

			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				resultmap.put(String.valueOf(rs.getInt("o_id")), rs.getString("o_name"));
				return null;
			}});
		
		return resultmap;
	}
	
	public String ordernum_create() {
		DecimalFormat df = new DecimalFormat("00000");
		int year = LocalDate.now().getYear();
		String sql = "select count(*) from out_product_management where op_ordernumber like '%-"+year+"-%'";
		int ans = jt.queryForObject(sql,Integer.class);
		String result = "OT-"+year+"-"+df.format(ans+1);
		return result;
	}
	
	// 외주 업체의 주문번호와 진행상황을 맵으로 만들어주는 메서드
	public Map<String, String> order_check() {
		String sql = "select * from out_company_progress";
		Map<String, String> result = new HashMap<String, String>();
		
		jt.query(sql, new RowMapper<Object>() {

			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				result.put(String.valueOf(rs.getInt("ocp_ordernum")), rs.getString("ocp_progress"));
				return null;
			}});
		
		return result;
	}

	// 조건에 따라 출력해야할 총 게시물의 수를 받아오는 메서드
	public Integer totalpage(Map<String, Object> requestValues) {
		String project_id = (String)requestValues.get("project_id");
		String sql = null;
		Integer result = null;
		String comname = (String)requestValues.get("comname");
		String productname = (String)requestValues.get("productname");
		String startDate = (String)requestValues.get("startdate");
		String endDate = (String)requestValues.get("enddate");
		if (endDate != null && !endDate.equals("null")) {
			endDate = String.valueOf(LocalDate.parse(endDate).plusDays(1));
		}
			
		if (project_id != null && !project_id.equals("null") && !project_id.equals("all") && startDate != null && endDate != null && !startDate.equals("null") && !endDate.equals("null")) {
			sql = "select count(*) from out_product_management where op_proid=? and op_regdate between ? and ?";
			
			result = jt.queryForObject(sql, Integer.class, project_id, startDate, endDate);
		}
		else if (project_id != null && !project_id.equals("null") && !project_id.equals("all")) {
			if (comname != null && !comname.equals("null") && !comname.equals("")) {
				sql = "select count(*) from out_product_management where op_proid=? and op_comid in (select o_id from out_company_list where o_name like '%"+comname+"%')";
			}
			else if (productname != null && !productname.equals("null") && !productname.equals("")){
				sql = "select count(*) from out_product_management where op_proid=? and op_productname like '%"+productname+"%'";
			}
			else {
				sql = "select count(*) from out_product_management where op_proid=?";
			}
			result = jt.queryForObject(sql, Integer.class, project_id);
		}
		else if (startDate != null && endDate != null && !startDate.equals("null") && !endDate.equals("null")) {
			sql = "select count(*) from out_product_management where op_regdate between ? and ?";
			result = jt.queryForObject(sql, Integer.class, startDate, endDate);
		}
		else {
			if (comname != null && !comname.equals("null") && !comname.equals("")) {
				sql = "select count(*) from out_product_management where op_comid in (select o_id from out_company_list where o_name like '%"+comname+"%')";
			}
			else if (productname != null && !productname.equals("null") && !productname.equals("")){
				sql = "select count(*) from out_product_management where op_productname like '%"+productname+"%'";
			}
			else {
				sql = "select count(*) from out_product_management";
			}
			result = jt.queryForObject(sql, Integer.class);
		}
		
		return result;
	}

}
