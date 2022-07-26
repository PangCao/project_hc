<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/out_order_select.css"/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ArrayList<OutProductCommand> outlist = (ArrayList<OutProductCommand>)request.getAttribute("outlist");
	DecimalFormat decimalFormat = new DecimalFormat("###,###,###,###");
	Map<String, Integer> paging = (HashMap<String, Integer>)request.getAttribute("paging");
	ArrayList<ProjectCommand> projectlist = (ArrayList<ProjectCommand>)request.getAttribute("projectlist");
	String project_id = (String)request.getAttribute("project_id");
	ArrayList<OutCompanyListCommand> comlist = (ArrayList<OutCompanyListCommand>)request.getAttribute("comlist");
	Map<String, String> comMap = (HashMap<String, String>)request.getAttribute("commap");
	Map<String, String> orderchk = (HashMap<String, String>)request.getAttribute("orderchk");
	String StartDate = (String)request.getAttribute("startDate");
	String EndDate = (String)request.getAttribute("endDate");
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
			<section class="out_order_select_top">
				<div class="d-flex justify-content-between align-items-end">
					<div class="col-6">
						<form action="out_select?page=1" method="post" name="dateForm">
							<div class="col-12 pl-0">
								<input type="date" class="col-7" name="startdate" id="startdate" value="<%=StartDate%>">
							</div>
							<div class="col-12 pl-0">
								<input type="date" class="col-7" name="enddate" id="enddate" value="<%=EndDate%>">
								<input type="button" value="조회" onclick="project_date_search()">
							</div>
						</form>
					</div>
					<div class="col-4 d-flex align-items-end flex-column justify-content-end">
						<div style="width: 100%;" class="d-flex justify-content-end">
							<select name="" id="" class="col-10" onchange="project_search(this)">
						<%
							if (request.getAttribute("project_id") == null) {
						%>
								<option value="" disabled selected>== 프로젝트명 ==</option>
								<option value="all" selected>전체 프로젝트</option>
						<%
							}
							else {
						%>
								<option value="" disabled>== 프로젝트명 ==</option>
								<option value="all">전체 프로젝트</option>
						<%
							}
							for(int i = 0; i < projectlist.size(); i++) {
								ProjectCommand command = projectlist.get(i);
								if (project_id != null && project_id.equals(command.getPj_id())){
						%>
								<option value="<%=command.getPj_id()%>" selected><%= command.getPj_name() %></option>
						<%
								}
								else {
						%>
								<option value="<%=command.getPj_id()%>"><%= command.getPj_name() %></option>
						<%
								}
							}
						%>
							</select>
						</div>
						<form action="out_select?page=1&project_id=<%=project_id %>" method="post" style="width: 100%;">
							<input type="text" placeholder="품명" class="col-8" name="productname">
							<input type="submit" value="조회">
						</form>
						<form action="out_select?page=1&project_id=<%=project_id %>" method="post" style="width: 100%;">
							<input type="text" placeholder="업체명" class="col-8" name="comname">
							<input type="submit" value="조회">
						</form>
					</div>
				</div>
				<div class="p-0">
					<table>
						<tbody>
							<tr>
								<th>No</th>
								<th>의뢰번호</th>
								<th>프로젝트명</th>
								<th>업체명</th>
								<th>의뢰일</th>
								<th>납품예정일</th>
								<th>품명</th>
								<th>규격</th>
								<th>수량</th>
								<th>진행수량</th>
								<th>진행상황</th>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<section class="out_order_select_middle">
				<div>
					<table>
						<tbody>
					<%
						for(int i = 0; i < outlist.size(); i++) {
							OutProductCommand command = outlist.get(i);
					%>
							<tr>
								<td><%= paging.get("totalpage") - (paging.get("page")-1)*10 - i %></td>
								<td><%= command.getOp_ordernumber() %></td>
								<td><%= command.getOp_proname() %></td>
								<td><%= comMap.get(String.valueOf(command.getOp_comid())) %></td>
								<td><%= command.getOp_regdate().substring(0, 10) %><br><%= command.getOp_regdate().substring(10) %></td>
								<td></td>
								<td><%= command.getOp_productname() %></td>
								<td><%= command.getOp_productstandard() %></td>
								<td><%= command.getOp_unit() %></td>
								<td>0</td>
								<td><%= orderchk.get(String.valueOf(command.getOp_num())) %></td>
							</tr>
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
					<a href="out_select?page=<%=paging.get("page")-1%>&project_id=<%=request.getAttribute("project_id") %>&comname=<%=request.getAttribute("comname") %>&productname=<%=request.getAttribute("productname")%>&startdate=<%=request.getAttribute("startDate")%>&enddate=<%=request.getAttribute("endDate")%>" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="out_select?page=<%=i+1%>&project_id=<%=request.getAttribute("project_id") %>&comname=<%=request.getAttribute("comname") %>&productname=<%=request.getAttribute("productname") %>&startdate=<%=request.getAttribute("startDate")%>&enddate=<%=request.getAttribute("endDate")%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="out_select?page=<%=i+1%>&project_id=<%=request.getAttribute("project_id") %>&comname=<%=request.getAttribute("comname") %>&productname=<%=request.getAttribute("productname")%>&startdate=<%=request.getAttribute("startDate")%>&enddate=<%=request.getAttribute("endDate")%>"><%=i+1%></a>&nbsp;&nbsp;
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
					<a href="out_select?page=<%=paging.get("page")+1%>&project_id=<%=request.getAttribute("project_id") %>&comname=<%=request.getAttribute("comname") %>&productname=<%=request.getAttribute("productname")%>&startdate=<%=request.getAttribute("startDate")%>&enddate=<%=request.getAttribute("endDate")%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
				%>			
			</div>
		</section>
	</section>
</body>
<script type="text/javascript">
function project_date_search() {
	let s_date = document.getElementById('startdate');
	let e_date = document.getElementById('enddate');
	if (s_date.value.length < 1) {
		alert('조회 시작일을 입력해주세요.');
		return false;
	}
	if (e_date.value.length < 1) {
		alert('조회 종료일을 입력해주세요.');
		return false;
	}
	if (new Date(s_date.value) > new Date(e_date.value)) {
		alert('조회 시작일보다 종료일이 빠른 날짜일 수 없습니다.');
		return false;
	}
	document.dateForm.submit();
}
function project_search(obj) {
	console.log(obj.value);
	location.href="out_select?page=1&project_id="+obj.value;
}
document.getElementById('out_management').checked=true;
</script>
</html>