<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ArrayList<ProductCommand> productlist = (ArrayList<ProductCommand>)request.getAttribute("productlist");
	Map<String, String> projectmap = (HashMap<String, String>)request.getAttribute("projectmap");
%>
</head>
<body>
	<section style="width: 700px; height: 700px; margin: auto;">
        <table class="table text-center mt-5">
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
</body>
</html>