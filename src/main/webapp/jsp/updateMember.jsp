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
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background:
                linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .top-buttons {
            position: absolute;
            top: 20px;
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 0 20px;
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
            background: rgba(255, 255, 255, 0.95);
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            width: 550px;
        }

        h1 {
            text-align: center;
            color: #0d47a1;
            margin-bottom: 20px;
            border-bottom: 2px solid #90caf9;
            display: inline-block;
            padding-bottom: 10px;
            font-size: 28px;
            font-style: italic;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }

        input[readonly] {
            background-color: #f3f3f3;
        }

        .btn {
            margin-top: 20px;
            padding: 12px;
            width: 100%;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background-color: #64b5f6;
            color: white;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #42a5f5;
        }

        .message {
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
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
        String status = (String) request.getAttribute("status");
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
            <button type="submit" class="btn">Update</button>
        </div>
        <%
            }
        %>
    </form>
</div>
</body>
</html>
