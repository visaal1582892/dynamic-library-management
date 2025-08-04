<%@ page import="java.util.List" %>
<%@ page import="com.dynamic_library_management.domain.Book" %>
<%@ page import="com.dynamic_library_management.services.implementation.BookServiceImplementation"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
List<Book> booksList=new BookServiceImplementation().validateViewAllBooks();
request.setAttribute("bookslist", booksList);
%>

<html>
<head>


    <title>View All Members</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 10px;
            text-align: left;
        }
        .btn-delete {
            background-color: #ef5350;
            color: white;
            border: none;
            padding: 5px 10px;
            font-weight: bold;
            border-radius: 4px;
        }
        .message {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h2>All Books</h2>

    <%
        String message = (String) request.getAttribute("message");

        if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
        } 
        if (booksList != null && !booksList.isEmpty()) {
    %>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Gender</th>
                <th>Address</th>
              <!--   <th>Action</th> -->
            </tr>
        </thead>
        <tbody>
            <% for (Book book : booksList) { %>
                <tr>
                    <td><%= book.getBookId() %></td>
                    <td><%= book.getTitle() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td><%= book.getCategory().toString() %></td>
                    <td><%= book.getStatus().toString() %></td>
                    <td><%= book.getAvailability().toString() %></td>
                    <%-- <td>
                        <form method="post" action="/deleteMember" style="display:inline;">
                            <input type="hidden" name="memberId" value="<%= member.getMemberId() %>"/>
                            <input type="submit" class="btn-delete" value="Delete"/>
                        </form>
                    </td> --%>
                </tr>
            <% } %>
        </tbody>
    </table>

    <% } else { %>
        <div>No Books found.</div>
    <% } %>

    <br>
    <a href="home.jsp">Home</a> |
    <a href="memberManagement.jsp">Back</a>
</body>
</html>
