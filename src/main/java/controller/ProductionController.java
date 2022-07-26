package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import command.ProductCommand;
import command.RemarkCommand;
import service.ManagementDao;

//생산관리
@Controller
public class ProductionController {
	
	@Autowired
	private ManagementDao dao;
	
	@RequestMapping("project_input")
	public String project_input(Model model) {
		
		return "redirect:product_management";
	}
	
	@RequestMapping("/input_popup")
	public String input_popup(@RequestParam String project_id, @RequestParam String task, Model model) {
		model.addAttribute("projectinput", dao.project_id_name(project_id));
		model.addAttribute("task", task);
		return "product_management/input_popup";
	}
	
	@RequestMapping("/projectpopup")
	public String projectpopup() {
		return "product_management/projectpopup";
	}
	
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
	public String input(@RequestParam(required=false) String stat, @RequestParam(defaultValue = "1") int page, Model model){
		model.addAttribute("projectlist", dao.projectlist());
		model.addAttribute("stat", stat);
		model.addAttribute("productlist", dao.productlist("input"));
		model.addAttribute("membermap", dao.membermap());
		model.addAttribute("paging",  dao.paging(dao.totalpage(), page));
		
		return "product_management/process_input";
	}
	
	@RequestMapping("/input_popup_input")
	public String input_popup_input(HttpSession session, ProductCommand command, RemarkCommand issue, @RequestParam String p_prefix, @RequestParam String p_suffix, Model model) {
		dao.product_insert(command, p_prefix, p_suffix, dao.remark_insert(issue, session), session);
		model.addAttribute("stat", "2");
		return "closepopup";
	}
	
	//생산 작업 지시 착수
	@RequestMapping("/complete")
	public String complete(@RequestParam(required=false) String stat, Model model){
		model.addAttribute("pagechk", "complete");
		model.addAttribute("productlist", dao.productlist("complete"));
		model.addAttribute("memberMap",dao.membermap());
		model.addAttribute("stat", model.getAttribute("stat"));
		model.addAttribute("projectlist", dao.projectlist());
		return "product_management/product_complete";
	}
	
	//생산 작업 실적 등록
	@RequestMapping("/record")
	public String record(@RequestParam(required=false) String stat, Model model){
		model.addAttribute("pagechk", "record");
		model.addAttribute("productlist", dao.productlist("record"));
		model.addAttribute("memberMap",dao.membermap());
		model.addAttribute("stat", model.getAttribute("stat"));
		model.addAttribute("projectlist", dao.projectlist());
		return "product_management/product_complete";
	}
	
	@RequestMapping("/issue_popup")
	public String issue_popup(@RequestParam String issueids, Model model) {
		model.addAttribute("issuelist", dao.issuelist(issueids));		
		return "product_management/issuepopup";
	}

	@RequestMapping("/startdate_input")
	public String startdate(@RequestParam int product_id, RedirectAttributes ra) {
		dao.startdate_update(product_id);
		ra.addFlashAttribute("stat", "1");
		return "redirect:complete";
	}
	
	@RequestMapping("/comple_input")
	public String compledate(@RequestParam int product_id, RedirectAttributes ra) {
		dao.compledate_update(product_id);
		ra.addFlashAttribute("stat", "2");
		return "redirect:record";
	}
}
