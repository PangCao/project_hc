package command;

import lombok.Data;

@Data
public class ProjectCommand {
	
	private String pj_id; //프로젝트 id
	private String pj_name; //프로젝트명
	private String pj_regdate; //프로젝트 등록일
	private String pj_eta; //프로젝트 종료 예정일
	private String pj_task; //현재 작업
	private float pj_progress; //진행률
	
}
