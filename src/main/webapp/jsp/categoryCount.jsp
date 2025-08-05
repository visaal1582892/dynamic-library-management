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
<h1>Count of books per category</h1>
	<table>
		<tr>
			<th>Category</th>
            <th>Count</th>
		</tr>
		<c:forEach var="entry" items="${categoryCountMap}">
            <tr>
                <td>${entry.key}</td>
                <td>${entry.value}</td>
            </tr>
        </c:forEach>
	</table>

</body>
</html>