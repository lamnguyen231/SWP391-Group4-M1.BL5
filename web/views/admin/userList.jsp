<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.wmsmobile.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
</head>
<body>

<h2 class="title">System User List</h2>

<div class="top-bar">
    <a href="userForm.jsp" class="btn-add">Add new user</a>

    <div class="filters">
        <select class="filter-select">
            <option>All Role</option>
            <option>Employee</option>
            <option>Keeper</option>
        </select>

        <select class="filter-select">
            <option>All Status</option>
            <option>Active</option>
            <option>Inactive</option>
        </select>

        <input type="text" class="search-box" placeholder="Search user by mail">
        <button class="search-btn">Search</button>
    </div>
</div>

<%
    List<User> listUser = request.getAttribute("listUser");

%>

<table class="user-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Role</th>
            <th>Mail</th>
            <th>Status</th>
            <th style="width: 180px;">Actions</th>
        </tr>
    </thead>

    <tbody>
    <% for (User user : listUser) { %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getRole() %></td>

        <td>
            <% if ("Active".equals(user.getStatus())) { %>
                <span class="status-active">Active</span>
            <% } else { %>
                <span class="status-inactive">Inactive</span>
            <% } %>
        </td>

        <td>
            <a href="editUser?id=<%= user.getId() %>" class="action-link">Edit</a>

            <% if ("Active".equals(user.getStatus())) { %>
                <a href="toggleStatus?id=<%= user.getId() %>" class="action-link red">Deactivate</a>
            <% } else { %>
                <a href="toggleStatus?id=<%= user.getId() %>" class="action-link green">Activate</a>
            <% } %>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<div class="pagination">
    <button>1</button>
    <button>2</button>
    <span>...</span>
    <button>6</button>
    <button>7</button>
</div>

</body>
</html>
