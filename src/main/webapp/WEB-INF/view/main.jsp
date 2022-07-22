<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">
<meta charset="UTF-8">
<title>Insert title here</title>
	<%
		request.setCharacterEncoding("utf8");
	
		String error = "";
		
		if((String)request.getAttribute("error")!=null&(String)request.getAttribute("error")!=""){
			error = (String)request.getAttribute("error"); //Model에 들어가있는 값이 Object타입으로 되어있기 때문에 케스팅해야한다.
		}
	%>
</head>
<body>
	<section class="main">
		<div class="container d-flex justify-content-center align-items-center">
			<form action="login" method="post" class="col-5">
				<div class="form-group">
					<input type="text" name="m_num" class="form-control col-12" placeholder="사번입력">
				</div>
				<div class="form-group">
					<input type="password" name="m_password" class="form-control col-12" placeholder="비밀번호입력">
				</div>
				<div>
					<input type="submit" class="btn btn-secondary col-12" value="로그인">
				</div>
			</form>
		</div>
		<div class="logo_img">
			<img src="<c:url value="/resources/images/logo.png"/>" style="width: 300px;">
		</div>
	</section>
</body>
<script type="text/javascript">
	var er = '<%= error %>'; /* request의 값을 출력하여 스크립트 변수에 대입 */
	
	if(er != null&er != ""){
		alert(er);	
	}
</script>
</html>