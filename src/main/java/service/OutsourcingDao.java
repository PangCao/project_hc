package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import command.OutProductCommand;

public class OutsourcingDao {

	private JdbcTemplate jt;
	
	private DecimalFormat decimalFormat = new DecimalFormat("###,###");
	
	public OutsourcingDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	public List<OutProductCommand> outlist(Map<String, Object> requestValues) {
		String sql = "select * from out_product_management";
		
		List<OutProductCommand> result = jt.query(sql, new RowMapper<OutProductCommand>() {

			@Override
			public OutProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				OutProductCommand command = new OutProductCommand();
				command.setOp_num(rs.getInt("op_num"));
				command.setOp_ordernumber(rs.getString("op_ordernumber"));
				command.setOp_proname(rs.getString("op_proname"));
				command.setOp_comname(rs.getString("op_comname"));
				command.setOp_regdate(rs.getString("op_regdate"));
				command.setOp_productname(rs.getString("op_productname"));
				command.setOp_productstandard(rs.getString("op_productstandard"));
				command.setOp_unit(rs.getInt("op_unit"));
				command.setOp_price(rs.getInt("op_price"));
				command.setOp_regnum(rs.getString("op_regnum"));
				return command;
			}});
		
		return 	result;
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
		String sql = "select count(*) from out_product_management";
		
		Integer result = jt.queryForObject(sql, Integer.class);
		
		return result;
	}
}
