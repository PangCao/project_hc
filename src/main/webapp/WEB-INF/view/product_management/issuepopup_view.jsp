<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="command.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
<%
	RemarkCommand issueDetail = (RemarkCommand)request.getAttribute("issueDetail");
	String id = (String)session.getAttribute("id");
	String issueids = (String)request.getAttribute("issueids");
	String r_id = (String)request.getAttribute("r_id");
	String p_num = (String)request.getAttribute("p_num");
	String[] list = issueids.split(",");
	String next = null;
	String prev = null;
	for (int i = 0; i < list.length; i++) {
		if (list[i].equals(r_id)) {
			if (i < list.length-1){
				next = list[i+1];
			}
			if (i > 0) {
				prev = list[i-1];
			}
		}
	}
%>
</head>
<body>
	<section style="width: 900px; height: 700px;" class="m-auto mt-2 d-flex flex-column justify-content-between">
        <div>
            <hr>
            <div class="col-12 row justify-content-between">
                <div class="col-8 row">
                    <h4 class="col-2 m-0 d-flex align-items-center">제목</h4>
                    <h5 class="col-9 m-0  d-flex align-items-center"><%=issueDetail.getR_title() %></h5>
                </div>
                <div class="col-4 row justify-content-end">
                    <label for="" class="col-6 m-0 text-right d-flex align-items-center justify-content-end">등록자 : </label>
                    <p class="col-6 m-0 d-flex align-items-center"><%=issueDetail.getR_anthor() %></p>
                </div>
            </div>
            <hr>
            <div style="height: 520px;" class="col-12">
                <div class="col-12 row d-flex justify-content-between">
                    <div class="col-9 d-flex align-items-center">
                        <i class="fa-regular fa-eye"></i>
                        <p class="m-0 pl-2"><%=issueDetail.getR_view() %></p>
                    </div>
                    <div class="col-3 d-flex align-items-center justify-content-end">
                        <i class="fa-regular fa-calendar-check"></i>
                        <p class="m-0 pl-2"><%=issueDetail.getR_date() %></p>
                    </div>
                </div>
                <div class="pt-5" style="min-height: 500px; max-height: 500px; overflow-y: scroll;">
                    <p class="p-0 m-0" style="max-height: 500px; display: block;"><%=issueDetail.getR_content() %></p>
                </div>
            </div>
            <hr>
            <div class="d-flex justify-content-center">
            <%
            	if (prev != null) {
            %>
                <input type="button" value="이전" class="col-1 mx-1" onclick="prevpage()">
            <%
            	}
            	if (next != null) {
            %>
                <input type="button" value="다음" class="col-1 mx-1" onclick="nextpage()">
            <%
            	}
            %>
                <input type="button" value="목록" class="col-1 mx-1" onclick="backlist()">
            <%
            	if (issueDetail.getR_anthor_id().equals(id)) {
            %>
                <input type="button" value="삭제" class="col-1 mx-1" onclick="deleteissue()">
            <%
                }
            %>
            </div>
        </div>
    </section>
</body>
<script type="text/javascript">
	function prevpage() {
		location.href="issuepopup_view?p_num=<%=p_num%>&r_id=<%=prev%>";	
	}
	function nextpage() {
		location.href="issuepopup_view?p_num=<%=p_num%>&r_id=<%=next%>";
	}	
	function backlist() {
		location.href="issue_popup?p_num=<%=p_num%>";
	}
	function deleteissue() {
		if (confirm('이슈를 삭제하시겠습니까?')){
			location.href="issue_popup_delete?r_id=<%=r_id%>&p_num=<%=p_num%>&issueids=<%=issueids%>";
		}
	}
</script>
</html>