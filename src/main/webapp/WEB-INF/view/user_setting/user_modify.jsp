<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/user_modify.css"/>">
<head>
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
			<section class="user_modify">
				<form action="" class="col-8">
					<h3 class="text-center">개인정보관리</h3>
					<div class="row form-group">
						<label for="" class="col-2">사번</label>
						<input type="text" value="202207020001" name="" id="" disabled class="col-8">
					</div>
					<div class="row form-group">
						<label for="" class="col-2">비밀번호</label>
						<input type="password" name="" id="" class="col-8">
					</div>
					<div class="row form-group">
						<label for="" class="col-2">이름</label>
						<input type="text" name="" id="" class="col-8">
					</div>
					<div class="row form-group">
						<label for="" class="col-2">부서</label>
						<input type="text" value="생산관리부" name="" id="" class="col-8" disabled>
					</div>
					<div class="row form-group">
						<label for="" class="col-2">직책</label>
						<input type="text" value="부장" name="" id="" class="col-8" disabled>
					</div>
					<div class="row form-group">
						<label for="" class="col-2">연락처</label>
						<div class="col-8 d-flex justify-content-between p-0">
							<select name="" id="" class="col-3 text-center">
								<option value="">010</option>
							</select>
							<span>-</span>
							<input type="text" class="col-3">
							<span>-</span>
							<input type="text" name="" id="" class="col-3">
						</div>
					</div>
					<div class="row form-group">
						<label for="" class="col-2"></label>
						<input type="submit" value="회원정보 수정" class="col-8">
					</div>
				</form>
			</section>
		</section>
	</section>
</body>
</html>