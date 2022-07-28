<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="command.RemarkCommand" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/issue.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ArrayList<RemarkCommand> issuelist = (ArrayList<RemarkCommand>)request.getAttribute("issuelist");
	Map<String, Integer> paging = (HashMap<String, Integer>)request.getAttribute("paging");
	String rc = (String)request.getAttribute("r_class");
	String sdate = (String)request.getAttribute("sdate");
	String fdate = (String)request.getAttribute("fdate");
	String search_title = (String)request.getAttribute("search_title");
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
			<section class="issue">
				<h2 class="col-6 ml-5 mt-5">이슈관리</h2>
				<div class="d-flex justify-content-between">
					<div class="col-5">
						<form action="" class="col-12">
							<div style="width: 100%;">
								<input type="date" name="sdate" id="sdate" value="<%=sdate %>" style="width: 50%;">

							</div>
							<div style="width: 100%;">
								<input type="date" name="fdate" id="fdate" value="<%=fdate %>" style="width: 50%;">
								<input type="button" value="검색" onclick="SearchDate()" class="col-3">
							</div>
						</form>
					</div>
					<div class="col-4 d-flex">
						<div class="col-12 p-0">
							<form action="" method="post" class="col-12 p-0 d-flex justify-content-end">
								<select name="r_class" id="r_class" onchange="r_class_input()" class="col-8 text-center">
								<%
										if(rc !=null && rc.equals("")){
								%>
											<option value="" selected>== 심각도 선택 ==</option>
										<%
										}else{
										%>
											<option value="" >== 심각도 선택 ==</option>
										<%
										}
										
										if(rc !=null && rc.equals("INFO")){
										%>
											<option value="INFO" selected>INFO</option>
										<%
										}else{
										%>
											<option value="INFO" >INFO</option>
										<%
										}
										
										if(rc !=null && rc.equals("CARE")){
										%>
										<option value="CARE"selected>CARE</option>
										<%
										}else{
										%>
											<option value="CARE" >CARE</option>
										<%
										}
										
										if(rc !=null && rc.equals("WARN")){
										%>
											<option value="WARN" selected>WARN</option>
										<%
										}else{
										%>
											<option value="WARN" >WARN</option>
										<%
										}
										
										if(rc !=null && rc.equals("DANGER")){
										%>
											<option value="DANGER" selected>DANGER</option>
										<%
										}else{
										%>
											<option value="DANGER" >DANGER</option>
										<%
										}
								%>
								</select>
								<span class="col-4 ml-2"></span>
							</form>
							<form  action="issue" method="post" class="col-12 p-0 d-flex justify-content-end">
								<input type="text" name="search_title"class="col-8">
								<input type="submit" value="검색" class="col-4 ml-2">
							</form>
						</div>
					</div>
				</div>
				<div class="col-12">
					<table class="col-12 table table-hover text-center">
						<tbody>
							<tr>
								<th class="col-1">NO</th>
								<th class="col-4">제목</th>
								<th class="col-2">등록자</th>
								<th class="col-2">등록일</th>
								<th class="col-2">심각도</th>
								<th class="col-1">조회수</th>
							</tr>
					<%

						if (issuelist != null) {
							for(int i = 0; i < issuelist.size(); i++) {
								RemarkCommand dto = issuelist.get(i);
					%>
							<tr>
								<td><%= paging.get("total") - ((paging.get("page")-1)*10) - i %></td>
								<td><a style="color:black;" href="issue_view?r_id=<%=dto.getR_id()%>"><%= dto.getR_title() %></a></td>
								<td><%= dto.getR_anthor() %></td>
								<td><%= dto.getR_date() %></td>
								<td><%= dto.getR_class() %></td>
								<td><%= dto.getR_view() %></td>
							</tr>
					<%
							}
						}
						else {
					%>
							<tr>
								<td colspan="5" class="text-center">등록된 이슈가 없습니다.</td>
							</tr>
					<%
						}
					%>
						</tbody>
					</table>
				</div>
				<div class="d-flex justify-content-end col-12">
					<div class="d-flex justify-content-end col-2">
						<input type="button" value="이슈 작성" onclick="location.href='issue_write'">
					</div>
				</div>
			</section>
			<div class="col-12 d-flex justify-content-center">
				<%
					if(paging.get("page") == 1){	
				%>
					<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					else {
				%>
					<a href="issue?page=<%=paging.get("page")-1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="issue?page=<%=i+1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="issue?page=<%=i+1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
					}
					if (paging.get("page") * 10 >= paging.get("total")) {
				%>
					<a href="#" onclick="lastpage()&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					else {
				%>
					<a href="issue?page=<%=paging.get("page")+1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					
				%>
			</div>			
		</section>
	</section>
</body>
<script type="text/javascript">
	function r_class_input(){
		let rclass = document.getElementById("r_class").value;
		location.href="issue?r_class="+rclass;
	}
	
	function SearchDate(){
		let sdate = document.getElementById("sdate").value;
		let fdate = document.getElementById("fdate").value;
		if (sdate == "") {
			alert('조회 시작일을 선택해주세요.');
			return false;
		}
		if (fdate == "") {
			alert('조회 종료일을 선택해주세요.');
			return false;
		}
		if (new Date(sdate) > new Date(fdate)) {
			alert('조회 일자를 다시 한 번 확인해주세요.');
			return false;
		}
		
		location.href="issue?sdate="+sdate+"&fdate="+fdate;
	}
</script>
</html>