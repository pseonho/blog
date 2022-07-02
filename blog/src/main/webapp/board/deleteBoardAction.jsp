<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%
	//값 가져오기, 숫자형 문자열은 정수(10진수)로 반환
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // 게시물 번호
	String boardPw = request.getParameter("boardPw"); 
	
	//보드에 객체생성
	Board board = null;
	BoardDao boardDao = new BoardDao(); 	// 넣을 곳에서 deleteBoard메서드에(board) 넣기
	int row = boardDao.deleteBoard(boardNo, boardPw);
	
	//mariadb 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; 
	String dbuser = "root"; 
	String dbpw = "mariadb1234"; 
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " : conn결과");//디버깅
	
	//쿼리문 작성
	String sql = "DELETE FROM board WHERE board_no= , board_pw =?  ";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println("stmt:" + stmt); //디버깅
	
	//저장 된 쿼리
	stmt.setInt(1, boardNo); 
	stmt.setString(2, boardPw);
	
	//디버깅
	if(row == 0){ //삭제실패
		response.sendRedirect(request.getContextPath()+"/board/deleteBoardForm.jsp");
		System.out.println("삭제 실패");
	}else if(row == 1){//삭제성공
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
		System.out.println("삭제된 행(row):" + row);
	}else{
		System.out.println("error");
	}
	conn.close(); //종료
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>