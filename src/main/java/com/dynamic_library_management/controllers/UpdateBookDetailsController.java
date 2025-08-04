package com.dynamic_library_management.controllers;

import java.io.IOException;

import com.dynamic_library_management.domain.BookCategory;
import com.dynamic_library_management.domain.BookStatus;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.exceptions.InvalidDetailsException;
import com.dynamic_library_management.services.implementation.BookServiceImplementation;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateBookDetailsController
 */
@WebServlet("/updateBookDetailsController")
public class UpdateBookDetailsController extends HttpServlet {
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
	public UpdateBookDetailsController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("bookId").split(",")[0]);
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		BookCategory category = BookCategory.getEnumConstant(request.getParameter("category"));
		BookStatus status = BookStatus.getEnumConstant(request.getParameter("status"));

		System.out.println(id + title + author + category + status);

		try {
			new BookServiceImplementation().validateUpdateBookDetails(id, title, author, category, status);
			setSuccess(true);
			setMessage("Book Updated Succesfully...");
//			ResponseHandler.showResponse(message, "Book Added Succesfully...", Color.GREEN);
		} catch (InvalidDetailsException | DatabaseException e) {
			setSuccess(false);
			setMessage(e.getMessage());
//			ResponseHandler.showResponse(message, e.getMessage(), Color.RED);
		} finally {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("jsp/response.jsp");
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
