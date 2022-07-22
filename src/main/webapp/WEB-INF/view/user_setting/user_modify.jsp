<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="command.MemberCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/user_modify.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	MemberCommand memberCommand = (MemberCommand)session.getAttribute("member");
	String[] tel = memberCommand.getM_tel().split("-");
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
			<section class="user_modify">
				<form action="user_modify_submit" class="col-8" name="modiForm" method="post">
					<h3 class="text-center">개인정보관리</h3>
					<div class="row form-group">
						<label for="" class="col-2">사번</label>
						<input type="text" value="<%=memberCommand.getM_num() %>" name="m_num" disabled class="col-8">
					</div>
					<div class="row form-group">
						<label for="" class="col-2">비밀번호</label>
						<input type="password" name="password" id="password" class="col-8">
					</div>
					<div class="row form-group">
						<label for="" class="col-2">비밀번호 재확인</label>
						<input type="password" name="password_rechk" id="password_rechk" class="col-8">
					</div>
					<div class="row form-group">
						<label for="" class="col-2">이름</label>
						<input type="text" value="<%=memberCommand.getM_name() %>" name="m_name" class="col-8">
					</div>
					<div class="row form-group">
						<label for="" class="col-2">부서</label>
						<input type="text" value="<%=memberCommand.getM_department() %>" name="m_department" class="col-8" disabled>
					</div>
					<div class="row form-group">
						<label for="" class="col-2">직책</label>
						<input type="text" value="<%=memberCommand.getM_position() %>" name="m_position" class="col-8" disabled>
					</div>
					<div class="row form-group">
						<label for="" class="col-2">연락처</label>
						<div class="col-8 d-flex justify-content-between p-0">
							<input type="text" name="phone1" class="col-3" value="010" readonly>
							<span>-</span>
							<input type="text" name="phone2" id="phone2" class="col-3" value="<%=tel[1]%>">
							<span>-</span>
							<input type="text" name="phone3" id="phone3" class="col-3" value="<%=tel[2]%>">
						</div>
					</div>
					<div class="row form-group">
						<label for="" class="col-2"></label>
						<input type="button" value="회원정보 수정" class="col-8" onclick="modi_chk()">
					</div>
				</form>
			</section>
		</section>
	</section>
</body>
<script type="text/javascript">
	function modi_chk() {
		let pass = document.getElementById('password');
		let passre = document.getElementById('password_rechk');
		let phone2 = document.getElementById('phone2');
		let phone3 = document.getElementById('phone3');
		
		if (pass.value.length != 0 && pass.value.length < 4) {
			alert('비밀번호를 4자리 이상 입력해주세요.');
			return;
		}
		if (pass.value != passre.value) {
			alert('비밀번호를 다시 확인해주세요.');
			return;
		}
		if (phone2.value.length < 4 || phone3.value.length < 4) {
			alert('휴대폰 번호를 정확하게 입력해주세요.');
			return;
		}
		
		document.modiForm.submit();
	}
</script>
</html>