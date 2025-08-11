package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.dynamic_library_management.dao.implementation.ReportsDaoImplementation;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReportsController
 */
@WebServlet("/reports/*")
public class ReportsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	
    	String pathInfo = request.getPathInfo();
    	if (pathInfo.equals("/overdueRecords")) {
    		try {

    			List<String[]> overdue = new ArrayList<>();
    			List<List<String>> raw = new ReportsDaoImplementation().getOverdueBooks();
    			
    			for (List<String> row : raw) {
    				overdue.add(row.toArray(new String[0]));
    			}
    					
    			request.setAttribute("overdue", overdue);

    			RequestDispatcher rd = request.getRequestDispatcher("../jsp/overdueRecords.jsp");
    			rd.forward(request, response);

    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    	}else if(pathInfo.equals("/categoryCount")) {
    		Map<Object, Long> categoryCountMap = new ReportsDaoImplementation().countOfBooksPerCategory();
   		 
   		 System.out.println(categoryCountMap);
   		    
   		    request.setAttribute("categoryCountMap", categoryCountMap);
   		    
   		    RequestDispatcher dispatcher = request.getRequestDispatcher("../jsp/categoryCount.jsp");
   		    dispatcher.forward(request, response);
    	}else if(pathInfo.equals("/activeIssuedRecords")) {
    		try {

    			List<String[]> activeIssues = new ArrayList<>();
    			List<List<String>> raw = new ReportsDaoImplementation().getActiveIssuedBooks();
    			for (List<String> row : raw) {
    			    activeIssues.add(row.toArray(new String[0]));
    			}
    					
    			request.setAttribute("activeIssues", activeIssues);

    			RequestDispatcher rd = request.getRequestDispatcher("../jsp/activeIssuedRecords.jsp");
    			rd.forward(request, response);

    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    	}
    }

}
