<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">  <!--  부트 스트랩 4.0 -->		
	
	<!-- 메인 메뉴 시작-->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- 메인 메뉴 끝 -->	
	
	<div class="container-fluid m-2">	
		<div class="jumbotron text-center">
			<h1>HOME</h1>	<!--  가운대 글씨 -->
		</div>
		
		<!-- 카테고리 리스트  -->
		<div class="container-fluid row">
			<div class= " col-sm-2"> </div>
			<ul class="list-group col-sm-8 text-center">
				<li class="list-group-item"><a href="<%=request.getContextPath()%>/board/boardList.jsp">BoardList</a></li>
				<li class="list-group-item"><a href="<%=request.getContextPath()%>/photo/photoList.jsp">PhotoList</a></li>
				<li class="list-group-item"><a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">GuestbookList</a></li>
			</ul>
			<div class= " col-sm-2"> </div>
		</div>
	</div>
	
</body>
</html>