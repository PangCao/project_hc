<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/main.css"/>">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="main">
		<div class="container d-flex justify-content-center align-items-center">
			<form action="" method="post" class="col-5">
				<div class="form-group">
					<input type="text" class="form-control col-12" placeholder="사번입력">
				</div>
				<div class="form-group">
					<input type="password" class="form-control col-12" placeholder="비밀번호입력">
				</div>
				<div>
					<input type="submit" class="btn btn-secondary col-12" value="로그인">
				</div>
			</form>
		</div>
		<div class="logo_img">
			<div style="background-color: red; width: 100px; height: 50px;">로고이미지로 전환</div>
		</div>
	</section>
</body>
</html>