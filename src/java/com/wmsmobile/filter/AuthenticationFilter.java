package com.wmsmobile.filter;

import com.wmsmobile.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {

    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/login",
        "/views/auth/login.jsp",
        "/css/",
        "/js/",
        "/images/",
        "/forgotPassword"
    );

    private static final String ADMIN_ROLE = "Admin";
    private static final String ADMIN_PATH_PREFIX = "/admin/";
    private static final String USER_ATTRIBUTE = "account";
    private static final String INACTIVE_STATUS = "inactive";

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        
        User user = getAuthenticatedUser(req);
        boolean isLoggedIn = (user != null);
        boolean isPublicResource = isPublicResource(uri, contextPath);
        
        if (isLoggedIn && isLoginPage(uri)) {
            redirectToDashboard(res, contextPath, user);
            return;
        }
        
        if (isPublicResource) {
            chain.doFilter(request, response);
            return;
        }
        
        if (!isLoggedIn) {
            redirectToLogin(res, contextPath);
            return;
        }
        
        if (isAdminPath(uri) && !isAdmin(user)) {
            redirectToHome(res, contextPath);
            return;
        }

        chain.doFilter(request, response);
    }

    private User getAuthenticatedUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null) ? (User) session.getAttribute(USER_ATTRIBUTE) : null;
    }

    private boolean isPublicResource(String uri, String contextPath) {
        // Check if it matches public paths
        for (String path : PUBLIC_PATHS) {
            if (uri.contains(path)) {
                return true;
            }
        }
        
        return uri.equals(contextPath + "/") || uri.equals(contextPath + "/views/homepage.jsp");
    }

    private boolean isLoginPage(String uri) {
        return uri.endsWith("/login") || uri.contains("login.jsp");
    }

    private boolean isAdminPath(String uri) {
        return uri.contains(ADMIN_PATH_PREFIX);
    }

    private boolean isAdmin(User user) {
        return user != null && ADMIN_ROLE.equalsIgnoreCase(user.getRole());
    }

    private void redirectToDashboard(HttpServletResponse res, String contextPath, User user) 
            throws IOException {
        if (isAdmin(user)) {
            res.sendRedirect(contextPath + "/admin/dashboard");
        } else {
            res.sendRedirect(contextPath + "/");
        }
    }

    private void redirectToLogin(HttpServletResponse res, String contextPath) throws IOException {
        res.sendRedirect(contextPath + "/login");
    }

    private void redirectToHome(HttpServletResponse res, String contextPath) throws IOException {
        res.sendRedirect(contextPath + "/");
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}