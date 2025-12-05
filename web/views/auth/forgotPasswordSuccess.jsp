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
        <div class="icon">✅</div>
        <h2>Password Reset Successful!</h2>
        
        <div class="info-box">
            <p>A temporary password has been generated for:</p>
            <p style="font-weight: bold; color: #333;"><%= request.getAttribute("email") %></p>
        </div>
        
        <div class="temp-password">
            <div class="temp-password-label">YOUR TEMPORARY PASSWORD:</div>
            <div class="temp-password-value"><%= request.getAttribute("tempPassword") %></div>
        </div>
        
        <div class="warning">
            <strong>⚠️ Important Instructions:</strong>
            <ul>
                <li>Please save this temporary password</li>
                <li>Use it to login to your account</li>
                <li>Change your password immediately after login for security</li>
                <li>This password will not be sent via email in this demo</li>
            </ul>
        </div>
        
        <a href="<%= request.getContextPath() %>/login" class="login-btn">Go to Login</a>
    </div>
</body>
</html>
