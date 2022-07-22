package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
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
	
	public List<NoticeCommand> noticeView(int noticepage, int cnt) {
		int searchPage = (noticepage - 1) * cnt;
		
		String sql = "select * from notice limit "+searchPage+", "+cnt;
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
		return result.isEmpty()? null : result; //isEmpty()메서드를 통해 result값이 비었는지 안비었는지 확인함
	}
	
	public Integer totalpage(String category) {
		String sql = null;
		if (category.equals("notice")) {
			sql = "select count(*) from notice";
		}
		else {
			sql = "select count(*) from remark";
		}
		return jt.queryForObject(sql, Integer.class);
	} 

	
	//이슈 만들어야 함(현일이꺼)
}
