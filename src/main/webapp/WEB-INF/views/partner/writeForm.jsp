<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>partnerJoin</title>

	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src= "/js/memberRegister.js"></script>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	
</head>
<body>
	<div class="container">
		<div class="col-md-6">
			<form  name = "partnerJoinForm" action="write.do" method="post">
				<h3>업체등록</h3>
					<div>
						<label>업체명</label>
						<input type="text" name="companyName" size="20" class="form-control">	
					</div>
					<div>
						<label>아이디</label>
						<input type="text" name="id" size="30" value="${vo.id }" class="form-control" readonly>
					</div>
					<div>
						<label>이메일</label>
						<input type="email" name="email" size="20" value="${vo.email }" class="form-control">
					</div>
					<div class="form-group">				
				<label for="post">주소</label>
				<div class="row ml-1 mb-1">
					<div class="mr-1">
						<input type="text" id="sample4_postcode" placeholder="우편번호" name="postcode" readonly class="form-control">
					</div>
					<div class="">
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" id="post" class="btn btn-primary">
					</div>
				</div>
				<div class="row ml-1 mb-1">
					<div class="mr-1">
						<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="roadAddress" class="form-control" readonly></div>
					<div class="">
						<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="jibunAddress" class="form-control" readonly></div>
					<span id="guide" style="color:#999;display:none"></span>
				</div>
				<div class="row ml-1 mb-1">
					<div class="mr-1">
						<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="detailAddress" class="form-control"></div>
					<div class="">
						<input type="text" id="sample4_extraAddress" placeholder="참고항목" name="extraAddress" class="form-control"></div>
				</div>
			</div>
				<button class="btn btn-primary">가입하기</button>
				<a href = "/" class="btn btn-primary">HOME</a>
			</form>
		</div>
	</div>
</body>
</html>