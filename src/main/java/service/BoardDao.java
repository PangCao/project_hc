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

import command.NoticeCommand;

public class BoardDao {

	private JdbcTemplate jt;
	
	public BoardDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	public List<NoticeCommand> noticeView(int noticepage, String search_title, int cnt) {
		int searchPage = (noticepage - 1) * cnt;
		String sql=null;
		if (search_title != null && !search_title.equals("")) {
			sql = "select * from notice where n_title like '%"+search_title+"%' limit "+searchPage+", "+cnt;
		}
		else {
			sql = "select * from notice limit "+searchPage+", "+cnt;
		}
		List<NoticeCommand> result = jt.query(sql, new RowMapper<NoticeCommand>() {

			@Override
			public NoticeCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				NoticeCommand dto = new NoticeCommand();
				dto.setN_id(rs.getInt("n_id"));
				dto.setN_title(rs.getString("n_title"));
				dto.setN_content(rs.getString("n_content"));
				dto.setN_anthor(rs.getString("n_anthor"));
				dto.setN_date(rs.getString("n_date").substring(0, 10));
				dto.setN_view(rs.getInt("n_view"));			
				return dto;
			}});
		return result.isEmpty()? null : result;
	}
	
	public Integer totalpage(String category, String search_title) {
		String sql = null;
		if (category.equals("notice")) {
			if (search_title != null && !search_title.equals("")) {
				sql = "select count(*) from notice where n_title like '%"+search_title+"%'";
			}
			else {
				sql = "select count(*) from notice";
			}
		}
		else {
			sql = "select count(*) from remark";
		}
		return jt.queryForObject(sql, Integer.class);
	} 

	public NoticeCommand noticeDetail(int n_id) {
				
		String sql = "select * from notice where n_id=?";
		List<NoticeCommand> result = jt.query(sql, new RowMapper<NoticeCommand>() {

			@Override
			public NoticeCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				NoticeCommand dto = new NoticeCommand();
				dto.setN_id(rs.getInt("n_id"));
				dto.setN_title(rs.getString("n_title"));
				dto.setN_content(rs.getString("n_content"));
				dto.setN_anthor(rs.getString("n_anthor"));
				dto.setN_date(rs.getString("n_date").substring(0, 10));
				dto.setN_view(rs.getInt("n_view"));	
				return dto;
			}}, n_id);
		return result.isEmpty()? null:result.get(0);
	}
	
	public Map<String, Integer> noticepaging(int n_id) {
		Map<String, Integer> result = new HashMap<String, Integer>();
		String sql = "select * from notice where n_id > ? order by n_id asc";
		List<Integer> list = jt.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("n_id");
			}}, n_id);
		
		result.put("next", list.isEmpty()? null:list.get(0));
		sql = "select * from notice where n_id < ? order by n_id desc";
		list = jt.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("n_id");
			}}, n_id);
		result.put("prev", list.isEmpty()? null:list.get(0));
		result.put("current", n_id);
		return result;
	}
	
	public void notice_viewUp(int n_id) {
		String sql = "update notice set n_view=n_view+1 where n_id=?";
		jt.update(sql, n_id);
	}
	
	public void notice_del(int n_id) {
		String sql = "delete from notice where n_id=?";
		jt.update(sql, n_id);
	}
	
	public void notice_input(NoticeCommand noticeCommand) {
		String sql = "insert into notice(n_title, n_content, n_anthor, n_date) values (?,?,?,?)";
		jt.update(sql, noticeCommand.getN_title(), noticeCommand.getN_content(), noticeCommand.getN_anthor(), LocalDateTime.now());
	}
	//이슈 만들어야 함(현일이꺼)
}
