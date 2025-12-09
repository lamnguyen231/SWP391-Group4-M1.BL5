package com.wmsmobile.controller;

import com.wmsmobile.dao.UserDAO;
import com.wmsmobile.model.User;
import com.wmsmobile.util.EmailService;
import com.wmsmobile.util.ResetTokenStore;
import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Forgot Password Controller
 * Xử lý yêu cầu reset mật khẩu qua email
 * 
 * @author PC
 */
@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordController extends HttpServlet {

    // Đường dẫn các view
    private static final String FORGOT_PASSWORD_VIEW = "/views/auth/forgotpassword.jsp";
    private static final String SUCCESS_VIEW = "/views/auth/forgotPasswordSuccess.jsp";
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        // Xác thực email không được để trống
        if (email == null || email.trim().isEmpty()) {
            forwardWithError(request, response, "Please enter your email address");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        // Kiểm tra user có tồn tại không
        if (user == null) {
            forwardWithError(request, response, "No account found with this email address");
            return;
        }

        // Kiểm tra tài khoản có đang active không
        if (!user.getStatus()) {
            forwardWithError(request, response, "This account is inactive. Please contact administrator.");
            return;
        }

        // Tạo và lưu token reset (hết hạn sau 30 phút)
        String token = UUID.randomUUID().toString();
        ResetTokenStore.saveToken(token, user.getId(), email);

        // Tạo link reset mật khẩu
        String resetLink = buildResetLink(request, token);

        // Gửi email chứa link reset
        boolean emailSent = EmailService.sendPasswordResetEmail(email, resetLink);

        // Chuyển đến trang thành công
        request.setAttribute("success", emailSent
                ? "Password reset link has been sent to your email."
                : "Failed to send email. Please try again or contact administrator.");
        request.setAttribute("email", email);
        if (!emailSent) {
            request.setAttribute("resetLink", resetLink);
        }
        request.getRequestDispatcher(SUCCESS_VIEW).forward(request, response);
    }
    
    /**
     * Tạo URL đầy đủ cho link reset mật khẩu
     */
    private String buildResetLink(HttpServletRequest request, String token) {
        String baseUrl = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort();
        return baseUrl + request.getContextPath() + "/resetPassword?token=" + token;
    }

    /**
     * Forward to forgot password view with error
     */
    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher(FORGOT_PASSWORD_VIEW).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Forgot Password Controller";
    }
}
