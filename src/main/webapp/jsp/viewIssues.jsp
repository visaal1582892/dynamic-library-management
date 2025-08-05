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
    </style>
</head>
<body>
	<h1>All Issues</h1>
	<table border="3" style="margin: 0px auto;">
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