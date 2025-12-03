<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <h2>System User List</h2>

    <div class="add-user-container">
        <a href="userForm.jsp" class="btn btn-add">+ Add New User</a>
    </div>

    <%
    
        List<Map<String, String>> userList = (List<Map<String, String>>) request.getAttribute("userList");
        
        if (userList == null) {
            userList = new ArrayList<>();
            Map<String, String> u1 = new HashMap<>(); u1.put("id", "101"); u1.put("name", "Alice Johnson"); u1.put("email", "alice@test.com");
            Map<String, String> u2 = new HashMap<>(); u2.put("id", "102"); u2.put("name", "Bob Smith"); u2.put("email", "bob@test.com");
            userList.add(u1); userList.add(u2);
        }
    %>

    <table class="user-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email Address</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if (userList != null && !userList.isEmpty()) {
                    for (Map<String, String> user : userList) {
            %>
            <tr>
                <td><%= user.get("id") %></td>
                <td><%= user.get("name") %></td>
                <td><%= user.get("email") %></td>
                <td>
                    <a href="editUser?id=<%= user.get("id") %>" class="btn btn-edit">Edit</a>
                    <a href="deleteUser?id=<%= user.get("id") %>" 
                       class="btn btn-delete" 
                       onclick="return confirm('Delete user <%= user.get("name") %>?');">
                       Delete
                    </a>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="4" style="text-align:center;">No users found.</td>
            </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>