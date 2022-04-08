<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.GuestbookDao" %>
<%

	//요청값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String writer = request.getParameter("writer");
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");
	
	//디버깅코드
	System.out.println(guestbookNo);
	System.out.println(writer);
	System.out.println(guestbookContent);
	System.out.println(guestbookPw);	
	
	//Guestbook에 요청값 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookNo = guestbookNo;
	guestbook.writer = writer;
	guestbook.guestbookContent = guestbookContent;
	guestbook.guestbookPw = guestbookPw;
	
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.updateGuestbook(guestbook);
	
	// 수정성공, 실패 후 guestbookList.jsp 이동
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		System.out.println("수정성공");
	} else {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		System.out.println("수정실패");
	}
	
%>