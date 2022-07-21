package command;

public class ProductCommand {
	
	private int p_num; //db id값
	private String p_proname; //프로젝트명
	private String p_tasknumber; //작업번호
	private String p_processnumber; //공정번호
	private String p_regdate; //등록일
	private String p_startdate; //착수일
	private String p_compledate; //완료일
	private int p_remarkid; //특이사항 아이디
	private String p_regnum; //등록자
	private String p_state; //결재상태
	
	
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getP_proname() {
		return p_proname;
	}
	public void setP_proname(String p_proname) {
		this.p_proname = p_proname;
	}
	public String getP_tasknumber() {
		return p_tasknumber;
	}
	public void setP_tasknumber(String p_tasknumber) {
		this.p_tasknumber = p_tasknumber;
	}
	public String getP_processnumber() {
		return p_processnumber;
	}
	public void setP_processnumber(String p_processnumber) {
		this.p_processnumber = p_processnumber;
	}
	public String getP_regdate() {
		return p_regdate;
	}
	public void setP_regdate(String p_regdate) {
		this.p_regdate = p_regdate;
	}
	public String getP_startdate() {
		return p_startdate;
	}
	public void setP_startdate(String p_startdate) {
		this.p_startdate = p_startdate;
	}
	public String getP_compledate() {
		return p_compledate;
	}
	public void setP_compledate(String p_compledate) {
		this.p_compledate = p_compledate;
	}
	public int getP_remarkid() {
		return p_remarkid;
	}
	public void setP_remarkid(int p_remarkid) {
		this.p_remarkid = p_remarkid;
	}
	public String getP_regnum() {
		return p_regnum;
	}
	public void setP_regnum(String p_regnum) {
		this.p_regnum = p_regnum;
	}
	public String getP_state() {
		return p_state;
	}
	public void setP_state(String p_state) {
		this.p_state = p_state;
	}
	
	
}
