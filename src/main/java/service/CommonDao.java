package service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import command.NoticeCommand;
import command.ProductCommand;
import command.ProjectCommand;
import command.RemarkCommand;
import command.Remark_projectCommand;

public class CommonDao {

	private JdbcTemplate jt;
	
	public CommonDao(DataSource dataSource) {
		this.jt = new JdbcTemplate(dataSource);
	}
	
	// 공지사항 검색기능
	public List<NoticeCommand> noticeView(Map<String, Object> requestValues, int cnt) {
		String search_title = (String)requestValues.get("search_title");
		int page = requestValues.get("noteicepege") == null? 1:Integer.valueOf((String)requestValues.get("noticepage"));
		int searchPage = (page - 1) * cnt;
		String sql = null;
		
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

	//공지글 삭제
	public void notice_del(int n_id) {
		String sql = "delete from notice where n_id=?";
		jt.update(sql, n_id);
	}

	//공지사항 작성 등록
	public void notice_input(NoticeCommand noticeCommand) {
		String sql = "insert into notice(n_title, n_content, n_anthor, n_date, n_anthor_id) values (?,?,?,?,?)";
		jt.update(sql, noticeCommand.getN_title(), noticeCommand.getN_content().replace("\n", "<br>"), noticeCommand.getN_anthor(), LocalDateTime.now(), noticeCommand.getAnthor_id());
	}

	//공지글 조회수
	public void notice_viewUp(int n_id) {
		String sql = "update notice set n_view=n_view+1 where n_id=?";
		jt.update(sql, n_id);
	}

	public List<RemarkCommand> issueMainView(Map<String, Object> requestValues, int cnt) {
		int page = requestValues.get("remarkpage")== null ? 1:Integer.valueOf((String)requestValues.get("remarkpage"));
		String search_title = (String)requestValues.get("search_title");
		int searchPage = (page - 1) * cnt;
		String sql = null;
	
		if (search_title != null && !search_title.equals("")) {
			sql = "select * from remark where r_title like '%"+search_title+"%' order by r_id desc limit "+searchPage+", "+cnt;
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
				dto.setR_date(rs.getString("r_date"));
				dto.setR_view(rs.getInt("r_view"));
				dto.setR_class(rs.getString("r_class"));
				dto.setR_anthor_id(rs.getString("r_anthor_id"));
				dto.setR_p_num(rs.getInt("r_p_num"));
				return dto;
			}});
		return result.isEmpty()? null : result; //isEmpty()메서드를 통해 result값이 비었는지 안비었는지 확인함
		
		
		
	}

	public Map<String, Remark_projectCommand> issueSubView(){
		Map<String, Remark_projectCommand> result = new HashMap<String, Remark_projectCommand>();
		String sql = "select * from remark_project";
		jt.query(sql, new RowMapper<Object>() {

			@Override
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				Remark_projectCommand command = new Remark_projectCommand();
				command.setRp_num(rs.getInt("rp_num"));
				command.setRp_r_id(rs.getInt("rp_r_id"));
				command.setRp_proid(rs.getString("rp_proid"));
				command.setRp_task(rs.getString("rp_task"));
				command.setRp_process(rs.getString("rp_process"));
				result.put(String.valueOf(rs.getInt("rp_r_id")), command);
				
				return null;
			}
			
		});
		return result;
	}
	
	//이슈 검색
	public List<RemarkCommand> issueView(Map<String, Object> requestValues, int cnt) {
		int page = requestValues.get("page") == null? 1:Integer.valueOf((String)requestValues.get("page"));
		String search_title = (String)requestValues.get("search_title");
		String r_class= (String)requestValues.get("r_class");
		String sdate = (String)requestValues.get("sdate");
		String fdate = (String)requestValues.get("fdate");
		if(fdate != null && !fdate.equals("null")) {
			fdate = String.valueOf(LocalDate.parse(fdate).plusDays(1));   
	    }
		int searchPage = (page - 1) * cnt;
		String sql = null;
		
		if (search_title != null && !search_title.equals("")) {
			// r_titledp search_title이 포함되는 값들을 가져옴                         //정렬 r_id 기준 /desc:내림차순, age:오름차순
			sql = "select * from remark where r_title like '%"+search_title+"%' order by r_id desc limit "+searchPage+", "+cnt;
		}
		else if(r_class != null && !r_class.equals("")) {
			sql = "select * from remark where r_class='"+r_class+"' order by r_id desc limit "+searchPage+", "+cnt;
		}
		else if(sdate != null && !sdate.equals("") && fdate != null && !fdate.equals("")) {
			sql = "select * from remark where r_date between '"+sdate+"' and '"+fdate+"' order by r_id desc limit "+searchPage+", "+cnt;
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
				dto.setR_p_num(rs.getInt("r_p_num"));
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
				dto.setR_anthor_id(rs.getString("r_anthor_id"));
				dto.setR_p_num(rs.getInt("r_p_num"));
				return dto;
			}}, r_id);
		return result.isEmpty()? null:result.get(0);
	}

	public Integer issuetotal(Map<String, Object> requestValues, int cnt) {
		String search_title = (String)requestValues.get("search_title");
		String r_class= (String)requestValues.get("r_class");
		String sdate = (String)requestValues.get("sdate");
		String fdate = (String)requestValues.get("fdate");
		if(fdate != null && !fdate.equals("null")) {
			fdate = String.valueOf(LocalDate.parse(fdate).plusDays(1));   
	    }
		String sql = null;
		
		if (search_title != null && !search_title.equals("")) {
			sql = "select count(*) from remark where r_title like '%"+search_title+"%'";
		}
		else if(r_class != null && !r_class.equals(""))
		{
			sql = "select count(*) from remark where r_class='"+r_class+"'";
		}
		else if(sdate != null && !sdate.equals("") && fdate != null && !fdate.equals(""))
		{
			sql = "select count(*) from remark where r_date between '"+sdate+"' and '"+fdate+"'";
		}
		else
		{
			sql = "select count(*) from remark";
		}
		
		int result = jt.queryForObject(sql, Integer.class);
		
		return result;
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
		String sql = "delete from remark_project where rp_r_id=?";
		jt.update(sql, r_id);
		sql = "delete from remark where r_id=?";
		jt.update(sql, r_id);
		System.out.println("여기는 실행됨");
	}

	//이슈글 정보 저장
	public void issue_input(RemarkCommand remarkCommand, HttpSession session, String p_num) {
		String id = (String)session.getAttribute("id");
		String sql = "insert into remark(r_title, r_content, r_anthor, r_date, r_anthor_id, r_class,r_p_num) values (?,?,?,?,?,?,?)";
		
		jt.update(sql, remarkCommand.getR_title(),  remarkCommand.getR_content().replace("\n", "<br>"), remarkCommand.getR_anthor(), String.valueOf(LocalDateTime.now()),id, remarkCommand.getR_class(), p_num);
	}

	public List<ProductCommand> product_issue_select(Map<String,Object> requestValues) {
		String project_id = (String)requestValues.get("project_id");
		String searchword = (String)requestValues.get("searchword");
		int page = requestValues.get("page") == null ? 1:Integer.valueOf((String)requestValues.get("page"));
		int SearchPage = (page - 1) * 10;
		String sql = "";
		
		if (project_id != null && !project_id.equals("null") && searchword != null && !searchword.equals("null") && !searchword.equals("")) {
			sql = "select * from product_management where p_proid='"+project_id+"' and p_tasknumber like '%"+searchword+"%' limit "+SearchPage+", 10";
		}
		else if (project_id != null && !project_id.equals("null")) {
			sql = "select * from product_management where p_proid='"+project_id+"' limit "+SearchPage+", 10";
		}
		else if (searchword != null && !searchword.equals("null") && !searchword.equals("")) {
			sql = "select * from product_management where p_tasknumber like '%"+searchword+"%' limit "+SearchPage+", 10";
		}
		else {
			sql = "select * from product_management limit "+SearchPage+", 10";
		}
		List<ProductCommand> result = jt.query(sql, new RowMapper<ProductCommand>() {
	
			@Override
			public ProductCommand mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProductCommand command = new ProductCommand();
				command.setP_proid(rs.getString("p_proid"));
				command.setP_processnumber(rs.getString("p_processnumber"));
				command.setP_tasknumber(rs.getString("p_tasknumber"));
				command.setP_num(rs.getInt("p_num"));
				return command;
			}});
		return result;
	}

	public Integer product_issue_total(Map<String, Object> requestValues) {
		String sql = "";
		String project_id = (String)requestValues.get("project_id");
		String searchword = (String)requestValues.get("searchword");
		
		if (project_id != null && !project_id.equals("null") && searchword != null && !searchword.equals("null") && !searchword.equals("")) {
			sql = "select count(*) from product_management where p_proid='"+project_id+"' and p_tasknumber like '%"+searchword+"%'";
		}
		else if (project_id != null && !project_id.equals("null")) {
			sql = "select count(*) from product_management where p_proid='"+project_id+"'";
		}
		else if (searchword != null && !searchword.equals("null") && !searchword.equals("")) {
			sql = "select count(*) from product_management where p_tasknumber like '%"+searchword+"%'";
		}
		else {
			sql = "select count(*) from product_management";
		}
		Integer totalpage = jt.queryForObject(sql, Integer.class);
		return totalpage;
	}

	//공지사항 모든 페이지
	public Integer totalpage(String category, Map<String, Object> requestValues) {
		String sql = null;
		String search_title = (String)requestValues.get("search_title");
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
}
