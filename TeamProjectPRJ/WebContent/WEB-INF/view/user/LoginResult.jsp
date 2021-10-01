<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//controller에 저장된 세션으로 로그인할 때 생성됨
	// 로그인 성공 : 1, 아이디, 비밀번호 불일치로 인한 실패 : 0, 시스템 에러 : 2
	String SS_USER_ID = CmmUtil.nvl((String)session.getAttribute("SS_USER_ID"));
	String res = CmmUtil.nvl((String)request.getAttribute("res"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 되었습니다.</title>
	<%
		String msg = "";
		if(res.equals("0")){
			msg = "아이디, 비밀번호가 일치하지 않습니다.";
		} else if(res.equals("2")) {
			msg = "시스템에 문제가 발생하였습니다. 잠시후 다시 시도하여 주시길 바랍니다.";
		}
	%>

	<%if(res.equals("1")) {%>
		<meta http-equiv="refresh" content="0;url=http://localhost:8090/mainMap/home.do">
	<%} else {%>
		<script type="text/javascript">
			alert("<%=msg%>");
		</script>
		<meta http-equiv="refresh" content="0;url=http://localhost:8090/user/LoginForm.do">	
	<%} %>
</head>
<body>
</body>
</html>