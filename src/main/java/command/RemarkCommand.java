package command;

import lombok.Data;

//이슈 관리
@Data
public class RemarkCommand {
	
	private int r_id; //특이사항 아이디
	private String r_title; //제목
	private String r_content; //내용
	private String r_anthor; //등록자
	private String r_date; //날짜
	private int r_view; //조회수
	private String r_class; //심각도
	private String r_anthor_id; //등록자 아이디
	private int r_p_num; // 생산 지시 등록
	
}
