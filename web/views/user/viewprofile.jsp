<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.wmsmobile.model.User" %>
<%
    // Ưu tiên lấy user từ request attribute (được set bởi ViewProfileController)
    User user = (User) request.getAttribute("user");
    if(user == null) {
        // Dự phòng lấy từ session nếu không có trong request
        user = (User) session.getAttribute("account");
    }
    if(user == null) {
        // Chuyển hướng về trang login nếu không tìm thấy user
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>My Profile - WMS Mobile</title>
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
            padding: 30px 30px 80px;
            text-align: center;
            position: relative;
        }
        .header h1 {
            font-size: 28px;
            margin-bottom: 5px;
        }
        .header p {
            opacity: 0.9;
        }
        .user-avatar {
            width: 100px;
            height: 100px;
            background: white;
            color: #667eea;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            font-weight: bold;
            margin: 0 auto;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            position: absolute;
            bottom: -50px;
            left: 50%;
            transform: translateX(-50%);
        }
        .profile-content {
            padding: 40px 30px 30px;
        }
        .info-row {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .label {
            width: 120px;
            font-weight: bold;
            color: #555;
        }
        .value {
            flex: 1;
            color: #333;
        }
        .role-badge {
            display: inline-block;
            padding: 4px 12px;
            background: #667eea;
            color: white;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-active {
            color: #4caf50;
            font-weight: bold;
        }
        .status-inactive {
            color: #f44336;
            font-weight: bold;
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Header profile với nền gradient -->
        <div class="header">
            <h1>My Profile</h1>
            <p>View your account information</p>
            <!-- Avatar hình tròn hiển thị chữ cái đầu tên người dùng -->
            <div class="user-avatar">
                <%= user.getName().substring(0, 1).toUpperCase() %>
            </div>
        </div>

        <div class="profile-content">
            <!-- User ID - mã định danh duy nhất trong database -->
            <div class="info-row">
                <div class="label">User ID:</div>
                <div class="value">#<%= user.getId() %></div>
            </div>

            <!-- Họ tên - có thể chỉnh sửa qua Edit Profile -->
            <div class="info-row">
                <div class="label">Full Name:</div>
                <div class="value"><%= user.getName() %></div>
            </div>

            <!-- Email - chỉ đọc, không thể thay đổi -->
            <div class="info-row">
                <div class="label">Email:</div>
                <div class="value"><%= user.getEmail() %></div>
            </div>

            <!-- Vai trò - Admin/Keeper/Employee/Accountant, được gán bởi admin -->
            <div class="info-row">
                <div class="label">Role:</div>
                <div class="value">
                    <span class="role-badge"><%= user.getRole() %></span>
                </div>
            </div>

            <!-- Trạng thái tài khoản - Active/Inactive -->
            <div class="info-row">
                <div class="label">Status:</div>
                <div class="value">
                    <span class="<%= user.getStatus() ? "status-active" : "status-inactive" %>">
                        <%= user.getStatus() ? "Active" : "Inactive" %>
                    </span>
                </div>
            </div>

            <!-- Các nút hành động để điều hướng -->
            <div class="button-group">
            <div class="button-group">
                <!-- Quay về trang chủ -->
                <a href="<%= request.getContextPath() %>/" class="btn btn-secondary">← Back to Home</a>
                <!-- Chỉnh sửa profile (chỉ tên) -->
                <a href="<%= request.getContextPath() %>/editProfile" class="btn btn-primary">✏️ Edit Profile</a>
                <!-- Đổi mật khẩu -->
                <a href="<%= request.getContextPath() %>/changePassword" class="btn btn-primary">🔒 Change Password</a>
            </div>
    </div>
</body>
</html>