package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.sql.SQLException;

import com.dynamic_library_management.constants.MemberGender;
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

/**
 * Servlet implementation class AddBookController
 */
@WebServlet("/addMemberController")
public class AddMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean success;
	private String message;

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mobileno = request.getParameter("mobile");
		MemberGender gender = MemberGender.getEnumConstant(request.getParameter("gender"));
		String address = request.getParameter("address");
		try {
			new MemberServiceImplementation().addMember(new Member(name, email, mobileno, gender, address));
			setSuccess(true);
			setMessage("Member Added Succesfully...");
		} catch (InvalidDetailsException | DatabaseException e) {
			setSuccess(false);
			setMessage(e.getMessage());

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/addMember.jsp");
			request.setAttribute("message", getMessage());
			request.setAttribute("success", isSuccess());
			if (isSuccess()) {
				requestDispatcher.forward(request, response);
			} else {
				requestDispatcher.include(request, response);
			}

		}
	}

}