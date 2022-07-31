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
<title>Insert title here</title>
<style type="text/css">
a, a:hover, a:active{
	color:black;
	text-decoration: none;
}
</style>
<%
	ArrayList<RemarkCommand> issuelist = (ArrayList<RemarkCommand>)request.getAttribute("issuelist");
	String p_num = (String)request.getAttribute("p_num");
	Map<String, Integer> paging = (HashMap<String, Integer>)request.getAttribute("paging");
	String stat = (String)request.getAttribute("stat");
	if (stat != null && stat.equals("1")) {
%>
<script type="text/javascript">
	alert('이슈가 삭제되었습니다.');
</script>
<%
	}
%>
</head>
<body>
	<section style="width: 900px; height: 700px;" class="m-auto d-flex flex-column justify-content-between">
        <div>
            <table class="table table-hover text-center mt-5">
                <tbody class="col-12">
                    <tr>
                        <th class="col-1">NO</th>
                        <th class="col-4">제목</th>
                        <th class="col-2">심각도</th>
                        <th class="col-2">등록일</th>
                        <th class="col-2">등록자</th>
                        <th class="col-1">조회수</th>
                    </tr>
            <%
            	for(int i = 0; i < issuelist.size(); i++) {
            		RemarkCommand command = issuelist.get(i);
            %>
               		<tr>
                        <td><%= paging.get("total") - ((paging.get("page")-1)*10) - i %></td>
                        <td><a href="issuepopup_view?r_id=<%=command.getR_id()%>&p_num=<%=p_num%>"><%= command.getR_title()%></a></td>
                        <td><%= command.getR_class() %></td>
                        <td><%= command.getR_date() %></td>
                        <td><%= command.getR_anthor() %></td>
                        <td><%= command.getR_view() %></td>
                    </tr>
            <%
            	}
            %>
                </tbody>
            </table>
        </div>
        <div class="d-flex justify-content-center">
        <%
			if(paging.get("page") == 1){	
		%>
			<a href="#" onclick="firstpage()"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
		<%
			}
			else {
		%>
			<a href="issue_popup?page=<%=paging.get("page")-1%>&p_num=<%=p_num%>"><i class="fa-solid fa-angle-left"></i></a>&nbsp;&nbsp;
		<%
			}
			for(int i = paging.get("min"); i < paging.get("max"); i++){
				if (paging.get("page")-1 == i) {
		%>
			<a href="issue_popup?page=<%=i+1%>&p_num=<%=p_num%>" style="color:red;"><%=i+1%></a>&nbsp;&nbsp;
		<%
				}
				else {
		%>
			<a href="issue_popup?page=<%=i+1%>&p_num=<%=p_num%>"><%=i+1%></a>&nbsp;&nbsp;
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
			<a href="issue_popup?page=<%=paging.get("page")+1%>&p_num=<%=p_num%>"><i class="fa-solid fa-angle-right"></i></a>
		<%
			}
		%>
        </div>
    </section>
</body>
</html>