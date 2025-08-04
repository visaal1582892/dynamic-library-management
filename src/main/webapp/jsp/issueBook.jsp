<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issue Book</title>
</head>
<body>
	<h2>Issue Book</h2>
	<form action="issueRecord" method="post">
		<label>Select Member:</label> <select name="member" required>
			<option value="" disabled selected> Select Member </option>
			<c:forEach var="member" items="${members}">
				<option value="${member.memberId}">${member.memberId}.
					${member.memberName}</option>
			</c:forEach>
		</select> <br> <label>Select Book:</label> <select name="book" required>
			<option value="" disabled selected> Select Book </option>
			<c:forEach var="book" items="${books}">
				<option value="${book.bookId}">${book.bookId}.
					${book.title}</option>
			</c:forEach>
		</select> <br> <input type="submit" value="Issue Book">
	</form>
</body>
</html>
