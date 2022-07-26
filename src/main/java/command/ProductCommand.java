package command;

import lombok.Data;

@Data
public class ProductCommand {
	
	private int p_num; //db id값
	private String p_proname; //프로젝트명
	private String p_tasknumber; //작업번호
	private String p_processnumber; //공정번호
	private String p_regdate; //등록일
	private String p_startdate; //착수일
	private String p_compledate; //완료일
	private String p_remarkid; //특이사항 아이디
	private String p_regnum; //등록자
	private String p_state; //결재상태
}
