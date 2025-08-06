<%@page import="com.dynamic_library_management.domain.Book"%>
<%@page import="com.dynamic_library_management.dao.implementation.BookDaoImplementation"%>
<%@page import="com.dynamic_library_management.domain.BookCategory"%>
<%@page import="com.dynamic_library_management.domain.BookStatus"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setAttribute("categoryList", List.of(BookCategory.values()));
    request.setAttribute("statusList", List.of(BookStatus.values()));
    request.setAttribute("bookList", new BookDaoImplementation().selectAllBooks());
%>

<%! 
    public Book selectById(HttpServletRequest request, int id) {
        List<Book> books = (List<Book>) request.getAttribute("bookList");
        return books.stream()
                    .filter(book -> book.getBookId() == id)
                    .findFirst()
                    .get();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Book</title>
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

        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            color: #0d47a1;
            padding: 8px 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            z-index: 10;
        }

        .back-btn:hover {
            background-color: #bbdefb;
        }

        .container {
            width: 500px;
            background: rgba(255, 255, 255, 0.95);
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        h1 {
            text-align: center;
            font-size: 26px;
            color: #0d47a1;
            margin-bottom: 25px;
            border-bottom: 2px solid #90caf9;
            display: inline-block;
            padding-bottom: 10px;
        }

        label {
            display: block;
            margin-top: 18px;
            font-size: 16px;
            color: #0d47a1;
            font-weight: bold;
        }

        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .submit-btn {
            display: block;
            width: 100%;
            margin-top: 30px;
            padding: 12px;
            background-color: #64b5f6;
            color: white;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #42a5f5;
        }
    </style>
</head>
<body>

<a href="${pageContext.request.contextPath}/jsp/bookOptions.jsp" class="back-btn">← Back</a>

<div class="container">
    <h1>Update Book</h1>

    <form action="${pageContext.request.contextPath}/updateBookDetailsController" method="post">
        <!-- Book Selection -->
        <label>Select Book:</label>
        <select id="bookSelector" name="bookId" onchange="loadBookDetails()" required>
            <option disabled selected>Select Book to Update</option>
            <c:forEach items="${bookList}" var="book">
                <option value="${book.getBookId()}">${book.getBookId()}. ${book.getTitle()}</option>
            </c:forEach>
        </select>

        <label>Title:</label>
        <input type="text" name="title" id="titleField" required />

        <label>Author:</label>
        <input type="text" name="author" id="authorField" required />

        <label>Category:</label>
        <select name="category" id="categoryField" required>
            <option value="">Select Category</option>
            <c:forEach items="${categoryList}" var="category">
                <option value="${category.getStringValue()}">${category.toString()}</option>
            </c:forEach>
        </select>

        <label>Status:</label>
        <select name="status" id="statusField" required>
            <option value="">Select Status</option>
            <c:forEach items="${statusList}" var="status">
                <option value="${status.getStringValue()}">${status.toString()}</option>
            </c:forEach>
        </select>

        <input type="submit" class="submit-btn" value="Update Book" />
    </form>
</div>

<script>
    const bookMap = new Map();

    <c:forEach items="${bookList}" var="book">
        bookMap.set(${book.getBookId()}, {
            "title": "${book.getTitle()}",
            "author": "${book.getAuthor()}",
            "category": "${book.getCategory().getStringValue()}",
            "status": "${book.getStatus().getStringValue()}"
        });
    </c:forEach>

    function loadBookDetails() {
        const selectedId = Number(document.getElementById("bookSelector").value.split(".")[0]);
        const currBook = bookMap.get(selectedId);

        if (currBook) {
            document.getElementById("titleField").value = currBook["title"];
            document.getElementById("authorField").value = currBook["author"];
            document.getElementById("categoryField").value = currBook["category"];
            document.getElementById("statusField").value = currBook["status"];
        }
    }
</script>

</body>
</html>
