<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Password Reset Success - WMS Mobile</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .success-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }
        .icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        h2 {
            color: #2e7d32;
            margin-bottom: 20px;
        }
        .info-box {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }
        .info-box p {
            color: #666;
            margin-bottom: 10px;
        }
        .temp-password {
            background: #fff3cd;
            border: 2px dashed #ffc107;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
        }
        .temp-password-label {
            color: #856404;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .temp-password-value {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            letter-spacing: 2px;
            font-family: monospace;
        }
        .warning {
            background: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            text-align: left;
        }
        .warning strong {
            display: block;
            margin-bottom: 10px;
        }
        .warning ul {
            margin-left: 20px;
        }
        .warning li {
            margin: 5px 0;
        }
        .login-btn {
            display: inline-block;
            padding: 12px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            margin-top: 20px;
            transition: transform 0.2s;
        }
        .login-btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="success-container">
        <!-- Icon thành công -->
        <div class="icon">✅</div>
        
        <!-- Tiêu đề động: Thay đổi dựa vào có attribute "success" hay không -->
        <h2><%= request.getAttribute("success") != null ? "Email Sent!" : "Password Reset Link" %></h2>
        
        <!-- Thông tin email đã gửi -->
        <div class="info-box">
            <% if(request.getAttribute("success") != null) { %>
                <!-- Trường hợp email gửi thành công -->
                <p><%= request.getAttribute("success") %></p>
                <p style="font-weight: bold; color: #333;"><%= request.getAttribute("email") %></p>
            <% } else { %>
                <!-- Trường hợp email gửi thất bại (hiển thị link dự phòng) -->
                <p>A password reset link has been created for:</p>
                <p style="font-weight: bold; color: #333;"><%= request.getAttribute("email") %></p>
            <% } %>
        </div>
        
        <!-- Link dự phòng nếu email gửi thất bại -->
        <% if(request.getAttribute("resetLink") != null) { %>
        <div class="temp-password">
            <div class="temp-password-label">BACKUP LINK (Email failed to send):</div>
            <div style="margin: 15px 0;">
                <!-- Link reset trực tiếp cho trường hợp email không gửi được -->
                <a href="<%= request.getAttribute("resetLink") %>" 
                   style="color: #667eea; font-weight: bold; word-break: break-all;">
                    <%= request.getAttribute("resetLink") %>
                </a>
            </div>
        </div>
        <% } %>
        
        <!-- Hướng dẫn và cảnh báo quan trọng -->
        <div class="warning">
            <strong>⚠️ Important Instructions:</strong>
            <ul>
                <% if(request.getAttribute("success") != null) { %>
                    <!-- Hướng dẫn khi email đã gửi thành công -->
                    <li>Check your email inbox (and spam folder)</li>
                    <li>Click the link in the email to reset your password</li>
                <% } else { %>
                    <!-- Hướng dẫn khi sử dụng link dự phòng -->
                    <li>Click the link above to set your new password</li>
                <% } %>
                <li>The link will expire in 30 minutes</li> <!-- Cập nhật từ 15 thành 30 phút -->
                <li>You will be able to choose your own password</li>
            </ul>
        </div>
        
        <!-- Nút hành động: Reset ngay hoặc quay về login -->
        <% if(request.getAttribute("resetLink") != null) { %>
            <!-- Nếu có link dự phòng, cho phép reset ngay -->
            <a href="<%= request.getAttribute("resetLink") %>" class="login-btn">Reset Password Now</a>
        <% } else { %>
            <!-- Nếu email đã gửi, chỉ cần quay về trang login -->
            <a href="<%= request.getContextPath() %>/login" class="login-btn">Go to Login</a>
        <% } %>
    </div>
</body>
</html>
