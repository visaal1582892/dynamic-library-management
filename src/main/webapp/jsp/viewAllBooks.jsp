<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dynamic_library_management.domain.Book" %>

<%
    String message = (String) request.getAttribute("message");
    String messageColor = (String) request.getAttribute("messageColor");
    List<Book> books = (List<Book>) request.getAttribute("books");
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Books</title>
    <style>
        body {
            background: linear-gradient(to bottom right, #e3f2fd, #ffffff);
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h1 {
            text-align: center;
            font-size: 32px;
            font-style: italic;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .message {
            text-align: center;
            font-size: 18px;
            color: <%= messageColor != null ? messageColor : "black" %>;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #90caf9;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #bbdefb;
            font-weight: bold;
        }
        .btn {
            padding: 6px 10px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-delete {
            background-color: #ef5350;
            color: white;
        }
        .btn-back, .btn-home {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            position: absolute;
            top: 20px;
        }
        .btn-back {
            left: 20px;
            background-color: #bbdefb;
            color: #0d47a1;
        }
        .btn-home {
            right: 20px;
            background-color: #c8e6c9;
            color: #1b5e20;
        }
    </style>
</head>
<body>

<h1>ALL BOOKS</h1>

<div class="message"><%= message != null ? message : "" %></div>

<table>
    <tr>
        <th>Book ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Category</th>
        <th>Status</th>
        <th>Availability</th>
        <th>Actions</th>
    </tr>
    <%
        if (books != null && !books.isEmpty()) {
            for (Book book : books) {
    %>
    <tr>
        <td><%= book.getBookId() %></td>
        <td><%= book.getTitle() %></td>
        <td><%= book.getAuthor() %></td>
        <td><%= book.getCategory() %></td>
        <td><%= book.getStatus() %></td>
        <td><%= book.getAvailability() %></td>
        <td>
            <form method="post" action="deleteBookController">
                <input type="hidden" name="bookId" value="<%= book.getBookId() %>" />
                <button class="btn btn-delete" type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<form action="bookOptions" method="get">
    <button type="submit" class="btn btn-back">← Back</button>
</form>

<form action="home" method="get">
    <button type="submit" class="btn btn-home">Home 🏠</button>
</form>

</body>
</html>
