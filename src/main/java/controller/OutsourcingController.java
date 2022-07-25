package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import command.OutProductCommand;
import service.OutsourcingDao;

//외주 관리
@Controller
public class OutsourcingController {
	
	@Autowired
	private OutsourcingDao dao;

	//외주 의뢰 등록
	@RequestMapping("/out_input")
	public String out_input(@RequestParam Map<String, Object> requestValues, Model model){
		List<OutProductCommand> outlist = dao.outlist(requestValues);
		dao.author_select(outlist);
		model.addAttribute("outlist", outlist);
		return "out_product_management/out_order_input";
	}
	
	//외주 공정 현황
	@RequestMapping("/out_select")
	public String out_select(@RequestParam Map<String, Object> requestValues, Model model) {
		model.addAttribute("outlist", dao.outlist(requestValues));
		return "out_product_management/out_order_select";
	}
}
