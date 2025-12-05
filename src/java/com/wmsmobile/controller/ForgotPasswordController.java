package com.wmsmobile.controller;

import com.wmsmobile.dao.UserDAO;
import com.wmsmobile.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(request, response);
    } 

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        String email = request.getParameter("email");
//        
//        // Validate email
//        if(email == null || email.trim().isEmpty()) {
//            request.setAttribute("error", "Please enter your email address");
//            request.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(request, response);
//            return;
//        }
//        
//        UserDAO userDAO = new UserDAO();
//        User user = userDAO.getUserByEmail(email);
//        
//        if(user == null) {
//            request.setAttribute("error", "No account found with this email address");
//            request.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(request, response);
//            return;
//        }
//        
//        // Generate temporary password
//        String tempPassword = generateTempPassword();
//        
//        // Update password in database
//        boolean success = userDAO.updatePassword(user.getId(), tempPassword);
//        
//        if(success) {
//            // In real application, send email with temp password
//            // For now, just display it on screen
//            request.setAttribute("success", "Your temporary password has been generated.");
//            request.setAttribute("tempPassword", tempPassword);
//            request.setAttribute("email", email);
//            request.getRequestDispatcher("/views/auth/forgotPasswordSuccess.jsp").forward(request, response);
//        } else {
//            request.setAttribute("error", "Failed to reset password. Please try again.");
//            request.getRequestDispatcher("/views/auth/forgotpassword.jsp").forward(request, response);
//        }
//    }
    
    private String generateTempPassword() {
        // Generate random 8-character password
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        for(int i = 0; i < 8; i++) {
            int index = (int)(Math.random() * chars.length());
            password.append(chars.charAt(index));
        }
        return password.toString();
    }

    @Override
    public String getServletInfo() {
        return "Forgot Password Servlet";
    }
}
