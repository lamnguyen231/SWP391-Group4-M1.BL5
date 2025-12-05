<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.wmsmobile.model.Role" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Role Management</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminCommon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminRoleList.css">
    </head>
    <body>

        <h2 class="title">System Role List</h2>

        <div class="top-bar">
            <a href="roleForm.jsp" class="btn-add">Add new role</a>

            <form action="roles" method="GET">
                <div class="filters">

                    <a href="roles" class="reset-btn">Reset</a>

                    <input type="text" name="search" class="search-box" 
                           placeholder="Search role name" value="${currentSearch}">

                    <button type="submit" class="search-btn">Search</button>
                </div>
            </form>
        </div>

        <%
            List<Role> listRole = (List<Role>) request.getAttribute("listRole");
            
            if (listRole == null) listRole = new ArrayList<>();
        %>

        <table class="role-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Role Name</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>
                <% for (Role role : listRole) { %>
                <tr>
                    <td><%= role.getId() %></td> 
                    <td><%= role.getName() %></td>

                    <td class="">
                        <a href="editRole?id=<%= role.getId() %>" class="action-link edit">Edit</a>
                        <a href="deleteRole?id=<%= role.getId() %>" class="action-link delete">Delete</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div class="pagination">
            <button>1</button>
            <button>2</button>
            <button>...</button>
            <button>5</button>
            <button>6</button>
        </div>

    </body>
</html>