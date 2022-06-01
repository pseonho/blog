<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo =Integer.parseInt(request.getParameter("boardNo"));
	String boardTitle = request.getParameter("boardTitle");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board delete</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>	
	<h1 class=table-active> 삭제</h1>
	<form action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp" method="post">
	<table class= "table table-hover ">
			<tr>
				<td>번호: <input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>비밀번호: <input type="password" name="boardPw"></td>
			</tr>
		</table>
		<div>
			<button type="submit">삭제</button>
		</div>
	</form>
</body>
</html>