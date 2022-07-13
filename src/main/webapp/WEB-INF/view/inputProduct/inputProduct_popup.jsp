<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/all.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <section class="container">
        <form action="" class="mt-4">
            <div class="col-12 row form-group d-flex justify-content-end">
                <select name="" id="" class="form-control col-3 mx-1">
                    <option value="" selected>대분류</option>
                </select>
                <select name="" id="" class="form-control col-3 mx-1">
                    <option value="" selected>중분류</option>
                </select>
                <select name="" id="" class="form-control col-3 mx-1">
                    <option value="" selected>소분류</option>
                </select>
                <input type="submit" class="btn btn-secondary col-2 ml-2" value="카테고리 검색">
            </div>   
        </form>
        <hr>
        <form action="">
            <div class="col-12 row form-group d-flex justify-content-end">
                <input type="text" class="col-5 mx-1 form-control" placeholder="품명을 입력해주세요.">
                <input type="submit" class="btn btn-secondary col-2 ml-2" value="품명 검색">
            </div>
        </form>
        <hr>
        <form action="">
            <table class="col-12 table table-hover text-right">
                <tbody>
                    <tr>
                        <th class="col-2">품번</th>
                        <th class="col-6">품명</th>
                        <th class="col-2">재고수량</th>
                        <th class="col-2">선택</th>
                    </tr>
                    <!-- 검색하면 나오는 목록 -->
                    <tr>
                        <td>x-11</td>
                        <td>제품명 1</td>
                        <td>900</td>
                        <!-- 클릭시 부모창에 값 입력하고 창 닫기(자바스크립트) -->
                        <td><input type="button" value="선택" class="btn btn-success"></td>
                    </tr>
                    <tr>
                        <td>x-11</td>
                        <td>제품명 1</td>
                        <td>900</td>
                        <td><input type="button" value="선택" class="btn btn-success"></td>
                    </tr>
                    <tr>
                        <td>x-11</td>
                        <td>제품명 1</td>
                        <td>900</td>
                        <td><input type="button" value="선택" class="btn btn-success"></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </section>
</body>
</html>