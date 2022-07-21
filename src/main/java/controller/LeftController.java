package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LeftController {
	
	//생산관리
	@RequestMapping("/project_sub_management")//생산 작업 실적 등록
	public String sub(){
		return "product_management/project_sub_management";
	}
	@RequestMapping("/project_detail")//생산 작업 실적 등록
	public String detail(){
		return "product_management/project_detail";
	}
	
	// LoginController와 중복된 경로설정(리턴값이 같음)
//	@RequestMapping("/management")//전체 공정 현황
//	public String management(){
//		return "product_management/project_management";
//	}
	
	@RequestMapping("/input")//생산 작업 지시 등록
	public String input(){
		return "product_management/process_input";
	}
	
	@RequestMapping("/complete")//생산 작업 지시 착수
	public String complete(){
		return "product_management/product_complete";
	}
	
	@RequestMapping("/record")//생산 작업 실적 등록
	public String record(){
		return "product_management/product_complete";
	}
	
	//외주 관리
	@RequestMapping("/out_input")//외주 의뢰 등록
	public String out_input(){
		return "product_management/product_complete";
	}
	
	@RequestMapping("/out_select")//외주 공정 현황
	public String out_select(){
		return "product_management/product_complete";
	}
	
	//개인정보 관리
	@RequestMapping("/user_modify")
	public String user_authentication() {
		return "user_setting/user_modify";
	}
}
