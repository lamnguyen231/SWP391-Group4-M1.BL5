<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.wmsmobile.model.User" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .navbar {
                background-color: #2c3e50;
                color: white;
                padding: 10px 20px;
            }
            .navbar a {
                color: white;
                text-decoration: none;
                padding: 10px 15px;
                display: inline-block;
            }
            .navbar a:hover {
                background-color: #34495e;
                border-radius: 5px;
            }
            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            .menu ul {
                list-style: none;
                padding: 0;
            }
            .menu li {
                display: inline;
                margin-right: 15px;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <div class="container-fluid">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="homepage.jsp">Home</a></li>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Products</a></li>
                    <li><a href="#">Roles</a></li>
                    <li><a href="#">Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                </ul>
            </div>
        </div>
        <div class="container">
            <h1>Welcome to the Home Page</h1>
            <p>This is where you can find information about our products and services.</p>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </body>
</html>
