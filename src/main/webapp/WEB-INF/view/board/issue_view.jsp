<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.RemarkCommand" %>
<%@ page import="command.MemberCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/issue_view.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	RemarkCommand remarkCommand = (RemarkCommand)request.getAttribute("issue_detail");
	HashMap<String, Integer> remarkmap = (HashMap<String, Integer>)request.getAttribute("paging");
	MemberCommand memberCommand = (MemberCommand)session.getAttribute("member");
%>
</head>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="issue_view">
				<div class="col-12 pt-4 pl-4">
					<h2>공지사항</h2>
				</div>
				<div class="col-12 mt-5">
					<hr>
					<div class="col-12 row">
						<div class="col-8 row">
							<h5 class="col-2 m-0"><b>제목</b></h5>
							<h5 class="col-10 m-0"><%=remarkCommand.getR_title() %></h5>
						</div>	
						<div class="col-4 d-flex justify-content-end">
							<p class="m-0">등록자 : <%=remarkCommand.getR_anthor() %></p>
						</div>
					</div>
					<div class="col-12 row">

					</div>
					<hr>
					<div class="col-12 row d-flex justify-content-between">
						<div class="col-9 d-flex align-items-center">
							<i class="fa-regular fa-eye"></i>
							<p class="m-0 pl-2"><%=remarkCommand.getR_view() %></p>
						</div>
						<div class="col-3 d-flex align-items-center justify-content-end">
							<i class="fa-regular fa-calendar-check"></i>
							<p class="m-0 pl-2"><%=remarkCommand.getR_date() %></p>
						</div>
					</div>
					<div class="col-12 row mt-5 px-5">
						<p><%=remarkCommand.getR_content() %></p>
					</div>
					<hr>
					<div class="col-12 row d-flex justify-content-center">
				<%
					if (remarkmap.get("prev") != null) {
				%>
						<input type="button" value="이전" onclick="location.href='issue_view?r_id=<%=remarkmap.get("prev")%>'">
				<%
					}
					if (remarkmap.get("next") != null) {
				%>
						<input type="button" value="다음"  onclick="location.href='issue_view?r_id=<%=remarkmap.get("next")%>'">
				<%
					}
				%>
						<input type="button" value="목록" class="list_btn" onclick="location.href='issue'">
				<%
					if (remarkCommand.getR_anthor_id() != null && remarkCommand.getR_anthor_id().equals(memberCommand.getM_num()) ){
				%>
						<input type="button" value="삭제" class="delete_btn" onclick="r_delete()">
				<%
					}
				%>
					</div>
				</div>
			</section>
		</section>
	</section>
</body>
<script type="text/javascript">
	function r_delete() {
		if (confirm('게시물을 삭제하시겠습니까?')) {
			location.href="issue_delete?r_id=<%=remarkmap.get("current")%>";
		}
	}
</script>
</html>