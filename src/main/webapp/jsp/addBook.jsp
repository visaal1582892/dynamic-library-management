<%@page import="com.dynamic_library_management.domain.BookCategory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            background: linear-gradient(to bottom, #e3f2fd, #ffffff);
            font-family: Arial, sans-serif;
        }
        .container {
            width: 600px;
            margin: 50px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }
        h1 {
            text-align: center;
            color: #2090bc;
            text-decoration: underline;
            font-style: italic;
        }
        label {
            display: block;
            margin-top: 15px;
            font-size: 18px;
            font-style: italic;
        }
        input[type="text"], select {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            background-color: lightblue;
        }
        .back-btn, .home-btn {
            position: absolute;
            top: 20px;
            padding: 5px 15px;
            font-weight: bold;
            border-radius: 8px;
            border: none;
        }
        .back-btn {
            left: 20px;
            background-color: #bbdefb;
            color: #0d47a1;
        }
        .home-btn {
            right: 20px;
            background-color: #c8e6c9;
            color: #1b5e20;
        }
    </style>
</head>
<body>

    <!-- Home and Back Buttons -->
    <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="home-btn">Home</a>
    <a href="${pageContext.request.contextPath}/jsp/bookManagement.jsp" class="back-btn">Back</a>

    <div class="container">
        <h1>ADD BOOK</h1>

        <form action="/dynamic-library-management/addBookController" method="post">
            <label>Title:</label>
            <input type="text" name="title" placeholder="Enter Book Title" required />

            <label>Author:</label>
            <input type="text" name="author" placeholder="Enter Author Name" required />

            <label>Category:</label>
            <select name="category" required>
                <option value="">Select Category</option>
                <c:forEach items="${categoryList}" var="category">
                    <option value="${category.stringValue}">${category}</option>
                </c:forEach>
            </select>

            <input type="submit" value="Add Book" class="btn" />
        </form>
    </div>

</body>
</html>
