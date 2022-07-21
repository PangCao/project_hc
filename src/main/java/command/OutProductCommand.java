package command;

//외주 지시 등록
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
	
	public int getOp_num() {
		return op_num;
	}
	public void setOp_num(int op_num) {
		this.op_num = op_num;
	}
	public String getOp_ordernumber() {
		return op_ordernumber;
	}
	public void setOp_ordernumber(String op_ordernumber) {
		this.op_ordernumber = op_ordernumber;
	}
	public String getOp_proname() {
		return op_proname;
	}
	public void setOp_proname(String op_proname) {
		this.op_proname = op_proname;
	}
	public String getOp_comname() {
		return op_comname;
	}
	public void setOp_comname(String op_comname) {
		this.op_comname = op_comname;
	}
	public String getOp_regdate() {
		return op_regdate;
	}
	public void setOp_regdate(String op_regdate) {
		this.op_regdate = op_regdate;
	}
	public String getOp_productname() {
		return op_productname;
	}
	public void setOp_productname(String op_productname) {
		this.op_productname = op_productname;
	}
	public String getOp_productstandard() {
		return op_productstandard;
	}
	public void setOp_productstandard(String op_productstandard) {
		this.op_productstandard = op_productstandard;
	}
	public int getOp_unit() {
		return op_unit;
	}
	public void setOp_unit(int op_unit) {
		this.op_unit = op_unit;
	}
	public int getOp_price() {
		return op_price;
	}
	public void setOp_price(int op_price) {
		this.op_price = op_price;
	}
	public String getOp_regnum() {
		return op_regnum;
	}
	public void setOp_regnum(String op_regnum) {
		this.op_regnum = op_regnum;
	}
}
