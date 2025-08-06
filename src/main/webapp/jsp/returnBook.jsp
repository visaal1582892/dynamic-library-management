<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Return Book</title>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
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
	cursor: pointer;
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

label {
	display: block;
	margin-top: 15px;
	font-size: 16px;
	font-weight: bold;
	color: #333;
}

select {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border-radius: 8px;
	border: 1px solid #ccc;
	margin-top: 5px;
	font-family: inherit;
	outline: none;
	transition: border-color 0.3s ease;
}

select:focus {
	border-color: #64b5f6;
	box-shadow: 0 0 5px rgba(100, 181, 246, 0.5);
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
	font-family: inherit;
	font-weight: bold;
}

.btn:hover {
	background-color: #42a5f5;
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

	<a href="${pageContext.request.contextPath}/jsp/index.jsp"
		class="home-btn">Home</a>
	<a href="${pageContext.request.contextPath}/jsp/issueReturn.jsp"
		class="back-btn">Back</a>

	<div class="container">
		<h1>Return Book</h1>
		<form action="returnRecord" method="post">

			<label>Select Member:</label> <select name="memberId" required>
				<option value="">Select Member</option>
				<c:forEach var="m" items="${members}">
					<option value="${m.memberId}"
						${selectedMemberId == m.memberId ? "selected" : ""}>${m.memberName}</option>
				</c:forEach>
			</select>

			<c:if test="${step == 'book'}">
				<label>Select Book:</label>
				<select name="bookId" required>
					<option value="">Select Book</option>
					<c:forEach var="b" items="${books}">
						<option value="${b.bookId}">${b.title}</option>
					</c:forEach>
				</select>
			</c:if>

			<c:choose>
				<c:when test="${step == 'book'}">
					<input type="submit" class="btn" formaction="finalReturn"
						value="Return Book" />
				</c:when>
				<c:otherwise>
					<input type="submit" class="btn" value="Next" />
				</c:otherwise>
			</c:choose>

		</form>

		<c:if test="${not empty message}">
			<p class="message ${status}">${message}</p>
		</c:if>
	</div>

</body>
</html>
