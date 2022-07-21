package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//외주 관리
@Controller
public class OutsourcingController {
	
		//외주 의뢰 등록
		@RequestMapping("/out_input")
		public String out_input(){
			return "out_product_management/out_order_input";
		}
		
		//외주 공정 현황
		@RequestMapping("/out_select")
		public String out_select(){
			return "out_product_management/out_order_select";
		}
}
