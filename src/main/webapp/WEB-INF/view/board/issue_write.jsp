<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
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

	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
	Map<String, String> projectmap = (HashMap<String, String>)request.getAttribute("projectmap");
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
							<label class="col-2">이슈 공정</label>
							<input type="text" id="project_view" readonly disabled class="col-2">
							<input type="hidden" id="rp_proid" name="rp_proid">
							<input type="hidden" id="rp_task" name="rp_task">
							<input type="hidden" id="rp_process" name="rp_process">
							<input type="hidden" id="p_num" name="p_num">
							<input type="button" class="ml-2 issue_search_btn" value="공정 검색" onclick="issue_search()">
						</div>
						<script type="text/javascript">
							function issue_search() {
								let popwidth = 720;
								let popheight = 780;
								let popx = (window.screen.width / 2) - (popwidth / 2);
								let popy = (window.screen.height / 2) - (popheight / 2);
								window.open("issue_search_popup","issueSearchpop", "status=no, width="+popwidth+", height="+popheight+", left="+popx+", top="+popy);
							}
						</script>
						<div class="col-12 row">
							<label class="col-2">심각도</label>
							<select name="r_class" class="d-flex justify-content-center text-center col-2">
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
							<input type="text" class="col-10" value="<%=name %>" readonly name="r_anthor">
							<input type="hidden" name="anthor_id" value="<%=id%>">
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
		let pv = document.getElementById('project_view').value;
		if (pv.length == 0) {
			alert('이슈 공정을 검색해주세요,');
			return false;
		}
		if (confirm('이슈를 작성하시겠습니까?')) {
			document.issueWriteForm.submit();	
		}
	}
</script>
</html>