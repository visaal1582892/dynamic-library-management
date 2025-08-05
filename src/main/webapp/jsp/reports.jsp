<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reports</title>
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

    .container {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        width: 500px;
        text-align: center;
    }

    h1 {
        color: #0d47a1;
        margin-bottom: 30px;
        border-bottom: 2px solid #90caf9;
        display: inline-block;
        padding-bottom: 10px;
        font-style: italic;
        font-weight: bold;
        font-size: 33px;
    }

    .btn {
        display: block;
        margin: 20px auto;
        padding: 15px 60px;
        font-size: 18px;
        background-color: #64b5f6;
        border: none;
        border-radius: 8px;
        box-shadow: 2px 2px 5px gray;
        font-style: italic;
        cursor: pointer;
        text-decoration: none;
        color: white;
        transition: background-color 0.3s ease;
        width: fit-content;
        min-width: 280px;
    }

    .btn:hover {
        background-color: #42a5f5;
        color: white;
        text-decoration: none;
    }
    
    .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            padding: 8px 16px;
            background-color: rgba(255, 255, 255, 0.8);
            color: #0d47a1;
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
</style>
</head>
<body>
<a href="${pageContext.request.contextPath}/jsp/index.jsp" class="back-btn">← Back</a>

<div class="container">
    <h1>Reports</h1>
    <a href="../overdueRecords" class="btn">List of Overdue Books</a>
    <a href="../categoryCount" class="btn">Count of Books per Category</a>
    <a href="../activeIssuedRecords" class="btn">List of Members with Active Issued Books</a>
</div>

</body>
</html>
