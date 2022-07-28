<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<style type="text/css">
a, a:hover, a:active{
	color: black;
	text-decoration: none;
}
</style>
<title>Insert title here</title>
<%
	ArrayList<ProductCommand> productlist = (ArrayList<ProductCommand>)request.getAttribute("productlist");
	Map<String, String> projectmap = (HashMap<String, String>)request.getAttribute("projectmap");
	ArrayList<ProjectCommand> projectlist = (ArrayList<ProjectCommand>)request.getAttribute("projectlist");
	Map<String, Integer> paging = (HashMap<String, Integer>)request.getAttribute("paging");
	String project_id = (String)request.getAttribute("project_id");
	String searchword = (String)request.getAttribute("searchword");
%>
</head>
<body>
	<section style="width: 700px; height: 700px; margin: auto;">
        <div class="mt-3 mb-1 d-flex justify-content-between">
            <select name="" id="" class="col-4 text-center" onchange="project_sel(this)">
            <%
            	if(project_id != null && !project_id.equals("null")) {
            %>
                <option value="" disabled>==프로젝트명==</option>
            <%
            	}
            	else{
       		%>
       		    <option value="" disabled selected>==프로젝트명==</option>
       		<%
            	}
            	for(int i = 0; i < projectlist.size(); i++) {
            		ProjectCommand command = projectlist.get(i);
            		if (project_id != null && project_id.equals(command.getPj_id())){
            %>
            	<option value="<%= command.getPj_id() %>" selected><%= command.getPj_name() %></option>
            <%
            		}
            		else {
   			%>
   				<option value="<%= command.getPj_id() %>"><%= command.getPj_name() %></option>
   			<%
            		}
            	}
            %>
            </select>
            <script type="text/javascript">
            	function project_sel(obj){
            		location.href="issue_search_popup?project_id="+obj.value;
            	}
            </script>
            <form action="issue_search_popup?project_id=<%=project_id%>" method="post">
                <input type="text" name="searchword" placeholder="작업번호" class="pl-2">
                <input type="submit" value="검색">
            </form>
        </div>
        <table class="table text-center">
            <tbody >
                <tr>
                    <th>프로젝트 명</th>
                    <th>작업번호</th>
                    <th>공정번호</th>
                    <th>선택</th>
                </tr>
            <%
            	if (productlist != null && productlist.size() != 0) { 
            		for(int i = 0; i < productlist.size(); i++) {
            			ProductCommand command = productlist.get(i);
            %>
	            	<tr>
	                    <td><%=command.getP_proid() %></td>
	                    <td><%=command.getP_tasknumber() %></td>
	                    <td><%=command.getP_processnumber() %></td>
	                    <td><input type="button" value="공정 선택" onclick="issue_select<%=i %>()" class="issue_search_btn"></td>
	                </tr>
	                <script type="text/javascript">
						function issue_select<%=i%>() {
							opener.document.getElementById('rp_proid').value = '<%=command.getP_proid()%>';
							opener.document.getElementById('rp_task').value = '<%=command.getP_tasknumber()%>';
							opener.document.getElementById('rp_process').value = '<%=command.getP_processnumber()%>';
							opener.document.getElementById('project_view').value = "<%=projectmap.get(command.getP_proid())%> / <%=command.getP_tasknumber()%> / <%=command.getP_processnumber()%>"
							window.close();
						}                
					</script>
            <%
            		}
            	}
            	else {
            %>
            		<tr>
            			<td class="text-center" colspan="4">등록가능한 이슈 공정이 없습니다.</td>
            		</tr>
            <%
            	}
            %>

            </tbody>
        </table>
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
					<a href="issue_search_popup?page=<%=paging.get("page")-1%>&project_id=<%=project_id%>&searchword=<%=searchword%>"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
				<%
					}
					for(int i = paging.get("min"); i < paging.get("max"); i++){
						if (paging.get("page")-1 == i) {
				%>
					<a href="issue_search_popup?page=<%=i+1%>&project_id=<%=project_id%>&searchword=<%=searchword%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
				<%
						}
						else {
				%>
					<a href="issue_search_popup?page=<%=i+1%>&project_id=<%=project_id%>&searchword=<%=searchword%>"><%=i+1%></a>&nbsp;&nbsp;
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
					<a href="issue_search_popup?page=<%=paging.get("page")+1%>&project_id=<%=project_id%>&searchword=<%=searchword%>"><i class="fa-solid fa-angle-right"></i></a>
				<%
					}
				%>
	</div>
</body>
</html>