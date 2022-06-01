<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BoardDao"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
		
	String categoryName = request.getParameter("categoryName");
	BoardDao boardDao = new BoardDao(); // 메서드를 사용할 객체 생성
	Board board = boardDao.selectBoardOne(boardNo); // 메서드 사용 후 Board객체에 저장
	System.out.println("updateBoardForm_boardNo" + boardNo); // 디버깅

	ArrayList<String> categoryList = boardDao.selectCategory(categoryName); // 카테고리 이름들을 select하는 메서드 실행 후 ArrayList에 저장
	
	for(String s : categoryList) {
		System.out.println(s);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<h1 class=table-active>수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
	<table class= "table table-hover ">
			<tr>
				<td>boardNo</td>
				<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<%
							for(String s : categoryList) {
								if(s.equals(board.getCategoryName())) {
						%>
									<option selected="selected" value="<%=s%>"><%=s%></option>
						<%
								} else {
						%>
									<option value="<%=s%>"><%=s%></option>
						<%		
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td><textarea rows="5" cols="50" name="boardContent" value="<%=board.getBoardContent()%>"></textarea></td>
			<tr>	
				<td>boardPw</td>
				<td><input type="password" name="boardPw" value=""></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	</div>
</body>
</html>