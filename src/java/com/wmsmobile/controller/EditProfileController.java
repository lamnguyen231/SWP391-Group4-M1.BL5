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
 * Edit Profile Controller
 * Xử lý cập nhật thông tin cá nhân (chỉ tên, email không thể thay đổi)
 * 
 * @author PC
 */
@WebServlet(name = "EditProfileController", urlPatterns = {"/editProfile"})
public class EditProfileController extends HttpServlet {

    // Key để lưu user trong session
    private static final String SESSION_ACCOUNT_KEY = "account";
    // Đường dẫn view
    private static final String VIEW_PATH = "/views/user/editProfile.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) request.getSession().getAttribute(SESSION_ACCOUNT_KEY);
        request.setAttribute("user", user);
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

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(SESSION_ACCOUNT_KEY);
        String newName = request.getParameter("name");

        // Xác thực tên không được để trống
        if (newName == null || newName.trim().isEmpty()) {
            forwardWithMessage(request, response, user, "error", "Name cannot be empty");
            return;
        }

        // Cập nhật thông tin vào database
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateUserProfile(user.getId(), newName);

        if (success) {
            // Cập nhật session với tên mới
            user.setName(newName);
            session.setAttribute(SESSION_ACCOUNT_KEY, user);
            forwardWithMessage(request, response, user, "success", "Profile updated successfully!");
        } else {
            forwardWithMessage(request, response, user, "error", "Failed to update profile. Please try again.");
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
     * Chuyển tiếp đến view với thông báo (success hoặc error)
     */
    private void forwardWithMessage(HttpServletRequest request, HttpServletResponse response,
            User user, String messageType, String message) throws ServletException, IOException {
        request.setAttribute(messageType, message);
        request.setAttribute("user", user);
        request.getRequestDispatcher(VIEW_PATH).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Edit Profile Controller";
    }
}
