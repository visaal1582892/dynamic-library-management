package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

import com.dynamic_library_management.dao.implementation.BookDaoImplementation;
import com.dynamic_library_management.dao.implementation.MemberDaoImplementation;
import com.dynamic_library_management.domain.Book;
import com.dynamic_library_management.domain.IssueRecord;
import com.dynamic_library_management.domain.Member;
import com.dynamic_library_management.services.implementation.IssueRecordServiceImplementation;

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

		System.out.println("inside get");
		try {

			List<Member> members = new MemberDaoImplementation().getAllMembers();
			System.out.println("Members fetched: " + members.size());
			request.setAttribute("members", members);

			List<Book> books = new BookDaoImplementation().selectAllBooks();
			System.out.println("Books fetched: " + books.size());
			request.setAttribute("books", books);

			RequestDispatcher rd = request.getRequestDispatcher("jsp/issueBook.jsp");
			rd.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("inside post");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		int memberId = Integer.parseInt(request.getParameter("member"));
		int bookId = Integer.parseInt(request.getParameter("book"));

		out.println("<p>Selected Member ID: " + memberId + "</p>");
		out.println("<p>Selected Book ID: " + bookId + "</p>");

		IssueRecord issue = new IssueRecord(bookId, memberId, LocalDate.now());
		String print_message = new IssueRecordServiceImplementation().issueBook(issue);
		out.println("<h2>" + print_message + "</h2>");
	}

}
