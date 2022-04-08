<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.ArrayList" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage")); 
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	</head>
	<body>
		<div class="jumbotron">
		<!-- 메인 메뉴 시작-->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- include 시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
		<!-- 메인 메뉴 끝 -->
	<% 
		for(Guestbook g : list) {
	%>
			<table class="table table-bordered">
				<tr class="table-success">
					<td><%=g.getWriter()%></td>
					<td><%=g.getCreateDate()%></td>
				</tr>
				<tr class="table-warning">
					<td colspan="2"><%=g.getGuestbookContent()%></td>
				</tr>
			</table>
			<div>
				<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>"><button type="button" class="btn btn-primary btn-sm">수정</button></a>
				<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>"><button type="button" class="btn btn-primary btn-sm">삭제</button></a>
			</div>
	<%	
		}
		
		if(currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>"><button type="button" class="btn-sm btn-outline-success">이전</button></a>
	<%		
		}
		
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>"><button type="button" class="btn-sm btn-outline-success">다음</button></a>
	<%
		}
	%>
		
		<!-- 방명록 입력 -->
		<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
			<div class="jumbotron">
			<table border="1">
				<tr class="table-warning">
					<td>글쓴이</td>
					<td><input type="text" name="writer"></td>
					<td>비밀번호</td>
					<td><input type="password" name="guestbookPw"></td>
				</tr>
				<tr class="table-warning">
					<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
				</tr>
			</table>
			<button>입력</button>
		</form>
		</div>
	</body>
	</html>