<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>

<script>
  $( function() {
	  
	var idCheck = false;
	var pwCheck = false;  
	  
    $( ".radio" ).checkboxradio();
 	// datepicker 클래스 이벤트 - 적정한 옵션을 넣어서 초기화 시켜 준다. 기본 datepicker()로 사용 가능
    $(".datepicker").datepicker({
    changeMonth: true,
    changeYear: true,
    dateFormat: "yy-mm-dd",
    dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
    monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
    });
 	
    var now = new Date();
	var startYear = now.getFullYear();
	var yearRange = (startYear - 100) + ":" + startYear;
	// datepicker - 초기값으로 셋팅하는 방법을 사용하면 2번째는 무시 당한다.
	//원래 있던 datepicker에 option을 추가하는 방법이다.
	$(".datepicker").datepicker("option", {
		"maxDate" : new Date(),
		"yearRange" : yearRange
	});
	
	// 회원 가입 전처리 - 유효성 검사
	
	// 아이디 체크 이벤트
	$("#id").keyup(function() {
		
		idCheck = false;
		
		var id = $("#id").val();
		// 공백문자 처리
		id = $.trim(id);
		$("#id").val(id);
		// alert("입력한 아이디 : " + id);

		// 4자 미만 처리
		if (id.length < 4) {
			$("#idCheckDiv").removeClass("alert-success");
			$("#idCheckDiv").addClass("alert alert-danger");
			$("#idCheckDiv").text("아이디는 4자 이상 영숫자이여야 합니다.");
			return;
		}

		// 20자 초과
		if (id.length > 20) {
			$("#idCheckDiv").removeClass("alert-success");
			$("#idCheckDiv").addClass("alert-danger");
			$("#idCheckDiv").text("아이디는 20자 이내 영숫자이여야 합니다.");
			return;
		}

		// 4~20 사이 아이디인 경우 - 중복 체크하러 간다. -> 서버로 간다. URL필요 -> 화면에 다른 데이터는 변하지 않으면서 일부 처리에 필요한 데이터만 변경 URL은 변경이 없다. ->Ajax
		// 중복안된 경우(아이디가 null인 경우) - 사용가능한 아이디 입니다., 중복이된 경우(아이디가 null이 아닌 경우) - 중복된 아이디입니다. -> 서버에서 처리
		// /member/idCheck -> *.do:sitemesh 위 아래 메뉴와 카피라이트가 붙는다.
		// result -> 서버에서 전달해 주는 데이터
		$("#idCheckDiv").load("/member/idCheck?id=" + id, function(result) {
			// 결과에 따른 배경색 처리
			// alert(result);
			// 클래스 다 지우기
			$("#idCheckDiv").removeClass("alert-success alert-danger");
			if (result.indexOf("가능한") == -1) {
				// 중복된 아이디인 경우 배경은 빨간색
				$("#idCheckDiv").addClass("alert-danger");
				idCheck = false;
			} else {
				// 사용가능한 아이디인 경우 배경은 파란색
				$("#idCheckDiv").addClass("alert-success");
				idCheck = true;
			}
		});

	}); //$("#id").keyup() 이벤트의 끝
	
	// 비밀번호 처리 이벤트
	$("#pw").keyup(function() {
		pwCheck = false;
		// $(this) == $("#pw")
		var pw = $(this).val();
		//alert(pw.length);
		// 4자 미만 처리
		if (pw.length < 4) {
			$("#pwCheckDiv").removeClass("alert-success");
			$("#pwCheckDiv").addClass("alert-danger");
			$("#pwCheckDiv").text("비밀번호는 4자 이상이여야 합니다.");
			return;
		}

		// 20자 초과 처리
		if (pw.length > 20) {
			$("#pwCheckDiv").removeClass("alert-success");
			$("#pwCheckDiv").addClass("alert-danger");
			$("#pwCheckDiv").text("비밀번호는 20자 이내이여야 합니다.");
			return;
		}

		// 4~20 사이 pw2와 같은지 체크
		var pw2 = $("#pw2").val();
		if (pw == pw2) {
			// 비밀번호와 비밀번호 확인이 같은 경우
			$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-danger");
			$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-success");
			$("#pwCheckDiv, #pw2CheckDiv").text("적당한 비밀번호입니다.");
			pwCheck = true;
		} else {
			// 비밀번호와 비밀번호 확인이 같지 않은 경우
			$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-success");
			$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-danger");
			$("#pwCheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			if (pw2.length < 4)
				$("#pw2CheckDiv").text("비밀번호확인은 4자 이상이여야 합니다.");
			else if (pw2.length > 20)
				$("#pw2CheckDiv").text("비밀번호 확인은 20자 이내이여야 합니다.");
			else
				$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
		}

	});
	// 비밀번호 확인 처리 이벤트
	$("#pw2").keyup(function() {
		pwCheck = false;

		// $(this) == $("#pw2")
		var pw2 = $(this).val();
		//alert(pw2.length);
		// 4자 미만 처리
		if (pw2.length < 4) {
			$("#pw2CheckDiv").removeClass("alert-success");
			$("#pw2CheckDiv").addClass("alert-danger");
			$("#pw2CheckDiv").text("비밀번호확인은 4자 이상이여야 합니다.");
			return;
		}

		// 20자 초과 처리
		if (pw2.length > 20) {
			$("#pw2CheckDiv").removeClass("alert-success");
			$("#pw2CheckDiv").addClass("alert-danger");
			$("#pw2CheckDiv").text("비밀번호 확인은 20자 이내이여야 합니다.");
			return;
		}

		// 4~20 사이 pw와 같은지 체크
		var pw = $("#pw").val();
		if (pw == pw2) {
			// 비밀번호와 비밀번호 확인이 같은 경우
			$("#pw2CheckDiv, #pwCheckDiv").removeClass("alert-danger");
			$("#pw2CheckDiv, #pwCheckDiv").addClass("alert-success");
			$("#pw2CheckDiv, #pwCheckDiv").text("적당한 비밀번호입니다.");
			pwCheck = true;
		} else {
			// 비밀번호와 비밀번호 확인이 같지 않은 경우
			$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-success");
			$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-danger");
			$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			if (pw.length < 4)
				$("#pwCheckDiv").text("비밀번호확인은 4자 이상이여야 합니다.");
			else if (pw.length > 20)
				$("#pwCheckDiv").text("비밀번호 확인은 20자 이내이여야 합니다.");
			else
				$("#pwCheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
		}

	});
	// 비밀번호 처리 이벤트의 끝
	
	// 회원 가입 이벤트
	$("#writeForm").submit(function(){
		
		// alert("아이디 체크 : " + idCheck + "\n비밀번호 체크 : " + pwCheck);
		
		// 아이디 중복체크 - 사용 가능한 아이디 인지 확인
		if(!idCheck){
			alert("중복이 되지 않는 적당한 형식의 아이디를 사용하셔야만 합니다.");
			$("#id").focus();
			// form 전송을 무시시킨다.
			return false;
		}
		// 비밀번호와 비밀번호 확인
		if(!pwCheck){
			alert("비밀번호와 비밀번호 확인의 길이가 4~20이여야 하고 같아야 합니다.");
			$("#pw").focus();
			// form 전송을 무시시킨다.
			return false;
		}
		
		// form 전송을 무시시킨다. -> 나중에 꼭 주석처리해야만 한다.
		// return false;
	});
	
  });
</script>
</head>
<body>
	<div class="container" >
		<div class="col-md-offset-3 col-md-6">
			<h3>회원가입</h3>
			<form action="write.do" method="post" enctype="multipart/form-data" id="writeForm">
				<div class="form-group">
					<label for="id">*아이디</label> 
					<input name="id" id="id" type="text" class="form-control" pattern="[A-Za-z0-9]{4,20}" autocomplete="none" required>
				</div>
				<div class="alert alert-danger" id="idCheckDiv">아이디는 4자 이상의
					영문+숫자를 입력하셔야 합니다.</div>
				<div class="form-group">
					<label for="pw">*비밀번호</label> 
					<input name="pw" id="pw" type="password" class="form-control" pattern=".{4,20}" required>
				</div>
				<div class="alert alert-danger" id="pwCheckDiv">비밀번호는 4자 이상이여야합니다.</div>
				<div class="form-group">
					<label for="pw2">*비밀번호 확인</label> 
					<input name="pw2" id="pw2" type="password" class="form-control" pattern=".{4,20}" required>
				</div>
				<div class="alert alert-danger" id="pw2CheckDiv">비밀번호는 4자 이상이여야합니다.</div>
				<div class="form-group">
					<label for="name">*이름</label> 
					<input name="name" id="name" type="text" class="form-control" pattern="[가-힣]{2,10}" required>
				</div>
				<div class="form-group">
					<label for="birth">*생년월일</label> 
					<input name="birth" id="birth" type="text" class="form-control datepicker" autocomplete="none" required>
				</div>
				<div class="form-group">
					<label for="tel">연락처</label> 
					<input name="tel" id="tel" type="text" class="form-control" >
				</div>
				<div class="form-group">
					<label for="email">*이메일</label> 
					<input name="email" id="email" type="text" class="form-control" required >
				</div>
				<div class="form-group">
					<label for="imageFile">프로필</label> 
					<input name="imageFile" id="imageFile" type="file" class="form-control" >
				</div>
				<div class="form-group">
					<fieldset>
						<label >성별</label><br>
						<label for="man">남자</label>
						<input type="radio" name="gender" id="man" value="남자" class="radio" checked>
						<label for="woman">여자</label>
						<input type="radio" name="gender" id="woman" class="radio" value="여자">
					</fieldset>
				</div>
				<div class="form-group">
					<button class="btn btn-primary btn-md btn-block">가입하기</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>