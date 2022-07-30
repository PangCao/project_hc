<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.ProductCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/search.css"/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<style>
.all_product {
	background-color: rgb(0, 175, 23);
    color: white !important;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	ArrayList<ProductCommand> detaillist = (ArrayList<ProductCommand>)request.getAttribute("detaillist");
	Map<String, String> regnum = (Map<String, String>)request.getAttribute("membermap");
	Map<String, Integer> paging = (Map<String, Integer>)request.getAttribute("paging");
	Map<String, String> projectmap = (HashMap<String, String>)request.getAttribute("projectmap");
	String sdate = (String)request.getAttribute("sdate");
	String fdate = (String)request.getAttribute("fdate");
	String tasknum = (String)request.getAttribute("tasknum");
	String pj_id = (String)request.getAttribute("pj_id");
	String processnum = (String)request.getAttribute("processnum");
	String taskselector = (String)request.getAttribute("taskselector");
	DecimalFormat df = new DecimalFormat("00");
%>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="search_top" style="z-index:1">
				<div class="d-flex justify-content-between">
					<div class="col-6">
						<form action="project_detail" method="post" name="dateForm">
							<div class="col-12 pl-0">
								<input type="date"  name="sdate" id="sdate" value="<%=sdate %>" class="col-7">
							</div>
							<div class="col-12 pl-0">
								<input type="date" name="fdate" id="fdate" value="<%=fdate %>" class="col-7">
								<input type="button" onclick="SearchDate()" value="조회">
							</div>
						</form>
					</div>
					<div class="col-6 d-flex align-items-end flex-column">
						<form action="project_detail?pj_id=<%=pj_id %>" method="post" class="col-6 row">
							<select name="tasknum" id="tasknum" class="col-12 text-center" onchange="tasknumchg(this)" style="height: 32px; padding-top:2px; padding-bottom:2px; margin:5px;">
							<%
								if (tasknum != null && !tasknum.equals("")) {
							%>
								<option value="" disabled>== 작업번호 ==</option>
							<%
								}
								else {
							%>
								<option value="" selected disabled>== 작업번호 ==</option>
							<%
								}
								if (tasknum != null && tasknum.equals("all")) {
							%>
								<option value="all" selected>== 전체공정 ==</option>
							<%
								}
								else{
							%>
								<option value="all">== 전체공정 ==</option>
							<%
								}
								for(int i = 0; i < 12; i++) {
									if (tasknum != null && tasknum.equals(String.valueOf(df.format(i+1)))){
							%>
										<option value="<%=df.format(i+1)%>" selected><%=df.format(i+1) %></option>
							<%
									}
									else {
							%>
										<option value="<%=df.format(i+1)%>"><%=df.format(i+1) %></option>
							<%
									}
								}
							%>
							</select>
							<script type="text/javascript">
								function tasknumchg(obj) {
									location.href="project_detail?page=<%=1%>&pj_id=<%=pj_id %>&sdate=<%=sdate%>&fdate=<%=fdate%>&tasknum="+obj.value+"&processnum=<%=processnum%>&taskselector=<%=taskselector%>"
								}
							</script>
						</form>
						<form action="project_detail?page=<%=1%>&pj_id=<%=pj_id %>&sdate=<%=sdate%>&fdate=<%=fdate%>&tasknum=<%=tasknum %>&taskselector=<%=taskselector%>" method="post" class="col-6 row d-flex justify-content-between">
							<input type="text" name="processnum" id="processnum" placeholder="공정번호" class="col-8">
							<input type="submit"  value="조회" class="col-3">
						</form>
					</div>
				</div>
				<div class="p-0">
					<table>
						<tbody>
							<tr>
								<th>No</th>
								<th>프로잭트코드</th>
								<th>프로잭트명</th>
								<th>작업번호</th>
								<th>공정번호</th>
								<th>등록일</th>
								<th>착수일</th>
								<th>완료일</th>
								<th>등록자</th>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<%
				if(detaillist != null){
					for(int i=0; i<detaillist.size(); i++){
						ProductCommand productcom = detaillist.get(i);
			%>
			<section class="search_middle">
				<div>
					<table>
						<tbody>
							<tr>
								<td><%=productcom.getP_num() %></td>
								<td><%=productcom.getP_proid() %></td>
								<td><%=projectmap.get(productcom.getP_proid()) %></td>
								<td><%=productcom.getP_tasknumber() %></td>
								<td><%=productcom.getP_processnumber() %></td>
								<td><%=productcom.getP_regdate().substring(0,10) %><br><%=productcom.getP_regdate().substring(10) %></td>
								<%
									if (!productcom.getP_startdate().equals("-")) {
								%>
								<td><%=productcom.getP_startdate().substring(0,10) %><br><%=productcom.getP_startdate().substring(10) %></td>
								<%
									}
									else {
								%>
								<td><%=productcom.getP_startdate() %></td>
								<%
									}
									if (!productcom.getP_compledate().equals("-")) {
								%>
								<td><%=productcom.getP_compledate().substring(0,10) %><br><%= productcom.getP_compledate().substring(10) %></td>
								<%
									}
									else {
								%>
								<td><%=productcom.getP_compledate() %></td>
								<%
									}
								%>
								<td><%=regnum.get(productcom.getP_regnum()) %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
							<%
					}
				}
				else{
			%>
			<section class="search_middle">
				<div>
					<table>
						<tbody>
							<tr>
								<td colspan="5" class="text-center">정보가 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<%
				}
			%>
			<div class="col-12 d-flex justify-content-center my-5">
				<%
					if(paging.get("page") == 1){	
				%>
					<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					else {
				%>
					<a href="project_detail?page=<%=paging.get("page")-1%>&pj_id=<%=pj_id %>&sdate=<%=sdate%>&fdate=<%=fdate%>&tasknum=<%=tasknum%>&processnum=<%=processnum%>&taskselector=<%=taskselector%>"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="project_detail?page=<%=i+1%>&pj_id=<%=pj_id %>&sdate=<%=sdate%>&fdate=<%=fdate%>&tasknum=<%=tasknum%>&processnum=<%=processnum%>&taskselector=<%=taskselector%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="project_detail?page=<%=i+1%>&pj_id=<%=pj_id %>&sdate=<%=sdate%>&fdate=<%=fdate%>&tasknum=<%=tasknum%>&processnum=<%=processnum%>&taskselector=<%=taskselector%>"><%=i+1%></a>&nbsp;&nbsp;
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
					<a href="project_detail?page=<%=paging.get("page")+1%>&pj_id=<%=pj_id %>&sdate=<%=sdate%>&fdate=<%=fdate%>&tasknum=<%=tasknum%>&processnum=<%=processnum%>&taskselector=<%=taskselector%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					
				%>
			</div>				
		</section>
	</section>
</body>
<script type="text/javascript">
	function SearchDate(){
		let sdates = document.getElementById("sdate").value;
		let fdates = document.getElementById("fdate").value;
		if (sdates == "") {
			alert('조회 시작일을 선택해주세요.');
			return false;
		}
		if (fdates == "") {
			alert('조회 종료일을 선택해주세요.');
			return false;
		}
		if (new Date(sdates) > new Date(fdates)) {
			alert('조회 일자를 다시 한 번 확인해주세요.');
			return false;
		}
		document.dateForm.submit();
	}
</script>
</html>