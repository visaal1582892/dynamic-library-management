<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issue Book</title>
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

.form-group {
	display: flex;
	align-items: center;
	margin-top: 15px;
}

.form-group label {
	width: 150px;
	font-size: 18px;
	font-style: italic;
}

.form-group select {
	flex: 1;
	padding: 6px;
	font-size: 16px;
}

.register-btn {
	background-color: lightblue;
	padding: 10px 20px;
	margin-top: 20px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.register-btn:hover {
	background-color: #90caf9;
}

.message {
	font-size: 18px;
	margin-top: 10px;
	font-weight: bold;
	text-align: center;
}

.success {
	color: green;
}

.error {
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<h1>Issue Book</h1>
		<form action="issueRecord" method="post">
			<div class="form-group">
				<label>Select Member:</label> <select name="member" required>
					<option value="" disabled selected>Select Member</option>
					<c:forEach var="member" items="${members}">
						<option value="${member.memberId}">${member.memberId}.
							${member.memberName}</option>
					</c:forEach>
				</select>
			</div>

			<div class="form-group">
				<label>Select Book:</label> <select name="book" required>
					<option value="" disabled selected>Select Book</option>
					<c:forEach var="book" items="${books}">
						<option value="${book.bookId}">${book.bookId}.
							${book.title}</option>
					</c:forEach>
				</select>
			</div>

			<div style="text-align: center;">
				<input type="submit" value="Issue Book" class="btn register-btn">
			</div>
		</form>
		<c:if test="${not empty message}">
			<p class="message ${status}">${message}</p>
		</c:if>
	</div>
</body>
</html>
