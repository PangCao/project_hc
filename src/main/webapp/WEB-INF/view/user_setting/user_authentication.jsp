<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">

<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/user_authentication.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String error = (String)request.getAttribute("error");
	if (error != null && error.equals("1")) {
%>
	<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다.");
	</script>
<%
	}
	else if (error != null && error.equals("2")) {
%>
	<script type="text/javascript">
		alert("개인정보가 정상적으로 변경되었습니다.");
	</script>
<%
	}
%>
</head>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0"">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0"">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			<section class="user_authentication">
				<form action="user_modify" method="post" class="col-4">
					<div class="col-12">
						<label class="col-12">비밀번호 재입력</label>
					</div>
					<div class="col-12">
						<input type="password" class="col-12" name="password">
					</div>
					<div class="col-12">
						<input type="submit" value="확인" class="col-12">
					</div>
				</form>
			</section>
		</section>
	</section>
</body>
</html>