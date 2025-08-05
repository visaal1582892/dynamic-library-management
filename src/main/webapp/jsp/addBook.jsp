
<%@page import="com.dynamic_library_management.domain.BookCategory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	List<BookCategory> categoryList = List.of(BookCategory.values());
	request.setAttribute("categoryList", categoryList);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <style>
        body {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100vw;
	height: 100vh;
	overflow: hidden;
	background-color: #f0f0f0;
	font-family: sans-serif;
}

#main-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: space-around;
	width: 30%;
	height: 50%;
	border-radius: 25px;
	padding: 10px;
	background-color: white;
	box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.5);
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 80%;
	justify-content: space-around;
	width: 75%;
}

.input-container {
	display: flex;
	justify-content: space-between;
	width: 100%;
	margin: 10px 0;
}

label {
	font-weight: bold;
	color: #592bd5;
	width: 30%;
}

input, select {
	width: 65%;
	padding: 5px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

h1 {
	color: #4aff4a;
	margin-bottom: 10px;
}

.submit-btn, a {
	text-decoration: none;
	padding: 10px;
	background-color: #592bd5;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
	margin-top: 15px;
}

.submit-btn:hover, a:hover {
	background-color: #3e1ca3;
}

.message {
	font-size: 18px;
	margin-top: 10px;
	font-weight: bold;
	text-align: center;
}

.success {
	color: #4aff4a;
}

.error {
	color: red;
}
    </style>
</head>
<body>
    <main id="main-container">
        <h1>Add Book</h1>
        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/addBookController" method="post">
            <div class="input-container">
                <label>Title:</label>
                <input name="title" required />
            </div>
            <div class="input-container">
                <label>Author:</label>
                <input name="author" required />
            </div>
            <div class="input-container">
                <label>Category:</label>
                <select name="category" required>
                    <option>Select Category</option>
                    <c:forEach items="${categoryList}" var="category">
                        <option value="${category.getStringValue()}">${category.toString()}</option>
                    </c:forEach>
                </select>
            </div>
            <input class="submit-btn" type="submit" value="Add Book" />
        </form>
    </main>
</body>
</html>
