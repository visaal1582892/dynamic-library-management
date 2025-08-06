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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #e0f7fa, #ffffff);
        }

        h1 {
            text-align: center;
            margin-top: 30px;
            color: #2c3e50;
            font-style: italic;
            font-weight: bold;
            text-decoration: underline;
            font-size: 33px;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto 60px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }

        .message {
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
            color: <%= messageColor != null ? messageColor : "#2e7d32" %>;
            background-color: <%= messageColor != null && messageColor.equals("#c62828") ? "#ffcdd2" : "#d0f0c0" %>;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }

        th {
            background-color: #00796b;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .btn-delete {
            background-color: #ef5350;
            color: white;
            border: none;
            padding: 6px 12px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-delete:hover {
            background-color: #d32f2f;
        }

        .nav-links {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 40px;
        }
        


        .nav-links a {
            text-decoration: none;
            color: #00796b;
            font-weight: bold;
            margin: 0 10px;
            padding: 8px 16px;
            border: 2px solid #00796b;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        

        .nav-links a:hover {
            background-color: #00796b;
            color: white;
        }
        

        /* Responsive */
        @media (max-width: 600px) {
            th, td {
                padding: 8px;
                font-size: 14px;
            }
            
            h1 {
                font-size: 24px;
            }
            
            .nav-links a {
                padding: 6px 12px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>All Books</h1>

    <% if (message != null && !message.trim().isEmpty()) { %>
        <div class="message"><%= message %></div>
    <% } %>

    <table>
        <thead>
            <tr>
                <th>Book ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Status</th>
                <th>Availability</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
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
                    <form method="post" action="deleteBookController" style="display:inline;">
                        <input type="hidden" name="bookId" value="<%= book.getBookId() %>" />
                        <button class="btn-delete" type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7" style="text-align:center; padding: 20px; font-style: italic; color: #555;">
                    No books found.
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>


   
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/jsp/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/jsp/bookOptions.jsp">Back</a>
        </div>
</div>




</body>
</html>
