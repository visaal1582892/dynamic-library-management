package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.sql.SQLException;

import com.dynamic_library_management.constants.MemberGender;
import com.dynamic_library_management.dao.implementation.MemberDaoImplementation;
import com.dynamic_library_management.domain.Member;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.exceptions.InvalidDetailsException;
import com.dynamic_library_management.services.implementation.MemberServiceImplementation;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateMemberController")
public class UpdateMemberController extends HttpServlet {

	private final MemberDaoImplementation dao = new MemberDaoImplementation();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String idStr = request.getParameter("memberId");
			if (idStr != null && !idStr.isEmpty()) {
				int id = Integer.parseInt(idStr);
				Member selected = dao.selectMemberById(id);
				request.setAttribute("selectedMember", selected);
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/updateMember.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException | DatabaseException e) {
			e.printStackTrace();
			throw new ServletException("Error loading members", e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int memberId = Integer.parseInt(request.getParameter("memberId"));
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String mobile = request.getParameter("mobile");
			String address = request.getParameter("address");
			MemberGender gender = MemberGender.getEnumConstant(request.getParameter("gender"));

			Member updatedMember = new Member(memberId, name, email, mobile, gender, address);

			new MemberServiceImplementation().validateUpdateMemberDetails(updatedMember);

			request.setAttribute("message", "Member updated successfully!");
			request.setAttribute("status", "success");
			request.setAttribute("selectedMember", updatedMember);
			request.setAttribute("members", dao.getAllMembers());

		} catch (InvalidDetailsException e) {
			request.setAttribute("message", e.getMessage());
			request.setAttribute("status", "error");
		} catch (SQLException | DatabaseException | NumberFormatException e) {
			request.setAttribute("message", "Failed to update member. Please try again.");
			request.setAttribute("status", "error");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/updateMember.jsp");
		dispatcher.forward(request, response);
	}

}