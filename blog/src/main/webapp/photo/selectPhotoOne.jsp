<%@page import="vo.Photo"%>
<%@page import="dao.PhotoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo")); // 사용자가 볼 이미지의 번호 받아오기

	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.selectPhotoOne(photoNo);
	
	// 디버깅
	System.out.println("상세보기 한 이미지 번호 : " + photo.photoNo);
	System.out.println("상세보기 한 이미지 작성자 : " + photo.writer);
	System.out.println("상세보기 한 pdf 이름 : " + photo.photoName);
	System.out.println("상세보기 한 이미지 작성날짜 : " + photo.createDate);
	System.out.println("상세보기 한 이미지 업데이트 날짜 : " + photo.updateDate);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>selectPhotoOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="jumbotron">
		<!-- 메인 메뉴 시작-->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
		<!-- 메인 메뉴 끝 -->
		<h1>상세 페이지</h1>
		<table class="table thead-dark table-bordered">
			<tr>
				<td>번호</td>
				<td><%=photo.photoNo%></td>
				<td>작성자</td>
				<td><%=photo.writer%></td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="<%=request.getContextPath()%>/upload/<%=photo.photoName%>">
				</td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td><%=photo.createDate%></td>
				<td>수정날짜</td>
				<td><%=photo.updateDate%></td>
			</tr>
			<tr>
				<td colspan="4"><a class = "btn btn-danger float-right" href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.photoNo%>">삭제</a></td>
			</tr>
		</table>
	</div>
	
</body>
</html>