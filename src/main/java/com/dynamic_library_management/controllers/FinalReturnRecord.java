package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import com.dynamic_library_management.dao.implementation.IssueRecordDaoImplementation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/finalReturn")
public class FinalReturnRecord extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			response.setContentType("text/html");
			PrintWriter out = response.getWriter();

			int memberId = Integer.parseInt(request.getParameter("memberId"));
			int bookId = Integer.parseInt(request.getParameter("bookId"));

			String message = new IssueRecordDaoImplementation().returnBook(memberId, bookId);
			out.println("<h2>" + message + "</h2>");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
