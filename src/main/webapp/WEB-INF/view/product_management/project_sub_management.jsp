<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">

<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value="/resources/css/project_sub_management.css"/>">
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
			<section class="project_sub_management">
				<div class="d-flex justify-content-between p-4">
					<h2>PJT명</h2>
				</div>
				<div class="row m-0">
					<div class="col-3">
						<table>
							<tbody>
								<tr>
									<td style="background-color: rgba(255, 0, 0, 0.322);">1</td>
									<td>2</td>
									<td>3</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">4</td>
								</tr>
								<tr>
									<td>5</td>
									<td>6</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">7</td>
									<td>8</td>
								</tr>
								<tr>
									<td>9</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">10</td>
									<td>11</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">12</td>
								</tr>
							</tbody>
						</table>
						<div class="d-flex justify-content-center">
							<p>&lt; A &gt;</p>
						</div>
					</div>
					<div class="col-3">
						<table>
							<tbody>
								<tr>
									<td style="background-color: rgba(255, 0, 0, 0.322);">1</td>
									<td>2</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">3</td>
									<td>4</td>
								</tr>
								<tr>
									<td style="background-color: rgba(255, 0, 0, 0.322);">5</td>
									<td>6</td>
									<td>7</td>
									<td>8</td>
								</tr>
								<tr>
									<td>9</td>
									<td>10</td>
									<td>11</td>
									<td>12</td>
								</tr>
							</tbody>
						</table>
						<div class="d-flex justify-content-center">
							<p>&lt; B &gt;</p>
						</div>
					</div>
					<div class="col-3">
						<table>
							<tbody>
								<tr>
									<td>1</td>
									<td>2</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">3</td>
									<td>4</td>
								</tr>
								<tr>
									<td>5</td>
									<td>6</td>
									<td>7</td>
									<td>8</td>
								</tr>
								<tr>
									<td style="background-color: rgba(255, 0, 0, 0.322);">9</td>
									<td>10</td>
									<td>11</td>
									<td>12</td>
								</tr>
							</tbody>
						</table>
						<div class="d-flex justify-content-center">
							<p>&lt; C &gt;</p>
						</div>
					</div>
					<div class="col-3">
						<table>
							<tbody>
								<tr>
									<td style="background-color: rgba(255, 0, 0, 0.322);">1</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">2</td>
									<td>3</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">4</td>
								</tr>
								<tr>
									<td>5</td>
									<td>6</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">7</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">8</td>
								</tr>
								<tr>
									<td>9</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">10</td>
									<td style="background-color: rgba(255, 0, 0, 0.322);">11</td>
									<td>12</td>
								</tr>
							</tbody>
						</table>
						<div class="d-flex justify-content-center">
							<p>&lt; D &gt;</p>
						</div>
					</div>
				</div>
			</section>
			<div class="d-flex justify-content-center mt-5">
				<p>&lt; 1 2 3 &gt;</p>
			</div>
		</section>
	</section>
</body>
</html>