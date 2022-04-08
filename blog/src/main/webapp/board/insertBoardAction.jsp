<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import = "vo.Board" %>
 <% 
	request.setCharacterEncoding("utf-8");// 글자 깨지지 않게
 	response.sendRedirect(request.getContextPath()+"/boardList.jsp");
 
 	//insertBoardForm에서 넘긴 것 저장하기
 	String categoryName = request.getParameter("categoryName");
 	String boardTitle = request.getParameter("boardTitle");
 	String boardContent = request.getParameter("boardContent");
 	String boardPw = request.getParameter("boardPw");
 	
 	//정보 가공 하나로 묶기
 	Board board = new Board();
 	board.categoryName = categoryName;
 	board.boardTitle = boardTitle;
 	board.boardContent = boardContent;
 	board.boardPw = boardPw;
 	
 	// 디버깅
 	System.out.println(board.categoryName + " <-- insertBoardAction categoryName");
 	System.out.println(board.boardTitle + " <-- insertBoardAction boardTitle");
 	System.out.println(board.boardContent + " <-- insertBoardAction boardContent");
 	System.out.println(board.boardPw + " <-- insertBoardAction boardPw");
 	
	// maraidb접속
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn");    
	
	/*
		insert into board(
			category_name,
			board_title,
			board_content,
			board_pw
			create_date
			update_date
		) values(
			?,?,?,?,now(),now()		
		)
	*/
 	
	//categoryName,boardTitle,boardContent,boardPw 저장한 것 사용
	String sql="insert into board(category_name, board_title, board_content, board_pw, create_date, update_date) values(?,?,?,?,now(),now())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,board.categoryName);
	stmt.setString(2,board.boardTitle);//제목
	stmt.setString(3,board.boardContent);//내용
	stmt.setString(4,board.boardPw);//비밀번호
	
	// 디버깅
	System.out.println(stmt + " <-- insertBoardAction stmt");
	System.out.println(sql + " <-- insertBoardAction sql");;
	
	// 디버깅 
	int row = stmt.executeUpdate(); // 몇 행을 입력했는지
	if(row == 1) {
		System.out.println(row + "입력성공");
	} else {
		System.out.println("입력실패");
	}	
	
	conn.close(); //종료
 %>