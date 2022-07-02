<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.Board" %>
<%@ page import = "dao.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 형변환 후 받아오기
	System.out.println("boardNo : " + boardNo);
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아db 드라이버 로딩
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "mariadb1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw); // 계정 접속
	System.out.println("conn : " + conn);
	
	String categorySql = "SELECT category_name categoryName, count(*) cnt FROM board GROUP BY category_name"; // categoryName, count
	String boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate FROM board WHERE board_no=?"; // boardPw는 아님 
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql); // category 값 넣어주기(CategoryList)
	PreparedStatement boardStmt = conn.prepareStatement(boardSql); // board 값 넣어주기(boardOne)
	boardStmt.setInt(1, boardNo); // board_no=? 값 넣기	
	System.out.println("categoryStmt : " + categoryStmt);
	System.out.println("boardStmt : " + boardStmt);
	
	ResultSet categoryRs = categoryStmt.executeQuery(); // category값 저장
	ResultSet boardRs = boardStmt.executeQuery(); // board값 저장
	System.out.println("categoryRs : " + categoryRs);
	System.out.println("boardRs : " + boardRs);
	
	// category
	ArrayList<HashMap<String,Object>> categoryList = new ArrayList<HashMap<String,Object>>(); // ResultSet -> ArrayList
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	// boardOne 
	Board board = null; // board_no은 하나이므로
	while(boardRs.next()) {
		board = new Board();
		board.setBoardNo(boardRs.getInt("boardNo"));
		board.setCategoryName(boardRs.getString("categoryName"));
		board.setBoardTitle(boardRs.getString("boardTitle"));
		board.setBoardContent(boardRs.getString("boardContent"));
		board.setCreateDate(boardRs.getString("createDate"));
		board.setUpdateDate(boardRs.getString("updateDate"));
	}
	
	conn.close(); // Connection 사용 후 반납
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style type="text/css">
</style>
</head>
<body>
	<!-- category별 게시글 링크 메뉴 -->
	<div class="jumbotron text-center">
	<h3>CATEGORY</h3>
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%></a>
				<span class="badge badge-info badge-*">[<%=m.get("cnt")%>]</span>
				
			<%		
				}
			%>
	</div>
	
		
	<h3>BOARD_상세보기</h3> <!-- 게시글 상세보기 -->
	<table class="table table-sm text-left">
		<tr>
			<td>boardNo</td>
			<td><%=board.getBoardNo() %></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td><%=board.getCategoryName() %></td>
		</tr>
		<tr>
			<td>boardTitle</td>
			<td><%=board.getBoardTitle() %></td>
		</tr>
		<tr>
			<td>boardContent</td>
			<td><%=board.getBoardContent() %></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%=board.getCreateDate() %></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td><%=board.getUpdateDate() %></td>
		</tr>
	</table>
		
	<div>
		<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo() %>">[수정]</a>
		<a href="<%=request.getContextPath()%>/board//deleteBoardForm.jsp?boardNo=<%= board.getBoardNo() %>">[삭제]</a>
	

	</div>
</body>
</html>
​