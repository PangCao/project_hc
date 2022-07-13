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
			<div class="px-5">
				<form action="" class="row d-flex justify-content-end mb-3 mt-5">
					<input type="text" class="form-control col-4">
					<input type="button" value="검색" class="btn btn-secondary col-1 ml-3">
				</form>
				<table class="table table-hover text-center">
					<tbody>
						<tr>
							<th class="col-2">품번</th>
							<th class="col-4">품명</th>
							<th class="col-2">재고수량</th>
							<th class="col-2">수정</th>
							<th class="col-2">진행사항</th>
						</tr>
						<tr>
							<td>
								<input type="text" value="x-11" class="form-control text-center">
								<input type="hidden" value="x-11" disabled readonly>
							</td>
							<td>
								<input type="text" value="수정할 상품명" class="form-control text-center">
								<input type="hidden" value="수정할 상품명" disabled readonly>
							</td>
							<td>
								<input type="text" value="20" class="form-control text-center">
								<input type="hidden" value="20" disabled readonly>
							</td>
							<td>
								<!-- hidden의 내용과 다른 내용이 있을 경우 수정신청 가능 -->
								<!-- 수정 신청을 눌리면 팝업창으로 사유 입력하도록 설정하고 페이지 이동(db연동하고 진행사항 적용) -->
								<input type="button" value="수정 신청" class="btn btn-danger" disabled>
							</td>
							<td>
								<!-- 신청이 진행중일때는 수정신청버튼 disabled -->
								<p class="btn btn-secondary">진행중</p>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" value="x-12" class="form-control text-center">
								<input type="hidden" value="x-12" disabled readonly>
							</td>
							<td>
								<input type="text" value="수정할 상품명2" class="form-control text-center">
								<input type="hidden" value="수정할 상품명2" disabled readonly>
							</td>
							<td>
								<input type="text" value="0" class="form-control text-center">
								<input type="hidden" value="0" disabled readonly>
							</td>
							<td>
								<input type="button" value="수정 신청" class="btn btn-danger" disabled>
							</td>
							<td>
								<!-- 신청이 진행중일때는 수정신청버튼 disabled -->
								<p class="btn btn-secondary">진행중</p>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" value="x-13" class="form-control text-center">
								<input type="hidden" value="x-13" disabled readonly>
							</td>
							<td>
								<input type="text" value="수정할 상품명3" class="form-control text-center">
								<input type="hidden" value="수정할 상품명3" disabled readonly>
							</td>
							<td>
								<input type="text" value="40" class="form-control text-center">
								<input type="hidden" value="40" disabled readonly>
							</td>
							<td>
								<input type="button" value="수정 신청" class="btn btn-danger">
							</td>
							<td>
								<!-- 수정 신청이 없는 상품에 대해서는 아무 진행사항 표시 안함 -->
							</td>
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