<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.NoticeCommand" %>
<%@ page import="command.MemberCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/notice_view.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"/>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	NoticeCommand noticeCommand = (NoticeCommand)request.getAttribute("notice_detail");
	HashMap<String, Integer> noticemap = (HashMap<String, Integer>)request.getAttribute("paging");
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
			<section class="notice_view">
				<div class="col-12 pt-4 pl-4">
					<h2>공지사항</h2>
				</div>
				<div class="col-12 mt-5">
					<hr>
					<div class="col-12 row">
						<div class="col-8 row">
							<h5 class="col-2 m-0"><b>제목</b></h5>
							<h5 class="col-10 m-0"><%=noticeCommand.getN_title() %></h5>
						</div>	
						<div class="col-4 d-flex justify-content-end">
							<p class="m-0">등록자 : <%=noticeCommand.getN_anthor() %></p>
						</div>
					</div>
					<div class="col-12 row">

					</div>
					<hr>
					<div class="col-12 row d-flex justify-content-between">
						<div class="col-9 d-flex align-items-center">
							<i class="fa-regular fa-eye"></i>
							<p class="m-0 pl-2"><%=noticeCommand.getN_view() %></p>
						</div>
						<div class="col-3 d-flex align-items-center justify-content-end">
							<i class="fa-regular fa-calendar-check"></i>
							<p class="m-0 pl-2"><%=noticeCommand.getN_date() %></p>
						</div>
					</div>
					<div class="col-12 row mt-5 px-5">
						<p><%=noticeCommand.getN_content() %></p>
					</div>
					<hr>
					<div class="col-12 row d-flex justify-content-center">
				<%
					if (noticemap.get("prev") != null) {
				%>
						<input type="button" value="이전" onclick="location.href='notice_view?n_id=<%=noticemap.get("prev")%>'">
				<%
					}
					if (noticemap.get("next") != null) {
				%>
						<input type="button" value="다음"  onclick="location.href='notice_view?n_id=<%=noticemap.get("next")%>'">
				<%
					}
				%>
						<input type="button" value="목록" class="list_btn" onclick="location.href='notice'">
				<%
					// 세션 처리 후 변경해야 하는 코드
					if (noticeCommand.getAnthor_id() != null && noticeCommand.getAnthor_id().equals(memberCommand.getM_num()) ){
				%>
						<input type="button" value="삭제" class="delete_btn" onclick="n_delete()">
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
	function n_delete() {
		if (confirm('게시물을 삭제하시겠습니까?')) {
			location.href="notice_delete?n_id=<%=noticemap.get("current")%>";
		}
	}
</script>
</html>