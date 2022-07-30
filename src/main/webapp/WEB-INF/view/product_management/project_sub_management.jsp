<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.ProjectCreateCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/project_sub_management.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	ArrayList<ProjectCreateCommand> pcclist = (ArrayList<ProjectCreateCommand>)request.getAttribute("pcc");
	String pj_id = pcclist.get(0).getPc_id();
	String[] taskString = {"A", "B", "C", "D"};
	
%>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="project_sub_management">
				<div class="d-flex justify-content-between p-4">
					<h2><%=pcclist.get(0).getPc_name() %></h2>
				</div>
				<div class="row m-0">
				<%
					int index = 0;
					for (int i = 0; i < 4; i++) {
				%>
					<div class="col-3">
						<a href="project_detail?pj_id=<%=pj_id%>&taskselector=<%=pcclist.get(index).getPc_tasknumber().charAt(0)%>">
							<table>
								<tbody>
								<%
									for (int j = 0; j < 3; j++) {
										
								%>
								<tr>
									<%
										
										for (int x = 0; x < 4; x++) {
											  
											
											if (pcclist.get(index).getPc_dpn().equals("3333333333")) {
									%>
										<td style="background-color: green; "><%= (j*4)+x+1%></td>
									<%
											}
											else{
									
									%>
										<td><%= (j*4)+x+1%></td>
									<%
											}
											index++;
										}
									%>
								</tr>
								<%
									}
								%>	
								</tbody>
							</table>
						</a>
						<div class="text-center mt-3">&lt;&nbsp;<%=taskString[i]%>&nbsp;&gt;</div>
					</div>
				<%
					}
				%>
				</div>
			</section>
		</section>
	</section>
</body>
<script type="text/javascript">
	document.getElementById('product_management').checked=true;
</script>
</html>