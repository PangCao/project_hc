<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">

<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/out_order_select.css"/>">
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
			<section class="out_order_select_top">
				<div class="d-flex justify-content-between align-items-end">
					<div class="col-6">
						<form action="" method="post">
							<div class="col-12 pl-0">
								<input type="date" class="col-7">
							</div>
							<div class="col-12 pl-0">
								<input type="date" class="col-7">
								<input type="submit" value="조회">
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
								<th>납품예정일</th>
								<th>품명</th>
								<th>규격</th>
								<th>수량</th>
								<th>진행수량</th>
								<th>진행상황</th>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<section class="out_order_select_middle">
				<div>
					<table>
						<tbody>
							<tr>
								<td>1</td>
								<td>O010011</td>
								<td>PJT-01</td>
								<td>Out Company</td>
								<td>2022/07/21<br>09:04:10</td>
								<td></td>
								<td>xxx-001</td>
								<td>xxxl-10</td>
								<td>1,000</td>
								<td>0</td>
								<td>의뢰수락대기</td>
							</tr>
							<tr>
								<td>1</td>
								<td>O010011</td>
								<td>PJT-01</td>
								<td>Out Company</td>
								<td>2022/07/21<br>09:04:10</td>
								<td>2022/07/22<br>09:04:10</td>
								<td>xxx-001</td>
								<td>xxxl-10</td>
								<td>1,000</td>
								<td>100</td>
								<td>생산중</td>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<div class="d-flex justify-content-center mt-5">
				<p>&lt; 1 2 3 &gt;</p>
			</div>
	</section>
			
			
		</section>
	</section>
</body>
</html>