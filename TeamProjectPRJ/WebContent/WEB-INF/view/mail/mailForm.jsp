<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일전송폼</title>
</head>
<body>
	<form action="/mail/sendMailResult.do" method="post">
		<table border="1">
			<tr>
				<td>받는사람</td>
				<td><input type="text" name="toMail" style="width: 500px;" required></td>
			</tr>
			<tr>
				<td>메일제목</td>
				<td><input type="text" name="title" style="width: 500px;" required></td>
			</tr>
			<tr>
				<td>메일내용</td>
				<td><textarea name="contents" cols="70" rows="30"></textarea></td>
			</tr>
		</table>
		<br>
		<input type="submit" value="메일전송">
		<input type="reset" value="내용초기화">
	</form>
</body>
</html>