<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Members with Active Issued Books</title>
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
    <h1>Members with Active Issued Books</h1>

    <table>
        <thead>
            <tr>
                <th>Member ID</th>
                <th>Member Name</th>
                <th>Book Title</th>
                <th>Issue Status</th>
                <th>Book Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="issue" items="${activeIssues}">
                <tr>
                    <td><c:out value="${issue[0]}" /></td>
                    <td><c:out value="${issue[1]}" /></td>
                    <td><c:out value="${issue[2]}" /></td>
                    <td>
                        <c:choose>
                            <c:when test="${issue[3] == 'I'}">Issued</c:when>
                            <c:when test="${issue[3] == 'R'}">Returned</c:when>
                            <c:otherwise>Unknown</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${issue[4] == 'I'}">Inactive</c:when>
                            <c:when test="${issue[4] == 'A'}">Active</c:when>
                            <c:otherwise>Unknown</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty activeIssues}">
                <tr>
                    <td colspan="5" style="text-align:center; padding: 20px; font-style: italic; color: #555;">
                        No active issues found.
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/jsp/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/jsp/reports.jsp">Back</a>
    </div>
</div>

</body>
</html>
