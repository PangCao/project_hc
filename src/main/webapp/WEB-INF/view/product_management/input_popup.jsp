<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/input_popup.css'/>">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="input_popup">
        <div>
            <div class="d-flex justify-content-between mb-0">
                <div class="col-8">
                    <div>
                        <label class="col-3">프로젝트명 </label>
                        <input type="text" value="PJT명" disabled class="text-center p-0 m-0 col-6">
                    </div>
                    <div>
                        <label class="col-3">작업번호 </label>
                        <input type="text" value="A15" disabled class="text-center p-0 m-0 col-6">
                    </div>
                    <div class="d-flex">
                        <label class="col-3">공정번호</label>
                        <div>
                            <div class="col-6 d-flex p-0">
                                <select name="" id="" class="col-11 text-center p-0">
                                    <option value="" selected disabled> == 공정분류 == </option>
                                    <option value="">A1</option>
                                    <option value="">A2</option>
                                </select>
                            </div>
                            <div class="col-6 p-0 d-flex justify-content-end">
                                <select name="" id="" class="col-11 text-center p-0">
                                    <option value="" selected disabled> == 세부공정 == </option>
                                    <option value="">001</option>
                                    <option value="">002</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div>
                        <label for="issue" class="col-3">이슈등록</label>
                        <input type="checkbox" id="issuechk" name="issuechk" onclick="issueinput(this)">
                    </div>
                </div>
                <div class="col-4 d-flex justify-content-end align-items-start">
                    <h5>등록자 : 김현일</h5>
                    <input type="hidden" value="김현일">
                </div>
            </div>
            <div class="mb-0">
                <div class="col-8">
                    <div>
                        <label class="col-3">제목</label>
                        <input type="text" name="title" id="title" class="col-6 p-0 m-0" disabled>
                    </div>
                    <div>
                        <label class="col-3">심각도</label>
                        <select name="class" id="class" class="col-6 p-0 m-0 text-sm-center" disabled>
                            <option value="" selected disabled>== 심각도 선택 ==</option>
                            <option value="">INFO</option>
                            <option value="">CARE</option>
                            <option value="">WARN</option>
                        </select>
                    </div>
                </div>
                <div class="col-12 d-flex justify-content-end">
                    <textarea name="content" id="content" class="col-12 pr-0" style="resize: none;" disabled></textarea>
                </div>
            </div>
            <div class="d-flex justify-content-end col-12">
                <input type="submit" value="등록">
            </div>
        </div>
    </section>
</body>
<script type="text/javascript">
	function issueinput(obj) {
		if (obj.checked == true) {
			document.getElementById('title').disabled = false;
			document.getElementById('class').disabled = false;
			document.getElementById('content').disabled = false;
		}
		else {
			document.getElementById('title').disabled = true;
			document.getElementById('class').disabled = true;
			document.getElementById('content').disabled = true;
		}
	}
</script>
</html>