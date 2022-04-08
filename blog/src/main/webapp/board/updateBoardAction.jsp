<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%
	request.setCharacterEncoding("utf-8");

	BoardDao boardDao = new BoardDao(); // 메서드를 사용하기 위한 객체 생성
	Board board = new Board(); // 객체 생성
	
	// 값 넘겨받고 변수에 저장하기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	// Form에서 입력한 값 디버깅 
	System.out.println(boardNo+"<--BoardNo");
	System.out.println(categoryName+"<--categoryName");
	System.out.println(boardTitle+"<--boardTitle");
	System.out.println(boardContent+"<--boardContent");
	System.out.println(boardPw+"<--boardPw");
	
	// 객체 생성 후 멤버변수에 정보 저장
		board.boardNo = boardNo;
		board.categoryName = categoryName;
		board.boardTitle = boardTitle;
		board.boardContent = boardContent;
		board.boardPw = boardPw;
		
		int row =  boardDao.updateBoard(board); // 메서드로 실행된 행의 갯수 저장
		
		if(row == 0) { // 실행이 실패했을때
			System.out.println("수정 실패");
			response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
		} else if(row == 1) { // 실행이 성공했을때
			System.out.println("수정 성공");
			response.sendRedirect(request.getContextPath() + "/board/boardOne.jsp?boardNo=" + boardNo);
		} else {
			System.out.println("에러");
		}
	%>