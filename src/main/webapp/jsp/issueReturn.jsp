<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issue / Return Book</title>
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

    .container {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px 60px;
        border-radius: 15px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        text-align: center;
        width: 400px;
    }

    h1 {
        font-size: 30px;
        color: #0d47a1;
        margin-bottom: 30px;
        border-bottom: 2px solid #90caf9;
        display: inline-block;
        padding-bottom: 10px;
    }

    .btn {
        display: block;
        margin: 15px auto;
        padding: 12px 30px;
        font-size: 18px;
        background-color: #64b5f6;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }

    .btn:hover {
        background-color: #42a5f5;
    }
</style>

</head>
<body>
    <!-- Back button outside the main container -->
    <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="back-btn">← Back</a>

    <!-- Main content container -->
    <div class="container">
        <h1>Issue / Return Book</h1>
        <a href="../issueRecord" class="btn">📚 Issue Book</a>
        <a href="../returnRecord" class="btn">🔄 Return Book</a>
        <a href="../viewIssues" class="btn">📖 View All Issues</a>
    </div>

	

</body>
</html>
