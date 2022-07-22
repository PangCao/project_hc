<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="command.MemberCommand" %>
<div class="d-flex justify-content-end topmenu">
	<%
		request.setCharacterEncoding("UTF8");
		MemberCommand dto = (MemberCommand)session.getAttribute("member");
	%>
	<div class="d-flex align-items-center">
		<p><%=dto.getM_department()%> &nbsp <%=dto.getM_name()%>님</p>
		<a href="logout">로그아웃</a>
	</div>
</div>