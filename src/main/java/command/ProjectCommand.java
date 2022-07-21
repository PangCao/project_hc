package command;

public class ProjectCommand {
	
	private String pj_id; //프로젝트 id
	private String pj_name; //프로젝트명
	private String pj_regdate; //프로젝트 등록일
	private String pj_eta; //프로젝트 종료 예정일
	private String pj_task; //현재 작업
	private float pj_progress; //진행률
	
	public String getPj_id() {
		return pj_id;
	}
	public void setPj_id(String pj_id) {
		this.pj_id = pj_id;
	}
	public String getPj_name() {
		return pj_name;
	}
	public void setPj_name(String pj_name) {
		this.pj_name = pj_name;
	}
	public String getPj_regdate() {
		return pj_regdate;
	}
	public void setPj_regdate(String pj_regdate) {
		this.pj_regdate = pj_regdate;
	}
	public String getPj_eta() {
		return pj_eta;
	}
	public void setPj_eta(String pj_eta) {
		this.pj_eta = pj_eta;
	}
	public String getPj_task() {
		return pj_task;
	}
	public void setPj_task(String pj_task) {
		this.pj_task = pj_task;
	}
	public float getPj_progress() {
		return pj_progress;
	}
	public void setPj_progress(float pj_progress) {
		this.pj_progress = pj_progress;
	}
}
