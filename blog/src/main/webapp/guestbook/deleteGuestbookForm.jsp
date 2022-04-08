<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); //삭제할 방명록 번호
 System.out.println(guestbookNo + "<-- guestbookNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<h1 class=table-active>삭제</h1>
<form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
	<table class="table table-bordered">
			<tr class="table-success">
			<td>삭제할 번호</td>
			<td>
			<input type="text" name="guestbookNo" value="<%=guestbookNo%>" readonly ="readonly">
			</td>
		</tr>
		<tr>
			<td>비밀번호 입력</td>
			<td>
			<input type="password" name="guestbookPw" value="">
			</td>
		</tr>
	</table>
	<button type="submit">삭제</button> 
	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" >뒤로 가기</a>
</form>
</body>
</html>