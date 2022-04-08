<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@page import ="dao.*" %>
<%
	// deletePhotoForm에서 데이터 요청 값 받는 코드
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	// 디버깅 코드
	System.out.println(photoNo + " <-- photoNo");
	System.out.println(photoPw + " <-- photoPw");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePhotoForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="jumbotron">
		<!-- 메인 메뉴 시작-->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- 메인 메뉴 끝 -->
		<h1>이미지 삭제</h1>
		<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
			<table class="table table-bordered text-center table-striped table-dark">
				<tr>
					<td>번호</td>
					<td><input class="text-center" type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly"></td>
					<td>비밀번호</td>
					<td><input type="password" name="photoPw" value=""></td>
				</tr>
				<tr>
					<td colspan="4">
						<button type="submit">사진 삭제</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>