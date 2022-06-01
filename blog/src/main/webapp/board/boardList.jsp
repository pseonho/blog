<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.BoardDao"%>
<%@page import="vo.Board"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	BoardDao boardDao = new BoardDao(); // 메서드 사용을 위한 객체 생성
	Board board = new Board(); // 객체 생성
	
	// boardList페이지 실행 시 최근 10개의 게시물을 보여줌 (1페이지로 설정)
	int currentPage = 1; // 현재 페이지의 기본값 -> 1페이지
	
	if(request.getParameter("currentPage") != null) { // 이전 또는 다음 버튼을 눌러서 들어왔을때
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage : " + currentPage);
	
	String categoryName = request.getParameter("categoryName"); // 카테고리 받아오기
	// 페이지가 바뀔때 데이터도 변해야 함
	/*
		알고리즘
		SELECT .... LIMIT 0, 10
		
		currentPage	beginRow
		1			0
		2			10
		3			20
		4			30
		? <-- (currentPage-1)*10
	*/
	int rowPerPage = 10; // 내가 보고싶은 페이지의 갯수
	
	int beginRow = (currentPage-1) * rowPerPage; // 페이지 알고리즘 -> 1page : LIMIT 0, 10 2page : LIMIT 10, 10 ...
	
	ArrayList<HashMap<String, Object>> categoryList = boardDao.boardListByCategoryPage(categoryName); // 카테고리별 목록을 보여주는 메서드를 이용해 ArrayList<HashMap<String, Object>>에 저장
	ArrayList<Board> list = boardDao.selectBoardListByPage(beginRow, rowPerPage, categoryName); // 카테고리별로 정보를 보여주는 메서드

 	int lastPage = 0; // 마지막 페이지
 	int totalRow = 0; // 총 행의 갯수
 	
 	if(categoryName == null) { // 사용자가 카테고리를 선택하지 않았을때
 		totalRow = boardDao.selectBoardTotalRow(); // 카테고리와 상관없이 모든 행의 갯수 저장
 	} else { // 사용자가 카테고리를 선택했을때
 		totalRow = boardDao.selectCategoryTotalRow(categoryName); // 카테고리별 행의 갯수 저장
 	}
 	
 	System.out.println("totalRow : " + totalRow); // 디버깅
 	if(totalRow % rowPerPage == 0) {
 		lastPage = totalRow / rowPerPage; // ex) 총 10개의 게시물을 5개씩 출력했을때는 2페이지로 다 표현이 되므로 lastPage = totalRow / rowPerPage로 가능
 	} else {
 		lastPage = (totalRow / rowPerPage) + 1; // ex) 총 11개의 게시물을 5개씩 출력했을때는 2페이지로 다 표현이 안되므로 +1Page 추가
 	}
 	System.out.println("lastPage : " + lastPage); // 디버깅
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
		<!-- 메인 메뉴 시작-->
					<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- include 시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
		<!-- 메인 메뉴 끝 -->
		<!-- category별 게시글 링크 메뉴 -->
	<div class="jumbotron text-center ">
					<tr>
						<%
							for(HashMap<String, Object> m : categoryList) {
						%>
								<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%></a>
									<span class="badge badge-info badge-*">[<%=m.get("cnt")%>]</span>
						<%		
							}
						%>
					</tr>
	</div>
	<!-- 게시글 리스트 -->
	<div class="text-center theground to table headers">
				<%
					if(request.getParameter("categoryName") == null) { // 사용자가 아직 카테고리를 선택하지 않았을때
				%>
					<h2>게시글 목록</h2><h6>(TOTAL:<%=totalRow%>)</h6>
				<% 
					} else { // 사용자가 카테고리를 선택했을때
				%>
						<h1><%=categoryName%></h1>
				<%
					}
				%>
	<table class="table thead-dark  table-bordered">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>boardTitle</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : list) {
			%>
					<tr>
						<td><%=b.getCategoryName()%></td>
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
						<td><%=b.getCreateDate()%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	
	<div>
		<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지 -->
		<%
			if(currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
				if(categoryName == null) {
		%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
		<%	
				} else {
		%>
		<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
		<%
			 }
			}
		%>
		<!--  
			전체행			마지막 페이지 ? 
			10개 				1
			11,12,13 ~ 20		2
			21 ~ 30				3
			31 ~ 40				4
			마지막 페이지 = 전체행 / rowPerPage
		-->
		<%
			if(currentPage < lastPage) {
				if(categoryName == null) {
		%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>	
		<%		
			 }
			}
		%>
	</div>
	
</body>
	<div> <p class="text-right">
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">게시글 입력</a>
	 </p></div>
</html>