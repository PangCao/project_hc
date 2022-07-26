<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<div class="sidebar-container">
	<div class="sidebar-header d-flex justify-content-center">
		<img src="<c:url value="/resources/images/logo_black.png"/>" alt="" style="width: 90%;" class="mt-4 mb-5">
	</div>
	<nav class="menu">
		<ul class="sidebar-menu metismenu" id="sidebar-menu">
			<li>
				<a href="mainpage" class="d-flex justify-content-between home_page">
					<div><i class="fa-solid fa-house"></i> 메인페이지</div>
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</li>
			<li>
				<a href="notice" class="d-flex justify-content-between notice_page">
					<div><i class="fa-solid fa-circle-exclamation"></i> 공지사항</div>
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</li>
			<li>
				<input type="checkbox" id="product_management">
				<label for="product_management" class="d-flex justify-content-between ">
					<div><i class="fa-solid fa-gears"></i> 생산관리</div>
					<i class="fa-solid fa-angle-right"></i>
				</label>
				<ul class="sidebar-nav">
					<li>
						<a href="product_management" class="all_product"> 전체 공정 현황 </a>
					</li>
					<li>
						<a href="input" class="order_product"> 생산 작업 지시 등록 </a>
					</li>
					<li>
						<a href="complete" class="complete_product"> 생산 작업 지시 착수 </a>
					</li>
					<li>
						<a href="record" class="record_product"> 생산 작업 실적 등록 </a>
					</li>
				</ul>
			</li>
			<li>
				<input type="checkbox" id="out_management">
				<label for="out_management" class="d-flex justify-content-between">
					<div><i class="fa-regular fa-handshake"></i> 외주관리</div>
					<i class="fa-solid fa-angle-right"></i>
				</label>
				<ul class="sidebar-nav">
					<li>
						<a href="out_input" class="input_out"> 외주 의뢰 등록</a>
					</li>
					<li>
						<a href="out_select" class="select_out"> 외주 공정 현황 </a>
					</li>
				</ul>
			</li>
			<li>
				<a href="issue" class="d-flex justify-content-between management_issue">
					<div><i class="fa-solid fa-triangle-exclamation"></i> 이슈관리</div>
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</li>
			<li>
				<a href="user_authentication" class="d-flex justify-content-between setting_user">
					<div><i class="fa-regular fa-circle-user"></i> 개인정보관리</div>
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</li>
		</ul>
	</nav>
</div>
