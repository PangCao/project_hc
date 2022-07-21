package command;

//회원정보
public class MemberCommand {
	
	private String m_num; //사원번호
	private String m_password; //비밀번호
	private String m_name; //이름
	private String m_position; //직책
	private String m_department; //부서
	private String m_tel; //연락처
	
	
	public String getM_num() {
		return m_num;
	}
	public void setM_num(String m_num) {
		this.m_num = m_num;
	}
	public String getM_password() {
		return m_password;
	}
	public void setM_password(String m_password) {
		this.m_password = m_password;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_position() {
		return m_position;
	}
	public void setM_position(String m_position) {
		this.m_position = m_position;
	}
	public String getM_department() {
		return m_department;
	}
	public void setM_department(String m_department) {
		this.m_department = m_department;
	}
	public String getM_tel() {
		return m_tel;
	}
	public void setM_tel(String m_tel) {
		this.m_tel = m_tel;
	}

}
