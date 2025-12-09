<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password - WMS Mobile</title>
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
        .reset-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
        }
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .email-info {
            background: #f5f5f5;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
            color: #555;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
        }
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
        }
        button:hover {
            transform: translateY(-2px);
        }
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .success-message {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .icon {
            text-align: center;
            font-size: 48px;
            margin-bottom: 20px;
        }
        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <div class="icon">🔑</div>
        <h2>Reset Your Password</h2>
        <p class="subtitle">Enter your new password</p>
        
        <!-- Hiển thị email đang reset mật khẩu -->
        <% if(request.getAttribute("email") != null) { %>
            <div class="email-info">
                Resetting password for: <strong><%= request.getAttribute("email") %></strong>
            </div>
        <% } %>
        
        <!-- Hiển thị thông báo lỗi (token hết hạn, mật khẩu không khớp, v.v.) -->
        <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <!-- Hiển thị thông báo thành công -->
        <% if(request.getAttribute("success") != null) { %>
            <div class="success-message">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <!-- Form reset mật khẩu - POST đến servlet /resetPassword -->
        <form action="<%= request.getContextPath() %>/resetPassword" method="post">
            <!-- Token ẩn trong hidden field - được lấy từ URL -->
            <input type="hidden" name="token" value="<%= request.getAttribute("token") %>">
            
            <!-- Trường mật khẩu mới - tối thiểu 6 ký tự -->
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required 
                       placeholder="Enter new password" minlength="6">
                <div class="password-requirements">Must be at least 6 characters</div>
            </div>
            
            <!-- Xác nhận mật khẩu mới -->
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required 
                       placeholder="Confirm new password" minlength="6">
            </div>
            
            <button type="submit">Reset Password</button>
        </form>
    </div>
</body>
</html>
