package com.wmsmobile.controller;

import com.wmsmobile.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * View Profile Controller
 * Hiển thị thông tin cá nhân của user đã đăng nhập
 * User có thể xem: ID, tên, email, role, status
 * 
 * @author PC
 */
@WebServlet(name = "ViewProfileController", urlPatterns = {"/viewProfile"})
public class ViewProfileController extends HttpServlet {

    /**
     * Xử lý GET request để hiển thị trang profile
     * URL: /viewProfile
     * 
     * Flow:
     * 1. Kiểm tra user đã đăng nhập chưa
     * 2. Lấy thông tin user từ session
     * 3. Forward sang JSP để hiển thị
     * 
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException Lỗi servlet
     * @throws IOException Lỗi IO
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy session hiện tại (false = không tạo session mới nếu chưa có)
        HttpSession session = request.getSession(false);
        
        // Kiểm tra session có tồn tại và có user đã login không
        if (session == null || session.getAttribute("account") == null) {
            // Chưa đăng nhập → Redirect về trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin user từ session (key = "account")
        User user = (User) session.getAttribute("account");
        
        // Set user vào request attribute để JSP có thể truy cập
        // JSP sẽ dùng: ${user.name}, ${user.email}, ...
        request.setAttribute("user", user);
        
        // Forward request đến viewprofile.jsp để hiển thị thông tin
        // URL trên browser không đổi, vẫn là /viewProfile
        request.getRequestDispatcher("/views/user/viewprofile.jsp").forward(request, response);
    }

    /**
     * Thông tin về servlet
     * @return Mô tả servlet
     */
    @Override
    public String getServletInfo() {
        return "View Profile Controller - Hiển thị thông tin cá nhân user";
    }
}
