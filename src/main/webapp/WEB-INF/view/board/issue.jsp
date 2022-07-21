<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/issue.css'/>">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
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
			<section class="issue">
				<h2 class="col-6 ml-5 mt-5">이슈관리</h2>
				<div class="d-flex justify-content-between">
					<div class="col-5">
						<form action="" class="col-12">
							<div style="width: 100%;">
								<input type="date" style="width: 50%;">
							</div>
							<div style="width: 100%;">
								<input type="date" style="width: 50%;">
								<input type="submit" value="검색" class="col-3">
							</div>
						</form>
					</div>
					<div class="col-4 d-flex">
						<div class="col-12 p-0">
							<form action="" method="post" class="col-12 p-0 d-flex justify-content-end">
								<select name="" id="" class="col-8 text-center">
									<option value="" disabled selected>== 심각도 선택 ==</option>
									<option value="">INFO</option>
									<option value="">CARE</option>
									<option value="">WARN</option>
								</select>
								<span class="col-4 ml-2"></span>
							</form>
							<form  action="" method="post" class="col-12 p-0 d-flex justify-content-end">
								<input type="text" name="" id="" class="col-8">
								<input type="submit" value="검색" class="col-4 ml-2">
							</form>
						</div>
					</div>
				</div>
				<div class="col-12">
					<table class="col-12 table table-hover text-center">
						<tbody>
							<tr>
								<th class="col-1">NO</th>
								<th class="col-4">제목</th>
								<th class="col-2">등록자</th>
								<th class="col-2">등록일</th>
								<th class="col-2">심각도</th>
								<th class="col-1">조회수</th>
							</tr>
							<tr>
								<td>1</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
							<tr>
								<td>2</td>
								<td>폭염 주의</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>INFO</td>
								<td>0</td>
							</tr>
							<tr>
								<td>3</td>
								<td>장마철 안전</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>INFO</td>
								<td>0</td>
							</tr>
							<tr>
								<td>4</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
							<tr>
								<td>5</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
							<tr>
								<td>6</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
							<tr>
								<td>7</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
							<tr>
								<td>8</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
							<tr>
								<td>9</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
							<tr>
								<td>10</td>
								<td>자재 공급 지연</td>
								<td>이반장</td>
								<td>2022/07/21</td>
								<td>WARN</td>
								<td>0</td>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<div class="col-12 d-flex justify-content-center">
				<p>&lt;1 2 3&gt;</p>
			</div>			
		</section>
	</section>
</body>
</html>