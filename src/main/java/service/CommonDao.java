package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import command.MemberCommand;
import command.NoticeCommand;
import command.RemarkCommand;

public class CommonDao {

	private JdbcTemplate jt;
	
	public CommonDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	// 공지사항 검색기능
	public List<NoticeCommand> noticeView(int noticepage, String search_title, int cnt) {
		int searchPage = (noticepage - 1) * cnt;
		String sql=null;
		if (search_title != null && !search_title.equals("")) {
			sql = "select * from notice where n_title like '%"+search_title+"%' order by n_id desc limit "+searchPage+", "+cnt;
		}
		else {
			sql = "select * from notice order by n_id desc limit "+searchPage+", "+cnt;
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
				dto.setAnthor_id(rs.getString("n_anthor_id"));
				return dto;
			}});
		return result.isEmpty()? null : result; //isEmpty()메서드를 통해 result값이 비었는지 안비었는지 확인함
	}
	
	//공지사항 모든 페이지
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
	
	//공지사항 상세 페이지
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
				dto.setAnthor_id(rs.getString("n_anthor_id"));
				return dto;
			}}, n_id);
		return result.isEmpty()? null:result.get(0);
	}
	
	
	//
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
	
	
	//공지글 조회수
	public void notice_viewUp(int n_id) {
		String sql = "update notice set n_view=n_view+1 where n_id=?";
		jt.update(sql, n_id);
	}
	
	
	//공지글 삭제
	public void notice_del(int n_id) {
		String sql = "delete from notice where n_id=?";
		jt.update(sql, n_id);
	}
	
	
	//공지사항 작성 등록
	public void notice_input(NoticeCommand noticeCommand) {
		String sql = "insert into notice(n_title, n_content, n_anthor, n_date, n_anthor_id) values (?,?,?,?,?)";
		jt.update(sql, noticeCommand.getN_title(), noticeCommand.getN_content(), noticeCommand.getN_anthor(), LocalDateTime.now(), noticeCommand.getAnthor_id());
	}
	
	
	//이슈 검색
	public List<RemarkCommand> issueView(int issuepage, String search_title, String r_class, int cnt) {
		int searchPage = (issuepage - 1) * cnt;
		String sql=null;
		if (search_title != null && !search_title.equals("")) {
			// r_titledp search_title이 포함되는 값들을 가져옴                         //정렬 r_id 기준 /desc:내림차순, age:오름차순
			sql = "select * from remark where r_title like '%"+search_title+"%' order by r_id desc limit "+searchPage+", "+cnt;
		}
		if(r_class != null && !r_class.equals("")){
			sql = "select * from remark where r_class='"+r_class+"' order by r_id desc limit "+searchPage+", "+cnt;
		}
		else {
			sql = "select * from remark order by r_id desc limit "+searchPage+", "+cnt;
		}
		
		List<RemarkCommand> result = jt.query(sql, new RowMapper<RemarkCommand>() {

			@Override
			public RemarkCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				RemarkCommand dto = new RemarkCommand();
				dto.setR_id(rs.getInt("r_id"));
				dto.setR_title(rs.getString("r_title"));
				dto.setR_content(rs.getString("r_content"));
				dto.setR_anthor(rs.getString("r_anthor"));
				dto.setR_date(rs.getString("r_date").substring(0, 10));
				dto.setR_view(rs.getInt("r_view"));
				dto.setR_class(rs.getString("r_class"));
				dto.setR_anthor_id(rs.getString("r_anthor_id"));

				return dto;
			}});
		return result.isEmpty()? null : result; //isEmpty()메서드를 통해 result값이 비었는지 안비었는지 확인함
	}
	
	public RemarkCommand issueDetail(int r_id) {
		
		String sql = "select * from remark where r_id=?";
		List<RemarkCommand> result = jt.query(sql, new RowMapper<RemarkCommand>() {

			@Override
			public RemarkCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				RemarkCommand dto = new RemarkCommand();
				dto.setR_id(rs.getInt("r_id"));
				dto.setR_title(rs.getString("r_title"));
				dto.setR_content(rs.getString("r_content"));
				dto.setR_anthor(rs.getString("r_anthor"));
				dto.setR_date(rs.getString("r_date").substring(0, 10));
				dto.setR_view(rs.getInt("r_view"));	
				return dto;
			}}, r_id);
		return result.isEmpty()? null:result.get(0);
	}
	
	public Map<String, Integer> issuepaging(int r_id) {
		Map<String, Integer> result = new HashMap<String, Integer>();
		String sql = "select * from remark where r_id > ? order by r_id asc";
		List<Integer> list = jt.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("r_id");
			}}, r_id);
		
		result.put("next", list.isEmpty()? null:list.get(0));
		
		sql = "select * from remark where r_id < ? order by r_id desc";
		list = jt.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("r_id");
			}}, r_id);
		result.put("prev", list.isEmpty()? null:list.get(0));
		result.put("current", r_id);
		return result;
	}
	
	
	
	//이슈글 조회수
	public void issue_viewUp(int r_id) {
		String sql = "update remark set r_view = r_view+1 where r_id=?";
		jt.update(sql, r_id);
	}
	
	
	//이슈글 삭제
	public void issue_del(int r_id) {
		String sql = "delete from remark where r_id=?";
		jt.update(sql, r_id);
	}
	
	
	//이슈글 정보 저장
	public void issue_input(RemarkCommand remarkCommand, HttpSession session) {
		MemberCommand list= (MemberCommand)session.getAttribute("member");
		String sql = "insert into remark(r_title, r_content, r_anthor, r_date, r_anthor_id, r_class) values (?,?,?,?,?,?)";
		jt.update(sql, remarkCommand.getR_title(), remarkCommand.getR_content(), remarkCommand.getR_anthor(), LocalDateTime.now(), list.getM_num(), remarkCommand.getR_class());
	}
}
