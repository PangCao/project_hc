<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.*" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/product_complete.css"/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<head>
<%
	String pagechk = (String)request.getAttribute("pagechk");
	ArrayList<ProductCommand> productlist = (ArrayList<ProductCommand>)request.getAttribute("productlist");
	HashMap<String, String> memberMap = (HashMap<String, String>)request.getAttribute("memberMap");
	String stat = (String)request.getAttribute("stat");
	ArrayList<ProjectCommand> projectlist = (ArrayList<ProjectCommand>)request.getAttribute("projectlist");
	String project_id = (String)request.getAttribute("project_id");
	Map<String, Integer> paging = (HashMap<String, Integer>)request.getAttribute("paging");
	String tasknumber = (String)request.getAttribute("tasknumber");
	String processnumber = (String)request.getAttribute("processnumber");
	Map<String, String> projectmap = (HashMap<String, String>)request.getAttribute("projectmap");
	
	if (stat != null && stat.equals("1")){
%>
<script type="text/javascript">
	alert('공정을 정상적으로 착수하였습니다.');
</script>
<%
	}
	else if(stat != null && stat.equals("2")) {
%>
<script type="text/javascript">
	alert('공정을 정상적으로 완료하였습니다.');
</script>
<%
	}
	
	if (pagechk.equals("complete")) {
%>
<script type="text/javascript">
	function project_search(obj) {
		location.href="complete?project_id="+obj.value;
	}
</script>
<style type="text/css">
.complete_product {
	background-color: rgb(0, 175, 23);
    color: white !important;
}
.complete_product:hover {
	background-color: rgb(0, 175, 23) !important;
    color: white !important;
}
</style>
<%
	} else{
%>
<script type="text/javascript">
	function project_search(obj) {
		location.href="record?project_id="+obj.value;
	}
</script>
<style type="text/css">
.record_product {
	background-color: rgb(0, 175, 23);
    color: white !important;
}
.record_product:hover {
	background-color: rgb(0, 175, 23) !important;
    color: white !important;
}
</style>
<%
	}
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="product_complete_top">
				<div class="d-flex justify-content-between pl-0">
					<div class="col-6 pl-0">
						<select class="col-6 text-center" onchange="project_search(this)">
				<%
					if (project_id != null && !project_id.equals("null")){
				%>
							<option value="" disabled>== 프로젝트명 ==</option>
				<%
					}
					else{
				%>
							<option value="" disabled selected>== 프로젝트명 ==</option>
				<%
					}
				%>
							<option value="null">전체 프로젝트</option>
				<%
					
					for(int i = 0; i < projectlist.size(); i++){
						ProjectCommand command = projectlist.get(i);
						if (command.getPj_id().equals(project_id)){
				%>
						<option value="<%=command.getPj_id() %>" selected><%=command.getPj_name() %></option>
				<%
						}
						else {
				%>
						<option value="<%=command.getPj_id() %>" ><%=command.getPj_name() %></option>
				<%
							
						}
					}
				%>
						</select>
					</div>
					<div class="col-6 d-flex align-items-end flex-column">
					<%
						if (pagechk.equals("complete")) {
					%>
						<form action="complete?project_id=<%= project_id %>" method="post">
							<input type="text" placeholder="작업번호" name="p_tasknumber">
							<input type="submit" value="조회">
						</form>
					<%
						}
						else {
					%>
						<form action="record?project_id=<%= project_id %>" method="post">
							<input type="text" placeholder="작업번호" name="p_tasknumber">
							<input type="submit" value="조회">
						</form>
					<%
						}
						if (pagechk.equals("complete")) {
					%>
						<form action="complete?project_id=<%= project_id %>" method="post">
							<input type="text" placeholder="공정번호" name="processnumber">
							<input type="submit" value="조회">
						</form>
					<%
						}
						else {
					%>
						<form action="record?project_id=<%= project_id %>" method="post">
							<input type="text" placeholder="공정번호" name="processnumber">
							<input type="submit" value="조회">
						</form>
					<%
						}
					%>
					</div>
				</div>
				<div class="p-0">
					<table>
						<tbody>
							<tr>
								<th>No</th>
								<th>프로젝트명</th>
								<th>작업번호</th>
								<th>공정번호</th>
								<th>등록일</th>
								<th>착수일</th>
								<th>완료일</th>
								<th>특이사항</th>
								<th>등록자</th>
								<th>결재상태</th>
								<th>결재신청</th>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<section class="product_complete_middle">
		
				<div>
					<table>
						<tbody>
				<%
					
						for(int i = 0; i < productlist.size(); i++) {
							ProductCommand command = productlist.get(i);
				%>
							<tr>
								<td><%=i+1 %></td>
								<td><%=projectmap.get(command.getP_proid()) %></td>
								<td><%=command.getP_tasknumber() %></td>
								<td><%=command.getP_processnumber() %></td>
								<td><%=command.getP_regdate().substring(0,10) %><br><%=command.getP_regdate().substring(10) %></td>
				<%
					if (command.getP_startdate().equals("-")){ 
				%>
								<td><%=command.getP_startdate() %></td>
				<%
					}
					else{
				%>
								<td><%=command.getP_startdate().substring(0,10) %><br><%=command.getP_startdate().substring(10) %></td>
				<%
					}
					if (command.getP_compledate().equals("-")){
				%>
								<td><%=command.getP_compledate() %></td>
				<%
					}
					else{
				%>
								<td><%=command.getP_startdate().substring(0,10) %><br><%=command.getP_compledate().substring(10) %></td>
				<%
					}
				%> 
								<td><a href="#" onclick="issueup<%=i%>()" style="color:black;">이슈가 총 <span style="color:red;"><%=command.getP_remarkid() != null ? command.getP_remarkid().split(",").length : 0 %></span>개 존재합니다.</a></td>
								<td><%=memberMap.get(command.getP_regnum())%></td>
								<td><%=command.getP_state() %></td>
				<%
							if (pagechk.equals("complete")) {
				%>
								<td><input type="button" value="착수" class="order_btn" onclick="start_input<%=i%>()"></td>
								<script type="text/javascript">
									function start_input<%=i%>() {
										if (confirm('\"<%=projectmap.get(command.getP_proid())%>\"프로젝트의 \"<%=command.getP_processnumber()%>\"를 착수하시겠습니까?')){
											location.href="startdate_input?product_num=<%=command.getP_num()%>&project_id=<%=command.getP_proid()%>&p_tasknumber=<%=command.getP_tasknumber() %>&p_prefix=<%=command.getP_processnumber().substring(0, command.getP_processnumber().length()-3) %>&p_suffix=<%=command.getP_processnumber().substring(command.getP_processnumber().length()-3)%>";
										}
									}
								</script>
				<%
							}
							else {
								if (command.getP_compledate().equals("-")){
				%>
								<td><input type="button" value="완료" class="comple_btn" onclick="comple_input<%=i%>()"></td>
								<script type="text/javascript">
									function comple_input<%=i%>() {
										if (confirm('\"<%=projectmap.get(command.getP_proid())%>\"프로젝트의 \"<%=command.getP_processnumber()%>\"를 완료하시겠습니까?')) {
											location.href="comple_input?product_num=<%=command.getP_num()%>&project_id=<%=command.getP_proid()%>&p_tasknumber=<%=command.getP_tasknumber() %>&p_prefix=<%=command.getP_processnumber().substring(0, command.getP_processnumber().length()-3) %>&p_suffix=<%=command.getP_processnumber().substring(command.getP_processnumber().length()-3)%>";
										}	
									}
								</script>
				<%
								}
								else{
				%>
								<td><input type="button" value="완료" class="comple_btn" disabled></td>
				<%
								}
				%>

				<%
							}
				%>
							</tr>
							<script type="text/javascript">
								function issueup<%=i%>() {
									let popwidth = 920;
									let popheight = 720;
									let popx = (window.screen.width / 2) - (popwidth / 2);
									let popy = (window.screen.height / 2) - (popheight / 2);
									window.open("issue_popup?issueids=<%=command.getP_remarkid()%>" ,"issuepop", "status=no, width="+popwidth+", height="+popheight+", left="+popx+", top="+popy);
								}
							</script>
				<%
						}
					
				%>
						</tbody>
					</table>
				</div>
			</section>
			<div class="d-flex justify-content-center mt-5">
				<%
				if (pagechk.equals("complete")) {
					if(paging.get("page") == 1){	
				%>
					<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					else {
				%>
					<a href="complete?page=<%=paging.get("page")-1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="complete?page=<%=i+1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="complete?page=<%=i+1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
					}
					if (paging.get("page") == paging.get("max")) {
				%>
					<a href="#" onclick="lastpage()"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					else {
				%>
					<a href="complete?page=<%=paging.get("page")+1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
				}
				else {
					if(paging.get("page") == 1){	
					%>
						<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
					<%
						}
						else {
					%>
						<a href="record?page=<%=paging.get("page")-1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
					<%
						}
						for(int i = paging.get("min"); i < paging.get("max"); i++){
							if (paging.get("page")-1 == i) {
					%>
						<a href="record?page=<%=i+1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
					<%
							}
							else {
					%>
						<a href="record?page=<%=i+1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>"><%=i+1%></a>&nbsp;&nbsp;
					<%
							}
						}
						if (paging.get("page") == paging.get("max")) {
					%>
						<a href="#" onclick="lastpage()"><i class="fa-solid fa-angle-right"></i></a>
					<%
						}
						else {
					%>
						<a href="record?page=<%=paging.get("page")+1%>&project_id=<%=project_id %>&tasknumber=<%= tasknumber%>&processnumber=<%=processnumber %>"><i class="fa-solid fa-angle-right"></i></a>
					<%
						}
				}
				%>
			</div>
		</section>
	</section>
</body>
<script type="text/javascript">
	document.getElementById('product_management').checked=true;
</script>
</html>