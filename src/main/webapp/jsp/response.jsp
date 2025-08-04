<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Response</title>
    <link rel="stylesheet" type="text/css" href="css/response.css">
</head>
<body>
    <main id="main-container">
        <h1 class="<%= (Boolean.TRUE.equals(request.getAttribute("success")) ? "success" : "error") %>">
            <%= (Boolean.TRUE.equals(request.getAttribute("success")) ? "Success" : "Failed") %>
        </h1>

        <div class="message <%= (Boolean.TRUE.equals(request.getAttribute("success")) ? "success" : "error") %>">
            <%= request.getAttribute("message") %>
        </div>

        <a href="html/bookOptions.html">← Back To Book Options</a>
    </main>
</body>
</html>
