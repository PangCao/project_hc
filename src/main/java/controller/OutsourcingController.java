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
	public String out_input(@RequestParam Map<String, Object> requestValues, @RequestParam(required=false) String stat, Model model){
		List<OutProductCommand> outlist = dao.outlist(requestValues);
		dao.author_select(outlist);
		dao.project_name_select(outlist);
		model.addAttribute("outlist", outlist);
		model.addAttribute("paging", dao.pageConut(dao.totalpage(requestValues), requestValues));
		model.addAttribute("projectlist", dao.projectlist());
		model.addAttribute("project_id", requestValues.get("project_id"));
		model.addAttribute("comname", requestValues.get("comname"));
		model.addAttribute("productname", requestValues.get("productname"));
		model.addAttribute("startDate", requestValues.get("startdate"));
		model.addAttribute("endDate", requestValues.get("enddate"));
		model.addAttribute("comlist", dao.out_com_list(model));
		model.addAttribute("commap", dao.commap());
		model.addAttribute("stat", stat);
		return "out_product_management/out_order_input";
	}
	
	//외주 공정 현황
	@RequestMapping("/out_select")
	public String out_select(@RequestParam Map<String, Object> requestValues, Model model) {
		List<OutProductCommand> outlist = dao.outlist(requestValues);
		dao.author_select(outlist);
		dao.project_name_select(outlist);
		model.addAttribute("outlist", outlist);
		model.addAttribute("paging", dao.pageConut(dao.totalpage(requestValues), requestValues));
		model.addAttribute("projectlist", dao.projectlist());
		model.addAttribute("project_id", requestValues.get("project_id"));
		model.addAttribute("comname", requestValues.get("comname"));
		model.addAttribute("productname", requestValues.get("productname"));
		model.addAttribute("startDate", requestValues.get("startdate"));
		model.addAttribute("endDate", requestValues.get("enddate"));
		model.addAttribute("comlist", dao.out_com_list(model));
		model.addAttribute("orderchk", dao.order_check());
		model.addAttribute("commap", dao.commap());
		return "out_product_management/out_order_select";
	}
	
	//외주 등록 팝업이동
	@RequestMapping("/out_input_popup")
	public String out_input_popup(Model model) {
		model.addAttribute("projectlist", dao.projectlist());
		model.addAttribute("comlist", dao.out_com_list(model));
		return "out_product_management/out_input_popup";
	}
	
	//외주 등록 프로세스
	@RequestMapping("/out_input_popup_input")
	public String out_input_popup_input(OutProductCommand command, Model model) {
		dao.out_input(command, dao.commap());
		return "out_product_management/closepopup";
	}
}
