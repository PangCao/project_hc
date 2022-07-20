<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">

<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/.css'/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0" style="background-color: aqua;">
			<jsp:include page="/WEB-INF/view/leftmenu.jsp"/>
		</section>
		<section class="layout_right col-10 p-0" style="background-color: antiquewhite;">
			<jsp:include page="/WEB-INF/view/topmenu.jsp"/>
			<!-- 여기 아래부터 바디 -->
			
			
			
		</section>
	</section>
</body>
</html>