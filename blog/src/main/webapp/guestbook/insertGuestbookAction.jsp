<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<% 
	//한글 깨지지 않게 인코딩
	request.setCharacterEncoding("utf-8"); 
	
	//GuestbookDao 생성
	GuestbookDao guestbookDao = new GuestbookDao();
	
	//사용 할 값 받아오기
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	
	//디버깅
	System.out.println("writer : " + writer);
	System.out.println("guestbookPw : " + guestbookPw);
	System.out.println("guestbookContent : " + guestbookContent);

	//Guestbook-하나의 변수로 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.writer = writer;
	guestbook.guestbookPw = guestbookPw;
	guestbook.guestbookContent = guestbookContent;
	
	//메소드 호출
	guestbookDao.insertGuestbook(guestbook);
	
	// 입력 후 guestbookList.jsp로 다시 이동
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); 
%>
