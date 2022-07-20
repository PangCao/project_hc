<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">

<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/process_input.css'/>">
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
			<section class="proccess_input_top">
				<div class="d-flex justify-content-between">
					<div class="col-6">
						<select name="" id="">
							<option value="" selected disabled oninput="">== 프로젝트명 ==</option>
							<option value="">PJT명</option>
						</select>
						<select name="" id="">
							<option value="" selected disabled oninput="">== 작업번호 ==</option>
							<option value="">A15</option>
						</select>
					</div>
					<div class="col-6 d-flex align-items-end flex-column">
						<input type="button" value="등록">
					</div>
				</div>
				<div class="p-0">
					<table>
						<tbody>
							<tr>
								<th>No</th>
								<th>작업번호</th>
								<th>공정번호</th>
								<th>등록일</th>
								<th>착수일</th>
								<th>완료일</th>
								<th>특이사항</th>
								<th>등록자</th>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
			<section class="proccess_input_middle">
				<div>
					<table>
						<tbody>
							<tr>
								<td>1</td>
								<td>A15</td>
								<td>A1-001</td>
								<td>2022/07/19 12:04:10</td>
								<td>2022/07/21 09:04:10</td>
								<td>2022/07/25 18:01:40</td>
								<td>특이사항 무</td>
								<td>김현일</td>
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