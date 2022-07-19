<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/input_popup.css"/>">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="input_popup">
        <div>
            <div class="d-flex justify-content-between mb-0">
                <div class="col-8">
                    <div>
                        <label>프로젝트명 </label>
                        <input type="text" value="PJT명" disabled class="text-center p-0 m-0">
                    </div>
                    <div>
                        <label>작업번호 </label>
                        <input type="text" value="A15" disabled class="text-center p-0 m-0">
                    </div>
                    <div class="d-flex mb-0">
                        <label>공정번호</label>
                        <div>
                            <select name="" id="">
                                <option value="" selected disabled> == 공정분류 == </option>
                                <option value="">A1</option>
                                <option value="">A2</option>
                            </select>
                            <select name="" id="">
                                <option value="" selected disabled> == 세부공정 == </option>
                                <option value="">001</option>
                                <option value="">002</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-4 d-flex justify-content-end align-items-end">
                    <h5>등록자 : 김현일</h5>
                    <input type="hidden" value="김현일">
                </div>
            </div>
            <div>
                <div>
                    <p class="m-0">특이사항</p>
                </div>
                <textarea name="" id=""></textarea>
            </div>
            <div class="d-flex justify-content-end">
                <input type="submit" value="등록">
            </div>
        </div>
    </section>
</body>
</html>