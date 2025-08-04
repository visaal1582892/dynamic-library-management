<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Form</title>
    <style>
        body {
            background: linear-gradient(to bottom, #e3f2fd, #ffffff);
            font-family: Arial, sans-serif;
        }
        .container {
            width: 600px;
            margin: 50px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }
        h1 {
            text-align: center;
            color: #2090bc;
            text-decoration: underline;
            font-style: italic;
        }
        .message {
            text-align: center;
            color: #d32f2f;
            font-size: 18px;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-size: 18px;
            font-style: italic;
        }
        input[type="text"], select {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
        }
        .register-btn {
            background-color: lightblue;
        }
        .back-btn, .home-btn {
            position: absolute;
            top: 20px;
            padding: 5px 15px;
            font-weight: bold;
            border-radius: 8px;
            border: none;
        }
        .back-btn {
            left: 20px;
            background-color: #bbdefb;
            color: #0d47a1;
        }
        .home-btn {
            right: 20px;
            background-color: #c8e6c9;
            color: #1b5e20;
        }
    </style>
</head>
<body>

    <!-- Back and Home Buttons -->
    <a href="${pageContext.request.contextPath}/jsp/index.jsp">Home</a> |
    <a href="${pageContext.request.contextPath}/jsp/memberManagement.jsp">Back</a>

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

            <input type="submit" value="Register" class="btn register-btn" />
        </form>
    </div>

</body>
</html>
