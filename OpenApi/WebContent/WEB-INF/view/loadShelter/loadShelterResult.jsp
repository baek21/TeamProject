<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String res = CmmUtil.nvl((String)request.getAttribute("res"), "0");
 
	session.setMaxInactiveInterval(2400);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공공데이터 API 저장 결과</title>
</head>
<body>
	지진 옥외대피장소 정보 <%=res %>건을 확인했습니다.
</body>
</html>