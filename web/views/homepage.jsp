<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>WMS Mobile - Home</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 15px 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .navbar h1 {
            font-size: 24px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .user-info span {
            font-size: 16px;
        }
        .logout-btn {
            background: white;
            color: #667eea;
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
        }
        .logout-btn:hover {
            background: #f0f0f0;
        }
        .change-password-btn {
            background: transparent;
            color: white;
            padding: 8px 20px;
            border: 2px solid white;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
        }
        .change-password-btn:hover {
            background: rgba(255,255,255,0.1);
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .welcome-card {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .welcome-card h2 {
            color: #333;
            margin-bottom: 10px;
        }
        .welcome-card p {
            color: #666;
            font-size: 18px;
        }
        .role-badge {
            display: inline-block;
            padding: 5px 15px;
            background: #667eea;
            color: white;
            border-radius: 20px;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>WMS Mobile System</h1>
        <div class="user-info">
            <span>Welcome, <%= user.getName() %></span>
            <a href="<%= request.getContextPath() %>/profile" class="change-password-btn">My Profile</a>
            <a href="<%= request.getContextPath() %>/changePassword" class="change-password-btn">Change Password</a>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="welcome-card">
            <h2>Welcome to WMS Mobile!</h2>
            <p>Email: <%= user.getEmail() %></p>
            <p>Role: <%= user.getRole() %></p>
            <div style="margin-top: 20px;">
                <a href="<%= request.getContextPath() %>/profile" style="color: #667eea; text-decoration: none; font-weight: 600;">📋 View My Profile</a>
                <% if("Admin".equals(user.getRole())) { %>
                    <span style="margin: 0 10px;">|</span>
                    <a href="<%= request.getContextPath() %>/admin/users" style="color: #667eea; text-decoration: none; font-weight: 600;">👥 Manage Users</a>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
