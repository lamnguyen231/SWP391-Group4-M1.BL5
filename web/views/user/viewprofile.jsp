<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.wmsmobile.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if(user == null) {
        user = (User) session.getAttribute("user");
    }
    if(user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>View My Profile - WMS Mobile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }
        
        .profile-header h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: white;
            color: #667eea;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            margin: 0 auto 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .profile-body {
            padding: 40px;
        }
        
        .profile-section {
            margin-bottom: 30px;
        }
        
        .profile-section h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }
        
        .profile-info {
            display: grid;
            gap: 20px;
        }
        
        .info-item {
            display: flex;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .info-item:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }
        
        .info-label {
            font-weight: 600;
            color: #495057;
            min-width: 150px;
        }
        
        .info-value {
            color: #212529;
            flex: 1;
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
        
        .role-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            background: #667eea;
            color: white;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            text-align: center;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.4);
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-header">
            <div class="profile-avatar">
                <%= user.getName().substring(0, 1).toUpperCase() %>
            </div>
            <h1><%= user.getName() %></h1>
            <p><%= user.getEmail() %></p>
        </div>
        
        <div class="profile-body">
            <div class="profile-section">
                <h2>Thông tin cá nhân</h2>
                <div class="profile-info">
                    <div class="info-item">
                        <span class="info-label">Họ và tên:</span>
                        <span class="info-value"><%= user.getName() %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value"><%= user.getEmail() %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">User ID:</span>
                        <span class="info-value">#<%= user.getId() %></span>
                    </div>
                </div>
            </div>
            
            <div class="profile-section">
                <h2>Thông tin hệ thống</h2>
                <div class="profile-info">
                    <div class="info-item">
                        <span class="info-label">Vai trò:</span>
                        <span class="info-value">
                            <span class="role-badge"><%= user.getRole() %></span>
                        </span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Trạng thái:</span>
                        <span class="info-value">
                            <% if(user.getStatus()) { %>
                                <span class="status-badge status-active">Đang hoạt động</span>
                            <% } else { %>
                                <span class="status-badge status-inactive">Đã vô hiệu hóa</span>
                            <% } %>
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="action-buttons">
                <a href="<%= request.getContextPath() %>/changePassword" class="btn btn-primary">Đổi mật khẩu</a>
                <a href="<%= request.getContextPath() %>/views/homepage.jsp" class="btn btn-secondary">Trang chủ</a>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">Đăng xuất</a>
            </div>
        </div>
    </div>
</body>
</html>