<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.NoticeCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/notice.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<head>
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
			<section class="notice">
				<h2 class="col-6 ml-5 mt-5">공정 진행 전체 현황</h2>
				<div class="col-12">
					<table class="col-12 table table-hover text-center">
						<tbody>
							<tr>
								<th class="col-2">프로젝트ID</th>
								<th class="col-4">프로젝트명</th>
								<th class="col-2">작업번호</th>
								<th class="col-2">공정파트</th>
								<th class="col-2">세부공정번호</th>
							</tr>
					<%
						if (noticelist != null) {
							for(int i = 0; i < noticelist.size(); i++) {
								NoticeCommand dto = noticelist.get(i);
					%>
							<tr>
								<td><%= paging.get("totalpage") - (paging.get("page")-1)* 10 - i%></td>
								<td><a href="notice_view?n_id=<%=dto.getN_id()%>"><%= dto.getN_title() %></a></td>
								<td><%= dto.getN_anthor() %></td>
								<td><%= dto.getN_date() %></td>
								<td><%= dto.getN_view() %></td>
							</tr>
					<%
							}
						}
						else {
					%>
							<tr>
								<td colspan="5" class="text-center">등록된 공지사항이 없습니다.</td>
							</tr>
					<%
						}
					%>
						</tbody>
					</table>
				</div>
				<div class="d-flex justify-content-end col-12">
					<input type="button" value="공지사항 작성" onclick="location.href='notice_write'">
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
					<a href="notice?noticepage=<%=paging.get("page")-1%>"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="notice?noticepage=<%=i+1%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="notice?noticepage=<%=i+1%>"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
					}
					if (paging.get("page") * 10 >= paging.get("totalpage")) {
				%>
					<a href="#" onclick="lastpage()"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
					else {
				%>
					<a href="notice?noticepage=<%=paging.get("page")+1%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
				%>
			</div>
		</section>
	</section>
</body>
</html> --%>