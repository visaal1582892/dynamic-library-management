package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dynamic_library_management.domain.Member;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.services.implementation.MemberServiceImplementation;

@WebServlet("/viewAllMembers")
public class ViewAllMembersController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Member> members = new MemberServiceImplementation().validateViewAllMembers();
            request.setAttribute("members", members);
            request.getRequestDispatcher("/viewAllMembers.jsp").forward(request, response);
        } catch (DatabaseException e) {
            request.setAttribute("errorMessage", "Cannot Fetch Members Data...");
            request.getRequestDispatcher("/viewAllMembers.jsp").forward(request, response);
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
