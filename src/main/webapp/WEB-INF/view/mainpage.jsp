<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/mainpage.css'/>">
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
			<section class="mainpage">
				<div>
					<img src="<c:url value='/resources/images/main2.jpg'/>" alt="" style="width: 100%; padding: 10px;"/>
				</div>
				<div class="col-12 justify-content-center d-flex mt-5">
					<div class="col-6">
						<div>
							<div class="d-flex justify-content-between align-items-center">
								<a href="issue">이슈 관리</a>
								<div>
									<a href="">
										<i class="fa-solid fa-circle-arrow-left mr-3"></i>
									</a>
									<a href="">
										<i class="fa-solid fa-circle-arrow-right"></i>
									</a>
								</div>
							</div>
							<table class="table table-hover text-center">
								<tbody>
									<tr>
										<th>프로젝트명</th>
										<th>작업번호</th>
										<th>공정명</th>
										<th>등록시간</th>
										<th>등급</th>
									</tr>
									<tr>
										<td>PJT-01</td>
										<td>A15</td>
										<td>AA-001</td>
										<td>2022/07/21</td>
										<td>INFO</td>
									</tr>
									<tr>
										<td>PJT-01</td>
										<td>A15</td>
										<td>AA-001</td>
										<td>2022/07/21</td>
										<td>INFO</td>
									</tr>
									<tr>
										<td>PJT-01</td>
										<td>A15</td>
										<td>AA-001</td>
										<td>2022/07/21</td>
										<td>INFO</td>
									</tr>
									<tr>
										<td>PJT-01</td>
										<td>A15</td>
										<td>AA-001</td>
										<td>2022/07/21</td>
										<td>CARE</td>
									</tr>
									<tr>
										<td>PJT-01</td>
										<td>A15</td>
										<td>AA-001</td>
										<td>2022/07/21</td>
										<td>WARN</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="col-6">
						<div>
							<div class="d-flex justify-content-between align-items-center">
								<a href="notice">공지사항</a>
								<div>
									<a href="">
										<i class="fa-solid fa-circle-arrow-left mr-3"></i>
									</a>
									<a href="">
										<i class="fa-solid fa-circle-arrow-right"></i>
									</a>
								</div>
							</div>
							<table class="table table-hover text-center">
								<tbody>
									<tr>
										<th>NO</th>
										<th>제목</th>
										<th>등록자</th>
										<th>등록시간</th>
									</tr>
									<tr>
										<td class="col-1">1</td>
										<td class="col-5">안전사고예방</td>
										<td class="col-3">김부장</td>
										<td class="col-3">2022/07/21</td>
									</tr>
									<tr>
										<td class="col-1">2</td>
										<td class="col-5">안전사고예방</td>
										<td class="col-3">김부장</td>
										<td class="col-3">2022/07/21</td>
									</tr>
									<tr>
										<td class="col-1">3</td>
										<td class="col-5">안전사고예방</td>
										<td class="col-3">김부장</td>
										<td class="col-3">2022/07/21</td>
									</tr>
									<tr>
										<td class="col-1">4</td>
										<td class="col-5">안전사고예방</td>
										<td class="col-3">김부장</td>
										<td class="col-3">2022/07/21</td>
									</tr>
									<tr>
										<td class="col-1">5</td>
										<td class="col-5">안전사고예방</td>
										<td class="col-3">김부장</td>
										<td class="col-3">2022/07/21</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</section>
		</section>
	</section>
</body>
</html>