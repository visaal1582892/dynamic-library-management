<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<h1>Members with Active Issued Books</h1>
	<table border="3" style="margin: 0px auto;">
		<tr>
			<th>Member ID</th>
			<th>Member Name</th>
			<th>Book Title</th>
			<th>Issue Status</th>
			<th>Book Status</th>
		</tr>
		<c:forEach var="issue" items="${activeIssues}">
			<tr>
				<td><c:out value="${issue[0]}" /></td>
				<td><c:out value="${issue[1]}" /></td>
				<td><c:out value="${issue[2]}" /></td>
				<td><c:out value="${issue[3]}" /></td>
				<td><c:out value="${issue[4]}" /></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>