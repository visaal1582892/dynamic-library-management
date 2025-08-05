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

        .top-buttons {
            display: flex;
            justify-content: flex-end;
            padding: 20px;
            gap: 10px;
        }

        .btn-top {
            background-color: #bbdefb;
            color: #0d47a1;
            padding: 8px 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-top:hover {
            background-color: #90caf9;
        }

        .container {
            width: 760px;
            margin: 0 auto;
            padding-top: 10px;
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
        .message {
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            padding: 10px;
            border-radius: 10px;
            margin: 10px auto;
            width: fit-content;
        }

        .success {
            background-color: #c8e6c9;
            color: #1b5e20;
        }

        .error {
            background-color: #ffcdd2;
            color: #b71c1c;
        }
    </style>
</head>
<body>

<!-- Top Buttons -->
<div class="top-buttons">
    <a href="${pageContext.request.contextPath}/jsp/memberManagement.jsp" class="btn-top">← Back</a>
    <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="btn-top">🏠 Home</a>
</div>

<div class="container">

    <!-- Success or Error Message -->
    <%
        String msg = (String) request.getAttribute("message");
        String status = (String) request.getAttribute("status"); // "success" or "error"
        if (msg != null && !msg.isEmpty()) {
    %>
        <div class="message <%= "success".equalsIgnoreCase(status) ? "success" : "error" %>">
            <%= msg %>
        </div>
    <%
        }
    %>

    <!-- GET form to load member -->
    <form action="/dynamic-library-management/updateMemberController" method="get">
        <h1>UPDATE MEMBER DETAILS</h1>

        <div class="form-group">
            <label for="memberId">Select Member</label>
            <select name="memberId" onchange="this.form.submit()" required>
                <option value="">Select Member</option>
                <%
                    MemberDaoImplementation dao = new MemberDaoImplementation();
                    List<Member> members = dao.getAllMembers();
                    request.setAttribute("members", members);
                    List<Member> allmembers = (List<Member>) request.getAttribute("members");

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
        </div>
        <%
            }
        %>
    </form>
</div>
</body>
</html>
