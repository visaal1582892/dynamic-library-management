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
            background: linear-gradient(to bottom, #e3f2fd, #ffffff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            width: 700px;
            margin: 60px auto;
            padding: 40px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #2090bc;
            font-size: 30px;
            font-style: italic;
            text-decoration: underline;
        }

        label {
            display: block;
            margin-top: 20px;
            font-size: 18px;
            font-style: italic;
        }

        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 10px;
        }

        .submit-btn {
            display: block;
            margin: 30px auto 0;
            padding: 12px 25px;
            background-color: lightblue;
            color: #003366;
            font-size: 18px;
            font-weight: bold;
            font-style: italic;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: box-shadow 0.3s ease;
        }

        .submit-btn:hover {
            box-shadow: 2px 2px 5px gray;
        }

        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: #bbdefb;
            color: #0d47a1;
            padding: 8px 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            text-decoration: none;
        }

        .back-btn:hover {
            background-color: #90caf9;
        }
    </style>
</head>
<body>

<a href="${pageContext.request.contextPath}/jsp/bookManagement.jsp" class="back-btn">← Back</a>

<div class="container">
    <h1>UPDATE BOOK</h1>

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

<!-- JavaScript to dynamically populate form -->
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
