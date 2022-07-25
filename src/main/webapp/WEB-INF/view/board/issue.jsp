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
	int issuepage = (Integer)request.getAttribute("issuepage");
	int issuetotal = (Integer)request.getAttribute("issuetotal");
	int min = 0;
	int max = 5;
	if (issuepage > 3) {
		min= issuepage - 2;
		max = issuepage + 3;
	}
	if (max > (issuetotal / 10) + 1) {
		max = (issuetotal / 10) + 1;
	}
	if (issuetotal % 10 == 0) {
		max -= 1;
	}
	if (issuetotal == 0) {
	      max = 1;
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
			<section class="issue">
				<h2 class="col-6 ml-5 mt-5">이슈관리</h2>
				<div class="d-flex justify-content-between">
					<div class="col-5">
						<form action="" class="col-12">
							<div style="width: 100%;">
								<input type="date" style="width: 50%;">
							</div>
							<div style="width: 100%;">
								<input type="date" style="width: 50%;">
								<input type="submit" value="검색" onclick="" class="col-3">
							</div>
						</form>
					</div>
					<div class="col-4 d-flex">
						<div class="col-12 p-0">
							<form action="issue" method="post" class="col-12 p-0 d-flex justify-content-end">
								<select name="r_class" id="r_class" onchange="r_class_input()" class="col-8 text-center">
									<option value="" disabled selected>== 심각도 선택 ==</option>
									<option value="INFO">INFO</option>
									<option value="CARE">CARE</option>
									<option value="WARN">WARN</option>
									<option value="DANGER">DANGER</option>
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
						int pagecnt = issuetotal - (issuepage-1)* 10 + 1;
						if (issuelist != null) {
							for(int i = 0; i < issuelist.size(); i++) {
								RemarkCommand dto = issuelist.get(i);
					%>
							<tr>
								<td><%= pagecnt -= 1%></td>
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
					<input type="button" value="이슈 작성" onclick="location.href='issue_write'">
				</div>
			</section>
			<div class="col-12 d-flex justify-content-center">
				<%
					if(issuepage == 1){	
				%>
					<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					else {//페이징 처리 해야함
				%>
					<a href="issue?issuepage=<%=issuepage-1%>" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = min; i < max; i++){
						if (issuepage-1 == i) {
				%>
					<a href="issue?issuepage=<%=i+1%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="issue?issuepage=<%=i+1%>"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
					}
					if (issuepage * 10 >= issuetotal) {
				%>
					<a href="#" onclick="lastpage()"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					else {
				%>
					<a href="issue?issuepage=<%=issuepage+1%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
				%>
			</div>			
		</section>
	</section>
</body>
<script type="text/javascript">
	function r_class_input(){
		let r_class = document.getElementById("r_class").value;
		location.href="issue?r_class="+r_class;
	}
</script>
</html>