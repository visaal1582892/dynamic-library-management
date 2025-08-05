<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Issues</title>
<style>
        body {
            background: linear-gradient(to bottom right, #e3f2fd, #ffffff);
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h1 {
            text-align: center;
            font-size: 32px;
            font-style: italic;
            font-weight: bold;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #90caf9;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #bbdefb;
            font-weight: bold;
        }
    </style>
</head>
<body>
	<h1>All Issues</h1>
	<table>
		<tr>
			<th>Issue ID</th>
			<th>Book ID</th>
			<th>Member ID</th>
			<th>Status</th>
			<th>Issue Date</th>
			<th>Return date</th>
		</tr>
		<c:forEach var="issue" items="${issues}">
			<tr>
				<td><c:out value="${issue.issueId}" /></td>
				<td><c:out value="${issue.bookId}" /></td>
				<td><c:out value="${issue.memberId}" /></td>
				<td><c:out value="${issue.status}" /></td>
				<td><c:out value="${issue.issueDate}" /></td>
				<td><c:out value="${issue.returnDate}" /></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>