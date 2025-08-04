<%@page import="com.dynamic_library_management.domain.BookCategory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	List<BookCategory> categoryList = List.of(BookCategory.values());
	request.setAttribute("categoryList", categoryList);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <link rel="stylesheet" type="text/css" href="../css/commonForm.css">
</head>
<body>
    <main id="main-container">
        <h1>Add Book</h1>
        <form action="${pageContext.request.contextPath}/addBookController" method="post">
            <div class="input-container">
                <label>Title:</label>
                <input name="title" required />
            </div>
            <div class="input-container">
                <label>Author:</label>
                <input name="author" required />
            </div>
            <div class="input-container">
                <label>Category:</label>
                <select name="category" required>
                    <option>Select Category</option>
                    <c:forEach items="${categoryList}" var="category">
                        <option value="${category.getStringValue()}">${category.toString()}</option>
                    </c:forEach>
                </select>
            </div>
            <input class="submit-btn" type="submit" value="Add Book" />
        </form>
    </main>
</body>
</html>
