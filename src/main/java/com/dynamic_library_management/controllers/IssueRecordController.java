package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import com.dynamic_library_management.dao.implementation.BookDaoImplementation;
import com.dynamic_library_management.dao.implementation.IssueRecordDaoImplementation;
import com.dynamic_library_management.dao.implementation.MemberDaoImplementation;
import com.dynamic_library_management.domain.Book;
import com.dynamic_library_management.domain.IssueRecord;
import com.dynamic_library_management.domain.Member;
import com.dynamic_library_management.exceptions.DatabaseException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/issueRecord")
public class IssueRecordController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			List<Member> members = new MemberDaoImplementation().getAllMembers();
			request.setAttribute("members", members);

			List<Book> books = new BookDaoImplementation().selectAllBooks();
			request.setAttribute("books", books);

			RequestDispatcher rd = request.getRequestDispatcher("jsp/issueBook.jsp");
			rd.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("status", "error");
			request.setAttribute("message", "Failed to load issue form.");
			request.getRequestDispatcher("jsp/issueBook.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int memberId = Integer.parseInt(request.getParameter("member"));
		int bookId = Integer.parseInt(request.getParameter("book"));

		IssueRecord issue = new IssueRecord(bookId, memberId, LocalDate.now());
		String print_message = new IssueRecordDaoImplementation().issueBook(issue);

		try {
			List<Member> members = new MemberDaoImplementation().getAllMembers();
			List<Book> books = new BookDaoImplementation().selectAllBooks();

			request.setAttribute("members", members);
			request.setAttribute("books", books);
			request.setAttribute("message", print_message);

			if ("Book issued successfully".equals(print_message)) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "error");
			}

			RequestDispatcher rd = request.getRequestDispatcher("jsp/issueBook.jsp");
			rd.forward(request, response);

		} catch (DatabaseException | SQLException e) {
			e.printStackTrace();
			request.setAttribute("status", "error");
			request.setAttribute("message", "An error occurred while issuing the book.");
			request.getRequestDispatcher("jsp/issueBook.jsp").forward(request, response);
		}
	}
}
