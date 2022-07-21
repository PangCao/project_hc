package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//생산관리
@Controller
public class ProductionController {
	
	//전체 공정 현황
	@RequestMapping("/product_management")
	public String product_management() {
		
		return "product_management/project_management";
	}
	
	//프로잭트 서브
	@RequestMapping("/project_sub_management")
	public String sub(){
		return "product_management/project_sub_management";
	}
	
	//생산 작업 실적 등록
	@RequestMapping("/project_detail")
	public String detail(){
		return "product_management/project_detail";
	}
	
	//생산 작업 지시 등록
	@RequestMapping("/input")
	public String input(){
		return "product_management/process_input";
	}
	
	//생산 작업 지시 착수
	@RequestMapping("/complete")
	public String complete(){
		return "product_management/product_complete";
	}
	
	//생산 작업 실적 등록
	@RequestMapping("/record")
	public String record(){
		return "product_management/product_complete";
	}
}
