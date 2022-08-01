<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="command.ProjectCommand" %>
<%@ page import="command.OutCompanyListCommand" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/out_input_popup.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ArrayList<ProjectCommand> projectlist = (ArrayList<ProjectCommand>)request.getAttribute("projectlist");
	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
	ArrayList<OutCompanyListCommand> comlist = (ArrayList<OutCompanyListCommand>)request.getAttribute("comlist");
%>
</head>
<body>
	<section class="out_input_popup">
        <form action="out_input_popup_input" method="post" class="col-12 row" name="outForm">
            <div class="col-6">
                <div class="col-12 row">
                    <label class="col-4">프로젝트명</label>
                    <select name="op_proid" id="op_proid" class="col-8 text-center">
                    <%
                    	for(int i = 0; i < projectlist.size(); i++) {
                    		ProjectCommand command = projectlist.get(i);
                    %>
                    	<option value="<%=command.getPj_id()%>"><%=command.getPj_name() %></option>
                   	<%
                    	}
                   	%>
                    </select>
                </div>
                <div class="col-12 row">
                    <label class="col-4">업체명</label>
                    <select class="col-8 text-center" name="op_comid" id="op_comid">
                        <option value="" selected disabled> == 업체 선택 == </option>
                    <%
                    	for(int i = 0; i < comlist.size(); i++) {
                    		OutCompanyListCommand command = comlist.get(i);
                    %>
                    	<option value="<%=command.getO_id()%>"><%=command.getO_name() %></option>
                    <%
                    	}
                    %>
                    </select>
                </div>
<!--                 <div class="col-12 row">
                    <label class="col-4">의뢰번호</label>
                    <input type="text" class="col-8 text-right" name="op_ordernumber" id="op_ordernumber">
                </div> -->
                <div class="col-12 row">
                    <label class="col-4">등록자</label>
                    <input type="text" class="col-8 text-right" value="<%=name%>" disabled>
                    <input type="hidden" value="<%=id %>" name="op_regnum">
                </div>
            </div>
            <div class="col-6">
            	<div class="col-12 row">
                    <label class="col-4">품명</label>
                    <input type="text" class="col-8 text-right" name="op_productname" id="op_productname">
                </div>
                <div class="col-12 row">
                    <label class="col-4">규격</label>
                    <input type="text" class="col-8 text-right" name="op_productstandard" id="op_productstandard">
                </div>
                <div class="col-12 row">
                    <label class="col-4">개수</label>
                    <input type="number" class="col-8 text-right" min="0" value="0" name="op_unit" id="op_unit">
                </div>
                <div class="col-12 row">
                    <label class="col-4">단가</label>
                    <input type="number" class="col-8 text-right" min="0" value="0" name="op_price" id="op_price">
                </div>
                <div class="col-12 row justify-content-end">
                    <input type="button" value="등록" class="col-3" onclick="out_submit()">
                </div>
            </div>
        </form>
    </section>
</body>
<script type="text/javascript">
	function out_submit() {
		let pro_name = document.getElementById('op_proid');
		let com_id = document.getElementById('op_comid');
/* 		let ordernumber = document.getElementById('op_ordernumber');
 */		let p_name = document.getElementById('op_productname');
		let p_stan = document.getElementById('op_productstandard');
		let p_unit = document.getElementById('op_unit');
		let p_price = document.getElementById('op_price');
		
		
		if (com_id.value.length == 0) {
			alert('업체명을 입력해주세요.');
			return false;
		}
/* 		if (ordernumber.value.length == 0) {
			alert('외뢰번호를 입력해주세요.');
			return false;
		} */
		if (p_name.value.length == 0) {
			alert('품명을 입력해주세요.');
			return false;
		}
		if (p_stan.value.length == 0) {
			alert('규격을 입력해주세요.');
			return false;
		}
		if (p_unit.value == 0) {
			alert('수량을 입력해주세요.');
			return false;
		}
		if (p_price.value == 0) {
			alert('단가를 입력해주세요.');
			return false;
		}
		
		document.outForm.submit();		
	}
	document.getElementById('out_management').checked=true;
</script>
</html>