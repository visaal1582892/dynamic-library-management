<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.btn {
	display: inline-block;
	margin: 20px auto;
	padding: 15px 60px;
	font-size: 25px;
	background-color: lightblue;
	border: none;
	border-radius: 10px;
	box-shadow: 2px 2px 5px gray;
	font-style: italic;
	cursor: pointer;
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<h1>Issue / Return Book</h1>
	<a href="../issueRecord" class="btn">Issue Book</a>
	<br>
	<a href="../returnRecord" class="btn">Return Book</a>
	<br>
	<a href="../viewIssues" class="btn">View All Issues</a>
</body>
</html>