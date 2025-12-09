package com.wmsmobile.controller;

import com.wmsmobile.dao.UserDAO;
import com.wmsmobile.util.ResetTokenStore;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Reset Password Controller
 * Xử lý việc reset mật khẩu thông qua token từ email
 * 
 * @author PC
 */
@WebServlet(name = "ResetPasswordController", urlPatterns = {"/resetPassword"})
public class ResetPasswordController extends HttpServlet {

    // Độ dài mật khẩu tối thiểu
    private static final int MIN_PASSWORD_LENGTH = 6;
    // Đường dẫn các view
    private static final String RESET_VIEW = "/views/auth/resetPassword.jsp";
    private static final String LOGIN_VIEW = "/views/auth/login.jsp";
    private static final String FORGOT_PASSWORD_VIEW = "/views/auth/forgotpassword.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");

        // Kiểm tra tham số token có tồn tại không
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Invalid reset link");
            request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
            return;
        }

        // Xác thực token còn hợp lệ và chưa hết hạn
        if (!ResetTokenStore.isValidToken(token)) {
            request.setAttribute("error", "Reset link has expired or is invalid. Please request a new one.");
            request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
            return;
        }

        // Hiển thị form reset mật khẩu
        String email = ResetTokenStore.getEmail(token);
        request.setAttribute("token", token);
        request.setAttribute("email", email);
        request.getRequestDispatcher(RESET_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Xác thực các tham số mật khẩu
        String validationError = validatePasswordInputs(newPassword, confirmPassword);
        if (validationError != null) {
            forwardToResetWithError(request, response, token, validationError);
            return;
        }

        // Kiểm tra token vẫn còn hợp lệ
        if (!ResetTokenStore.isValidToken(token)) {
            request.setAttribute("error", "Reset link has expired. Please request a new one.");
            request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
            return;
        }

        // Cập nhật mật khẩu vào database
        Integer userId = ResetTokenStore.getUserId(token);
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updatePassword(userId, newPassword);

        if (success) {
            // Xóa token đã sử dụng
            ResetTokenStore.removeToken(token);
            request.setAttribute("success", "Password has been reset successfully. You can now login with your new password.");
            request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
        } else {
            forwardToResetWithError(request, response, token, "Failed to reset password. Please try again.");
        }
    }

    /**
     * Xác thực các tham số khi reset mật khẩu
     */
    private String validatePasswordInputs(String newPassword, String confirmPassword) {
        // Kiểm tra mật khẩu không được để trống
        if (newPassword == null || newPassword.trim().isEmpty()) {
            return "Password cannot be empty";
        }
        // Kiểm tra độ dài tối thiểu
        if (newPassword.length() < MIN_PASSWORD_LENGTH) {
            return "Password must be at least " + MIN_PASSWORD_LENGTH + " characters";
        }
        // Kiểm tra hai mật khẩu khớp nhau
        if (!newPassword.equals(confirmPassword)) {
            return "Passwords do not match";
        }
        return null;
    }

    /**
     * Forward to reset view with error and token
     */
    private void forwardToResetWithError(HttpServletRequest request, HttpServletResponse response,
            String token, String error) throws ServletException, IOException {
        request.setAttribute("error", error);
        request.setAttribute("token", token);
        request.getRequestDispatcher(RESET_VIEW).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Reset Password Controller";
    }
}
