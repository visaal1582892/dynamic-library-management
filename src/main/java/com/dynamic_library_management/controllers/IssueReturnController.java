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

/**
 * Servlet implementation class IssueReturnController
 */
@WebServlet("/issuesAndReturns/*")
public class IssueReturnController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String pathInfo = request.getPathInfo();

		if (pathInfo != null) {
			if (pathInfo.equals("/issueRecord")) {

				try {
					// Fetch all members and books to display on the issue book form
					List<Member> members = new MemberDaoImplementation().getAllMembers();
					List<Book> books = new BookDaoImplementation().selectAllBooks();

					request.setAttribute("members", members);
					request.setAttribute("books", books);

					// Forward to issueBook.jsp to display the form
					RequestDispatcher rd = request.getRequestDispatcher("../jsp/issueBook.jsp");
//					RequestDispatcher rd = request.getRequestDispatcher("../jsp/issueBookChanges.jsp");
					rd.forward(request, response);

				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("status", "error");
					request.setAttribute("message", "Failed to load issue form.");				
				request.getRequestDispatcher("../jsp/issueBook.jsp").forward(request, response);
//					request.getRequestDispatcher("../jsp/issueBookChanges.jsp").forward(request, response);
				}
			} else if (pathInfo.equals("/returnRecord")) {
				try {
					List<Member> members = new MemberDaoImplementation().getAllMembers();
					request.getSession().setAttribute("members", members);
					request.setAttribute("step", "member");

					RequestDispatcher rd = request.getRequestDispatcher("../jsp/returnBook.jsp");
					rd.forward(request, response);

				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("status", "error");
					request.setAttribute("message", "Failed to load return form.");
					request.getRequestDispatcher("../jsp/returnBook.jsp").forward(request, response);
				}
			} else if (pathInfo.equals("/viewIssues")) {
//				System.out.println("inside get");
				try {

					List<IssueRecord> issues = new IssueRecordDaoImplementation().getAllIssues();
//					System.out.println("Members fetched: " + issues.size());
					request.setAttribute("issues", issues);

					RequestDispatcher rd = request.getRequestDispatcher("../jsp/viewIssues.jsp");
					rd.forward(request, response);

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Path not found.");
			}
		} else {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request.");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pathInfo = request.getPathInfo();

		if (pathInfo != null) {
			if (pathInfo.equals("/issueRecord")) {

				try {
					List<Member> members = new MemberDaoImplementation().getAllMembers();
					List<Book> books = new BookDaoImplementation().selectAllBooks();

					request.setAttribute("members", members);
					request.setAttribute("books", books);
					
					int memberId = -1;
					int bookId = -1;
					boolean memberError = false;
					boolean bookError = false;

					try {
						memberId = Integer.parseInt(request.getParameter("member"));
					} catch (NumberFormatException e) {
						memberError = true;
					}

					try {
						bookId = Integer.parseInt(request.getParameter("book"));
					} catch (NumberFormatException e) {
						bookError = true;
					}

					if (memberError && bookError) {
						request.setAttribute("status", "error");
						request.setAttribute("message", "Invalid member and book");				
						request.getRequestDispatcher("../jsp/issueBook.jsp").forward(request, response);
//						request.getRequestDispatcher("../jsp/issueBookChanges.jsp").forward(request, response);
						return;
					} else if (memberError) {
						request.setAttribute("status", "error");
						request.setAttribute("message", "Invalid member");				
						request.getRequestDispatcher("../jsp/issueBook.jsp").forward(request, response);
//						request.getRequestDispatcher("../jsp/issueBookChanges.jsp").forward(request, response);
						return;
					} else if (bookError) {
						request.setAttribute("status", "error");
						request.setAttribute("message", "Invalid book");				
						request.getRequestDispatcher("../jsp/issueBook.jsp").forward(request, response);
//						request.getRequestDispatcher("../jsp/issueBookChanges.jsp").forward(request, response);
						return;
					}

//					System.out.println(memberId + " - " + bookId);
					IssueRecord issue = new IssueRecord(bookId, memberId, LocalDate.now());
					String print_message = new IssueRecordDaoImplementation().issueBook(issue);

					// After issuing, reload members and books to show in the form again

					request.setAttribute("message", print_message);

					if ("Book issued successfully".equals(print_message)) {
						request.setAttribute("status", "success");
					} else {
						request.setAttribute("status", "error");
					}

					RequestDispatcher rd = request.getRequestDispatcher("../jsp/issueBook.jsp");
//					RequestDispatcher rd = request.getRequestDispatcher("../jsp/issueBookChanges.jsp");
					rd.forward(request, response);

				} catch (DatabaseException | SQLException e) {
					e.printStackTrace();
					request.setAttribute("status", "error");
					request.setAttribute("message", "An error occurred while issuing the book.");
					request.getRequestDispatcher("../jsp/issueBook.jsp").forward(request, response);
//					request.getRequestDispatcher("../jsp/issueBookChanges.jsp").forward(request, response);

				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("status", "error");
					request.setAttribute("message", "Unexpected error occurred.");					
				request.getRequestDispatcher("../jsp/issueBook.jsp").forward(request, response);
//					request.getRequestDispatcher("../jsp/issueBookChanges.jsp").forward(request, response);
				}

			} else if (pathInfo.equals("/returnRecord")) {

				String selectedMemberId = request.getParameter("memberId");
				if (selectedMemberId != null && !selectedMemberId.isEmpty()) {
					int memberId = Integer.parseInt(selectedMemberId);

//					System.out.println(memberId);
					try {
						List<Member> members = new MemberDaoImplementation().getAllMembers();
						request.setAttribute("members", members);
						request.setAttribute("selectedMemberId", memberId);

						List<Book> issuedBooks = new BookDaoImplementation().selectAllMemberBooks(memberId);
						request.setAttribute("books", issuedBooks);
						request.setAttribute("step", "book");
						request.getRequestDispatcher("../jsp/returnBook.jsp").forward(request, response);

					} catch (DatabaseException | SQLException e) {
						e.printStackTrace();
						request.setAttribute("status", "error");
						request.setAttribute("message", "Database error occurred.");
						request.getRequestDispatcher("../jsp/returnBook.jsp").forward(request, response);
					} catch (Exception e) {
						e.printStackTrace();
						request.setAttribute("status", "error");
						request.setAttribute("message", "Unexpected error occurred.");
						request.getRequestDispatcher("../jsp/returnBook.jsp").forward(request, response);
					}
				}
			} else if (pathInfo.equals("/finalReturn")) {
				try {
					int memberId = Integer.parseInt(request.getParameter("memberId"));
					int bookId = Integer.parseInt(request.getParameter("bookId"));
//					System.out.println(memberId + " - " + bookId);
					String print_message = new IssueRecordDaoImplementation().returnBook(memberId, bookId);

					request.setAttribute("message", print_message);
					if (print_message.equals("Book returned successfully")) {
						request.setAttribute("status", "success");
					} else {
						request.setAttribute("status", "error");
					}

					RequestDispatcher rd = request.getRequestDispatcher("returnRecord");
					rd.forward(request, response);

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request for this path.");
			}
		} else {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request.");
		}
	}
}
