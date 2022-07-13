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
			<div class="select_pro">
				<div>
					<div class="col-12 row">
						<label class="col-3">제품명</label>
						<p class="col-9">x8451589-5121566-cc51522</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">목표수량</label>
						<p class="col-9">200</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">진행수량</label>
						<p class="col-9">100</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">불량률</label>
						<p class="col-9">0%</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">날짜</label>
						<p class="col-9">2022-07-12 20:52</p>
					</div>
					<div class="d-flex justify-content-end">
						<p>담당자 : 김현일 (1라인)</p>
					</div>
				</div>
				<div>
					<div class="col-12 row">
						<label class="col-3">제품명</label>
						<p class="col-9">x8451589-5121566-cc51522</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">목표수량</label>
						<p class="col-9">200</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">진행수량</label>
						<p class="col-9">100</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">불량률</label>
						<p class="col-9">0%</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">날짜</label>
						<p class="col-9">2022-07-12 20:52</p>
					</div>
					<div class="d-flex justify-content-end">
						<p>담당자 : 김현일 (2라인)</p>
					</div>
				</div>
				<div>
					<div class="col-12 row">
						<label class="col-3">제품명</label>
						<p class="col-9">x8451589-5121566-cc51522</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">목표수량</label>
						<p class="col-9">200</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">진행수량</label>
						<p class="col-9">100</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">불량률</label>
						<p class="col-9">0%</p>
					</div>
					<div class="col-12 row">
						<label class="col-3">날짜</label>
						<p class="col-9">2022-07-12 20:52</p>
					</div>
					<div class="d-flex justify-content-end">
						<p>담당자 : 김현일 (3라인)</p>
					</div>
				</div>
			</div>
			<div class="pageNum d-flex justify-content-center">
				<p>&lt; 1 2 3 &gt;</p>
			</div>
			
			
		</section>
	</section>
</body>
</html>