<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<h1>Members with Active Issued Books</h1>
	<table>
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
				<td><c:choose>
						<c:when test="${issue[3] == 'I'}">Issued</c:when>
						<c:when test="${issue[3] == 'R'}">Returned</c:when>
						<c:otherwise>Unknown</c:otherwise>
					</c:choose></td>
				<td><c:choose>
						<c:when test="${issue[4] == 'I'}">Inactive</c:when>
						<c:when test="${issue[4] == 'A'}">Active</c:when>
						<c:otherwise>Unknown</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>