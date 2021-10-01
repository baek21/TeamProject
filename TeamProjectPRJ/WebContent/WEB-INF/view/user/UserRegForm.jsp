<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<!-- Bootstrap core CSS -->
	<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="/css/reg_login_user.css" rel="stylesheet">
	
	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	  
	<title>회원가입</title>
	<%@include file="/WEB-INF/view/header.jsp" %>
</head>

<body>
	<!-- This snippet uses Font Awesome 5 Free as a dependency. You can download it at fontawesome.io! -->
	<div class="container">
	    <div class="row">
			<div class="col-lg-10 col-xl-9 mx-auto">
				<div class="card card-signin flex-row my-5">
					
					<div class="card-img-left-reg d-none d-md-flex">
						<!-- Background image for card set in CSS! -->
					</div>
					
					<div class="card-body">
					
						<h5 class="card-title text-center">회원가입</h5>
            
	            		<form class="form-signin" name="f" method="post" action="/user/insertUserInfo.do">
							<div class="form-label-group">
								<input type="text" name="user_id" id="inputUserId" class="form-control" placeholder="아이디를 입력하세요" required autofocus>
								<label for="inputUserId">아이디</label>
							</div>
						
							<div class="form-label-group">
								<input type="password" name="password" id="inputPassword" class="form-control" placeholder="비밀번호를 입력하세요" required>
								<label for="inputPassword">비밀번호</label>
							</div>
						
							<div class="form-label-group">
								<input type="password" name="password2" id="inputConfirmPassword" class="form-control" placeholder="비밀번호를 입력하세요" required>
								<label for="inputConfirmPassword">비밀번호 재확인</label>
							</div>
						
							<div class="form-label-group">
								<input type="text" name="user_name" id="inputUserName" class="form-control" placeholder="이름을 입력하세요" required>
								<label for="inputUserName">이름</label>
							</div>
							
							<div class="form-label-group">
								<input type="email" name="email" id="inputEmail" class="form-control" placeholder="이메일을 입력하세요" required>
								<label for="inputEmail">이메일</label>
							</div>
							<br/>
							
							<div class="form-label-group">								
								<input type = "text" name = "addr1" id="inputAddress1" class="form-control" placeholder="주소를 입력하세요" required>
								<label for="inputAddress1">주소</label>
							</div>
							<div class="form-label-group">								
								<input type = "text" name = "addr2" id="inputAddress2" class="form-control" placeholder="상세주소를 입력하세요" required>
								<label for="inputAddress2">상세주소</label>
							</div>
							
							<hr class="my-4">
							
							<button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">가입하기</button>
							
							<a class="d-block text-center mt-2 small" href="LoginForm.do">로그인</a>
							
							<!-- 구글, 페이스북 아이디로 가입하기(미구현)
							<hr class="my-4">
							<button class="btn btn-lg btn-google btn-block text-uppercase" type="submit"><i class="fab fa-google mr-2"></i> Sign up with Google</button>
              				<button class="btn btn-lg btn-facebook btn-block text-uppercase" type="submit"><i class="fab fa-facebook-f mr-2"></i> Sign up with Facebook</button>
              				-->
	            		</form>
	            		
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>