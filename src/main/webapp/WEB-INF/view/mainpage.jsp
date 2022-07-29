<%@page import="command.Remark_projectCommand"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@page import="command.RemarkCommand"%>
<%@ page import="command.NoticeCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/mainpage.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"/>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<head>
<%
	ArrayList<NoticeCommand> noticelist = (ArrayList<NoticeCommand>)request.getAttribute("noticelist");
	ArrayList<RemarkCommand> remarklist = (ArrayList<RemarkCommand>)request.getAttribute("issuelist");
	Map<String, Remark_projectCommand> issuesublist = (HashMap<String, Remark_projectCommand>)request.getAttribute("issueSublist");
	Map<String, String> projectmap = (HashMap<String, String>) request.getAttribute("projectmap");
	int noticepage = (Integer)request.getAttribute("noticepage");
	int remarkpage = (Integer)request.getAttribute("remarkpage");
	int noticetotal = (Integer)request.getAttribute("noticetotal");
	int remarktotal = (Integer)request.getAttribute("remarktotal");
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="mainpage">
				<div>
					<img src="<c:url value='/resources/images/main2.jpg'/>" alt="" style="width: 100%; padding: 10px;"/>
				</div>
				<div class="col-12 justify-content-center d-flex mt-5">
					<div class="col-6">
						<div>
							<div class="d-flex justify-content-between align-items-center">
								<a href="issue">이슈 관리</a>
								<div>
									<%
										if (remarkpage == 1) {
									%>
									<a href="#" onclick="firstpage()">
										<i class="fa-solid fa-circle-arrow-left mr-3"></i>
									</a>
									<%
										}
										else {
									%>
									<a href="mainpage?noticepage=<%=noticepage%>&remarkpage=<%=remarkpage-1%>">
										<i class="fa-solid fa-circle-arrow-left mr-3"></i>
									</a>
									<%
										}
										if (remarkpage * 5 >= remarktotal) {
									%>
									<a href="#" onclick="lastpage()">
										<i class="fa-solid fa-circle-arrow-right"></i>
									</a>
									<%
										}
										else {
									%>
									<a href="mainpage?noticepage=<%=noticepage%>&remarkpage=<%=remarkpage+1%>">
										<i class="fa-solid fa-circle-arrow-right"></i>
									</a>
									<%
										}
									%>
								</div>
							</div>
							<table class="table table-hover text-center">
								<tbody>
									<tr>
										<th>프로젝트명</th>
										<th>작업번호</th>
										<th>공정명</th>
										<th>등록시간</th>
										<th>등급</th>
									</tr>
							<%
								if (remarklist != null) {
									for(int i = 0; i < remarklist.size(); i++) {
										RemarkCommand dto = remarklist.get(i);
										System.out.println("1 " + dto.getR_id());
										System.out.println("2 " + String.valueOf(dto.getR_id()));
										System.out.println("3 " + issuesublist.get(String.valueOf(dto.getR_id())).getRp_proid());
										System.out.println("4 " + projectmap.get(issuesublist.get(String.valueOf(dto.getR_id())).getRp_proid()));
							%>
									<tr>
									
										<td><a href="issue_view?r_id=<%=dto.getR_id()%>" style="color:black;"><%=projectmap.get(issuesublist.get(String.valueOf(dto.getR_id())).getRp_proid()) %></a></td>
										<td><a href="issue_view?r_id=<%=dto.getR_id()%>" style="color:black;"><%=issuesublist.get(String.valueOf(dto.getR_id())).getRp_task() %></a></td>
										<td><a href="issue_view?r_id=<%=dto.getR_id()%>" style="color:black;"><%=issuesublist.get(String.valueOf(dto.getR_id())).getRp_process() %></a></td>
										<td><%=dto.getR_date() %></td>
										<td><%=dto.getR_class() %></td>
									</tr>
							<%
									}
								}
								else {
							%>
									<tr>
										<td colspan="5" class="text-center">등록된 이슈가 없습니다.</td>
									</tr>
							<%
								}
							%>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-6">
						<div>
							<div class="d-flex justify-content-between align-items-center">
								<a href="notice">공지사항</a>
								<div>
									<%
										if (noticepage == 1) {
									%>
									<a href="#" onclick="firstpage()">
										<i class="fa-solid fa-circle-arrow-left mr-3"></i>
									</a>
									<%
										}
										else {
									%>
									<a href="mainpage?noticepage=<%=noticepage-1 %>&remarkpage=<%=remarkpage%>">
										<i class="fa-solid fa-circle-arrow-left mr-3"></i>
									</a>
									<%
										}
										if (noticepage * 5 >= noticetotal) {
									%>
									<a href="#" onclick="lastpage()">
										<i class="fa-solid fa-circle-arrow-right"></i>
									</a>
									<%
										}
										else {
									%>
									<a href="mainpage?noticepage=<%=noticepage+1 %>&remarkpage=<%=remarkpage%>">
										<i class="fa-solid fa-circle-arrow-right"></i>
									</a>
									<%
										}
									%>
								</div>
							</div>
							<table class="table table-hover text-center">
								<tbody>
									<tr>
										<th>NO</th>
										<th>제목</th>
										<th>등록자</th>
										<th>등록시간</th>
									</tr>
							<%
								if (noticelist != null) {
									int pagecnt = noticetotal - (noticepage-1) * 5 + 1;
									for(int i = 0; i < noticelist.size(); i++) {
										NoticeCommand dto = noticelist.get(i);
							%>
									<tr>
										<td class="col-1"><%= pagecnt -= 1 %></td>
										<td class="col-5"><a href="notice_view?n_id=<%=dto.getN_id()%>" style="color:black;"><%= dto.getN_title()%></a></td>
										<td class="col-3"><%= dto.getN_anthor()%></td>
										<td class="col-3"><%= dto.getN_date()%></td>
									</tr>
							<%
									}
								}
								else {
							%>
									<tr>
										<td colspan="4" class="text-center">등록된 공지사항이 없습니다.</td>
									</tr>
							<%
								}
							%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</section>
		</section>
	</section>
</body>
</html>