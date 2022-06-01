<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import = "vo.Board" %>
 <% 
	request.setCharacterEncoding("utf-8");// 글자 깨지지 않게
 	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
 
 	//insertBoardForm에서 넘긴 것 저장하기
 	String categoryName = request.getParameter("categoryName");
 	String boardTitle = request.getParameter("boardTitle");
 	String boardContent = request.getParameter("boardContent");
 	String boardPw = request.getParameter("boardPw");
 	
 	//정보 가공 하나로 묶기
 	Board board = new Board();
 	board.setCategoryName(categoryName);
 	board.setBoardTitle(boardTitle);
 	board.setBoardContent(boardContent);
 	board.setBoardPw(boardPw);
 	
 	// 디버깅
 	System.out.println(categoryName + " <-- insertBoardAction categoryName");
 	System.out.println(boardTitle + " <-- insertBoardAction boardTitle");
 	System.out.println(boardContent + " <-- insertBoardAction boardContent");
 	System.out.println(boardPw + " <-- insertBoardAction boardPw");
 	
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
	stmt.setString(1,board.getCategoryName());
	stmt.setString(2,board.getBoardTitle());//제목
	stmt.setString(3,board.getBoardContent());//내용
	stmt.setString(4,board.getBoardPw());//비밀번호
	
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