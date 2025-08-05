package com.dynamic_library_management.controllers;

import java.io.IOException;

import com.dynamic_library_management.dao.implementation.BookDaoImplementation;
import com.dynamic_library_management.domain.Book;
import com.dynamic_library_management.exceptions.DatabaseException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteBookController")
public class DeleteBookController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String bookIdParam = req.getParameter("bookId");

		try {
			int bookId = Integer.parseInt(bookIdParam);

			BookDaoImplementation bookDao = new BookDaoImplementation();
			Book fullBook = bookDao.selectBookById(bookId);

			if (fullBook != null) {
				// Step 2: Delete using DAO (which also logs the book)
				bookDao.deleteBook(fullBook);
				req.setAttribute("message", "Book Deleted Successfully...");
				req.setAttribute("messageColor", "green");
			} else {
				req.setAttribute("message", "Book not found in the database.");
				req.setAttribute("messageColor", "red");
			}

		} catch (NumberFormatException e) {
			req.setAttribute("message", "Invalid Book ID.");
			req.setAttribute("messageColor", "red");
		} catch (DatabaseException e) {
			req.setAttribute("message", "Error deleting book: " + e.getMessage());
			req.setAttribute("messageColor", "red");
		}

		resp.sendRedirect("viewAllBooksController");
	}
}
