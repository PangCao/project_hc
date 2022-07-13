<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">

<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="layout_main row">
		<section class="layout_left col-2 p-0" style="background-color: aqua;">
			<jsp:include page="<c:url value="/leftmenu.jsp"/>"/>
		</section>
		<section class="layout_right col-10 p-0" style="background-color: antiquewhite;">
			<jsp:include page="<c:url value="/topmenu.jsp"/>"/>
			<!-- 여기 아래부터 바디 -->
			<div class="d-flex justify-content-center">
				<form action="" class="col-10 mt-4">
					<div class="form-group row">
						<label class="col-2">자재명</label>
						<input type="text" class="form-control col-6" name="" id="">
					</div>
					<div class="form-group row">
						<label class="col-2">카테고리</label>
						<select name="" id="" class="col-6 form-control">
							<option value="test1" selected>test1</option>
							<option value="test2">test2</option>
							<option value="test3">test3</option>
							<option value="test4">test4</option>
							<option value="test5">test5</option>
							<option value="test6">test6</option>
						</select>
					</div>
					<div class="form-group row">
						<label class="col-2">수량</label>
						<input type="number" min="0" value="0" class="form-control col-6" name="" id="">
					</div>
					<div class="form-group row">
						<label class="col-2">입고일</label>
						<input type="date" class="form-control col-6" name="" id="">
					</div>
					<div class="form-group row">
						<div class="col-8 d-flex justify-content-end p-0">
							<input type="submit" value="입력" class="btn btn-primary col-9">
						</div>
					</div>
				</form>
			</div>
		</section>
	</section>
</body>
</html>