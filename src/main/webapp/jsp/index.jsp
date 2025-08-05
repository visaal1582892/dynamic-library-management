<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Library Management System</title>
    <style>
        body {
            background: linear-gradient(to bottom, #e3f2fd, #ffffff);
            font-family: 'Arial', sans-serif;
            text-align: center;
            padding-top: 40px;
        }

        h1 {
            color: #2090bc;
            font-size: 33px;
            font-style: italic;
            font-weight: bold;
            text-decoration: underline;
        }

        .btn {
            display: inline-block;
            margin: 20px auto;
            padding: 15px 60px;
            font-size: 25px;
            background-color: lightblue;
            border: none;
            border-radius: 10px;
            box-shadow: 2px 2px 5px gray;
            font-style: italic;
            cursor: pointer;
            text-decoration: none;
            color: black;
        }

        .container {
            width: 100%;
            max-width: 760px;
            margin: auto;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>LIBRARY MANAGEMENT SYSTEM</h1>

    <a href="bookOptions.jsp" class="btn">Book Management</a><br>
    <a href="memberManagement.jsp" class="btn">Member Management</a><br>
    <a href="issueReturn.jsp" class="btn">Issue & Return Books</a><br>
    <a href="reports.jsp" class="btn">Reports</a>
</div>

</body>
</html>
