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
</head>

<body>
 <%@include file="/WEB-INF/view/header.jsp" %>
	<!-- This snippet uses Font Awesome 5 Free as a dependency. You can download it at fontawesome.io! -->
	<div class="container">
	    <div class="row">
			<div class="col-lg-10 col-xl-9 mx-auto">
				<div class="card card-signin flex-row my-5">
					
					<div class="card-img-left-login d-none d-md-flex">
						<!-- Background image for card set in CSS! -->
					</div>
					
					<div class="card-body">
					
						<h5 class="card-title text-center">로그인</h5>
            
						<form class="form-signin" name="f" method="post" action="/user/getUserLoginCheck.do">
		                	<div class="form-label-group">
		                  		<input type="text" name="user_id" id="inputUserId" class="form-control" placeholder="아이디를 입력하세요" required autofocus>
		                  		<label for="inputUserId">아이디</label>
		                	</div>
		
			                <div class="form-label-group">
			                	<input type="password" name="password" id="inputPassword" class="form-control" placeholder="비밀번호를 입력하세요" required>
			                	<label for="inputPassword">비밀번호</label>
			                </div>
						
							<!-- 비밀번호 기억하기(미구현)
			                <div class="custom-control custom-checkbox mb-3">
			                  <input type="checkbox" class="custom-control-input" id="customCheck1">
			                  <label class="custom-control-label" for="customCheck1">Remember password</label>
			                </div>
			                -->
			                
		                	<hr class="my-4">
		                	
		                   	<button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" type="submit">로그인</button>
			              	<a class="d-block text-center mt-2 small" href="UserRegForm.do">가입하기</a>
			              	
			                <!-- 비밀번호 찾기(미구현)
			                <div class="text-center">
			                	<a class="small" href="#">Forgot password?</a>
			                </div>
			                -->
		              	</form>
	            		
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>