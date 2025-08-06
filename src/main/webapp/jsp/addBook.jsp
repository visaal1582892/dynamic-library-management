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
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: 
                linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .home-btn, .back-btn {
            position: absolute;
            top: 20px;
            padding: 8px 16px;
            font-weight: bold;
            border-radius: 8px;
            border: none;
            text-decoration: none;
        }

        .home-btn {
            right: 20px;
            background-color: #c8e6c9;
            color: #1b5e20;
        }

        .back-btn {
            left: 20px;
            background-color: #bbdefb;
            color: #0d47a1;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            width: 500px;
        }

        h1 {
            text-align: center;
            color: #0d47a1;
            margin-bottom: 20px;
            border-bottom: 2px solid #90caf9;
            display: inline-block;
            padding-bottom: 10px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-size: 16px;
            font-weight: bold;
        }

        input[type="text"], select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }

        .btn {
            margin-top: 25px;
            padding: 12px;
            width: 100%;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background-color: #64b5f6;
            color: white;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #42a5f5;
        }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="home-btn">Home</a>
    <a href="${pageContext.request.contextPath}/jsp/bookOptions.jsp" class="back-btn">Back</a>

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
                    <option value="${category.stringValue}">${category.toString()}</option>
                </c:forEach>
            </select>

            <input type="submit" value="Add Book" class="btn" />
        </form>
    </div>

</body>
</html>
