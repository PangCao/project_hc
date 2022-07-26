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
	ArrayList<RemarkCommand> issuelist = (ArrayList<RemarkCommand>)request.getAttribute("issuelist");
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
                        <td><%= issuelist.size() - i %></td>
                        <td><%= command.getR_title()%></td>
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
            <p>&lt; 1 2 3 &gt;</p>
        </div>
    </section>
</body>
</html>