package command;

import lombok.Data;

@Data
public class ProjectCreateCommand {
	
	private int pc_id;
	private String pc_name;
	private String pc_tasknumber;
	private String pc_propart;
	private String pc_dpn;
}
