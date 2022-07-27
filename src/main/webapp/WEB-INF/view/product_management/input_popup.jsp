<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="command.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/input_popup.css'/>">
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ProjectCommand projectinput = (ProjectCommand)request.getAttribute("projectinput");
	String task = (String)request.getAttribute("task");
	MemberCommand userInfo = (MemberCommand)session.getAttribute("member");
%>
</head>
<body>
	<section class="input_popup">
        <form action="input_popup_input" method="post" name="inputForm">
            <div class="d-flex justify-content-between mb-0">
                <div class="col-8">
                    <div>
                        <label class="col-3">프로젝트명 </label>
                        <input type="text" value="<%= projectinput.getPj_name() %>" disabled class="text-center p-0 m-0 col-6">
                        <input type="hidden" value="<%= projectinput.getPj_name() %>" name="p_proname">
                        <input type="hidden" value="<%=projectinput.getPj_id()%>" name="project_id">
                    </div>
                    <div>
                        <label class="col-3">작업번호 </label>
                        <input type="text" value="<%=task %>" disabled class="text-center p-0 m-0 col-6">
                        <input type="hidden" value="<%=task%>" name="p_tasknumber">
                    </div>
                    <div class="d-flex">
                        <label class="col-3">공정번호</label>
                        <div>
                            <div class="col-6 d-flex p-0">
                                <select name="p_prefix" id="p_processnumber_prefix" class="col-11 text-center p-0">
                                    <option value="" selected disabled> == 공정분류 == </option>
                                    <option value="A">A(가공)</option>
                                    <option value="B">B(소조립)</option>
                                    <option value="C">C(대조립)</option>
                                    <option value="D">D(선행의장)</option>
                                    <option value="E">E(블럭도장)</option>
                                    <option value="F">F(P.E.)</option>
                                    <option value="G">G(탑재)</option>
                                    <option value="H">H(DOCK 의장)</option>
                                    <option value="I">I(진수 선행 도장)</option>
                                    <option value="J">J(진수)</option>
                                </select>
                            </div>
                            <div class="col-6 p-0 d-flex justify-content-end">
                                <select name="p_suffix" id="p_processnumber_suffix" class="col-11 text-center p-0">
                                    <option value="" selected disabled> == 세부공정 == </option>
                            <%
                            	for(int i = 0; i < 10; i++) {
                            		if (i != 9){
                            %>
                            	<option value="00<%=i+1%>">00<%=i+1 %></option>
                            <%
                            		}
                            		else{
                  			%>
                  				<option value="0<%=i+1%>">0<%=i+1 %></option>
                  			<%
                            		}
                            	}
                            		
                            %>
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
                    <h5>등록자 : <%=userInfo.getM_name() %></h5>
                    <input type="hidden" value="<%=userInfo.getM_num() %>" name="p_regnum">
                </div>
            </div>
            <div class="mb-0">
                <div class="col-8">
                    <div>
                        <label class="col-3">제목</label>
                        <input type="text" name="r_title" id="r_title" class="col-6 p-0 m-0" disabled>
                    </div>
                    <div>
                        <label class="col-3">심각도</label>
                        <select name="r_class" id="r_class" class="col-6 p-0 m-0 text-sm-center" disabled>
                            <option value="" selected disabled>== 심각도 선택 ==</option>
                            <option value="INFO">INFO</option>
                            <option value="CARE">CARE</option>
                            <option value="WARN">WARN</option>
                            <option value="DANGER">DANGER</option>
                        </select>
                    </div>
                </div>
                <div class="col-12 d-flex justify-content-end">
                    <textarea name="r_content" id="r_content" class="col-12 pr-0" style="resize: none;" disabled></textarea>
                </div>
            </div>
            <div class="d-flex justify-content-end col-12">
                <input type="button" value="등록" onclick="product_input()">
            </div>
        </form>
    </section>
</body>
<script type="text/javascript">
	function issueinput(obj) {
		if (obj.checked == true) {
			document.getElementById('r_title').disabled = false;
			document.getElementById('r_class').disabled = false;
			document.getElementById('r_content').disabled = false;
		}
		else {
			document.getElementById('r_title').disabled = true;
			document.getElementById('r_class').disabled = true;
			document.getElementById('r_content').disabled = true;
		}
	}
	function product_input() {
		let pronum_p = document.getElementById('p_processnumber_prefix');
		let pronum_s = document.getElementById('p_processnumber_suffix');
		let issue_chk = document.getElementById('issuechk');
		let title_r =document.getElementById('r_title');
		let class_r = document.getElementById('r_class');
		let content_r = document.getElementById('r_content');
		
		if (pronum_p.value=="") {
			alert('공정분류를 선택해주세요.');
			return false;
		}
		if (pronum_s.value=="") {
			alert('공정 세부분류를 선택해주세요.');
			return false;
		}
		if(issue_chk.checked == true) {
			if (title_r.value == "") {
				alert('이슈 제목을 입력해주세요.');
				return false;
			}
			if (class_r.value == "") {
				alert('심각도를 선택해주세요.');
				return false;
			}
			if (content_r.value == "") {
				alert('내용을 입력해주세요.');
				return false;
			}
			
		}
		document.inputForm.submit();
	}
</script>
</html>