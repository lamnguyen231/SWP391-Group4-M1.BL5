<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.wmsmobile.model.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Management</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userList.css">
    </head>
    <body>

        <h2 class="title">System User List</h2>

        <div class="top-bar">
            <a href="/views/admin/addUser.jsp" class="btn-add">Add new user</a>

            <form action="users" method="GET">
                <div class="filters">

                    <a href="users" class="reset-btn">Reset filter</a>

                    <select name="role" class="filter-select" onchange="this.form.submit()">
                        <option value="All" ${currentRole == 'All' ? 'selected' : ''}>All Role</option>
                        <option value="Employee" ${currentRole == 'Employee' ? 'selected' : ''}>Employee</option>
                        <option value="Keeper" ${currentRole == 'Keeper' ? 'selected' : ''}>Keeper</option>
                        <option value="Admin" ${currentRole == 'Admin' ? 'selected' : ''}>Admin</option>
                    </select>

                    <select name="status" class="filter-select" onchange="this.form.submit()">
                        <option value="All" ${currentStatus == 'All' ? 'selected' : ''}>All Status</option>
                        <option value="Active" ${currentStatus == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Inactive" ${currentStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                    </select>

                    <input type="text" name="search" class="search-box" 
                           placeholder="Search user by mail" value="${currentSearch}" >

                    <button type="submit" class="search-btn">Search</button>
                </div>
            </form>
        </div>

        <%
            List<User> listUser = (List<User>) request.getAttribute("listUser");

        %>

        <table class="user-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Mail</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
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
                        <% if (user.getStatus()) { %>
                        <span class="status-active">Active</span>
                        <% } else { %>
                        <span class="status-inactive">Inactive</span>
                        <% } %>
                    </td>

                    <td>
                        <a href="edit?id=<%= user.getId() %>" class="action-link">Edit</a>

                        <% if (!user.getRole().equals("Admin")) { %>
                        <% if (user.getStatus()) { %>
                        <a href="toggleStatus?id=<%= user.getId() %>" class="action-link red">Deactivate</a>
                        <% } else { %>
                        <a href="toggleStatus?id=<%= user.getId() %>" class="action-link green">Activate</a>
                        <% } %>
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
