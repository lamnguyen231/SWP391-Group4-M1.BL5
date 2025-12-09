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
 * Change Password Controller
 * Xử lý chức năng đổi mật khẩu của người dùng với xác thực bảo mật
 * 
 * @author PC
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/changePassword"})
public class ChangePasswordController extends HttpServlet {

    // Độ dài mật khẩu tối thiểu
    private static final int MIN_PASSWORD_LENGTH = 6;
    // Key để lưu user trong session
    private static final String SESSION_ACCOUNT_KEY = "account";
    // Đường dẫn đến JSP view
    private static final String VIEW_PATH = "/views/auth/changePassword.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher(VIEW_PATH).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập
        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin user và các tham số từ form
        User user = (User) request.getSession().getAttribute(SESSION_ACCOUNT_KEY);
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Xác thực các trường nhập liệu
        String validationError = validatePasswordInputs(currentPassword, newPassword, confirmPassword);
        if (validationError != null) {
            forwardWithError(request, response, validationError);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Xác minh mật khẩu hiện tại để bảo mật
        if (!isCurrentPasswordValid(userDAO, user, currentPassword)) {
            forwardWithError(request, response, "Current password is incorrect");
            return;
        }

        // Cập nhật mật khẩu mới vào database
        if (userDAO.updatePassword(user.getId(), newPassword)) {
            forwardWithSuccess(request, response, "Password changed successfully!");
        } else {
            forwardWithError(request, response, "Failed to change password. Please try again.");
        }
    }

    /**
     * Kiểm tra người dùng đã đăng nhập chưa
     */
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(SESSION_ACCOUNT_KEY) != null;
    }

    /**
     * Xác thực các tham số đầu vào khi đổi mật khẩu
     */
    private String validatePasswordInputs(String currentPassword, String newPassword, String confirmPassword) {
        // Kiểm tra các trường không được để trống
        if (isNullOrEmpty(currentPassword) || isNullOrEmpty(newPassword) || isNullOrEmpty(confirmPassword)) {
            return "All fields are required";
        }
        // Kiểm tra mật khẩu mới và xác nhận khớp nhau
        if (!newPassword.equals(confirmPassword)) {
            return "New passwords do not match";
        }
        // Kiểm tra độ dài mật khẩu tối thiểu
        if (newPassword.length() < MIN_PASSWORD_LENGTH) {
            return "Password must be at least " + MIN_PASSWORD_LENGTH + " characters";
        }
        return null;
    }

    /**
     * Xác minh mật khẩu hiện tại có đúng không
     */
    private boolean isCurrentPasswordValid(UserDAO userDAO, User user, String currentPassword) {
        User verifiedUser = userDAO.getAccountByLogin(user.getEmail(), currentPassword);
        return verifiedUser != null;
    }

    /**
     * Check if string is null or empty
     */
    private boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    /**
     * Forward to view with error message
     */
    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher(VIEW_PATH).forward(request, response);
    }

    /**
     * Forward to view with success message
     */
    private void forwardWithSuccess(HttpServletRequest request, HttpServletResponse response, String success)
            throws ServletException, IOException {
        request.setAttribute("success", success);
        request.getRequestDispatcher(VIEW_PATH).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Change Password Controller";
    }
}
