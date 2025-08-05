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
<h1>Count of books per category</h1>
	<table border="3" style="margin: 0px auto;">
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