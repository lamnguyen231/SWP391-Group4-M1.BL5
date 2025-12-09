<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.wmsmobile.model.User" %>
<%
    // Lấy thông tin user từ request attribute hoặc session
    User user = (User) request.getAttribute("user");
    if(user == null) {
        user = (User) session.getAttribute("account");
    }
    if(user == null) {
        // Chuyển hướng về login nếu chưa đăng nhập
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile - WMS Mobile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .header h1 {
            font-size: 28px;
            margin-bottom: 5px;
        }
        .header p {
            opacity: 0.9;
        }
        .form-content {
            padding: 40px 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        input[type="email"]:focus {
            outline: none;
            border-color: #667eea;
        }
        input[type="text"]:disabled,
        input[type="email"]:disabled {
            background: #f5f5f5;
            cursor: not-allowed;
        }
        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #4caf50;
        }
        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #f44336;
        }
        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }
        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #f5f5f5;
            color: #333;
        }
        .btn-secondary:hover {
            background: #e0e0e0;
        }
        .info-note {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 13px;
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✏️ Edit Profile</h1>
            <p>Update your account information</p>
        </div>

        <div class="form-content">
            <!-- Hiển thị thông báo thành công -->
            <% if(request.getAttribute("success") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <!-- Hiển thị thông báo lỗi -->
            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Ghi chú: Không thể thay đổi User ID, Email và Role -->
            <div class="info-note">
                <strong>Note:</strong> User ID, Email and Role cannot be changed. Contact administrator if needed.
            </div>

            <!-- Form chỉnh sửa thông tin - POST đến servlet /editProfile -->
            <form action="<%= request.getContextPath() %>/editProfile" method="post">
                <!-- User ID - chỉ đọc, không thể chỉnh sửa -->
                <div class="form-group">
                    <label for="userId">User ID</label>
                    <input type="text" id="userId" value="#<%= user.getId() %>" disabled>
                </div>

                <!-- Họ tên - duy nhất trường có thể chỉnh sửa -->
                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" id="name" name="name" 
                           value="<%= user.getName() %>" 
                           required placeholder="Enter your full name">
                </div>

                <!-- Email - chỉ đọc, không cho phép thay đổi -->
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" 
                           value="<%= user.getEmail() %>" 
                           disabled style="background-color: #f5f5f5; cursor: not-allowed;">
                </div>

                <!-- Vai trò - chỉ đọc, chỉ admin mới có thể thay đổi -->
                <div class="form-group">
                    <label for="role">Role</label>
                    <input type="text" id="role" value="<%= user.getRole() %>" disabled>
                </div>

                <!-- Các nút hành động -->
                <div class="button-group">
                    <!-- Hủy và quay về trang profile -->
                    <a href="<%= request.getContextPath() %>/viewProfile" class="btn btn-secondary">Cancel</a>
                    <!-- Lưu thay đổi -->
                    <button type="submit" class="btn btn-primary">💾 Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
