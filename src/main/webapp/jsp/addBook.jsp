
<%@page import="com.dynamic_library_management.domain.BookCategory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	List<BookCategory> categoryList=List.of(BookCategory.values());
	request.setAttribute("categoryList", categoryList);
	//boolean success=(boolean)request.getAttribute("success");
	//String message=(String)request.getAttribute("message");
	System.out.println(request.getAttribute("success"));
	System.out.println(request.getAttribute("message"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Add Book</h1>
	<form action="../addBookController" method="post">
		<label>Title : </label>
		<input name="title">
		<label>Author : </label>
		<input name="author">
		<label>Category : </label>
		<select name="category">
			<option>Select Category</option>
			<c:forEach items="${categoryList}" var="category">
				<option value="${category.getStringValue()}">${category.toString()}</option>
			</c:forEach>
		</select>
		<input type="submit" value="Add Book"  />
	</form>
</body>
</html>