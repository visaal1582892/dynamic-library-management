<%@ page import="java.util.List" %>
<%@ page import="com.dynamic_library_management.domain.Member" %>
<%@ page import="com.dynamic_library_management.dao.implementation.MemberDaoImplementation"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>View All Members</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 10px;
            text-align: left;
        }
        .btn-delete {
            background-color: #ef5350;
            color: white;
            border: none;
            padding: 5px 10px;
            font-weight: bold;
            border-radius: 4px;
        }
        .message {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>All Members</h2>

    <%
        String success = (String) session.getAttribute("successMessage");
        String error = (String) session.getAttribute("errorMessage");
        session.removeAttribute("successMessage");
        session.removeAttribute("errorMessage");

        if (success != null) {
    %>
        <div class="message"><%= success %></div>
    <%
        } else if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
        MemberDaoImplementation dao=new MemberDaoImplementation();
       List<Member> members=dao.getAllMembers();
        if (members != null && !members.isEmpty()) {
    %>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Mobile</th>
                <th>Gender</th>
                <th>Address</th>
              <!--   <th>Action</th> -->
            </tr>
        </thead>
        <tbody>
            <% for (Member member : members) { %>
                <tr>
                    <td><%= member.getMemberId() %></td>
                    <td><%= member.getMemberName() %></td>
                    <td><%= member.getMemberMail() %></td>
                    <td><%= member.getMobileNo() %></td>
                    <td><%= member.getGender() %></td>
                    <td><%= member.getMemberAddress() %></td>
                    <%-- <td>
                        <form method="post" action="/deleteMember" style="display:inline;">
                            <input type="hidden" name="memberId" value="<%= member.getMemberId() %>"/>
                            <input type="submit" class="btn-delete" value="Delete"/>
                        </form>
                    </td> --%>
                </tr>
            <% } %>
        </tbody>
    </table>

    <% } else { %>
        <div>No members found.</div>
    <% } %>

    <br>
    <a href="${pageContext.request.contextPath}/jsp/index.jsp">Home</a> |
    <a href="${pageContext.request.contextPath}/jsp/memberManagement.jsp">Back</a>
</body>
</html>
