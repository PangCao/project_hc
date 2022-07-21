package command;

//공지사항
public class NoticeCommand {
	
	private int n_id; //공지사항 아이디
	private String n_title; //제목
	private String n_content; //내용
	private String n_anthor; //등록자
	private String n_date; //날짜
	private int n_view; //조회수
	
	
	public int getN_id() {
		return n_id;
	}
	public void setN_id(int n_id) {
		this.n_id = n_id;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public String getN_anthor() {
		return n_anthor;
	}
	public void setN_anthor(String n_anthor) {
		this.n_anthor = n_anthor;
	}
	public String getN_date() {
		return n_date;
	}
	public void setN_date(String n_date) {
		this.n_date = n_date;
	}
	public int getN_view() {
		return n_view;
	}
	public void setN_view(int n_view) {
		this.n_view = n_view;
	}
}
