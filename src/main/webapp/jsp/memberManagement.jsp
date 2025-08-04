<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Member Management Options</title>
    <style>
        body {
            background: linear-gradient(to bottom, #e3f2fd, #ffffff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            width: 760px;
            margin: 60px auto;
            padding: 40px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        h1 {
            color: #2090bc;
            font-size: 33px;
            font-style: italic;
            font-weight: bold;
            text-decoration: underline;
        }

        .btn {
            display: block;
            width: 310px;
            margin: 20px auto;
            padding: 15px;
            background-color: lightblue;
            border: none;
            border-radius: 10px;
            font-size: 25px;
            font-style: italic;
            font-weight: bold;
            color: #003366;
            cursor: pointer;
            transition: box-shadow 0.3s ease;
        }

        .btn:hover {
            box-shadow: 2px 2px 5px gray;
        }

        .back-btn {
            position: absolute;
            left: 20px;
            top: 20px;
            padding: 8px 16px;
            background-color: #bbdefb;
            color: #0d47a1;
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

<a href="${pageContext.request.contextPath}/jsp/index.jsp" class="back-btn">← Back</a>

<div class="container">
    <h1>MEMBER MANAGEMENT OPTIONS</h1>

    <form action="addMember.jsp" method="get">
        <button type="submit" class="btn">Register Member</button>
    </form>

    <form action="updateMember.jsp" method="get">
        <button type="submit" class="btn">Update Member</button>
    </form>

    <form action="viewAllMembers.jsp" method="get">
        <button type="submit" class="btn">View All Members</button>
    </form>
</div>

</body>
</html>
