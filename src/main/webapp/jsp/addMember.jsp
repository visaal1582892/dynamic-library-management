<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Form</title>
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

        .home-btn, .back-btn {
            position: absolute;
            top: 20px;
            padding: 8px 16px;
            font-weight: bold;
            border-radius: 8px;
            border: none;
            text-decoration: none;
        }

        .home-btn {
            right: 20px;
            background-color: #c8e6c9;
            color: #1b5e20;
        }

        .back-btn {
            left: 20px;
            background-color: #bbdefb;
            color: #0d47a1;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            width: 500px;
        }

        h1 {
            text-align: center;
            color: #0d47a1;
            margin-bottom: 20px;
            border-bottom: 2px solid #90caf9;
            display: inline-block;
            padding-bottom: 10px;
        }

        .message {
            text-align: center;
            color: #d32f2f;
            font-size: 16px;
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-size: 16px;
            font-weight: bold;
        }

        input[type="text"], select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }

        .btn {
            margin-top: 25px;
            padding: 12px;
            width: 100%;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background-color: #64b5f6;
            color: white;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #42a5f5;
        }
    </style>
</head>
<body>

    <!-- Home and Back Buttons -->
    <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="home-btn">Home</a>
    <a href="${pageContext.request.contextPath}/jsp/memberManagement.jsp" class="back-btn">Back</a>

    <div class="container">
        <h1>REGISTRATION FORM</h1>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <form action="/dynamic-library-management/addMemberController" method="post">
            <label>Name:</label>
            <input type="text" name="name" placeholder="Enter Your Name" required />

            <label>Email Id:</label>
            <input type="text" name="email" placeholder="Enter Your Email Id" required />

            <label>Mobile No.:</label>
            <input type="text" name="mobile" placeholder="Enter Your Mobile Number" required />

            <label>Gender:</label>
            <select name="gender" required>
                <option value="">Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>

            <label>Address:</label>
            <input type="text" name="address" placeholder="Enter Your Address" required />

            <input type="submit" value="Register" class="btn" />
        </form>
    </div>

</body>
</html>
