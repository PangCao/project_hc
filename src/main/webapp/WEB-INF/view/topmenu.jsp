<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="command.MemberCommand" %>
<div class="d-flex justify-content-end topmenu">
	<%
		request.setCharacterEncoding("UTF8");
		String name = (String)session.getAttribute("name");
		String department = (String)session.getAttribute("department");
		if (department == null && name == null) {
	%>
	<script type="text/javascript">
		location.href="main";
	</script>
	<%
		}
	%>
	<div class="d-flex align-items-center">
		<p><%=department%> &nbsp <%=name%>님</p>
		<a href="logout">로그아웃</a>
	</div>
</div>