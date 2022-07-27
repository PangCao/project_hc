<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="command.*" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/process_input.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ArrayList<ProjectCommand> projectlist = (ArrayList<ProjectCommand>)request.getAttribute("projectlist");
	String stat = (String)request.getAttribute("stat");
	ArrayList<ProductCommand> productlist = (ArrayList<ProductCommand>)request.getAttribute("productlist");
	Map<String, String> memberMap = (HashMap<String, String>)request.getAttribute("membermap");
	Map<String, Integer> paging = (HashMap<String, Integer>)request.getAttribute("paging");
	Map<String,String> projectmap = (HashMap<String, String>)request.getAttribute("projectmap");
	
	if (stat != null && stat.equals("2")) {
%>
<script type="text/javascript">
	alert('정상적으로 등록되었습니다.');
</script>
<%
	}
%>
</head>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="proccess_input_top">
				<div class="d-flex justify-content-between">
					<div class="col-6">
						<select name="project_id" id="project_id">
							<option value="" selected disabled oninput="">== 프로젝트명 ==</option>
						<%
							for(int i = 0; i < projectlist.size(); i++){
								ProjectCommand command = projectlist.get(i);
						%>
							<option value="<%=command.getPj_id()%>"><%=command.getPj_name() %></option>
						<%
							}
						%>
							
						</select>
						<select name="task_prefix" id="task_prefix">
							<option value="" selected disabled oninput="">== 작업번호 대분류 ==</option>
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
						</select>
						<select name="task_suffix" id="task_suffix">
							<option value="" selected disabled oninput="">== 작업번호 소분류 ==</option>
							<%
								for(int i = 0; i < 12; i++) {
							%>
								<option value="<%=i+1%>"><%=i+1%></option>
							<%
								}
							%>
						</select>
					</div>
					<div class="col-6 d-flex align-items-end flex-column">
						<input type="button" value="등록" onclick="inputpopup()">
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
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<section class="proccess_input_middle">
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
								<td><%= command.getP_tasknumber()%></td>
								<td><%= command.getP_processnumber() %></td>
								<td><%= command.getP_regdate() %></td>
								<td><%= command.getP_startdate() %></td>
								<td><%= command.getP_compledate() %></td>
								<td>이슈가 총 <a href="#" onclick="issueup<%=i%>()" style="color:red;"><%= command.getP_remarkid() != null? command.getP_remarkid().split(",").length:0 %></a>개 존재합니다.</td>
								<td><%= memberMap.get(command.getP_regnum()) %></td>
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
					if(paging.get("page") == 1){	
				%>
					<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					else {
				%>
					<a href="input?page=<%=paging.get("page")-1%>"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="input?page=<%=i+1%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="input?page=<%=i+1%>"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
					}
					if (paging.get("page") * 10 >= paging.get("total")) {
				%>
					<a href="#" onclick="lastpage()"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					else {
				%>
					<a href="input?page=<%=paging.get("page")+1%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
				%>
			</div>
		</section>
	</section>
</body>
<script type="text/javascript">


	function inputpopup() {
		let pro_n = document.getElementById('project_id');
		let task_p = document.getElementById('task_prefix');
		let task_s = document.getElementById('task_suffix');
		if (pro_n.value == "") {
			alert('프로젝트명을 선택해주세요.');
			return false;
		}
		if (task_p.value == "") {
			alert('작업번호 대분류를 선택해주세요.');
			return false;
		}
		if (task_s.value == "") {
			alert('작업번호 소분류를 선택해주세요.');
			return false;
		}
		x
		let popwidth = 1000;
		let popheight = 700;
		let popx = (window.screen.width / 2) - (popwidth / 2);
		let popy = (window.screen.height / 2) - (popheight / 2);
		window.open("input_popup?project_id="+pro_n.value+"&task="+task_p.value+task_s.value,"inputpop", "status=no, width="+popwidth+", height="+popheight+", left="+popx+", top="+popy);
	}
	document.getElementById('product_management').checked=true;
</script>
</html>