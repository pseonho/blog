<%@page import="java.util.ArrayList"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String categoryName = request.getParameter("categoryName"); // 입력하는 게시물의 카테고리 받아오기
	BoardDao boardDao = new BoardDao(); // 메서드 사용을 위한 객체 생성
	ArrayList<String> insertList = boardDao.selectCategory(categoryName); // 카테고리 목록을 보여주는 메서드 실행 후 ArrayList<String>에 저장
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1 class="table-active">글 입력</h1>
	<form method="post" action="<%=request.getContextPath()%>/insertBoardAction.jsp">
	<table class= "table table-hover">
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<% 
							for(String s : insertList) { 
						%>
							<option value="<%=s%>"><%=s%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td>	
					<input name="boardTitle" type="text">
				</td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea name="boardContent" rows = "5" cols="100"type="text"> </textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td>
					<input name="boardPw" type="password">
				</td>
			</tr>
			<tr>
				<td colspan = "2">
					<button type="submit"> 글 입력</button>
				</td>
		</table>
	</form>
</body>
</html>