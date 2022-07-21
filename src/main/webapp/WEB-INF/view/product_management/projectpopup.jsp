<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
</head>
<body>
    <section class="projectpopup">
        <form action="" method="post" class="col-12">
            <div class="col-12 row">
                <label class="col-3">프로젝트명</label>
                <input type="text" class="col-9">
            </div>
            <div class="col-12 row">
                <label class="col-3">진수예정일</label>
                <input type="date" class="col-9 text-center">
            </div>
            <div class="col-12 row d-flex justify-content-end">
                <label class="col-3"></label>
                <input type="submit" class="col-9">
            </div>
        </form>
    </section>
</body>
</html>