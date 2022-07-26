<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="command.MemberCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/issue_write.css'/>">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
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
						<section class="issue_write">
				<h2 class="col-6 ml-5 mt-5">이슈 보고서 작성</h2>
				<div>
					<form action="issue_write_input" method="post" name="issueWriteForm">
						<div class="col-12 row">
							<label class="col-2">심각도</label>
							<select name="r_class" class="d-flex justify-content-center col-2">
								<option value="" disabled selected>== 심각도 ==</option>
								<option value="INFO">INFO</option>
								<option value="CARE">CARE</option>
								<option value="WARN">WARN</option>
								<option value="DANGER">DANGER</option>
							</select>
						</div>
						<div class="col-12 row">
							<label class="col-2">제목</label>
							<input type="text" class="col-10" name="r_title">
						</div>
						<div class="col-12 row">
							<label class="col-2">작성자</label>
							<input type="text" class="col-10" value="<%=memberCommand.getM_name() %>" readonly name="r_anthor">
							<input type="hidden" name="anthor_id" value="<%=memberCommand.getM_num()%>">
						</div>
						<div class="col-12 row">
							<label class="col-2">내용</label>
							<textarea name="r_content"class="col-10" style="resize: none;"></textarea>
						</div>
						<div class="d-flex justify-content-end col-12">
							<input type="button" value="작성" onclick="issue_write()">
						</div>
					</form>
				</div>
			</section>
		</section>
	</section>
</body>
<script type="text/javascript">
	function issue_write() {
		if (confirm('이슈를 작성하시겠습니까?')) {
			document.issueWriteForm.submit();	
		}
	}
</script>
</html>