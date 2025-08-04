package com.dynamic_library_management.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.dynamic_library_management.dao.implementation.ReportsDaoImplementation;
import com.dynamic_library_management.domain.IssueRecord;


@WebServlet("/overdueRecords")
public class OverdueRecordsController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

			List<IssueRecord> overdue = new ReportsDaoImplementation().getOverdueBooks();
					
			request.setAttribute("overdue", overdue);

			RequestDispatcher rd = request.getRequestDispatcher("jsp/overdueRecords.jsp");
			rd.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
