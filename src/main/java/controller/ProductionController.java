package controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import command.ProductCommand;
import command.ProjectCommand;
import command.RemarkCommand;
import service.ManagementDao;

//생산관리
@Controller
public class ProductionController {
	
	@Autowired
	private ManagementDao dao;
	
	@RequestMapping("project_input")
	public String project_input(@RequestParam(required = false) String name,
			@RequestParam(required = false) String date, 
			@RequestParam(required = false) String Sequence, Model model) {
		dao.ProjectCreate(name,date);
		return "redirect:product_management";
	}
	
	@RequestMapping("/projectpopup")
	public String projectpopup() {
		return "product_management/projectpopup";
	}
	
	//전체 공정 현황
	@RequestMapping("/product_management")
	public String product_management(Model model) {
		model.addAttribute("ProCom", dao.ProjectSearch());
		return "product_management/project_management";
	}
	
	//프로잭트 서브
	@RequestMapping("/project_sub_management")
	public String sub(@RequestParam String Sequence, Model model){
		model.addAttribute("pcc", dao.PccSearch(Sequence));
		model.addAttribute("sq",Sequence);
		return "product_management/project_sub_management";
	}
	
	//생산 작업 실적 등록
	@RequestMapping("/project_detail")
	public String detail(@RequestParam String sq, Model model){
		model.addAttribute("productcom",dao.pcom(sq));
		return "product_management/project_detail";
	}
	
	//생산 작업 지시 등록
	@RequestMapping("/input")
	public String input(@RequestParam Map<String, Object> requestValues, Model model){
		model.addAttribute("projectlist", dao.projectlist());
		model.addAttribute("stat", requestValues.get("stat"));
		model.addAttribute("productlist", dao.productlist("input", requestValues));
		model.addAttribute("membermap", dao.membermap());
		model.addAttribute("paging",  dao.paging(dao.totalpage("input", requestValues), requestValues));
		model.addAttribute("projectmap", dao.projectmap());
		model.addAttribute("product_issuelist", dao.product_issuelist());
		
		return "product_management/process_input";
	}
	
	@RequestMapping("/input_popup")
	public String input_popup(@RequestParam String project_id, @RequestParam String task, @RequestParam(required = false) String process, Model model) {
		model.addAttribute("projectinput", dao.project_id_name(project_id));
		model.addAttribute("task", task);
		model.addAttribute("processlist", dao.proparts(project_id, task));
		model.addAttribute("process", process);
		model.addAttribute("project_id",project_id);
		return "product_management/input_popup";
	}
	
	@RequestMapping("/input_popup_input")
	public String input_popup_input(HttpSession session, ProductCommand command, RemarkCommand issue, @RequestParam Map<String, Object> requestValues, Model model) {
		
		int p_num = dao.product_insert(command, requestValues, session);
		int remarkId = dao.remark_insert(issue, session, p_num);
		if (remarkId != -1) {
			dao.remark_project_insert(command, issue, remarkId, requestValues);
		}
		dao.projectcreate_update(requestValues, 1);
		model.addAttribute("stat", "2");
		return "closepopup";
	}
	
	//생산 작업 지시 착수
	@RequestMapping("/complete")
	public String complete(@RequestParam Map<String, Object> requestValues, Model model){
		model.addAttribute("pagechk", "complete");
		model.addAttribute("productlist", dao.productlist("complete", requestValues));
		model.addAttribute("product_issuelist", dao.product_issuelist());
		model.addAttribute("memberMap",dao.membermap());
		model.addAttribute("stat", model.getAttribute("stat"));
		model.addAttribute("projectlist", dao.projectlist());
		model.addAttribute("project_id", (String)requestValues.get("project_id"));
		model.addAttribute("paging", dao.paging(dao.totalpage("complete", requestValues), requestValues));
		model.addAttribute("tasknumber", requestValues.get("p_tasknumber"));
		model.addAttribute("processnumber", requestValues.get("processnumber"));
		model.addAttribute("projectmap", dao.projectmap());
		return "product_management/product_complete";
	}
	
	//생산 작업 실적 등록
	@RequestMapping("/record")
	public String record(@RequestParam Map<String, Object> requestValues, Model model){
		model.addAttribute("pagechk", "record");
		model.addAttribute("productlist", dao.productlist("record", requestValues));
		model.addAttribute("memberMap",dao.membermap());
		model.addAttribute("product_issuelist", dao.product_issuelist());
		model.addAttribute("stat", model.getAttribute("stat"));
		model.addAttribute("projectlist", dao.projectlist());
		model.addAttribute("project_id", (String)requestValues.get("project_id"));
		model.addAttribute("paging", dao.paging(dao.totalpage("record", requestValues), requestValues));
		model.addAttribute("tasknumber", requestValues.get("p_tasknumber"));
		model.addAttribute("processnumber", requestValues.get("processnumber"));
		model.addAttribute("projectmap", dao.projectmap());
		return "product_management/product_complete";
	}
	
	@RequestMapping("/issue_popup")
	public String issue_popup(@RequestParam Map<String, Object> requestValues, Model model) {
		model.addAttribute("issuelist", dao.issuelist(requestValues));
		model.addAttribute("p_num", (String)requestValues.get("p_num"));
		model.addAttribute("paging", dao.paging(dao.issuetotal(), requestValues));
		model.addAttribute("stat", model.getAttribute("stat"));
		return "product_management/issuepopup";
	}
	
	@RequestMapping("/issuepopup_view")
	public String issuepopup_view(@RequestParam Map<String, Object> requestValues, Model model) {
		dao.issue_viewUp(Integer.valueOf((String)requestValues.get("r_id")));
		model.addAttribute("issueDetail", dao.issueDetail(requestValues));
		model.addAttribute("p_num", (String)requestValues.get("p_num"));
		model.addAttribute("r_id", (String)requestValues.get("r_id"));
		model.addAttribute("next_prev", dao.next_prev(requestValues));
		return "product_management/issuepopup_view";
	}
	
	@RequestMapping("/startdate_input")
	public String startdate(@RequestParam Map<String, Object> requestValues, RedirectAttributes ra) {
		dao.startdate_update(Integer.valueOf((String)requestValues.get("product_num")));
		dao.projectcreate_update(requestValues, 2);
		ra.addFlashAttribute("stat", "1");
		return "redirect:complete";
	}
	
	@RequestMapping("/comple_input")
	public String compledate(@RequestParam Map<String, Object> requestValues, RedirectAttributes ra) {
		dao.compledate_update(Integer.valueOf((String)requestValues.get("product_num")));
		ra.addFlashAttribute("stat", "2");
		dao.projectcreate_update(requestValues, 3);
		return "redirect:record";
	}
	
	@RequestMapping("/issue_popup_delete")
	public String issue_delete(@RequestParam String r_id, @RequestParam String p_num, RedirectAttributes ra) {
		dao.issue_delete(r_id, p_num);
		ra.addAttribute("r_id", r_id);
		ra.addAttribute("p_num", p_num);
		ra.addFlashAttribute("stat", "1");
		return "redirect:issue_popup";
	}
}
