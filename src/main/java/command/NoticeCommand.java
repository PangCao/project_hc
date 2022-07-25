package command;

import lombok.Data;

//공지사항
@Data
public class NoticeCommand {
	
	private int n_id; //공지사항 아이디
	private String n_title; //제목
	private String n_content; //내용
	private String n_anthor; //등록자
	private String n_date; //날짜
	private int n_view; //조회수
	private String anthor_id; //등록자 아이디


}
