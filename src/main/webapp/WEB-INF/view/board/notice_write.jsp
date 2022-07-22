<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/all.css'/>">
<!-- 여기 아래 css가 계속 교체 -->
<link rel="stylesheet" href="<c:url value='/resources/css/notice_write.css'/>">
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
						<section class="notice_write">
				<h2 class="col-6 ml-5 mt-5">공지사항</h2>
				<div>
					<form action="notice_write_input" method="post" name="noticeWriteForm">
						<div class="col-12 row">
							<label class="col-2">제목</label>
							<input type="text" class="col-10" name="n_title">
						</div>
						<div class="col-12 row">
							<label class="col-2">작성자</label>
							<input type="text" class="col-10" value="김사장" disabled name="n_anthor">
						</div>
						<div class="col-12 row">
							<label class="col-2">내용</label>
							<textarea name="n_content"class="col-10" style="resize: none;"></textarea>
						</div>
						<div class="d-flex justify-content-end col-12">
							<input type="button" value="작성" onclick="notice_write()">
						</div>
					</form>
				</div>
			</section>
		</section>
	</section>
</body>
<script type="text/javascript">
	function notice_write() {
		if (confirm('공지사항을 작성하시겠습니까?')) {
			document.noticeWriteForm.submit();	
		}
	}
</script>
</html>