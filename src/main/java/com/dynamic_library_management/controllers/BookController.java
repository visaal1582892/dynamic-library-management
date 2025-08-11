package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.util.List;

import com.dynamic_library_management.constants.BookCategory;
import com.dynamic_library_management.dao.implementation.BookDaoImplementation;
import com.dynamic_library_management.domain.Book;
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
 * Servlet implementation class BookController
 */
@WebServlet("/books/*")
public class BookController extends HttpServlet {
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
       

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null) {
            if (pathInfo.equals("/viewAllBooksController")) {

            	List<Book> books = null;

            	try {
        			books = new BookServiceImplementation().validateViewAllBooks();
        		} catch (DatabaseException e) {
        			e.printStackTrace();
        		}
            	
        		request.getSession().setAttribute("books", books);
        		response.sendRedirect("../jsp/viewAllBooks.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Path not found.");
            }
        }else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request.");
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();

        if (pathInfo != null) {
            if (pathInfo.equals("/addBookController")) {

            	String title = request.getParameter("title");
        		String author = request.getParameter("author");
        		BookCategory category = BookCategory.getEnumConstant(request.getParameter("category"));
        		try {
        			new BookServiceImplementation().validateAddBook(title, author, category);
        			setSuccess(true);
        			setMessage("Book Added Succesfully...");
//        			ResponseHandler.showResponse(message, "Book Added Succesfully...", Color.GREEN);
        		} catch (InvalidDetailsException | DatabaseException e) {
        			setSuccess(false);
        			setMessage(e.getMessage());
//        			ResponseHandler.showResponse(message, e.getMessage(), Color.RED);
        		} finally {
        			RequestDispatcher requestDispatcher = request.getRequestDispatcher("../jsp/addBook.jsp");
        			request.setAttribute("message", getMessage());
        			request.setAttribute("success", isSuccess());
        			if (isSuccess()) {
        				requestDispatcher.forward(request, response);
        			} else {
        				requestDispatcher.include(request, response);
        			}

        		}
            } else if (pathInfo.equals("/updateBookDetailsController")) {

            	try {
        			String bookIdString = request.getParameter("bookId");
        			if (bookIdString == null) {
        				throw new InvalidDetailsException("Book Must Be Selected to Update...");
        			}
        			int id = Integer.parseInt(bookIdString.split(",")[0]);
        			String title = request.getParameter("title");
        			String author = request.getParameter("author");
        			BookCategory category = BookCategory.getEnumConstant(request.getParameter("category"));
//        			BookStatus status = BookStatus.getEnumConstant(request.getParameter("status"));
//        			new BookServiceImplementation().validateUpdateBookDetails(id, title, author, category, status);
        			new BookServiceImplementation().validateUpdateBookDetails(id, title, author, category);
        			setSuccess(true);
        			setMessage("Book Updated Succesfully...");
//        			ResponseHandler.showResponse(message, "Book Added Succesfully...", Color.GREEN);
        		} catch (InvalidDetailsException | DatabaseException e) {
        			setSuccess(false);
        			setMessage(e.getMessage());
//        			ResponseHandler.showResponse(message, e.getMessage(), Color.RED);
        		} finally {
        			RequestDispatcher requestDispatcher = request.getRequestDispatcher("../jsp/updateBookDetails.jsp");
        			request.setAttribute("message", getMessage());
        			request.setAttribute("success", isSuccess());
        			if (isSuccess()) {
        				requestDispatcher.forward(request, response);
        			} else {
        				requestDispatcher.include(request, response);
        			}

        		}
            }
            else if (pathInfo.equals("/deleteBookController")) {

            	String bookIdParam = request.getParameter("bookId");

        		try {
        			int bookId = Integer.parseInt(bookIdParam);

        			BookDaoImplementation bookDao = new BookDaoImplementation();
        			Book fullBook = bookDao.selectBookById(bookId);

        			if (fullBook != null) {
        				bookDao.deleteBook(fullBook);
        				request.getSession().setAttribute("message", "Book Deleted Successfully...");
        				request.getSession().setAttribute("messageColor", "green");
        			} else {
        				request.getSession().setAttribute("message", "Book not found in the database.");
        				request.getSession().setAttribute("messageColor", "red");
        			}

        		} catch (NumberFormatException e) {
        			request.getSession().setAttribute("message", "Invalid Book ID.");
        			request.getSession().setAttribute("messageColor", "red");
        		} catch (DatabaseException e) {
        			request.getSession().setAttribute("message", "Error deleting book: " + e.getMessage());
        			request.getSession().setAttribute("messageColor", "red");
        		}

        		response.sendRedirect("viewAllBooksController");
            }
            
            
            else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request for this path.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request.");
        }
	}

}
