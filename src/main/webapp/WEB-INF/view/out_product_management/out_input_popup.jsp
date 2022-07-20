<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/out_input_popup.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="out_input_popup">
        <form action="" method="post" class="col-12 row">
            <div class="col-6">
                <div class="col-12 row">
                    <label class="col-4">프로젝트명</label>
                    <input type="text" class="col-8 text-right">
                </div>
                <div class="col-12 row">
                    <label class="col-4">업체명</label>
                    <input type="text" class="col-8 text-right">
                </div>
                <div class="col-12 row">
                    <label class="col-4"> </label>
                    <select name="" id="" class="col-8 text-center">
                        <option value="" selected disabled> == 업체 선택 == </option>
                    </select>
                </div>
                <div class="col-12 row">
                    <label class="col-4">의뢰번호</label>
                    <input type="text" class="col-8 text-right">
                </div>
            </div>
            <div class="col-6">
                <div class="col-12 row">
                    <label class="col-4">규격</label>
                    <input type="text" class="col-8 text-right">
                </div>
                <div class="col-12 row">
                    <label class="col-4">개수</label>
                    <input type="number" class="col-8 text-right" min="0" value="0">
                </div>
                <div class="col-12 row">
                    <label class="col-4">단가</label>
                    <input type="number" class="col-8 text-right" min="0" value="0">
                </div>
                <div class="col-12 row">
                    <label class="col-4">등록자</label>
                    <input type="text" class="col-8 text-right" value="김현일" disabled>
                </div>
                <div class="col-12 row justify-content-end">
                    <input type="submit" value="등록" class="col-3">
                </div>
            </div>
        </form>
    </section>
</body>
</html>