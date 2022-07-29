<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="command.ProjectCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/project_management.css'/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	ArrayList<ProjectCommand> procomlist = (ArrayList<ProjectCommand>)request.getAttribute("ProCom");
%>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="project_management row m-0 d-flex justify-content-center">
				<!-- 여기서 부터 -->
	<%
			for(int i=0; i<4;i++){
				if(procomlist != null && procomlist.size()>i){
					ProjectCommand dto = procomlist.get(i);
					if(dto.getPj_progress() == 1){
	%>
				<a class="col-5 comple" href="#" onclick="project_input()">
					<h3 class="mb-4"><%=dto.getPj_name()%></h3>
					<div>
						<P> 현재 진행 공정 : <%=dto.getPj_task() %></P>
						<div style="height: 2px; width: 100%; position: relative;" class="mb-3">
							<div style="background-color: white; height: 100%; width: 100%;"></div>
							<div style="position: absolute; height: 100%; width: 10%; top: 0; left: 0; background-color: orange; z-index: 1;"></div>
						</div>
						<div>
							<p>진수 예정일 : <%=dto.getPj_eta() %></p>
						</div>
						<p>전체 공정률</p>
						<div style="height: 7px; width: 100%; position: relative;" class="mb-3">
							<div style="background-color: white; height: 100%; width: 100%;"></div>
							<div style="position: absolute; height: 100%; width: <%=dto.getPj_progress()%>*100%; top: 0; left: 0; background-color: blue; z-index: 1;"></div>
						</div>
					</div>
				</a>
	<%
				}else{	
	%>
				<a class="col-5" href="project_sub_management?Sequence=<%=dto.getPj_id()%>">
					<h3 class="mb-4"><%=dto.getPj_name()%></h3>
					<div>
						<P> 현재 진행 공정 : <%=dto.getPj_task()%></P>
						<div style="height: 2px; width: 100%; position: relative;" class="mb-3">
							<div style="background-color: white; height: 100%; width: 100%;"></div>
							<div style="position: absolute; height: 100%; width: 10%; top: 0; left: 0; background-color: orange; z-index: 1;"></div>
						</div>
						<div>
							<p>진수 예정일 : <%=dto.getPj_eta()%></p>
						</div>
						<p>전체 공정률</p>
						<div style="height: 7px; width: 100%; position: relative;" class="mb-3">
							<div style="background-color: white; height: 100%; width: 100%;"></div>
							<div style="position: absolute; height: 100%; width: <%=dto.getPj_progress()%>*100%; top: 0; left: 0; background-color: blue; z-index: 1;"></div>
						</div>
					</div>
				</a>
	<%
				}
			}else{
	%>
				<a class="col-5 d-flex justify-content-center align-items-center comple" style="min-height:212px !important;" href="#" onclick="project_input()">
					<h3 class="m-4">프로젝트를 입력해주세요</h3>
				</a>
	<%
			}
		}
	%>
			</section>
		</section>
	</section>
</body>
<script type="text/javascript">
	function project_input() {
		if (confirm('프로젝트를 등록하시겠습니까?')) {
			let popwidth = 700;
			let popheight = 250;
			let popx = (window.screen.width / 2) - (popwidth / 2);
			let popy = (window.screen.height / 2) - (popheight / 2);
			window.open("projectpopup","projectpopup","status=no, width="+popwidth+", height="+popheight+", left="+popx+", top="+popy);
		}
	}
	document.getElementById('product_management').checked=true;

</script>
</html>