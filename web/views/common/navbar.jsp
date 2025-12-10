<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.wmsmobile.model.User" %>
<%
    User user = (User) session.getAttribute("account");
    String role = (user != null) ? user.getRole() : "";
%>

<link rel="stylesheet" href="css/navbar.css" />

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/">WMS</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span> </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="#">Products</a>
                </li>
                <% if("Admin".equals(role)) { %>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/dashboard">Admin Dashboard</a>
                </li>
                <% } %>
            </ul>

            <ul class="navbar-nav ms-auto">
                <% if(user != null) { %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Hello, <%= user.getName() %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/viewProfile">Profile</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/changePassword">Change Password</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
                </li>
                <% } %>
            </ul>

        </div>
    </div>
</nav>