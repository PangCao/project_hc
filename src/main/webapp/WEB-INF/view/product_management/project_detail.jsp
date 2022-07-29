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
	String sdate = (String)request.getAttribute("sdate");
	String fdate = (String)request.getAttribute("fdate");
%>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="search_top">
				<div class="d-flex justify-content-between">
					<div class="col-6">
						<form action="" method="post">
							<div class="col-12 pl-0">
								<input type="date"  name="sdate" id="sdate" value="<%=sdate %>" class="col-7">
							</div>
							<div class="col-12 pl-0">
								<input type="date" name="fdate" id="fdate" value="<%=fdate %>" class="col-7">
								<input type="submit" onclick="SearchDate()" value="조회">
							</div>
						</form>
					</div>
					<div class="col-6 d-flex align-items-end flex-column">
						<form action="project_detail" method="post">
							<input type="text" name="tasknum" id="tasknum" placeholder="작업번호">
							<input type="submit"  value="조회">
						</form>
						<form action="project_detail" method="post">
							<input type="text" name="processnum" id="processnum" placeholder="공정번호">
							<input type="submit"  value="조회">
						</form>
					</div>
				</div>
				<div class="p-0">
					<table>
						<tbody>
							<tr>
								<th>No</th>
								<th>프로잭트코드</th>
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
								<td><%=productcom.getP_tasknumber() %></td>
								<td><%=productcom.getP_processnumber() %></td>
								<td><%=productcom.getP_regdate() %></td>
								<td><%=productcom.getP_startdate() %></td>
								<td><%=productcom.getP_compledate() %></td>
								<td><%=regnum.get(productcom.getP_regnum()) %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<%
				}
			%>
			<div class="col-12 d-flex justify-content-center">
				<%
					if(paging.get("page") == 1){	
				%>
					<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					else {
				%>
					<a href="project_detail?page=<%=paging.get("page")-1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&tasknum=<%=tasknum%>&processnum=<%=processnum%>"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="project_detail?page=<%=i+1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="project_detail?page=<%=i+1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>"><%=i+1%></a>&nbsp;&nbsp;
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
					<a href="project_detail?page=<%=paging.get("page")+1%>&r_class=<%=rc%>&sdate=<%=sdate%>&fdate=<%=fdate%>&search_title=<%=search_title%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					
				%>
			</div>				
		</section>
	</section>
</body>
<script type="text/javascript">
	document.getElementById('product_management').checked=true;
	
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
		
		location.href="product_detail?sdate="+sdate+"&fdate="+fdate;
	}
</script>
</html>