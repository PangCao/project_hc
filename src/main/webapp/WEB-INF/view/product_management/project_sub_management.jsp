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
	String dpn = pcclist.get(0).getPc_dpn();
	String[] Part = {"A","B","C","D"};
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
					for(int i=0;i<Part.length;i++){
						if(pcclist != null && pcclist.size()>i){	
							int cnt=1;
				%>
					<div class="col-3">
						<a href="project_detail?pj_id=<%=pj_id%>">
							<table>
								<tbody>
								<%
								for(int k=0; k<3; k++){
								%>
									<tr>
									<%
									for(int j=0; j<4; j++){
										for(int h=0; h<dpn.length(); h++){
											int count = 0;
											if(dpn.charAt(h) == '0'){
												count++;
												if(count==10){
												 %>
														<td style="background-color:green;"><%=cnt%></td>
												<%
												cnt++;
												break;
												}else{
												 %>
														<td><%=cnt%></td>
												<%	
												cnt++;
												break;
												}
											}
										}
		
									}
									 %>
									</tr>
								<%
									}
								%>
								</tbody>
							</table>
						</a>
						<div class="d-flex justify-content-center">
							<p>&lt; <%=Part[i] %> &gt;</p>
						</div>
					</div>
			<%
						}
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