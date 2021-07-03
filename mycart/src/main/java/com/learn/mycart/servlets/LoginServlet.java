package com.learn.mycart.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;

public class LoginServlet extends HttpServlet {
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		  	response.setContentType("text/html;charset=UTF-8");
		  	try(PrintWriter out = response.getWriter()) {
				
		  		String email = request.getParameter("email");
		  		String password = request.getParameter("password");
		  		
		  		//validations
		  		
		  		
		  		//authenticating user
		  		UserDao userDao=new UserDao(FactoryProvider.getFactory());
		  		User user=userDao.getUserByEmailAndPassword(email, password);
		  		HttpSession httpSession = request.getSession();
		  		
		  		
		  		if(user==null) {
		  			httpSession.setAttribute("message", "Invalid Details! Tekrar deneyin.");
		  			response.sendRedirect("login.jsp");
		  			return;
		  		}else {
		  			out.println("hoþgeldiniz" + user.getUserName());
		  			
		  			//login
		  			httpSession.setAttribute("current-user", user);
		  			if(user.getUserType().equals("admin")) {
			  			//admin: admin.jsp
		  				response.sendRedirect("admin.jsp");
		  			}
		  			//normal: normal.jsp
		  			else if(user.getUserType().equals("normal")) {
		  				response.sendRedirect("normal.jsp");
		  			}
		  			else {
		  				out.println("we have not identified user type");
		  			}
		  			
		  			
		  		}
		  		
			}
			
		
		}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		  processRequest(request, response);
		}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		  processRequest(request, response);
		}

}
