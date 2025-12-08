package com.wmsmobile.controller;

import com.wmsmobile.dao.UserDAO;
import com.wmsmobile.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/changePassword"})
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/views/auth/changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("user") == null) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }
//
//        User user = (User) session.getAttribute("user");
//        String currentPassword = request.getParameter("currentPassword");
//        String newPassword = request.getParameter("newPassword");
//        String confirmPassword = request.getParameter("confirmPassword");
//
//        // Validate inputs
//        if (currentPassword == null || currentPassword.isEmpty()
//                || newPassword == null || newPassword.isEmpty()
//                || confirmPassword == null || confirmPassword.isEmpty()) {
//            request.setAttribute("error", "All fields are required");
//            request.getRequestDispatcher("/views/auth/changePassword.jsp").forward(request, response);
//            return;
//        }
//
//        // Check if new passwords match
//        if (!newPassword.equals(confirmPassword)) {
//            request.setAttribute("error", "New passwords do not match");
//            request.getRequestDispatcher("/views/auth/changePassword.jsp").forward(request, response);
//            return;
//        }
//
//        // Check password length
//        if (newPassword.length() < 6) {
//            request.setAttribute("error", "Password must be at least 6 characters");
//            request.getRequestDispatcher("/views/auth/changePassword.jsp").forward(request, response);
//            return;
//        }
//
//        UserDAO userDAO = new UserDAO();
//
//        //     Verify current password
//        //    User verifiedUser = userDAO.getUserByEmailAndPassword(user.getEmail(), currentPassword);
//        //    if(verifiedUser == null) {
//        //        request.setAttribute("error", "Current password is incorrect");
//        //        request.getRequestDispatcher("/views/auth/changePassword.jsp").forward(request, response);
//        //        return;
//        //    }
//        // Update password
//        boolean success = userDAO.updatePassword(user.getId(), newPassword);
//
//        if (success) {
//            request.setAttribute("success", "Password changed successfully!");
//            request.getRequestDispatcher("/views/auth/changePassword.jsp").forward(request, response);
//        } else {
//            request.setAttribute("error", "Failed to change password. Please try again.");
//            request.getRequestDispatcher("/views/auth/changePassword.jsp").forward(request, response);
//        }
    }

    @Override
    public String getServletInfo() {
        return "Change Password Servlet";
    }
}
