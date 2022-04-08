<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	
	// guestbookOne
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = new Guestbook();
	// GuestbookOne출력하는 method호출해서 guestbook에 저장
	guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<form method = "post" action= "updateGuestbookAction.jsp">
	<h1 class=table-active>수정</h1>
	<table class="table table-bordered">
			<tr class="table-success">
			<td>방명록 번호</td>
			<td><input type="text" name="guestbookNo" value="<%=guestbook.getGuestbookNo()%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="5" cols="50" name = "guestbookContent"><%=guestbook.getGuestbookContent()%></textarea></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type = "password" name = "guestbookPw"></td>
		</tr>
	</table>
	
	
	<button type="submit">수정하기</button>
	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" >뒤로 가기</a>
</form>

</body>
</html>