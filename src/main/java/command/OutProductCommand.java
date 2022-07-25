package command;

import lombok.Data;

//외주 지시 등록
@Data
public class OutProductCommand {
	
	private int op_num; //외주 id
	private String op_ordernumber; //의뢰번호
	private String op_proname; //프로젝트명
	private String op_comname; //업체명
	private String op_regdate; //의뢰 등록일
	private String op_productname; //품명
	private String op_productstandard; //규격
	private int op_unit; //수량
	private int op_price; //단가
	private String op_regnum; //등록자
	private String anthor_name;

}
