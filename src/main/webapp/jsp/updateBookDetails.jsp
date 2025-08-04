<%@page import="com.dynamic_library_management.domain.Book"%>
<%@page
	import="com.dynamic_library_management.dao.implementation.BookDaoImplementation"%>
<%@page import="com.dynamic_library_management.domain.BookCategory"%>
<%@page import="com.dynamic_library_management.domain.BookStatus"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setAttribute("categoryList", List.of(BookCategory.values()));
request.setAttribute("statusList", List.of(BookStatus.values()));
request.setAttribute("bookList", new BookDaoImplementation().selectAllBooks());
%>

<%!public Book selectById(HttpServletRequest request,int id) {
		List<Book> books=(List<Book>)request.getAttribute("bookList");
		return books.stream()
			.filter(book -> book.getBookId()==id).findFirst().get();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Book</title>
<link rel="stylesheet" type="text/css" href="../css/commonForm.css">
</head>
<body>
	<main id="main-container">
		<h1>Update Book</h1>
		<form action="${pageContext.request.contextPath}/updateBookDetailsController"
			method="post">
			<!-- Book Selection -->
			<div class="input-container">
				<label>Select Book:</label> <select id="bookSelector" name="bookId"
					onchange="loadBookDetails()" required>
					<option disabled selected>Select Book to Update</option>
					<c:forEach items="${bookList}" var="book">
						<option value="${book.getBookId()}">${book.getBookId()}.
							${book.getTitle()}</option>
					</c:forEach>
				</select>
			</div>

			<div class="input-container">
				<label>Title:</label> <input name="title" id="titleField" required />
			</div>

			<div class="input-container">
				<label>Author:</label> <input name="author" id="authorField"
					required />
			</div>

			<div class="input-container">
				<label>Category:</label> <select name="category" id="categoryField"
					required>
					<option>Select Category</option>
					<c:forEach items="${categoryList}" var="category">
						<option value="${category.getStringValue()}">${category.toString()}</option>
					</c:forEach>
				</select>
			</div>

			<div class="input-container">
				<label>Status:</label> <select name="status" id="statusField"
					required>
					<option>Select Status</option>
					<c:forEach items="${statusList}" var="status">
						<option value="${status.getStringValue()}">${status.toString()}</option>
					</c:forEach>
				</select>
			</div>

			<input class="submit-btn" type="submit" value="Update Book" />
		</form>
	</main>

	<!-- JavaScript to dynamically populate form -->
	<script>

		var bookMap = new Map();
		
		<c:forEach items="${bookList}" var="book">
        bookMap.set(${book.getBookId()}, {
        	"title": "${book.getTitle()}",
        	"author": "${book.getAuthor()}",
        	"category": "${book.getCategory().toString()}",
        	"status": "${book.getStatus().getStringValue()}"
        });
		</c:forEach>
	
        function loadBookDetails() {
            const selectedId = Number(document.getElementById("bookSelector").value.split(".")[0]);
            
            const currBook=bookMap?.get(selectedId);
            
            document.getElementById("titleField").value=currBook["title"];
            document.getElementById("authorField").value=currBook["author"];
            document.getElementById("categoryField").value=currBook["category"];
            document.getElementById("statusField").value=currBook["status"];
        }
    </script>
</body>
</html>
