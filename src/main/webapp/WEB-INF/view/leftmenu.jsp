<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar-container">
	<div class="sidebar-header d-flex justify-content-center">
		<img src="<c:url value="/resources/images/logo_black.png"/>" alt="" style="width: 90%;" class="mt-4 mb-5">
	</div>
	<nav class="menu">
		<ul class="sidebar-menu metismenu" id="sidebar-menu">
			<li>
				<input type="checkbox" id="product_management">
				<label for="product_management" class="d-flex justify-content-between">
					<div><i class="fa-solid fa-gears"></i> 생산관리</div>
					<i class="fa-solid fa-angle-right"></i>
				</label>
				<ul class="sidebar-nav">
					<li>
						<a href="management"> 전체 공정 현황 </a>
					</li>
					<li>
						<a href="input"> 생산 작업 지시 등록 </a>
					</li>
					<li>
						<a href="complete"> 생산 작업 지시 착수 </a>
					</li>
					<li>
						<a href="record"> 생산 작업 실적 등록 </a>
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
						<a href="out_input"> 외주 의뢰 등록</a>
					</li>
					<li>
						<a href="out_select"> 외주 공정 현황 </a>
					</li>
				</ul>
			</li>
			<li>
				<a href="#" class="d-flex justify-content-between">
					<div><i class="fa-regular fa-circle-user"></i> 개인정보관리</div>
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</li>
		</ul>
	</nav>
</div>