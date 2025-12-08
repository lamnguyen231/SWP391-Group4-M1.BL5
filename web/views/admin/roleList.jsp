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
        
        <a href="${pageContext.request.contextPath}/admin/users" style="text-decoration: none">Go to user list</a>

        <h2 class="title">System Role List</h2>

        <div class="top-bar">
            <a href="roleForm.jsp" class="btn-add">Add new role</a>

            <div class="filters">
                
                <button onclick="resetFilters()" class="reset-btn">Reset</button>

                <select id="statusInput" class="filter-select" onchange="filterTable()">
                    <option value="all">All Status</option>
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>

                <input type="text" id="searchInput" class="search-box" 
                       placeholder="Search role name..." onkeyup="filterTable()">
            </div>
        </div>

        <%
            List<Role> listRole = (List<Role>) request.getAttribute("listRole");
            if (listRole == null) listRole = new ArrayList<>();
        %>

        <table class="role-table" id="roleTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Role Name</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>
                <% for (Role role : listRole) { %>
                <tr class="role-row" data-status="<%= role.getStatus() %>">
                    <td><%= role.getId() %></td> 
                    
                    <td class="role-name"><%= role.getName() %></td>
                    
                    <td>
                        <% if (role.getStatus()) { %>
                            <span class="status-active">Active</span>
                        <% } else { %>
                            <span class="status-inactive">Inactive</span>
                        <% } %>
                    </td>

                    <td>
                        <a href="edit?id=<%= role.getId() %>" class="action-link">Edit</a>

                        <% if (!"Admin".equalsIgnoreCase(role.getName())) { %>
                            <% if (role.getStatus()) { %>
                                <a href="toggleStatus?id=<%= role.getId() %>" 
                                   class="action-link red"
                                   onclick="return confirm('Deactivate this role?');">Deactivate</a>
                            <% } else { %>
                                <a href="toggleStatus?id=<%= role.getId() %>" 
                                   class="action-link green"
                                   onclick="return confirm('Activate this role?');">Activate</a>
                            <% } %>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <div id="noResults" style="display:none; text-align:center; margin-top: 20px; color: #666;">
            No roles match your search.
        </div>

    </body>

    <script>
        function filterTable() {
            let searchFilter = document.getElementById("searchInput").value.toLowerCase();
            let statusFilter = document.getElementById("statusInput").value;

            let rows = document.getElementsByClassName("role-row");
            let visibleCount = 0;

            for (let i = 0; i < rows.length; i++) {
                let row = rows[i];
                
                let roleName = row.querySelector(".role-name").innerText.toLowerCase();
                let roleStatus = row.getAttribute("data-status");

                let matchesSearch = roleName.includes(searchFilter);
                
                let matchesStatus = (statusFilter === "all") || (roleStatus === statusFilter);

                if (matchesSearch && matchesStatus) {
                    row.style.display = "";
                    visibleCount++;
                } else {
                    row.style.display = "none";
                }
            }
            
            document.getElementById("noResults").style.display = (visibleCount === 0) ? "block" : "none";
        }

        function resetFilters() {
            document.getElementById("searchInput").value = "";
            document.getElementById("statusInput").value = "all";
            filterTable(); 
        }
    </script>
</html>