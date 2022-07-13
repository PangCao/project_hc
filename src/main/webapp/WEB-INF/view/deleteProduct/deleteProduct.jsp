<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
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
			<!-- 상품, 자재 같이 사용할 예정 -->
			<div class="px-5">
				<form action="" class="row d-flex justify-content-end mb-3 mt-5">
					<input type="text" class="form-control col-4">
					<input type="button" value="검색" class="btn btn-secondary col-1 ml-3">
				</form>
				<table class="table table-hover text-center">
					<tbody>
						<tr>
							<th class="col-2">품번</th>
							<th class="col-6">품명</th>
							<th class="col-2">재고수량</th>
							<th class="col-2">삭제</th>
						</tr>
						<tr>
							<td>x-11</td>
							<td>삭제할 상품명</td>
							<td><input type="text" value="20" readonly class="form-control text-right"></td>
							<!-- 재고수량이 1개 이상이면 삭제 불가능하게 처리 -->
							<td>
								<input type="button" value="삭제" class="btn btn-danger" disabled>
							</td>
						</tr>
						<tr>
							<td>x-12</td>
							<td>삭제할 상품명</td>
							<td><input type="text" value="0" readonly class="form-control text-right"></td>
							<!-- 재고수량이 1개 이상이면 삭제 불가능하게 처리 -->
							<td><input type="button" value="삭제" class="btn btn-danger"></td>
						</tr>
						<tr>
							<td>x-13</td>
							<td>삭제할 상품명</td>
							<td><input type="text" value="0" readonly class="form-control text-right"></td>
							<!-- 재고수량이 1개 이상이면 삭제 불가능하게 처리 -->
							<td><input type="button" value="삭제" class="btn btn-danger"></td>
						</tr>
						<tr>
							<td>x-14</td>
							<td>삭제할 상품명</td>
							<td><input type="text" value="1" readonly class="form-control text-right"></td>
							<!-- 재고수량이 1개 이상이면 삭제 불가능하게 처리 -->
							<td><input type="button" value="삭제" class="btn btn-danger" disabled></td>
						</tr>
						<tr>
							<td>x-15</td>
							<td>삭제할 상품명</td>
							<td><input type="text" value="0" readonly class="form-control text-right"></td>
							<!-- 재고수량이 1개 이상이면 삭제 불가능하게 처리 -->
							<td><input type="button" value="삭제" class="btn btn-danger"></td>
						</tr>
					</tbody>
				</table>
				<div class="d-flex justify-content-center mt-5">
					<p>&lt; 1 2 3 &gt;</p>
				</div>			
			</div>
		</section>
	</section>
</body>
</html>