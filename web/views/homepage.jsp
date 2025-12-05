<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wmsmobile.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>WMS - Home Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                margin-bottom: 10px;
            }
            .user-info {
                margin-bottom: 30px;
                padding: 15px;
                background: #f8f9fa;
                border-radius: 5px;
            }
            .nav-links {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
            }
            .nav-links a {
                display: inline-block;
                padding: 10px 20px;
                background: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background 0.3s;
            }
            .nav-links a:hover {
                background: #0056b3;
            }
            .logout-btn {
                background: #dc3545 !important;
            }
            .logout-btn:hover {
                background: #c82333 !important;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Welcome to WMS Mobile System</h1>
            <div class="user-info">
                <p><strong>User:</strong> <%= user.getName() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Role:</strong> <%= user.getRole() %></p>
            </div>
            
            <div class="nav-links">
                <% if("Admin".equals(user.getRole())) { %>
                    <a href="<%= request.getContextPath() %>/admin/users">User Management</a>
                <% } %>
                <a href="<%= request.getContextPath() %>/changePassword">Change Password</a>
                <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </body>
</html>
