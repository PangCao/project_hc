<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/projectpopup.css'/>">
</head>
<body>
    <section class="projectpopup">
        <form action="" method="post" class="col-12">
            <div class="col-12 row">
                <label class="col-3">프로젝트명</label>
                <input type="text" class="col-9" name="name" id="name">
            </div>
            <div class="col-12 row">
                <label class="col-3">진수예정일</label>
                <input type="date" class="col-9 text-center" name="date" id="date">
            </div>
            <div class="col-12 row d-flex justify-content-end">
                <label class="col-3"></label>
                <input type="button" class="col-9" onclick="pcolse()" value="프로젝트 생성">
            </div>
        </form>
    </section>
</body>
<script type="text/javascript">
	function pcolse() {
		let p_name = document.getElementById('name').value;
		let p_date = document.getElementById('date').value;
	    opener.location.replace("project_input?name="+p_name+"&date="+p_date);
	    window.close();
	}
</script>
</html>