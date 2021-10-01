<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- Bootstrap Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top" style="z-index:3; font-family: 'Noto Sans KR', sans-serif;">
	  <div class="container">
	    <a class="navbar-brand" href="/mainMap/home.do">
	    	지진 옥외대피장소
		</a>
	    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarResponsive">
	      <ul class="navbar-nav ml-auto">
	        <li class="nav-item active">
	          <c:if test="${SS_USER_ID != null}"><a class="nav-link"> ${SS_USER_ID}님 환영합니다.</a></c:if>
	            <span class="sr-only">(current)</span>
	        </li>
	        <li class="nav-item">
	         <c:if test="${SS_USER_ID != null}"><a class="nav-link" href="/logout.do">로그아웃</a></c:if>
		      <c:if test="${SS_USER_ID == null}"><a class="nav-link" href="/user/LoginForm.do">로그인</a></c:if>
	        </li>
	        <li class="nav-item">
	          
		      <c:if test="${SS_USER_ID == null}"><a class="nav-link" href="/user/UserRegForm.do">회원가입</a></c:if>
	          
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/notice/NoticeList.do">게시판</a>
	        </li>
	      </ul>
	    </div>
	  </div>
	</nav>

</body>
</html>