<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.wmsmobile.model.Role" %>

<h2 class="title">System Role List</h2>

<div class="top-bar">
    <button type="button" class="btn-add" onclick="openModal()">Add new user</button>

    <div class="filters">
        
        <button onclick="resetFilters()" class="reset-btn">Reset filter</button>

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
    // Standard Java logic to retrieve list
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
                <a href="editRole?id=<%= role.getId() %>" class="action-link">Edit</a>

                <% if (!"Admin".equalsIgnoreCase(role.getName())) { %>
                    <% if (role.getStatus()) { %>
                        <a href="toggleRoleStatus?id=<%= role.getId() %>" 
                           class="action-link red"
                           onclick="return confirm('Deactivate this role?');">Deactivate</a>
                    <% } else { %>
                        <a href="toggleRoleStatus?id=<%= role.getId() %>" 
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

    function openModal() {
        document.getElementById("userModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("userModal").style.display = "none";
        if(document.addForm) document.addForm.reset();
    }

    window.onclick = function(event) {
        var modal = document.getElementById("userModal");
        if (event.target == modal) {
            closeModal();
        }
    }
</script>