package command;

import lombok.Data;

//회원정보
@Data
public class MemberCommand {
	
	private String m_num; //사원번호
	private String m_password; //비밀번호
	private String m_name; //이름
	private String m_position; //직책
	private String m_department; //부서
	private String m_tel; //연락처
}
