package com.dynamic_library_management.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.dynamic_library_management.constants.MemberGender;
import com.dynamic_library_management.dao.implementation.MemberDaoImplementation;
import com.dynamic_library_management.domain.Member;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.exceptions.InvalidDetailsException;
import com.dynamic_library_management.services.implementation.MemberServiceImplementation;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("/members/*")
public class MemberController extends HttpServlet {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	
    	String pathInfo = request.getPathInfo();
    	if (pathInfo.equals("/updateMemberController")) {
    		try {

    			String idStr = request.getParameter("memberId");
    			if (idStr != null && !idStr.isEmpty()) {
    				int id = Integer.parseInt(idStr);
    				Member selected = new MemberDaoImplementation().selectMemberById(id);
    				request.setAttribute("selectedMember", selected);
    			}

    			RequestDispatcher dispatcher = request.getRequestDispatcher("../jsp/updateMember.jsp");
    			dispatcher.forward(request, response);

    		} catch (SQLException | DatabaseException e) {
    			e.printStackTrace();
    			throw new ServletException("Error loading members", e);
    		}
    	}else if(pathInfo.equals("/viewAllMembers")) {
    		try {
    			List<Member> members = new MemberServiceImplementation().validateViewAllMembers();
    			request.setAttribute("members", members);
    			request.getRequestDispatcher("../jsp/viewAllMembers.jsp").forward(request, response);
    		} catch (DatabaseException e) {
    			request.setAttribute("errorMessage", "Cannot Fetch Members Data...");
    			request.getRequestDispatcher("../jsp/viewAllMembers.jsp").forward(request, response);
    		} catch (SQLException e) {
    			e.printStackTrace();
    		}
    	}
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();

        if (pathInfo != null) {
            if (pathInfo.equals("/addMemberController")) {

            	String name = request.getParameter("name");
        		String email = request.getParameter("email");
        		String mobileno = request.getParameter("mobile");
        		MemberGender gender = MemberGender.getEnumConstant(request.getParameter("gender"));
        		String address = request.getParameter("address");
        		try {
        			new MemberServiceImplementation().addMember(new Member(name, email, mobileno, gender, address));
        			setSuccess(true);
        			setMessage("Member Added Succesfully...");
        		} catch (InvalidDetailsException | DatabaseException e) {
        			setSuccess(false);
        			setMessage(e.getMessage());

        		} catch (SQLException e) {
        			// TODO Auto-generated catch block
        			e.printStackTrace();
        		} finally {
        			RequestDispatcher requestDispatcher = request.getRequestDispatcher("../jsp/addMember.jsp");
        			request.setAttribute("message", getMessage());
        			request.setAttribute("success", isSuccess());
        			if (isSuccess()) {
        				requestDispatcher.forward(request, response);
        			} else {
        				requestDispatcher.include(request, response);
        			}

        		}
        		
            } else if (pathInfo.equals("/updateMemberController")) {

            	try {
        			int memberId = Integer.parseInt(request.getParameter("memberId"));
        			String name = request.getParameter("name");
        			String email = request.getParameter("email");
        			String mobile = request.getParameter("mobile");
        			String address = request.getParameter("address");
        			MemberGender gender = MemberGender.getEnumConstant(request.getParameter("gender"));

        			Member updatedMember = new Member(memberId, name, email, mobile, gender, address);

        			new MemberServiceImplementation().validateUpdateMemberDetails(updatedMember);

        			request.setAttribute("message", "Member updated successfully!");
        			request.setAttribute("status", "success");
        			request.setAttribute("selectedMember", updatedMember);
        			request.setAttribute("members", new MemberDaoImplementation().getAllMembers());

        		} catch (InvalidDetailsException e) {
        			request.setAttribute("message", e.getMessage());
        			request.setAttribute("status", "error");
        		} catch (SQLException | DatabaseException | NumberFormatException e) {
        			request.setAttribute("message", "Failed to update member. Please try again.");
        			request.setAttribute("status", "error");
        		}

        		RequestDispatcher dispatcher = request.getRequestDispatcher("../jsp/updateMember.jsp");
        		dispatcher.forward(request, response);
            }
            else if (pathInfo.equals("/deleteMemberController")) {

            	int memberId = Integer.parseInt(request.getParameter("memberId"));

        		try {
        			boolean deleted = new MemberServiceImplementation().deleteMemberById(memberId);
        			if (deleted) {
        				request.getSession().setAttribute("successMessage", "Member Deleted Successfully");
        			} else {
        				request.getSession().setAttribute("errorMessage", "Failed to Delete Member");
        			}
        		} catch (DatabaseException | SQLException e) {
        			request.getSession().setAttribute("errorMessage", e.getMessage());
        		}

        		response.sendRedirect("../jsp/viewAllMembers.jsp");
            }
            
            
            else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request for this path.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid POST request.");
        }
	}

}
