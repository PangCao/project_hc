package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.ui.Model;

import command.OutCompanyListCommand;
import command.OutProductCommand;
import command.ProjectCommand;

public class OutsourcingDao {

	private JdbcTemplate jt;
	
	public OutsourcingDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
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
		
		if (project_id != null && !project_id.equals("null") && !project_id.equals("all")) {
			if (comname != null && !comname.equals("null")) {
				sql = "select * from out_product_management where op_proid = ? and op_comname like '%"+comname+"%' limit "+page+", 10";
			}
			else if (productname != null && !productname.equals("null")) {
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
			if (comname != null && !comname.equals("null")) {
				sql = "select * from out_product_management where op_comname like '%"+comname+"%' limit "+page+", 10";
			}
			else if (productname != null && !productname.equals("null")){
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
	
	public Integer totalpage(Map<String, Object> requestValues) {
		String project_id = (String)requestValues.get("project_id");
		String sql = null;
		Integer result = null;
		String comname = (String)requestValues.get("comname");
		String productname = (String)requestValues.get("productname");
		String startDate = (String)requestValues.get("startdate");
		String endDate = (String)requestValues.get("enddate");
		
		if (project_id != null && !project_id.equals("null") && !project_id.equals("all")) {
			if (comname != null && !comname.equals("null")) {
				sql = "select count(*) from out_product_management where op_proid=? and op_comname like '%"+comname+"%'";
			}
			else if (productname != null && !productname.equals("null")){
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
			if (comname != null && !comname.equals("null")) {
				sql = "select count(*) from out_product_management where op_comname like '%"+comname+"%'";
			}
			else if (productname != null && !productname.equals("null")){
				sql = "select count(*) from out_product_management where op_productname like '%"+productname+"%'";
			}
			else {
				sql = "select count(*) from out_product_management";
			}
			result = jt.queryForObject(sql, Integer.class);
		}
		
		return result;
	}
	
	public Map<String, Integer> pageConut(int totalpage, Map<String, Object> requestValues) {
		int page = requestValues.get("page") == null ? 1 : Integer.valueOf((String)requestValues.get("page"));
		int min = 0;
		int max = 5;
		if (page > 3) {
			min = page - 3;
			max = page + 2;
		}
		if (max > (totalpage / 10) + 1) {
			max = (totalpage / 10) + 1;
		}
		if (totalpage % 10 == 0) {
			max -= 1;
		}
		if (totalpage == 0) {
			max = 1;
		}
		if (max < 5) {
			min = 0;
		}
		Map<String, Integer> result = new HashMap<String, Integer>();
	
		result.put("max", max);
		result.put("min", min);
		result.put("totalpage", totalpage);
		result.put("page", page);
		return result;
	}
	
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
	
	public List<ProjectCommand> project_name_id_select() {
		String sql = "select distinct pj_id, pj_name from project";
		List<ProjectCommand> result = jt.query(sql, new RowMapper<ProjectCommand>() {

			@Override
			public ProjectCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProjectCommand command = new ProjectCommand();
				command.setPj_name(rs.getString("pj_name"));
				command.setPj_id(rs.getString("pj_id"));
				return command;
			}});
		return result;
	}
	
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
	
	public void out_input(OutProductCommand command, Map<String, String> commap) {
		String sql = "insert into out_product_management (op_ordernumber, op_proid, op_comid, op_regdate, op_productname, op_productstandard, op_unit, op_price, op_regnum) values (?,?,?,?,?,?,?,?,?)";
		jt.update(sql, command.getOp_ordernumber(), command.getOp_proid(), command.getOp_comid(), LocalDateTime.now(), command.getOp_productname(), command.getOp_productstandard(), command.getOp_unit(), command.getOp_price(), command.getOp_regnum());
		
		sql = "select op_num from out_product_management order by op_num desc";
		
		List<Integer> max = jt.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				
				return rs.getInt("op_num");
			}});
		
		
		sql = "insert into out_company_progress (ocp_comid, ocp_ordernum, ocp_name, ocp_progress) values(?,?,?,?)";
		jt.update(sql, command.getOp_comid(), max.get(0), commap.get(String.valueOf(command.getOp_comid())), "의뢰수락대기");		
	}
	
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
}
