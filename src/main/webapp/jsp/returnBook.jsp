<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
Return Book
<form action="returnRecord" method="post">

    <label>Select Member:</label>
    <select name="memberId" required>
        <option value="">--Select Member--</option>
        <c:forEach var="m" items="${members}">
            <option value="${m.memberId}" ${selectedMemberId == m.memberId ? "selected" : ""}>
                ${m.memberName}
            </option>
        </c:forEach>
    </select>
    <br><br>

    <c:if test="${step == 'book'}">
        <label>Select Book to Return:</label>
        <select name="bookId" required>
            <option value="">--Select Book--</option>
            <c:forEach var="b" items="${books}">
                <option value="${b.bookId}">${b.title}</option>
            </c:forEach>
        </select>
        <br><br>
        <input type="submit" formaction="finalReturn" value="Return Book">
    </c:if>

    <c:if test="${step != 'book'}">
        <input type="submit" value="Next">
    </c:if>
</form>
</body>
</html>