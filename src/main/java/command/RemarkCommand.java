package command;

//이슈 관리
public class RemarkCommand {
	
	private int r_id; //특이사항 아이디
	private String r_title; //제목
	private String r_content; //내용
	private String r_anthor; //등록자
	private String r_date; //날짜
	private int r_view; //조회수
	private String r_class; //심각도
		
	public int getR_id() {
		return r_id;
	}
	public void setR_id(int r_id) {
		this.r_id = r_id;
	}
	public String getR_title() {
		return r_title;
	}
	public void setR_title(String r_title) {
		this.r_title = r_title;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	public String getR_anthor() {
		return r_anthor;
	}
	public void setR_anthor(String r_anthor) {
		this.r_anthor = r_anthor;
	}
	public String getR_date() {
		return r_date;
	}
	public void setR_date(String r_date) {
		this.r_date = r_date;
	}
	public int getR_view() {
		return r_view;
	}
	public void setR_view(int r_view) {
		this.r_view = r_view;
	}
	public String getR_class() {
		return r_class;
	}
	public void setR_class(String r_class) {
		this.r_class = r_class;
	}
}
