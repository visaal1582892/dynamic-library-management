<%@ page import="java.util.List" %>
<%@ page import="com.dynamic_library_management.domain.Member" %>
<%@ page import="com.dynamic_library_management.dao.implementation.MemberDaoImplementation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>View All Members</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #e0f7fa, #ffffff);
        }

        h2 {
            text-align: center;
            margin-top: 30px;
            color: #2c3e50;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }

        th {
            background-color: #00796b;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .btn-delete {
            background-color: #ef5350;
            color: white;
            border: none;
            padding: 6px 12px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-delete:hover {
            background-color: #d32f2f;
        }

        .message, .error {
            padding: 10px;
            border-radius: 4px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .message {
            background-color: #d0f0c0;
            color: #2e7d32;
        }

        .error {
            background-color: #ffcdd2;
            color: #c62828;
        }

        .nav-links {
            text-align: center;
            margin-top: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: #00796b;
            font-weight: bold;
            margin: 0 10px;
            padding: 8px 16px;
            border: 2px solid #00796b;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .nav-links a:hover {
            background-color: #00796b;
            color: white;
        }
    </style>
</head>
<body>

    <div class="container">
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

            MemberDaoImplementation dao = new MemberDaoImplementation();
            List<Member> members = dao.getAllMembers();

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
                    <%-- <th>Action</th> --%>
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
                        <%-- 
                        <td>
                            <form method="post" action="/deleteMember" style="display:inline;">
                                <input type="hidden" name="memberId" value="<%= member.getMemberId() %>"/>
                                <input type="submit" class="btn-delete" value="Delete"/>
                            </form>
                        </td> 
                        --%>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <% } else { %>
            <div class="error">No members found.</div>
        <% } %>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/jsp/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/jsp/memberManagement.jsp">Back</a>
        </div>
    </div>

</body>
</html>
