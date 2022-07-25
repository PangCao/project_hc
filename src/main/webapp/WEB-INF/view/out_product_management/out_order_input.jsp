<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.OutProductCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/out_order_input.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ArrayList<OutProductCommand> outlist = (ArrayList<OutProductCommand>)request.getAttribute("outlist");
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
			<section class="out_order_input_top">
				<div class="d-flex justify-content-between">
					<div class="col-6">
						<form action="" method="post">
							<div class="col-12 pl-0">
								<input type="date" class="col-7">
							</div>
							<div class="col-12 pl-0">
								<input type="date" class="col-7">
								<input type="submit" value="조회">
							</div>
							<div>
								<input type="button" value="등록" onclick="inputpopup()">
							</div>
						</form>
					</div>
					<div class="col-4 d-flex align-items-end flex-column justify-content-end">
						<div style="width: 100%;" class="d-flex justify-content-end">
							<select name="" id="" class="col-10">
								<option value="" disabled selected>== 프로젝트명 ==</option>
								<option value="">PJT-2</option>
								<option value="">PJT-1</option>
							</select>
						</div>
						<form action="" method="post" style="width: 100%;">
							<input type="text" placeholder="품명" class="col-8">
							<input type="submit" value="조회">
						</form>
						<form action="" method="post" style="width: 100%;">
							<input type="text" placeholder="업체명" class="col-8">
							<input type="submit" value="조회">
						</form>
					</div>
				</div>
				<div class="p-0">
					<table>
						<tbody>
							<tr>
								<th>No</th>
								<th>의뢰번호</th>
								<th>프로젝트명</th>
								<th>업체명</th>
								<th>의뢰일</th>
								<th>품명</th>
								<th>규격</th>
								<th>수량</th>
								<th>단가</th>
								<th>총액</th>
								<th>등록자</th>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<section class="out_order_input_middle">
				<div>
					<table>
						<tbody>
						<%
							for(int i = 0; i < outlist.size(); i++) {
								OutProductCommand command = outlist.get(i);
						%>
							<tr>
								<td><%= i+1 %></td>
								<td><%= command.getOp_ordernumber() %></td>
								<td><%= command.getOp_proname() %></td>
								<td><%= command.getOp_comname() %></td>
								<td><%= command.getOp_regdate().substring(0, 10) %><br><%= command.getOp_regdate().substring(10) %></td>
								<td><%= command.getOp_productname() %></td>
								<td><%= command.getOp_productstandard() %></td>
								<td><%= command.getOp_unit() %></td>
								<td><%= command.getOp_price() %></td>
								<td><%= command.getOp_unit()*command.getOp_price() %></td>
								<td><%= command.getAnthor_name() %></td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
				</div>
			</section>
			<div class="d-flex justify-content-center mt-5">
				<p>&lt; 1 2 3 &gt;</p>
			</div>
		</section>
	</section>
</body>
<script type="text/javascript">
	function inputpopup() {
		let popwidth = 1000;
		let popheight = 400;
		let popx = (window.screen.width / 2) - (popwidth / 2);
		let popy = (window.screen.height / 2) - (popheight / 2);
		window.open("out_input_popup","out_inputpop", "status=no, width="+popwidth+", height="+popheight+", left="+popx+", top="+popy);
	}
</script>
</html>