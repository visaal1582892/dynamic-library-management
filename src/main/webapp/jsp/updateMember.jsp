<%@ page import="java.util.List" %>
<%@ page import="com.dynamic_library_management.domain.Member" %>
<%@ page import="com.dynamic_library_management.dao.implementation.MemberDaoImplementation"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Member</title>
    <style>
        body {
            background: linear-gradient(to bottom, #e3f2fd, #ffffff);
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            width: 760px;
            margin: 0 auto;
            padding-top: 30px;
        }
        h1 {
            text-align: center;
            color: #2090bc;
            font-style: italic;
            text-decoration: underline;
            font-size: 30px;
        }
        .form-group {
            margin: 20px;
            font-size: 20px;
        }
        label {
            display: block;
            font-style: italic;
            font-size: 20px;
            margin-bottom: 5px;
        }
        input, select {
            width: 60%;
            padding: 10px;
            border-radius: 10px;
            font-size: 14px;
        }
        .btn {
            margin: 15px 5px;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-update { background-color: lightblue; }
        .btn-back { background-color: #bbdefb; color: #0d47a1; }
        .btn-home { background-color: #c8e6c9; color: #1b5e20; }
        .message {
            text-align: center;
            font-size: 20px;
            color: red;
        }
    </style>
</head>
<body>
<div class="container">

    <!-- GET form to load member -->
    <form action="/dynamic-library-management/updateMemberController" method="get">
        <h1>UPDATE MEMBER DETAILS</h1>

        <div class="form-group">
            <label for="memberId">Select Member</label>
            <select name="memberId" onchange="this.form.submit()">
                <option value="">-- Select Member --</option>
                <%
                MemberDaoImplementation dao=new MemberDaoImplementation();
                    List<Member> allmembers = dao.getAllMembers();
                    Member selected = (Member) request.getAttribute("selectedMember");
                    int selectedId = (selected != null) ? selected.getMemberId() : -1;

                    if (allmembers != null && !allmembers.isEmpty()) {
                        for (Member m : allmembers) {
                            String selectedAttr = (m.getMemberId() == selectedId) ? "selected" : "";
                %>
                <option value="<%= m.getMemberId() %>" <%= selectedAttr %>>
                    <%= m.getMemberName() %> (ID: <%= m.getMemberId() %>)
                </option>
                <%
                        }
                    } else {
                %>
                <option disabled>No members found</option>
                <%
                    }
                %>
            </select>
        </div>
    </form>

    <!-- POST form to update member -->
    <form action="/dynamic-library-management/updateMemberController" method="post">
        <%
            if (selected != null) {
        %>
        <input type="hidden" name="memberId" value="<%= selected.getMemberId() %>" />

        <div class="form-group">
            <label>Name</label>
            <input type="text" name="name" value="<%= selected.getMemberName() %>" required />
        </div>
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" value="<%= selected.getMemberMail() %>" required />
        </div>
        <div class="form-group">
            <label>Mobile No</label>
            <input type="text" name="mobile" value="<%= selected.getMobileNo() %>" required />
        </div>
        <div class="form-group">
            <label>Gender</label>
            <input type="text" name="genderDisplay" value="<%= selected.getGender() %>" readonly />
            <input type="hidden" name="gender" value="<%= selected.getGender() %>" />
        </div>
        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address" value="<%= selected.getMemberAddress() %>" required />
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-update">Update</button>
            <a href="home.jsp" class="btn btn-home">Home </a>
            <a href="memberManagement.jsp" class="btn btn-back">← Back</a>
        </div>
        <% } %>

        <%
            String msg = (String) request.getAttribute("message");
            if (msg != null) {
        %>
        <p class="message"><%= msg %></p>
        <% } %>
    </form>
</div>
</body>
</html>
