<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	function a() {
	window.close();
	opener.location.replace("out_input?stat=1");
	}
	setTimeout(a(), 3000);
</script>

</body>
</html>