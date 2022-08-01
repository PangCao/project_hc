package command;

import lombok.Data;

@Data
public class ProjectCreateCommand {
	
	private String pc_id;// PJT-현재년도-000X(순서대로 올라감)
	private String pc_name;//사용자가 지정한 네임
	private String pc_tasknumber;//A01~D12
	private String pc_propart;//A(가공)
	private String pc_dpn;//000000000
	
}
