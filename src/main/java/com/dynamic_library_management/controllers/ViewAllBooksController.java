package com.dynamic_library_management.controllers;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ViewAllBooksController
 */
@WebServlet("/ViewAllBooksController")
public class ViewAllBooksController extends HttpServlet {
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
	 * @see HttpServlet#HttpServlet()
	 */
	public ViewAllBooksController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			setSuccess(true);
			setMessage("Book Updated Succesfully...");
		} catch (Exception e) {
			setSuccess(false);
			setMessage("Failed To Fetch Books...");
		} finally {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/viewAllBooks.jsp");
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
